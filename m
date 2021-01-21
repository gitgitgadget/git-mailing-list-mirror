Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97882C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 06:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C95238EE
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 06:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbhAUGNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 01:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbhAUGNo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 01:13:44 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A966AC06179A
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 22:12:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w1so951778ejf.11
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 22:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iA3xQhB//VokeEbfMXNyLDTPMntXQ6SKQUTE2ZSvAA8=;
        b=JLDwbe4TaFL4SOZZZgXWY1yWp25XvfexvkMxmLQVwbYsWPeQr32fH6Jq1rkCL5smyt
         JjIcqm9iCb2E8aBf1NLlgoC0g8FyNJief3zTbNxWdRS2wupqjdBapkXRhcw2KmJEcmvk
         0J/h8QlQcrTp6HCl4jx7IAGwvFTWZkbpYLOrEZR05S4SV/N1JDqps1Dn5iACjBpGcapo
         9VHcRgXiQyIbY6QCRyRvISeSsjzD9h9fa2rlYkkYuhVl8ks7lZJlMCDAqwS7VQSBFZ+u
         WGJBYUvMidOOjlbHJg3TRTDeVpGpuWp6KRLGif6zI85aV9Y0sluMDjhnQ+uV/8liLGDN
         kFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iA3xQhB//VokeEbfMXNyLDTPMntXQ6SKQUTE2ZSvAA8=;
        b=Uf8p5d9jtGRN8X5pLys/kO3B2gOxQi4uzJRD0Q78HeVZnGLrVkuLc2jmh6DRxmReP1
         36/MzSVaM6os0agIgThExr7xAwiisa6ChNf5bKrI5unGtvF2JQP/tBmSMQJ8VYbjwltV
         Her2lWGR3geUonjeVkCilDvJ/XNSg+l7V94CCjmNqqGMbrmL/sMW8znt9qRrf8wDi7FN
         lNjfYUIOjQL3AhowHaxpDaAuBOIzoFasE0mVre+XILPZzrh6vW/0kC136kk8ioVRW/mv
         zLDQHsQjIQ+6CAU+YYYE7XG+wLq3G2oIYYrVFKK2Tnw9GJ5J++/wcORFMfoC8254hGSz
         siHA==
X-Gm-Message-State: AOAM532i5gFfQnqLYx1V6EnHUfeyXYo9OFhfEXvL/n/LQcs9LB8smYda
        VarairlkYYjVYAOZ7I4fZwHO+TdxvxQ=
X-Google-Smtp-Source: ABdhPJz++kcv+EEDcDnwauupgJPOSpgMLjrDSWphTSDMdp0U19nt7NEXrq7elgSMtHw0smnlblHPCA==
X-Received: by 2002:a17:906:4690:: with SMTP id a16mr8374806ejr.442.1611209541450;
        Wed, 20 Jan 2021 22:12:21 -0800 (PST)
Received: from szeder.dev (92-249-246-25.pool.digikabel.hu. [92.249.246.25])
        by smtp.gmail.com with ESMTPSA id g17sm2165096edb.39.2021.01.20.22.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 22:12:20 -0800 (PST)
Date:   Thu, 21 Jan 2021 07:12:19 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v19 03/10] receive-pack: add new proc-receive hook
Message-ID: <20210121061219.GF8396@szeder.dev>
References: <20200824174202.11710-1-worldhello.net@gmail.com>
 <20200827154551.5966-4-worldhello.net@gmail.com>
 <20210117222151.GY8396@szeder.dev>
 <CANYiYbE358amO95JStnspS-N-9WMYENiYspdKtsGsUc7Hv5jWw@mail.gmail.com>
 <20210120122858.GZ8396@szeder.dev>
 <CANYiYbEKi=DD5-7Ss4KMF4zXNxGr2cABed--T-uwAzSf2KA-nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANYiYbEKi=DD5-7Ss4KMF4zXNxGr2cABed--T-uwAzSf2KA-nw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 10:21:36AM +0800, Jiang Xin wrote:
