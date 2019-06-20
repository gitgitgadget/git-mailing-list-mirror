Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B811F461
	for <e@80x24.org>; Thu, 20 Jun 2019 22:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfFTWVb (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 18:21:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53027 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfFTWVb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 18:21:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C681A168539;
        Thu, 20 Jun 2019 18:21:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1JeSiI2HkhYXurKeK2HQpo76VlM=; b=LdcCU+
        jkqtliMIlUQ52BfYYXCGTRWJMoQ3PHirgomauxPean6FUQJjVGcjYGXrlRR7OQKy
        71kK3ifu9NsZrt5eomqveTWOvx2ZBRd+ujKTl+Ywh6aEmu4A76KCco4hQL0Wq060
        PXXZVv1IsqK5iPiPhhE1OvgJbwirf//cHasR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kaWL7/MybQA/IiqgGr5MCql58sSPHqi3
        3RFwWViO8Yssxm7D1UTb3bNNwkgyvEtcnJSZNFfyuYKgFRnpJMzmr1grI+EPDXrq
        guSjtIO28HYMdPcLR9O++os3exm2FmcnYG8szuxaknHswG/DebUwdVRcPv4gOFus
        GWB9/tlAlBE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE8CC168538;
        Thu, 20 Jun 2019 18:21:28 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21299168537;
        Thu, 20 Jun 2019 18:21:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/8] env--helper: new undocumented builtin wrapping git_env_*()
References: <20190619233046.27503-1-avarab@gmail.com>
        <20190620210915.11297-3-avarab@gmail.com>
        <xmqqpnn7lxet.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 20 Jun 2019 15:21:27 -0700
In-Reply-To: <xmqqpnn7lxet.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 20 Jun 2019 15:11:38 -0700")
Message-ID: <xmqqlfxvlwyg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF685A0A-93A9-11E9-9E96-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> as I am getting
>
>     error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> from here.
>
> Giving an otherwise useless initial value to ret would be a
> workaround.

I've added this on top of the topic before merging to keep the
integration going at least for now.

commit 8f86948797a1152594a8dee50d0878604fec3e80
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Jun 20 15:13:14 2019 -0700

    SQUASH??? avoid maybe-uninitialized

diff --git a/builtin/env--helper.c b/builtin/env--helper.c
index 2bb65ecf3f..29df0567fb 100644
--- a/builtin/env--helper.c
+++ b/builtin/env--helper.c
@@ -43,6 +43,9 @@ int cmd_env__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(env__helper_usage, opts);
 
 	switch (cmdmode) {
+	default:
+		BUG("wrong cmdmode");
+		break;
 	case ENV_HELPER_BOOL:
 		tmp_int = strtol(env_default, (char **)&env_default, 10);
 		if (*env_default) {
