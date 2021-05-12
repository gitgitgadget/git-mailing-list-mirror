Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92256C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7393E6191D
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhELB7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 21:59:45 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38949 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhELB7l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 21:59:41 -0400
X-Greylist: delayed 7727 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2021 21:59:41 EDT
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620784713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/jQs2c7cSMdUawgfy22yWQO3G2/3cOQVqXehQoN2DD0=;
        b=FPQyq9ZskoAg8RGyg1IXgY93DX8bML8oYtnvWkk/XGOKESbIcdEy4tkgxxsBTGlLdD8ggG
        XDrn1rxeaVGrFIIBC6RGyg/FZkIlOnrxdTPm93kQUt/w5XnlOIZblZtcMr4Yku7TAIoXtx
        D9NDqr+1vGgfYEyHweRmx10GmHhXCIIFP1M5Lq0hGkGAPrsu1i9o3wjkQX8S6xkifSmvR3
        mQ+v+FGhFCWFdUKjRrV8HX2VezTCmIq0lX76puvuhSO0Ds+XskfqEkY03+V5EsdFBnpD1k
        X4VNHFDwfxPsaSUnb/t66qZzV+D62ERkKmQIFOwTIvyiP5e9SufPxB57YUgwuw==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BBBEEFF803;
        Wed, 12 May 2021 01:58:32 +0000 (UTC)
Date:   Tue, 11 May 2021 19:58:29 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJs2RceLliGHI5TX@gpanders.com>
References: <20210511191510.25888-1-greg@gpanders.com>
 <609ae32e3b9f_60649208e0@natae.notmuch>
 <YJrsTu5YtGNpQvZh@gpanders.com>
 <609b0017a323b_6064920888@natae.notmuch>
 <YJsDAnHcnro6Gfk4@gpanders.com>
 <YJslulEQFvPkyo/R@coredump.intra.peff.net>
 <609b2aa26aa5b_678ff20893@natae.notmuch>
 <YJsuYAc+NniTWBc8@coredump.intra.peff.net>
 <609b34d66a0bc_678ff2083@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <609b34d66a0bc_678ff2083@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 May 2021 20:52 -0500, Felipe Contreras wrote:
>Jeff King wrote:
>> On Tue, May 11, 2021 at 08:08:50PM -0500, Felipe Contreras wrote:
>>
>> > > Yeah, that was mentioned in the thread I linked earlier. I think it
>> > > would be a fine solution, too. It would probably make sense for it to
>> > > use the shell, as suggested elsewhere, and to call it "smtp-command" for
>> > > consistency with other parts of Git (I'm thinking particularly of
>> > > GIT_SSH versus GIT_SSH_COMMAND, where the latter was introduced to fix
>> > > the defect that the former could not provide any arguments).
>> >
>> > But it would be "smtpserver-command", and I don't think that the best
>> > naming, because it doesn't necessarily have anything to do with SMTP, or
>> > a server.
>> >
>> > I think simply sendemail.command is perfectly fine.
>>
>> Aren't there many other "commands" run by send-email, like --to-cmd and
>> --cc-cmd? It probably should indicate somehow that it is the command for
>> sending mail. I agree it does not have to say "SMTP". If it is meant to
>> be compatible with sendmail, then maybe "sendemail.sendmailCommand" and
>> "--sendmail-cmd" would work.
>
>Yes, although I find sendemail.sendmailCommand awfully redundant.
>I would prefer sendemail.mainCommand, but to me sendemail.command
>implies it's the main command as opposed to all ther other commands.
>
>Just like there's many presidents in USA (of companies, organizations,
>and student unions), but when you say "the president of USA" it's
>understood which president you are talking about.
>
>Cheers.
>
>-- 
>Felipe Contreras

I agree with Jeff here. While I also find sendemail.sendmailCommand 
redundant, it makes more sense when used as a command line option:

     git send-email --sendmail-cmd <cmd>

Conversely, `--command` is more ambiguous and less clear. Explicitly 
using `sendmailCommand` makes it clear that the user is specifying a 
command that is compatible with the `sendmail` program.
