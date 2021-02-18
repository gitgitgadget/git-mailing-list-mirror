Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE50C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E0160295
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhBRTtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:49:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:37972 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231908AbhBRTqd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:46:33 -0500
Received: (qmail 28441 invoked by uid 109); 18 Feb 2021 19:45:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Feb 2021 19:45:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23753 invoked by uid 111); 18 Feb 2021 19:45:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Feb 2021 14:45:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Feb 2021 14:45:46 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 03/10] fsck.c: rename variables in fsck_set_msg_type()
 for less confusion
Message-ID: <YC7D6j0A9AW0X9Z9@coredump.intra.peff.net>
References: <20210217194246.25342-1-avarab@gmail.com>
 <20210218105840.11989-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210218105840.11989-4-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 18, 2021 at 11:58:33AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Rename variables in a function added in 0282f4dced0 (fsck: offer a
> function to demote fsck errors to warnings, 2015-06-22).
> 
> It was needlessly confusing that it took a "msg_type" argument, but
> then later declared another "msg_type" of a different type.
> 
> Let's rename that to "tmp", and rename "id" to "msg_id" and "msg_id"
> to "msg_id_str" etc. This will make a follow-up change smaller.

I think this is an improvement, though maybe "severity" would be a
less-generic term than "type".

>  void fsck_set_msg_type(struct fsck_options *options,
> -		const char *msg_id, const char *msg_type)
> +		const char *msg_id_str, const char *msg_type_str)
>  {
> -	int id = parse_msg_id(msg_id), type;
> +	int msg_id = parse_msg_id(msg_id_str), msg_type;

I always get nervous when a refactoring renames something away from
"foo", and then renames another thing _to_ "foo". Any untouched bits of
code are vulnerable to confusing them.

But I think the types are sufficiently different that we can mostly rely
on the compiler (though things like numeric or bool comparisons can work
with either pointers or ints), and the fact that we can see the entire
function is small enough that we can see the entire thing in the context
here.

So I think it is OK.

-Peff
