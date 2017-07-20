Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195ED1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 22:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965987AbdGTW1w (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 18:27:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63130 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965970AbdGTW1p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 18:27:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E080D8EB0E;
        Thu, 20 Jul 2017 18:27:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EFp2M44sqD/L
        8XLdb9TfZWXliok=; b=xMZyijvju6ilSw1DK9gJMmHqh3yLvW8J62gLSpSg/pQE
        1Ph6cNis2ih8AiKhoIz1sp5Kk74IIEscVZKKwn1m5hDcmuQOQVIQg1AeXEKl5u52
        ZlvScH2jqbMFMp44R3KE/w0zCx2mBxFqnauwakjgua0azZb2udlwWp6f3x+ATTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L5DplG
        0Mm3EaDQj1FJ0J1m8TsC7ypEsSpGUSmsfqrpxdoyeLDrLpnOhhpAKXlI0giC0Co+
        LDn6FJz2phVWdbWG86uyaMfTzZGdmfW0mYQcaZ1CLlD25wjBQ//6jmyQxQfUVEXD
        NuGaP1VLnVAJ4qK8r/NdCgLgiIo9jNZ/K4+CA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8E518EB0D;
        Thu, 20 Jul 2017 18:27:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 196698EB0C;
        Thu, 20 Jul 2017 18:27:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 00/10] tag: only respect `pager.tag` in list-mode
References: <cover.1499723297.git.martin.agren@gmail.com>
        <cover.1500321657.git.martin.agren@gmail.com>
Date:   Thu, 20 Jul 2017 15:27:36 -0700
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Mon, 17 Jul 2017 22:10:42 +0200")
Message-ID: <xmqq379qkalj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2C3379E-6D9A-11E7-8026-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> This is the second version of "[PATCH 0/7] tag: more fine-grained
> pager-configuration" [1]. That series introduced `pager.tag.list` to
> address the fact that `pager.tag` can be useful with `git tag -l` but
> actively hostile with `git tag -a`. Thanks to Junio, Peff and Brandon
> for helpful feedback.
>
> After that feedback, v2 drops `pager.tag.list` and instead teaches
> `git tag` to only consider `pager.tag` in list-mode, as suggested by
> Peff.
>
> Patches 1-3/10 replace patch 1/7. They move Documentation/technical/
> api-builtin.txt into builtin.h, tweak the formatting and bring it up to
> date. I may have gone overboard making this 3 patches...
>
> Patches 4-7/10 correspond to patches 2-5/7. `setup_auto_pager()' is now
> much simpler since we do not need to handle "tag.list" with a clever
> fallback strategy. IGNORE_PAGER_CONFIG is now called DELAY_PAGER_CONFIG=
.
> I now check with pager_in_use() and I moved the handling of `pager.tag`
> a bit further down.

I tend to agree with you that 1-3/10 may be better off being a
single patch (or 3/10 dropped, as Brandon is working on losing it
nearby).  I would have expected 7-8/10 to be a single patch, as by
the time a reader reaches 07/10, because of the groundwork laid by
04-06/10, it is obvious that the general direction is to allow the
caller, i.e. cmd_tag(), to make a call to setup_auto_pager() only in
some but not all circumstances, and 07/10 being faithful to the
original behaviour (only to be updated in 08/10) is somewhat counter
intuitive.  It is not wrong per-se; it was just unexpected.=20

> Patches 8-9/10 teach `git tag` to only respect `pager.tag` in list-mode
> and flip the default value for that config to "on".
>
> Patch 10/10 is somewhat similar to a hunk in patch 2/7, but is now a
> bug-fix instead of a feature. It teaches `execv_dashed_external()` not
> to check `pager.foo` when launching `git-foo` where foo is a builtin.
> I waffled about where to put this patch. Putting it earlier in the
> series as a preparatory step, I couldn't come up with a way of writing =
a
> test. So patch 8/10 introduces a `test_expect_failure` which this patch
> then fixes.

I haven't thought about ramifications of 9-10/10 to make a comment
yet, but overall the series was a pleasant read.

Thanks.
