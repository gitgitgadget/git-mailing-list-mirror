Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC4620401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbdFOV4H (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:56:07 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35231 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdFOV4G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:56:06 -0400
Received: by mail-pg0-f51.google.com with SMTP id k71so12072690pgd.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WGZDRMepQCKDHs459npIX+Jq4+MhHquSJHLABmu3pig=;
        b=leKNsib66k4iqrDSg+Aqgo8j4Ji9Nw5s3dI1rB0ZQ/ryVdEaPEQQsCspAY6eNut/Aw
         M5Qh8JQGWD+pMNHWAoPDsfItqdXhGHZwDDbyhPiCvtWY0fl4lZBpjIf3rI10tuVueBzI
         ObnTU1MUrw2TzqPZas/knLRNvHfryCciaOxi2t/0OAAUN/G13Q+Ss9YVylComDGaxvXk
         2pRKzZ2o0nX01G6P1fdX3EtIgcm/HfpF7PRXbyBnfE34XLqOuXyBOXjDndAkcrj0KwIQ
         /xvfunzWHqa2aoaU56Bb4Yk6GeSWdIVSfXBCnA3ob/ueEYtQP+Ou6QP1v74BNV15cgr3
         sC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WGZDRMepQCKDHs459npIX+Jq4+MhHquSJHLABmu3pig=;
        b=eQj6KNn7FIBxt7iUyJW3nC4ZR9C+JzT7WLwy4gKitgYEI9pGQhtd3iJeA18pmGYovJ
         hAjSpKGQ5s2OvYxC/RsqLrROc9XQBHLqOd6Qe51OX53otKZyJLFzYR7c0y5J/7Tz5ten
         BKOQEaxKHvwctnEYjB6JyZKC2bL8D0bwu1jnNPQaQt/UM0tsP6dKyn4u2ShhgJwKBirr
         SFZ1Jf3JLGEIMFuLg3Zv3BgfZgCn9pC1ZRLldD9rKPMcEvRwa5ykw523Mm5PJc9ZM7d5
         ICQthxVBUysl6EBCJFqaom3W4AmI1lI22BcGERUn3bBf0xJ1GQvRy11gTAx+ymKb/O4I
         KXkQ==
X-Gm-Message-State: AKS2vOx9NGDSoRf4zlIc08qm/LA5lpVwioqoAxTzy3b12O2CI80ZmWcr
        UTJ1pEXTg8uGdQ==
X-Received: by 10.98.210.199 with SMTP id c190mr7509938pfg.157.1497563765786;
        Thu, 15 Jun 2017 14:56:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id 189sm405826pgi.66.2017.06.15.14.56.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 14:56:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] checkout: don't write merge results into the object database
References: <b46827a5-2a8f-c343-ac1f-814fc8a16943@web.de>
        <20170615135751.qxn6bsfsxz5es236@sigill.intra.peff.net>
        <f7d38553-484b-ee81-e059-2c737dad2bc4@web.de>
Date:   Thu, 15 Jun 2017 14:56:03 -0700
In-Reply-To: <f7d38553-484b-ee81-e059-2c737dad2bc4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 15 Jun 2017 17:48:18 +0200")
Message-ID: <xmqqefukzzik.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> If it is a concern, I think it could be solved by "unpretending" after
>> our call to checkout_entry completes. That would need a new call in
>> sha1_file.c, but it should be easy to write.
>
> Good point; we'd accumulate fake entries that we'll never need again.

Hopefully we are not pretending to have the same object from two
callsites; this one may knows the merged one no longer needs to be
in core, but some other callsite wanted to pretend a blob with the
same contents is in the object store, what happens to it?  I do not
think we want to refcount ;-)

> The patch should clean them up.
>
> Alternatively we could finally address the NEEDSWORK comment and
> provide a way to checkout a file without faking an index entry..

Yeah, we should not need index entry, and we should not need the
blob object name.

    ... thinks a bit more ...

Having said that, in the longer term, it may be safe to write an
actual object out to the object store.  The convert-to-working-tree
backends currently work only on raw bytes, but it is not inplausible
for some new interfaces to want to pass the object name to the
backend and tell it either togive raw (converted) bytes back, or to
write out the bytes directly to the filesystem, bypassing the main
Git process.  If we "pretend" in this process, not just we accumulate
cruft in-core as Peff points out, we risk giving out an invalid object
name to such external mechanisms.

I do not think it is too bad to leave a handful of temporary blobs
that are written out by "git checkout -m <other-branch>" in the
object store to be GC'ed.

