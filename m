Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90C3201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 22:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbdKOWIU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 17:08:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60490 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753199AbdKOWIS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 17:08:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B58B6B0D40;
        Wed, 15 Nov 2017 17:08:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9FTtq7hYgeHw3wkwdYoKsqjSNTY=; b=Rd0Os+WKcayfZx4bHQgN
        cuW4FfEGfMw0owyPYGBWBrUXKbp9OijPeJ7uQSXOvSJRqatCKM25gz8jn4ZrGFeW
        TDU2YfiBa9BjrMnwgu59l8IzM27oz9BCIKwHCpodZHnwAXmWrqsSOPOzduUAEuvp
        OXKYES/xFPPUerqdqkgmRfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=wFXTk2QCPs0C1ZmIkSgMyX1+68wYenoib7I4pMd+TZHASo
        d0ShtiTR2JdCy+fGKCsp6nOqa2mhGfVSA21Wpv6aQv3HAU+8bJUeks1xMaoXIvsE
        9DjITni66Ys+IZIq/QQf3MwCdT03AhRPw32loWbdtq4FZpt2RDZ3KKQYkRp+U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE462B0D3F;
        Wed, 15 Nov 2017 17:08:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F39FB0D3E;
        Wed, 15 Nov 2017 17:08:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug in "revision.c: --all adds HEAD from all worktrees" ?
References: <CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com>
        <CAE5ih7_uuVVrze9gNr3JMg5HNH8eAcH_wM4wrc2kH6u=Hw0JOg@mail.gmail.com>
Date:   Thu, 16 Nov 2017 07:08:13 +0900
Message-ID: <xmqqtvxvyz3m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A5BD4B4-CA51-11E7-BFAA-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> Quite a few of the worktrees have expired - their head revision has
> been GC'd and no longer points to anything sensible
> (gc.worktreePruneExpire). The function other_head_refs() in worktree.c
> bails out if there's an error, which I think is the problem. I wonder
> if it should instead just report something and then keep going.

Am I correct to understand that your "git fsck" would fail because
these HEAD refs used by other stale worktrees are pointing at
missing objects?

What do you mean by "expired"?  "Even though I want to keep using
them, Git for some reason decided to destroy them." or "I no longer
use them but kept them lying around."?

If the latter, I wonder "worktree prune" to remove the
admininstrative information for them would unblock you?
