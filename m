Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7764D1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 19:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbcGKTTq (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 15:19:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750767AbcGKTTp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 15:19:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B0742C2D3;
	Mon, 11 Jul 2016 15:19:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/KaJJA8CA69VVEYDnUeYJK5wrXQ=; b=xduq7O
	jLXP4PkNmZpw0HJVIZiYp+m2h5Vxb2XDuyLGOl+TwQwhPlNwxc3D3O6laYHPWDjK
	6TAyIYtyWPU574Djne1Zmu6yo+ItgXjsCOfl/BBrOk063HjIvlgmLGwFHU19BDzK
	T9PImy6BaBBkzjTs6NvPOzjDng861LoVeQa4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HPUiAbBP40YS9IOWEqHUzobVjiAIEvHy
	cZg6yMCDlSFOCyZsiIdX/1NqKFjD4jIHFiuywdmlsvLteMBEcfw05ya9Rbd1tDWm
	u4b72WxZRg96uEHNVQUsDGdmGkyUE4eK6RtN5bOk6zuf+v9xFRYmZSIaD+sLexrX
	rSxCTrTSFms=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F2FC2C2D2;
	Mon, 11 Jul 2016 15:19:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E76E32C2D1;
	Mon, 11 Jul 2016 15:19:43 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com
Subject: Re: [PATCH v4 0/6] convert various shell functions in git-bisect to C
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
	<20160706202523.9850-1-pranit.bauva@gmail.com>
Date:	Mon, 11 Jul 2016 12:19:42 -0700
In-Reply-To: <20160706202523.9850-1-pranit.bauva@gmail.com> (Pranit Bauva's
	message of "Thu, 7 Jul 2016 01:55:17 +0530")
Message-ID: <xmqqy4587zjl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C629912-479C-11E6-A5D1-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Some minor nits. Previous version can be found here[1].
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/298263
>
> The inter-diff is :
> ...
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> ...
> Pranit Bauva (6):
>   bisect--helper: `bisect_clean_state` shell function in C
>   t6030: explicitly test for bisection cleanup
>   wrapper: move is_empty_file() and rename it as
>     is_empty_or_missing_file()
>   bisect--helper: `bisect_reset` shell function in C
>   bisect--helper: `is_expected_rev` & `check_expected_revs` shell
>     function in C
>   bisect--helper: `bisect_write` shell function in C
>
>  builtin/am.c                |  20 +---
>  builtin/bisect--helper.c    | 220 +++++++++++++++++++++++++++++++++++++++++++-
>  cache.h                     |   3 +
>  git-bisect.sh               |  97 ++-----------------
>  t/t6030-bisect-porcelain.sh |  17 ++++
>  wrapper.c                   |  13 +++
>  6 files changed, 261 insertions(+), 109 deletions(-)

Will replace.  Thanks.

