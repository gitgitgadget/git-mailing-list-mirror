Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2685C2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 16:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755589AbcJZQvH (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 12:51:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50007 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754876AbcJZQvG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 12:51:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11F5847296;
        Wed, 26 Oct 2016 12:51:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YSJjHGYYEHTq
        JLx266+SXLyV18E=; b=ViLQIX9oNQSN+BnVQgHP9xVf5BuFJBJetSnc6cpHETG+
        QR6KM26fJriNncfsq5njZuJrqWWVFBtdEGWKTFiTXs9a4J5qFbD5yPeIrFL0AoxY
        rEXimAwEuFcbcpm0KW7+h1tuhitFdAh4vFNgWYcgbGx3MX3xzyu4b527mUKcGVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kPmL9N
        JgSNflmYGWKx+6SXYkIJFMocBaBOj4uqWbJJ0QZudA5MM2EMRMTlg8Y2Wa3d/XGP
        JKrLmzEqQvMu61HyfnP00/ecUiotFN8qd5NHPTN/gLqqiUv8+4B0hcKaIf1cEuf3
        SYdKuOADUE8VARMaqSsX+3nWd7nqou0doOzDM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A4C747295;
        Wed, 26 Oct 2016 12:51:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 819CC47294;
        Wed, 26 Oct 2016 12:51:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase: add --forget to cleanup rebase, leave HEAD untouched
References: <20161026094658.20704-1-pclouds@gmail.com>
Date:   Wed, 26 Oct 2016 09:51:02 -0700
In-Reply-To: <20161026094658.20704-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 26 Oct 2016 16:46:58 +0700")
Message-ID: <xmqq60ofcavd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6229BB8E-9B9C-11E6-9496-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> There are occasions when you decide to abort an in-progress rebase and
> move on to do something else but you forget to do "git rebase --abort"
> first. Or the rebase has been in progress for so long you forgot about
> it. By the time you realize that (e.g. by starting another rebase)
> it's already too late to retrace your steps. The solution is normally
>
>     rm -r .git/<some rebase dir>
>
> and continue with your life. But there could be two different
> directories for <some rebase dir> (and it obviously requires some
> knowledge of how rebase works), and the ".git" part could be much
> longer if you are not at top-dir, or in a linked worktree. And
> "rm -r" is very dangerous to do in .git, a mistake in there could
> destroy object database or other important data.
>
> Provide "git rebase --forget" for this exact use case.

Two and a half comments.

 - The title says "leave HEAD untouched".  Are my working tree files
   and my index also safe from this operation, or is HEAD the only
   thing that is protected?

 - I think I saw a variant of this gotcha for an unconcluded
   cherry-pick that was left behind, which the bash-prompt script
   did not notice but the next "git cherry-pick" did by complaining
   "you are in the middle" or something like that.  Perhaps we would
   want to have a similarly sounding option to help that case, too,
   not in this patch but as another patch on the same theme?

 - Would it have helped if bash-prompt were in use?  I am not saying
   that this patch becomes unnecessary if you use it; I am trying to
   see if it helps its users by reminding them what state they are
   in.