> SZEDER Gábor <szeder.dev@gmail.com> 于2021年1月20日周三 下午8:29写道：
> >
> > On Mon, Jan 18, 2021 at 04:24:11PM +0800, Jiang Xin wrote:
> > > SZEDER Gábor <szeder.dev@gmail.com> 于2021年1月18日周一 上午6:21写道：
> > > >
> > > >
> > > > This patch added a whole lot of test cases, and two of them '86 -
> > > > proc-receive: not support push options (builtin protocol)' and '95 -
> > > > proc-receive: not support push options (builtin protocol/porcelain)'
> > > > are prone to rare failures.
> > > >
> > > > On Thu, Aug 27, 2020 at 11:45:44AM -0400, Jiang Xin wrote:
> > > > > diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
> > > > > new file mode 100644
> > > > > index 0000000000..d0c4da8b23
> > > > > --- /dev/null
> > > > > +++ b/t/t5411/test-0026-push-options.sh
> > > >
> > > > > +# Refs of upstream : master(A)
> > > > > +# Refs of workbench: master(A)  tags/v123
> > > > > +# git push -o ...  :                       refs/for/master/topic
> > > > > +test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
> > > > > +     test_must_fail git -C workbench push \
> > > > > +             -o issue=123 \
> > > > > +             -o reviewer=user1 \
> > > > > +             origin \
> > > > > +             HEAD:refs/for/master/topic \
> > > > > +             >out 2>&1 &&
> > > >
> > > > Three relevant things are happening here:
> > > >
> > > >   - 'git push' is executed with its standard output and error
> > > >     redirected to the file 'out'.
> > > >
> > > >   - 'git push' executes 'git receive-pack' internally, which inherits
> > > >     the open file descriptors, so its output and error goes into that
> > > >     same 'out' file.
> > > >
> > > >   - 'git push' is expected to fail when it finds out that the other
> > > >     side doesn't support push options, but it does so with a simple
> > > >     die() right away, without waiting for its child 'git receive-pack'
> > > >     process to finish.
> > > >
> > > > > +     make_user_friendly_and_stable_output <out >actual &&
> > > > > +     test_i18ngrep "fatal: the receiving end does not support push options" \
> > > > > +             actual &&
> > > > > +     git -C "$upstream" show-ref >out &&
> > > >
> > > > Here the shell opens and truncates the file 'out' to write 'git
> > > > show-ref's output, i.e. it is still the same 'out' file that was used
> > > > earlier.
> > > >
> > > > Consequently, it is possible that 'git receive-pack' is still running,
> > > > its open file descriptors to 'out' are still valid, and its "fatal:
> > > > the remote end hung up unexpectedly" error message about the suddenly
> > > > disappeared 'git push' can partially overwrite the output from 'git
> > > > show-ref'.
> >
> >
> > > > I think these are the only two tests that can cause this racy
> > > > behavior: by instrumenting finish_command() I found that in all other
> > > > tests where 'git push' is expected to fail it errors out gracefully
> > > > and waits for its 'git receive-pack' child process.
> > >
> > > Atomic push may have the same problem.
> >
> > I don't think so, because send_pack() doesn't die() when a ref is
> > rejected in an atomic push, but returns, and lets its caller terminate
> > in an usual way, including waiting for 'git receive-pack'.
> 
> I find many places where the client side will die() before closing the
> service side gracefully:
> 
>  + In `transport_push()`, if fail to push a submodule, will die().
>  + In `git_transport_push()`, will die() for an unimplemented v2 protocol.
>  + In `send_pack()`, will die() if
>     the server side has an incompatible hash algorithm, or
>     the receiving end does not support --signed push, or
>     the receiving end does not support --atomic push, or
>     the receiving end does not support push options

Sure, but it seems that those are not covered in thet 5411.

You can build Git with the patch below, run t5411 with '-V -x', and
then look through all the cases to see where 'git push' waited or did
not wait for its 'git receive-pack' child process.

diff --git a/run-command.c b/run-command.c
index ea4d0fb4b1..4accdb343e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -988,6 +988,7 @@ int start_command(struct child_process *cmd)
 int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
+	dprintf(3, "finish_command(): '%s'\n", cmd->argv[0]);
 	trace2_child_exit(cmd, ret);
 	child_process_clear(cmd);
 	return ret;
