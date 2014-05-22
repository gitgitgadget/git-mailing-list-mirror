From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Thu, 22 May 2014 15:53:25 -0700
Message-ID: <CAL=YDW=hytDiz5qzAMyBgXUgza+AcDhk_y3m3kAUmOdBG=F=vA@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-42-git-send-email-sahlberg@google.com>
	<20140522181722.GT12314@google.com>
	<CAL=YDWkUa2Ut=1iaMXgnjgte6g5jvXR49LBiEUNEkwv4Z-wO_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 00:53:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnbre-0005gl-O5
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 00:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbaEVWx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 18:53:27 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:58758 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaEVWx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 18:53:26 -0400
Received: by mail-vc0-f172.google.com with SMTP id ik5so1936549vcb.17
        for <git@vger.kernel.org>; Thu, 22 May 2014 15:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1UJ3TUDd5iMHD4IhVcMsVJoswGXgZ1GBcEN9eHMjZTA=;
        b=CT5MGUz1oTkF7NWp5BfolIGyM9mAvMW8So0cJi7tIyGcFNk65fikxiQ9odlNGKOiZC
         LoFMt6NlspeFHShV7CTVvr2YjQl8y9DIu4lIZfjY9zvIem+Oo3Rfb/T0KWKKbaWyYDvg
         46V5auayf7S5jwloVLIcQaNRPNINwa3HKFqm/yIKPPp9iwhZek60JoAbSWD7W+mJy2Z+
         rHLHD5b/euEltv7i4tn1saX6vMSpkv65buhaWPY1hek5VEFdIfktmrUr4/tsb0r7hG9e
         hwIkTtGR+SLtkquOn/E6iw9PYYbIaYHsClOfSKB8WAD1bs+WVI2cZmeSzrKo37s/dFvU
         H3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1UJ3TUDd5iMHD4IhVcMsVJoswGXgZ1GBcEN9eHMjZTA=;
        b=SrTjANRKml5d6Vv7qaMxvS3H3zGeW/+C4twdY8AwYHWyhR/0eo7oy86BEhlCSOfv59
         QWCUkuj2ivNOupqjBSOPdPO5QI+ynpUXt7m66/Vgu2qtAq1WOWuhejgVqxz68rqv5RRD
         SsYwktK/9Rm3p2sh4gY7W9dzN1t6RsqH0I0U3r6zUbRqStlDQQfmupRqA8ovoTA2Uetq
         rmoYvJdt3/KpiTTLm43txRW0rREfMvd/MS5C3bh7AxHGbuuzR206n3GUJ7AM0TjKwbAX
         ocYx8jiwh69A/TnButHHFhGZ8dFVzfmHEAovClvL/veIb+0jJoekLcu8zZKQeUUnbZGL
         NUGA==
X-Gm-Message-State: ALoCoQmx1FaTJJO5JJkddpqqos40PgyB+EEnRNctExkA1yRlNYo0+5TalK6HNmZoV/1Gr/logfL7
X-Received: by 10.58.186.207 with SMTP id fm15mr647948vec.4.1400799205669;
 Thu, 22 May 2014 15:53:25 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 15:53:25 -0700 (PDT)
In-Reply-To: <CAL=YDWkUa2Ut=1iaMXgnjgte6g5jvXR49LBiEUNEkwv4Z-wO_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249956>

I hate rename_ref :-)


I have reworked the transaction code to special case the deletion of
the old ref for n/n -> n  and n -> n/n renames
so that we can carefully avoid n/n.lock files to exist or prevent the
directory <-> file transition for n during these renames.

This should allow us to have rename_ref becoming reasonably
implementation agnostic, aside for that it wants to lstat the ref to
see if it is a soft link, and re-use the code for other refs backends.


Please see the ref-transaction branch.


On Thu, May 22, 2014 at 12:12 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Thu, May 22, 2014 at 11:17 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hi,
>>
>> Ronnie Sahlberg wrote:
>>
>>> Add a new flag REF_ISPACKONLY that we can use in ref_transaction_delete.
>>> This flag indicates that the ref does not exist as a loose ref andf only as
>>> a packed ref. If this is the case we then change the commit code so that
>>> we skip taking out a lock file and we skip calling delete_ref_loose.
>>
>> This seems wrong.  Can't someone else create a loose ref which will
>> shadow the packed ref and break the serializability of updates to this
>> ref?
>>
>> The above doesn't explain why we want to avoid locking the loose ref,
>> but I assume it's for the sake of the "git branch -m foo/bar foo"
>> case.  For that case, wouldn't the following sequence of filesystem
>> operations work?
>>
>>         - create $GIT_DIR/refs/heads/foo/bar.lock
>>         - create $GIT_DIR/refs/heads/foo.lock
>>         - if $GIT_DIR/refs/heads/foo/bar exists, add the ref to
>>           packed-refs (using the usual lockfile-update mechanism)
>>           and unlink $GIT_DIR/refs/heads/foo/bar
>>         - verify that current foo and foo/bar state are okay.  If
>>           not, roll back.
>>         - unlink $GIT_DIR/refs/heads/foo/bar.lock
>>         - rmdir $GIT_DIR/refs/heads/foo
>>         - rename $GIT_DIR/refs/heads/foo.lock into place
>>
>> Or:
>>
>>         - create $GIT_DIR/refs/heads/foo/bar.lock
>>         - create $GIT_DIR/refs/heads/foo.lock
>>         - verify state of all relevant refs
>>
>>         - update packed-refs to remove refs/heads/foo/bar and
>>           add refs/heads/foo
>>
>>         - unlink $GIT_DIR/refs/heads/foo/bar
>>         - unlink $GIT_DIR/refs/heads/foo
>>         - unlink $GIT_DIR/refs/heads/foo/bar.lock
>>         - unlink $GIT_DIR/refs/heads/foo.lock
>>
>
>
> I removed all the rename_ref related patches for now. rename_ref is
> probably best implemented specifically for each backend anyway.
>
> I will still produce a separate patch that will do something like this
> you suggested
> (since rename_ref is still racy and fragile)
>
>>         - create $GIT_DIR/refs/heads/foo/bar.lock
>>         - create $GIT_DIR/refs/heads/foo.lock
>>         - verify state of all relevant refs
>>
>>         - update packed-refs to remove refs/heads/foo/bar and
>>           add refs/heads/foo
>>
>>         - unlink $GIT_DIR/refs/heads/foo/bar
>>         - unlink $GIT_DIR/refs/heads/foo
>>         - unlink $GIT_DIR/refs/heads/foo/bar.lock
>>         - unlink $GIT_DIR/refs/heads/foo.lock
>>
>
> Thanks
> ronnie sahlberg
