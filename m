Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890002095B
	for <e@80x24.org>; Sun, 19 Mar 2017 10:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdCSKQb (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 06:16:31 -0400
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:33348 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdCSKQa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 06:16:30 -0400
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 351DCC6AF;
        Sun, 19 Mar 2017 11:15:33 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 2F69C100522;
        Sun, 19 Mar 2017 11:15:33 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 260666041D;
        Sun, 19 Mar 2017 10:31:11 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Add configuration options for some commonly used command-line options
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
Date:   Sun, 19 Mar 2017 11:15:33 +0100
In-Reply-To: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 19 Mar 2017 16:57:19 +0700")
Message-ID: <vpqa88hlghm.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via smtps.univ-grenoble-alpes.fr ACL (97)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 19, 2015 at 5:32 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> +### Add configuration options for some commonly used command-line options
>> +
>> +This includes:
>> +
>> +* git am -3
>> +
>> +* git am -c
>> +
>> +Some people always run the command with these options, and would
>> +prefer to be able to activate them by default in ~/.gitconfig.
>
> I was reading the .md file to add a new microproject and found this.
> Instead of adding new config case by case, should we do something more
> generic?
>
> We could have a new group defaultOptions.<command> (or
> <command>.options) which contains <option-name> = <value> where option
> names are the long name in parse-options? Then we don't have to
> manually add more config options any more (mostly, I'm aware of stuff
> like diff options that do not use parse-options).
>
> If we want to stop the users from shooting themselves in the foot, we
> could extend parse-options to allow/disallow certain options being
> used this way. Hmm?

I think the main problem is indeed "stop the users from shooting
themselves in the foot". Many command-line options change the behavior
completely so allowing users to enable them by default means allowing
the users to change Git in such a way that scripts calling it are
broken.

This also doesn't help when troublshouting an issue as these options are
typically something set once and for all and which you forget about.
This typically leads to discussion in Q&A forums like:

A: Can you run "git foo"?
B: Here's the result: ...
A: I don't understand, I can't reproduce here.

just because B has a CLI option enabled by default.

This is the same reasoning that leads Git to forbid aliasing an existing
command to something else.

OTOH, we already have almost "enable such or such option by default"
with aliases. People who always run "git am" with "-3" can write

[alias]
        a3 = am -3

and just run "git a3".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
