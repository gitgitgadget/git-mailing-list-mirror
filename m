Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB79C3F2D2
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 16:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9332120637
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 16:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpL4oYxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgCEQvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:51:31 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34723 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCEQvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 11:51:31 -0500
Received: by mail-yw1-f68.google.com with SMTP id o186so6257819ywc.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2020 08:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lxZ6t3rkiaTAvQSJm3juI/uWX3T1zKo28V1luIBg8sk=;
        b=EpL4oYxd8Af8xBJvSzRnBJlLkfHLRo8DqwMJwqiCl4bq3LznYr5GveKOjHdfgNCVGQ
         /vaCxgZ4lZBWZi8OTGZX3JDwSg1hVgv7YDjdwbjpy3+R/hAVNN+nOH8b838gI0NOcje/
         Aj+ED1o9Z0IyXrNjOTG1sj/HrZV/K3at5bSzM5URyjayfxa1iFiQ6ThFwNeV7yLd+e3r
         FPd5VYhW9uPvMjODzNtDHXDnebplrwTnn0Lp43wYXhtL/1PrSaXMiGugnZl69ZMGcRpn
         XwaITTyrDpEUkN6dgHELmm4jGbGEZu00SqWz20/jVV8jMGum84z0Di2YLMcldC7p8q+Q
         A+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lxZ6t3rkiaTAvQSJm3juI/uWX3T1zKo28V1luIBg8sk=;
        b=l6U/vqQ1a1d+HXnJW6bCmzo6RZcn7NQUpMxILUguaBMSQbpnkmN+d5Inr+cLOu89NQ
         9Zuh/Ik9g6zWQrfZfSk9gqR3uaNtfYlwjUd9wadi/DwP51flpCMiuFCWaFFHuX2Cs30O
         8Pc5bQ2UUXYz7lhJJHk0AbrEen6LLslJPExh1jvIRk18cuH1S8hGx2pj8E1a6l2+SD10
         Q+7z2/FomP53KEXmgj5zgd29CJ1gBeY6fZ7RHksvK2hdvE1MF8b0apJe1U5RAasMLmDV
         +oyvG0Igi1BL42PwgzrpeDcyIHqo0+Tf26t5V6wWGrvKoMRVC1aLkw5z+i+qBB3nMi7O
         /8ig==
X-Gm-Message-State: ANhLgQ3jXO/NFHPHUhXQ8iVsw43RjHXaYlcVJgT9vC4lJa0nb/N6FUwK
        dpwAK8FOlv0yVg1k2PKrBw9yQBdA5JAy8MXr5YRuKwbua7iAEQ==
X-Google-Smtp-Source: ADFU+vsl26LZmVKjJbrvwYkW9W1jFzNCcBZ+8Gm1Ibv5RNPcSVZGB4tILOPlRwFpLIIPXKRNuYBEs/eQyCkbecKhV70=
X-Received: by 2002:a25:e08e:: with SMTP id x136mr3101701ybg.238.1583427089999;
 Thu, 05 Mar 2020 08:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com> <xmqqv9nj4zxk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9nj4zxk.fsf@gitster-ct.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 6 Mar 2020 00:51:19 +0800
Message-ID: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] New execute-commands hook for centralized workflow
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=885=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:39=E5=86=99=E9=81=93=EF=BC=9A
>
> I do not claim to be great at naming, but you are worse ;-)

I totally agree that I am not good at naming, for example my daughter's nam=
e.

>  - Any hook is about executing command(s), so "execute-commands"
>    hook does not give any information to users.
>
>  - IIUC, this is only about what happens when accepting a push and
>    is not called at any other time.  Naming your hook without
>    "receive" anywhere in its name would mean other people won't be
>    able to add hook that "executes" commands upon cues other than
>    receiving a push.
>
> I can guess why you chose that name, because I know there is a
> function called execute_commands() in "git receive-pack", but that
> is not somethhing you can expect your end users, who are not
> intimate to our codebase, to know.

Yes, it's better to name the hook "* -receive", because the hooks are
for different commands, such as "commit-msg" is for `git commit`.

