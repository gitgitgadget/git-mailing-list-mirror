Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44A61F5FB
	for <e@80x24.org>; Sat, 25 Feb 2017 03:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbdBYDGL (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 22:06:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52037 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751348AbdBYDGK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 22:06:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEA1A6D44F;
        Fri, 24 Feb 2017 22:05:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=zNSnWaxLqhjIVuej71IcjfIfMUw=; b=AMndXC
        CWcJRjs1jP1dKuXgvy5e2ThBgeNsq8sDm3QvCyBMqK7h/3S2mPqtC1szKZzLp5sg
        TQelZtNZaodrVyy/DKhmFmf5dvtL1xtWMuFiL1dMNHU+ru3CwNPK3tSWsv//Jknq
        VU4WNfeyU3XlXR1uNdCrAv/3UX3MGXgy9vBd8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4AC96D44D;
        Fri, 24 Feb 2017 22:05:08 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E5196D44C;
        Fri, 24 Feb 2017 22:05:08 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] delete_ref: accept a reflog message argument
In-Reply-To: <CACsJy8BJgL1i85nZ9CpAXCKaG+PQQkjRKLFPWzbsMF8WN8TEjQ@mail.gmail.com>
References: <20170217035800.13214-1-kyle@kyleam.com> <20170221011035.847-1-kyle@kyleam.com> <20170221011035.847-2-kyle@kyleam.com> <CACsJy8BJgL1i85nZ9CpAXCKaG+PQQkjRKLFPWzbsMF8WN8TEjQ@mail.gmail.com>
Date:   Fri, 24 Feb 2017 22:05:05 -0500
Message-ID: <87poi7c6n2.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36A35B6C-FB07-11E6-98E0-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=zNSnWaxLqhjIVuej71IcjfIfMUw=; b=w6H4K7YBD3kKZUVouQ+YNMwVTt34eMoc9d35pMGvhH1MLxQ1nJe+wan+t/FuzPfup3OiM1P+q00I+Zuc9scjzgvAmOxdxgK47wMqeJ83LPE5T7vo2z/YmZfZVU0+UCCeJtxPsmpVMzvDAAV+JSrLpQy4LWDhSuJbRgakw1dwWCU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> You'll probably want to update the comment block above if msg can be
> NULL. We have _very_ good documentation in this file, let's keep it
> uptodate.

Looking at how other functions in refs.h document their "msg" or
"logmsg" parameter, none seem to mention it explicitly.  update_ref
refers to ref_transaction_update, and
ref_transaction_{update,create,delete,verify} refer to ref.h's
"Reference transaction updates" comment.

delete_ref's docstring already mentions that "flag" is passed to
ref_transaction_delete, so perhaps it should mention "msg" here as
well.

-- >8 --
Subject: [PATCH] delete_ref: mention "msg" parameter in docstring

delete_ref() was recently extended to take a "msg" argument.
---
 refs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index e529f4c3a..988750218 100644
--- a/refs.h
+++ b/refs.h
@@ -274,7 +274,8 @@ int reflog_exists(const char *refname);
  * verify that the current value of the reference is old_sha1 before
  * deleting it. If old_sha1 is NULL, delete the reference if it
  * exists, regardless of its old value. It is an error for old_sha1 to
- * be NULL_SHA1. flags is passed through to ref_transaction_delete().
+ * be NULL_SHA1. msg and flags are passed through to
+ * ref_transaction_delete().
  */
 int delete_ref(const char *msg, const char *refname,
 	       const unsigned char *old_sha1, unsigned int flags);
-- 
2.11.1

