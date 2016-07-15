Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371A1203C2
	for <e@80x24.org>; Fri, 15 Jul 2016 22:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbcGOWDV (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 18:03:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751262AbcGOWDT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 18:03:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 670562DA69;
	Fri, 15 Jul 2016 18:03:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DGPmT6BKvdtmx/sHR+okvfz+weI=; b=udP3rF
	h+FG1egJtrr8wCit9hVpPuS2ZfSd2Wx5Cpio6NzVPtzaM86hnpWlVNlW+iyP1wD9
	+oyyHkpbgBU9wPaHtneVeQ6Tq5gmCyxuzQxZDLtquurw6z9KTxtpU7lihu4Lk2QC
	pIYAHIkkGvCKBOCEau3jSTtTAE390mQ72wYIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sTQSt1weM+Kk2rh6lo9GZhC9PyvJtJQr
	o26GZIL1FJJ98PbgxLvQYGssT7pQFCpJ7BP/eEN8A/Yt+/8XiJitX7Vr+05nnKyM
	bt6P4HovNNIJ+3Cu3cbQ7FeeWy9u/fXoPJe/fZ3l9WmMYqQlFCwdSpkTA/m4pVHz
	KLaJSTiJy6E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6012A2DA68;
	Fri, 15 Jul 2016 18:03:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0ECD2DA67;
	Fri, 15 Jul 2016 18:03:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Andrew Keller <andrew@kellerfarm.com>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com>
	<2ED67396-2530-4D1C-8F21-1C30983DB9DC@kellerfarm.com>
	<CAPc5daWZofdZnE0VQyFX2sBQyEDvAPmU+4rmHe5rvh7eH001ZA@mail.gmail.com>
Date:	Fri, 15 Jul 2016 15:03:15 -0700
In-Reply-To: <CAPc5daWZofdZnE0VQyFX2sBQyEDvAPmU+4rmHe5rvh7eH001ZA@mail.gmail.com>
	(Junio C. Hamano's message of "Fri, 15 Jul 2016 14:19:04 -0700")
Message-ID: <xmqqh9bqlfto.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF8AC416-4AD7-11E6-8577-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> On Fri, Jul 15, 2016 at 1:30 PM, Andrew Keller <andrew@kellerfarm.com> wrote:
>> Am 15.07.2016 um 12:34 nachm. schrieb Andrew Keller <andrew@kellerfarm.com>:
>>
>>> I pulled out the source for version 2.9.1 and briefly skimmed how run_commit and
>>> prepare_to_commit work.  It seems that Git already understands that a pre-commit
>>> hook can change the index, and it rereads the index before running the
>>> prepare-commit-msg hook: https://github.com/git/git/blob/v2.9.1/builtin/commit.c#L941-L951
>>
>> Quick question: Why does Git reread the index after the pre-commit hook runs?
>
> Offhand I do not think of a good reason to do so; does something break
> if you took it out?

Ahh, I misremembered.  2888605c (builtin-commit: fix partial-commit
support, 2007-11-18) does consider the possibility that pre-commit
may have modified the index contents after we take control back from
that hook, so that is probably a good place to enumerate what got
changed.  Getting the list before running the hook can give an
out-of-date list, as you said.

Thanks.
