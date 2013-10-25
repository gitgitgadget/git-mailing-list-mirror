From: Johan Herland <johan@herland.net>
Subject: Re: Fwd: Errors when diff'ing arbitrary upstream remotes are not
 intuitive if git pull --all hasn't been done
Date: Fri, 25 Oct 2013 09:25:56 +0200
Message-ID: <CALKQrgdfcDzq+M4Pi=DdbSPXCDCcXRtk6qV7qhvyHviJoJXA8A@mail.gmail.com>
References: <CAGH67wSf_RQigCmqRZKOpHdV9ELqE=078mkpwA4dfnUr=AvGVQ@mail.gmail.com>
	<CAGH67wRwb1A9CzAfod_XLRVFBRyoEron8tmM+NbMGOeKDVf2Hg@mail.gmail.com>
	<20131025061407.GE11810@sigill.intra.peff.net>
	<20131025061459.GA23524@sigill.intra.peff.net>
	<CALKQrgc0u8TA4mXc+2Hv+Fyo8EYNuiickF_janeCxkzFn+xAvA@mail.gmail.com>
	<20131025071048.GA16856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "yaneurabeya ." <yanegomi@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 09:26:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZbme-0005t9-KP
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 09:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab3JYH0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 03:26:04 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:47466 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab3JYH0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 03:26:03 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VZbmS-00086H-Qr
	for git@vger.kernel.org; Fri, 25 Oct 2013 09:26:00 +0200
Received: from mail-pb0-f41.google.com ([209.85.160.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VZbmS-000AFM-D9
	for git@vger.kernel.org; Fri, 25 Oct 2013 09:26:00 +0200
Received: by mail-pb0-f41.google.com with SMTP id rp16so3887784pbb.14
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 00:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hDsFNk5Oe2SmfiANh0SusgUFjOzHRSCU80GkQ8UokFU=;
        b=mtc27H/bIfdwRAShUhU03KkbRD8XZ0sG5rcoL6v4fWAw4omTG8c0FHjutz9GYVzD1a
         hUGPYeL6xdoJ1mmKBz31z9vsqjQkzHeoYC2e1dmcSWB/7U6JCciSlszx2d3ucrr12OJl
         aQHXQ/Ua/uK2qc426l1im1v1wBvtZJhwcl+RkCvT0Qknlbglpqf9OKrcKv3niGLzaIfR
         QcRUYfkccskKIJaTP0ZkqhDoCcvQPT1UUvDjJrxG2gpxiAGXoRE7E/TP/jVqCaVTb5UZ
         7WHx7cAUO58ONVQ8CjWl3+lXx6M6x0VwGE4DWNe4gGCNPNDQaOYiMDMghYSTq5+w6m4K
         +iQw==
X-Received: by 10.67.14.231 with SMTP id fj7mr9152925pad.115.1382685956580;
 Fri, 25 Oct 2013 00:25:56 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Fri, 25 Oct 2013 00:25:56 -0700 (PDT)
In-Reply-To: <20131025071048.GA16856@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236693>

On Fri, Oct 25, 2013 at 9:10 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 25, 2013 at 09:03:41AM +0200, Johan Herland wrote:
>>  1. Split the input on the first '/' into $remote/$branch, and use the
>> preceding part ($remote) as a potential remote name, and the following
>> part ($branch) as a potential branch name. (Although it is
>> theoretically possible to have remote names containing slashes, I
>> don't think anybody uses them, and we have considered disallowing
>> them, mainly because of this very issue: it makes "$remote/$branch"
>> parsing (even more) ambiguous)
>
> What I specifically meant is that this breaks with a remote like:
>
>   [remote "foo"]
>     fetch = +refs/heads/*:refs/remotes/bar/*
>
> The correct advice for "bar/branch" is to recommend "git fetch foo", and
> the correct advice for "foo/branch" is nothing at all.
>
> I know such config is unusual, but I thought there was a recent push for
> us to be accurate about finding the local side of remote tracking
> branches, rather than just assuming they start with "$remote". Maybe I
> am misremembering, though; I thought it was related to potentially
> shifting the default refspecs.

Obviously, you're right. Sorry about that, haven't had my morning coffee yet. :(

> The procedure along those lines would be:
>
>   for each remote
>     for each fetch-refspec in remote
>       if refspec.rhs contains "refs/remotes/$failed_branch"
>         recommend "git fetch $remote"
>
> I was just wondering if we had something to make that "does this refspec
> contain this ref" part easier.

Yes, I found the following code in branch.c (added in 41c21f2), which
does a similar thing. Might want to refactor that into something more
general:

+static int check_tracking_branch(struct remote *remote, void *cb_data)
+{
+       char *tracking_branch = cb_data;
+       struct refspec query;
+       memset(&query, 0, sizeof(struct refspec));
+       query.dst = tracking_branch;
+       return !(remote_find_tracking(remote, &query) ||
+                prefixcmp(query.src, "refs/heads/"));
+}
+
+static int validate_remote_tracking_branch(char *ref)
+{
+       return !for_each_remote(check_tracking_branch, ref);
+}


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
