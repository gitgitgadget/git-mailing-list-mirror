Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7AFC433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 17:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38669206C3
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eFgZ2n2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgFHRSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:18:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51852 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgFHRSN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 13:18:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC4E4C3C52;
        Mon,  8 Jun 2020 13:18:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Iir4bOe4gxKoMGs7wrIeQS8BrA=; b=eFgZ2n
        2oHz18VTm+EkxlUkGi9kmAunt1wvGAXinteSCEJrNw1kHDyBrBzDjRC4kc9EYPJL
        xe81VK/x7nA0e5g7iUi9QDzN2oAYYuuHKawfMECoCY1YY7fE+far5Qdw30R0k3Ms
        i8w+RdE2t95zcezRLwQ4fsDFXA9l//zhaR5/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kK5YFe4Z/v/o40p7sHyFtwFafpPfRzh4
        ck0kFxu3zwXE1XxycybYgsxUioCm8CzKEX6c3FRTl74tEanPXYpUcwcDIXmvDfXh
        XHiYbWMk7rDVu2qozahLB7kau0U1ZE6PQxqskx+UVt+gIbb08Kb63aj9jjq+1xzO
        +6fZj8puwKY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E328FC3C51;
        Mon,  8 Jun 2020 13:18:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E5A9C3C4E;
        Mon,  8 Jun 2020 13:18:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Kyle Evans <kevans@freebsd.org>, Jeff King <peff@peff.net>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: fread reading directories
References: <CACNAnaG19QD1PbVS93nFm3XY70CZCrRosmVq-_3j+puAKSPj9Q@mail.gmail.com>
        <xmqqd06an6wf.fsf@gitster.c.googlers.com>
        <CACNAnaHBPeg1SMMGUdErKnn12bGo8t3O7LU6Yktw40B7bKfBGA@mail.gmail.com>
Date:   Mon, 08 Jun 2020 10:18:07 -0700
In-Reply-To: <CACNAnaHBPeg1SMMGUdErKnn12bGo8t3O7LU6Yktw40B7bKfBGA@mail.gmail.com>
        (Kyle Evans's message of "Sun, 7 Jun 2020 12:16:26 -0500")
Message-ID: <xmqqlfkxlbn4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0638F750-A9AC-11EA-AC25-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Evans <kevans@freebsd.org> writes:

> On Sun, Jun 7, 2020 at 12:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Kyle Evans <kevans@freebsd.org> writes:
>>
>> > I was looking at FREAD_READS_DIRECTORIES to measure some performance
>> > differences, then stumbled upon [0] that dropped fread() from the
>> > autoconf test that causes git to use its git_fopen shim [1] even on
>> > Linux.
>>
>> I thought we saw this mentioned recently?  I do not recall if
>> any concrete improvement came out of it.
>>
>
> Ah, this is my bad. =-( I had searched the archives (I'm not typically
> subscribed to this list) and noticed the related patch for GNU/Hurd,
> but completely missed that a more active discussion had taken place
> within that thread. I have now read that, and have no further
> questions.

For the benefit of those who are watching from sidelines, the
relevant thread ends at

https://lore.kernel.org/git/20200424055106.GG1648190@coredump.intra.peff.net/

In short, many callers of fopen() in our code rely on our variant of
fopen() that notices that the caller fed us a directory for error
reporting.  Unless the caller somehow knows the argument it calls
fopen() with is a file and not a directory, somebody needs to
fopen() and fstat() (or stat() and then fopen()) to catch it as an
error to give that caller a directory.  In the current arrangement, 
we let our fopen() wrapper do that task, instead of the callers.

It may make sense to do one of the two things:

 - The lighter weight one is to rename the macro to the reflect the
   trait we are trying to capture more faithfully: "fopen opens
   directories" and leave the code and performance characteristics
   as-is.

 - Heavier weight one is to audit callers of fopen() and only let
   those that know they do not have a directory directly call
   fopen().  The other callers would call our wrapper under a
   different name.  This way, the former won't have to pay the
   overhead of checking for "you gave me a directory but I only take
   a file" error twice.  This is what Brandon proposed in the
   thread.

Doing neither would leave this seed of confusion for later readers,
which is not ideal.  I am tempted to say that we for now should do
an even lighter variant of the former, which is to give a comment.

Thoughts?

 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 09f98b777c..a0bef206a9 100644
--- a/Makefile
+++ b/Makefile
@@ -19,8 +19,7 @@ all::
 # have been written to the final string if enough space had been available.
 #
 # Define FREAD_READS_DIRECTORIES if you are on a system which succeeds
-# when attempting to read from an fopen'ed directory (or even to fopen
-# it at all).
+# when an fopen() on a directory does not result in an error.
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 #