> > We can use the external "execute-commands" hook to create pull requests
> > or send emails.
>
> You can create pull requests or send emails out of the post-receive
> hook, so that is not a convincing justification why we want a new
> hook.

Another solution is using "pre-receive" + "post-receive" to handle a
push to "refs/for/master".  The "post-receive" hook is used to create
a pull requst and delete the special reference "refs/for/master"
created between these two hooks.  But having a temporary reference
created is not safe for concurrent pushes.

> Now, I understand that Gerrit-style "notice a push to for/<target>,
> take over the whole operation that happens after receiving the pack
> data and do something entirely different, such as attempting to run
> a merge with refs/heads/<target> and update refs/heads/<target>
> instead, or fail the push if automerge fails" is not easy to arrange
> within the current "pre-receive" + "post-receive" framework (by the
> way, we should start considering to deprecate "update", and
> "post-update" hooks as these "*-receive" hooks were added to replace
> them, perhaps we should leave a #leftoverbits mark here).  And I
> think it is reasonable to add a new hook that takes over the whole
> flow in "git receive-pack" to do so.
>
> I just do not think "the execute-commands hook" is a good name for
> it.  Perhaps "divert-receive" (as it diverts large portion of what
> receive does) or something?  I dunno.

I suggest naming the hook as "process-receive", which is executed
between the other two "p*-receive" hooks, and no need to create a
special "pre-receive" for "process-receive".

> How do Gerrit folks deal with the "we pushed to the server, so let's
> pretend to have turned around and fetched from the same server
> immediately after doing so" client-side hack, by the way?

In the following example, I push a local commit to a special reference
(refs/for/master) of the remote Gerrit server.  The "report()"
function (if Gerrit has one) says a new reference "refs/for/master"
has been created.  But in deed, there is no such reference created in
the remote repository, Gerrit will create another reference instead,
such as "refs/changes/71/623871/1", for user to download the code
review .  Because the local repository only has normal
"remote.<name>.fetch" config variables for remote tracking, so git
will not create a tracking reference for "refs/for/master".  Command
line tool, such as Android "repo" (or the reimplemented git-repo in
Golang), will create a special reference
(refs/published/<local/branch>) for tracking, and these tools are
responsible for banch tracking.

    $ git push --receive-pack=3D"gerrit receive-pack" origin
refs/heads/master:refs/for/master
    Enumerating objects: 13, done.
    Counting objects: 100% (13/13), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (11/11), done.
    Writing objects: 100% (12/12), 1.34 KiB | 171.00 KiB/s, done.
    Total 12 (delta 2), reused 0 (delta 0), pack-reused 0
    remote: Resolving deltas: 100% (2/2)
    remote: Processing changes: refs: 1, new: 1, done
    remote:
    remote: SUCCESS
    remote:
    remote: New Changes:
    remote:   http://gerrit.example.com/c/my/repo/+/623889 Test commit
    To ssh://gerrit.example.com:29418/my/repo
     * [new branch]      master -> refs/for/master


> A vanilla "git push" on the client side does not know a push to
> refs/for/master would result in an update to refs/heads/master on
> the server side, and it would not know the result of the munging
> done on the server side (whether it is to rebase what is received on
> top of 'master' or to merge it to 'master') anyway, the

Neither Gerrit nor our AGit-Flow server will update the master branch.
Our AGit-Flow server will create a special reference (like GitHub's
"refs/pull/<number>/head") for reviewers to download commits.

> remote-tracking branch refs/remotes/origin/master on the client side
> would be left stale.  If we wanted to help them pretend to have
> fetched immediately after, I think we need to extend the protocol.
> Right now, after accepting "git push", the server end will say, for
> each proposed update for a ref, if the push updated successfully or
> not, but to support the "push to for/<target>, get heads/<target>
> updated" interaction, the reporting of the result (done in the
> report() function in builtin/receive-pack.c) needs to be able to say
> what ref (it may be a ref that "git push" did not think it pushed
> to) got updated to what value (it may be an object the client does
> not yet have---and we may have to actually turn around and fetch
> from them internally if we want to keep the illusion).

I have no idea now how to make a simple patch to give an accurate report.
