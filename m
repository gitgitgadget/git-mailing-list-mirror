From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 35/41] refs.c: pack all refs before we start to rename
 a ref
Date: Tue, 3 Jun 2014 09:39:21 -0700
Message-ID: <CAL=YDW=j9m=_QrFLNu3w_UeH_JKUxmk4+VMh0-FFTdDq0CdOJg@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-36-git-send-email-sahlberg@google.com>
	<20140530180815.GI12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 18:40:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrrkM-0004EY-JN
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 18:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934067AbaFCQjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 12:39:24 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:57229 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934358AbaFCQjW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 12:39:22 -0400
Received: by mail-ve0-f182.google.com with SMTP id sa20so7231933veb.41
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MDU6yIdEXY2JilguhHByyGfm+iqA3TVTc7CK4Z0MF/g=;
        b=A7wnAAHBNeQ78QQMNDBWZOr8CDC8YoJtx6P8nxFK71yGNnKIzD2EJ+u4SiKBQoNeq9
         4/Z9Bs2t9Cxu/5AELBHERRqzO3z7nQx7DckTlqzlrZljE4LFFPm2dL8XsS/wAYaLaQh+
         qG/MIDV2zldTzT55ezfnFw17J0+voLPH2AE8Xs0YGAjcQQyewsfGQdMe2rwuSO4ZIAK1
         2xiTwrfNZj3mvutCqCN8hJpL9exFoXCIUTruQoVhJRrchL8MY8WT78UYrsuGlxpCkrho
         M4R/Jeaa9UhJpmMW1O/GYD6PUGlFlvQIJ5Y0dN7OqXykbHhAFbqU+REWJJbbWhy3Uc+U
         Rf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MDU6yIdEXY2JilguhHByyGfm+iqA3TVTc7CK4Z0MF/g=;
        b=iEIpsI8Z0muOuvSLqgzqTdbM/kYPZogBw0IaueTQ7nLHKVuM2AVQJdQe86wsufsWqY
         gWLOT3uqbgxwItTNlxtysvAmcPdkRSPFQgvNHIp1h4kL6CNGxwnlKmSK7sksoW1VQUg+
         msc2ORjMERmNyBxFts5+l6SQ5bcWq385VOm5KnieEYrjtEZS26nhqiiiJ8RN8RqsdIfM
         o8iYej/0ii8lMsWHCoX1ydce62IwIhlLu5SNoNrp4kjZRylnNv42Dy2k9KdKictoDiPL
         gOOpC45OsaxxJenQMz0cJHDq6JU8hWtl6KsIPmTyX2avXc238pkH4vA01SdKZn85rUZc
         ublw==
X-Gm-Message-State: ALoCoQnD2jUH9g5/Uh+J+f9qJtzpc153HnJ4Oyl02WRg5B+t7lFhNAyYnU7fYciV6vCnib7wnWoX
X-Received: by 10.52.100.3 with SMTP id eu3mr2555750vdb.68.1401813561391; Tue,
 03 Jun 2014 09:39:21 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 3 Jun 2014 09:39:21 -0700 (PDT)
In-Reply-To: <20140530180815.GI12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250629>

Thanks!

On Fri, May 30, 2014 at 11:08 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> We want to do this to make it easier to handle atomic renames in rename_ref for
>> the case 'git branch -m foo/bar foo'.
>
> In an ideal world, a part of me would rather see "git branch -m" doing
> something more targeted by only packing the two refs it is working
> with, and only when it knows it has to so the normal "git branch -m
> foo bar" case doesn't have to suffer.  But:
>
> That would be more complicated.
>
> Packing refs is not very slow and has some good benefits for
> performance of later commands.  Once we've committed to writing out a
> new pack-refs file, it's not so bad to enumerate all loose refs to get
> more benefit from writing out the new packed-refs file.
>
> Renaming refs is something usually done by humans and not by scripts
> or remote clients.  I'm not too worried about "git branch -m" in a
> tight loop getting slower.
>
> So I think this is an okay thing to do.
>
>>                                       If we can guarantee that foo/bar does not
>> exist as a loose ref we can avoid locking foo/bar.lock during transaction
>> commit
>
> That is not quite true --- there's still value in locking foo/bar to
> avoid clobbering a concurrent ref update.
>
> If git performed the entire rename transaction in the packed-refs
> file, we could avoid that race completely (for 'git branch -m foo/bar
> foo': lock refs, make sure the loose refs are pruned, perform the
> update in packed-refs, unlock refs.  for 'git branch -m foo foo/bar':
> lock foo, prune foo, lock foo/bar, prune foo/bar, perform the update
> in packed-refs, unlock refs).
>
> Even without doing that, packing refs first has a benefit in terms of
> ordering: if you do (1) delete loose foo/bar, (2) write loose foo, (3)
> rewrite packed-refs without foo/bar, then because you've packed refs
> first, no objects become unreferenced during step (1), which means
> that a hypothetical version of "git gc" that used filesystem snapshots
> would not see any relevant objects as safe to clean up no matter when
> it runs.
>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c            | 3 +++
>>  t/t3200-branch.sh | 6 +++---
>>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> With a clearer commit message,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
