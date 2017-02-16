Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EACD51FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbdBPSWS (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:22:18 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:52695 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933120AbdBPSWR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:22:17 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 88666C8B2;
        Thu, 16 Feb 2017 19:22:15 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (mailhost.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 823B91004A9;
        Thu, 16 Feb 2017 19:22:15 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 77148125EA8;
        Thu, 16 Feb 2017 19:22:15 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>,
        git@vger.kernel.org, pranit.bauva@gmail.com, peff@peff.net,
        pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 1/4 v4] revision.c: do not update argv with unknown option
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
        <1487258054-32292-2-git-send-email-kannan.siddharth12@gmail.com>
        <vpqwpcqm69k.fsf@anie.imag.fr>
        <xmqqwpcqxay0.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 16 Feb 2017 19:22:15 +0100
In-Reply-To: <xmqqwpcqxay0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 16 Feb 2017 10:11:35 -0800")
Message-ID: <vpqwpcqgfmw.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
>>
>>> handle_revision_opt() tries to recognize and handle the given argument. If an
>>> option was unknown to it, it used to add the option to unkv[(*unkc)++].  This
>>> increment of unkc causes the variable in the caller to change.
>>>
>>> Teach handle_revision_opt to not update unknown arguments inside unkc anymore.
>>> This is now the responsibility of the caller.
>>>
>>> There are two callers of this function:
>>>
>>> 1. setup_revision: Changes have been made so that setup_revision will now
>>> update the unknown option in argv
>>
>> You're writting "Changes have been made", but I did not see any up to
>> this point in the series.
>
> Actually, I think you misread the patch and explanation.
> handle_revision_opt() used to be responsible for stuffing unknown
> ones to unkv[] array passed from the caller even when it returns 0
> (i.e. "I do not know what they are" case, as opposed to "I know what
> they are, I am not handling them here and leaving them in unkv[]"
> case--the latter returns non-zero).  The first hunk makes the
> function stop doing so, and to compensate, the second hunk, which is
> in setup_revisions()

Indeed, I misread the patch. The explanation could be a little bit more
"tired-reviewer-proof" by not using a past tone, perhaps

1. setup_revision, which is changed to ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
