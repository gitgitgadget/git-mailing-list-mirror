Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA03920189
	for <e@80x24.org>; Mon, 20 Jun 2016 02:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbcFTCJb (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 22:09:31 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36463 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbcFTCJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 22:09:29 -0400
Received: by mail-qk0-f173.google.com with SMTP id p10so145222730qke.3
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 19:08:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MXsbbymDr9/44PJJaSnfE4id/GTikoO84VVCwljCAyI=;
        b=Go2ZCD7nq+bU6IfQgo9pMMCyJE8VCqic1UATdemWE2qS1gVwNIGYOYfs1FkvlPlfB5
         SutwBrs+lJyM7GVgdAY2pXtk6oES/KuzaZIjz0B5N5rImSI9EzAv54l+w9iKqPbQUx8E
         XRawO0kYY/TsTVsjsJN7kdZaSOw0YiwS5IJTGCy8O+iGNP6Rp5+anR2velVcy3HMQQwj
         xKNVRMUNmXyQmeHTpDPkxnunRCCwSTGeUmxJvq3Rmnegjp2aETcdeq+hd2lpFzVmlaR8
         3N7luHQlVHDYJTmlgCZoBF1EzLUNbuvBohjx6WBqDs3ScPYwqDPKqqMNewAYRdY4lGjX
         /WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MXsbbymDr9/44PJJaSnfE4id/GTikoO84VVCwljCAyI=;
        b=WLBCmHU+IeZbJbSnyyq9lUFWwJ/+1jkmB+hsT/1MwWt71dPRG0wAKNJu0D/rc6v/cH
         G+sfL3GJep5LJ+Mye+dxPNhDauniHnsWYx6q2iLXQSWFvpNOmpSs34gYi18edG4gqZiA
         mV4SrGq0x/SfDzgdnLQd3GOvVSTnQkZUL/WymDcohlrLigyGOjB77OjrUWdPPtGkC20S
         w66CzbgnZPDvp0d8on2ESDkot8ZqFfiDdGC9ajfq8XYNrCD1YxShjbvO0QgH2jnl/e2+
         DYS+foFosV+4o5SvRHNa82KRaSciGUEOiRkFGQkePETHdlWi6TcsMHzryg4n641so2Hu
         Y3YQ==
X-Gm-Message-State: ALyK8tLUJykti8r/raCB8E0rMz5GtsM38rSs/+U1j5tPMsThXmz+90WZs2Tg/9xeCRZuZrbiGOeLCax+UV+xMf3s
X-Received: by 10.233.223.5 with SMTP id t5mr17471081qkf.35.1466388063123;
 Sun, 19 Jun 2016 19:01:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Sun, 19 Jun 2016 19:01:02 -0700 (PDT)
In-Reply-To: <5765D752.4000404@eagerm.com>
References: <5765D752.4000404@eagerm.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Sun, 19 Jun 2016 19:01:02 -0700
Message-ID: <CAGZ79kYqtLGHjEirP=6ssiUf2fuHirtKDXr117bjwomho2uf3A@mail.gmail.com>
Subject: Re: Managing sub-projects
To:	Michael Eager <eager@eagerm.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 18, 2016 at 4:20 PM, Michael Eager <eager@eagerm.com> wrote:
>
> Any other ways to do what I want without creating a separate forked
> repo for each of the sub-projects?  Or have I misunderstood one of
> these schemes?

I think forking is the way to go here, as you want to have new code
and maintain that.

I assume you want to keep the history for each project separate, so
I would recommend against using subtrees.

git slave looks interesting for your use case. (I looked at it once
before, but have no deep knowledge about it as it is not part of core git)

IIUC the repo tool is tailored to be a multi-repo manager optimised
for usage with Gerrit, not just plain Git. The repo tool tracks branches
in the subproject instead of versions (as submodules do), so consistency
is hard, specially when looking back in history. (Not sure if you care about
that, but if you want to use e.g. git bisect, having an easy reproducable
history is a must)

Personally I would try out submodules.

> Git submodule:  Branches created in the sub-projects are pushed to the
> upstream repo, not to my repo.  I tried to change origin and created an
> upstream reference, but was not able to get changes pushed to my repo.

Beware that there are 2 areas you need to look at. First the submodule repo
needs to have a remote that points away from the projects origin (to your
private fork).

Then you have to look at the superproject that
1) records the sha1 for the submodules internally
2) all other information except the tracking sha1s must be user provided,
    where the .gitmodules file contains recommendations (i.e. the url where to
    obtain the submodule from, whether to clone it shallowly,
    if we have a specific branch in mind). The contents of that file
    are not binding, e.g. if the url provided in the .gitmodules file becomes
    outdated later, it is still possible to setup the
submodule/superproject correctly.

However for your business purpose, you would put the url of the private forks
in the recommended URL of the submodules.

As the superproject only tracks the sha1, and has this recommended pointer
where to get the submodule repository from, you need to take special care
in a rebase workflow, because the old rebased commits fall out of the
reachability
of the graph of objects, e.g.:

Say you have a version `abc` in a submodule that is one commit on top of
canonical projects history, and `abc` is recorded as the sha1 in the
superproject.

Then you rebase the commit in the submodule to a newer version of the upstream,
which then becomes a new commit `def` and `abc` is not referenced any more,
so it can be garbage collected.

This is bad for the history of the superproject as it then points to
an unreachable
commit in its history.

To preserve the historic non-rebased `abc` commit, you could have a
set of branches
(or tags) that maintain all the old non rebased versions.

This problem comes up with submodules with any workflow that requires
non fast forward changes (forced pushes), I think.

So maybe you need to have an alias in the submodule for rebasing, that
is roughly:

rebase:
    if rebased history is published
        create a tag, e.g.: "$(date -I)-${sha1}"
        (and push that tag here or later?)
    rebase as normal
    carry on with life

To get back to your complaint:

>  I tried to change origin and created an
> upstream reference, but was not able to get changes pushed to my repo.

I would imagine this to be

     (cd submodule && git remote set-url origin <your fork> && git push origin)

for plain pushing in the submodule and then

    $EDIT .gitmodules
    # edit submodule.<name>.url to point at <your fork>

to get the superproject correct.

Thanks,
Stefan














>
> --
> Michael Eager    eager@eagercon.com
> 1960 Park Blvd., Palo Alto, CA 94306  650-325-8077
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
