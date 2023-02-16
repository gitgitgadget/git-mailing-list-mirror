Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DEEC636D7
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 17:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjBPRVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 12:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjBPRVV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 12:21:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443334ECF3
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:21:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x4-20020a17090a388400b002349a303ca5so2272665pjb.4
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5hiMidztyzHilVeYMZ+DJIT489F5HbhxUEeXI5hQ+I=;
        b=VMzIzoWbaCCkVvvfciajcGYfgJplgXNoQn76Cx9491exrmlZHz7/zSIhCxDmSUJ7O0
         l+nPJpepNRR/H4IGoaVF8vTzYGHNBQnU2uGOYg/5Gv0BqcBPRbvleQK+4n2uNVpt8gDC
         ZfD6BJP/YZyhjOvQlc9SjpQD8dhFnXNJu+090+9iVi4I3xVBotMAXA/4LkvWhfkfGS8n
         PToNxTtAcn+b6q7qAsN0O3iJmhFGTR24EbBY3T58Sd3mvG9NEgHbJbhA+swpgcOGtl3q
         lbwU2oPl/KWwXUCm1elJVXw7YP/95vYdmLjoRom9uEyPLXfZrbNxWJxj6Lips75mRhqt
         dCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5hiMidztyzHilVeYMZ+DJIT489F5HbhxUEeXI5hQ+I=;
        b=zwvR0XSe+40IPEXxsL6WCWnCaHHKHS6ieGgITt+GJlNZfUfMk5mkaDQiysaXfAjMXk
         eWx2DC6b8ZQqqf/on2P0wjkQozY2U6d8W3y+H0FwH1zWu4W11rmf0ToNdtdnU7MR4T4H
         ynPthM1099JTgrl8mvA7clebHIfE2r5JBu/IGbtFfdUuQPYPpvuef79mxVHc4PaTqQF4
         I13cNvcamRG9pstYXGc3j7bUL76I4SCn2mds7U36ufDnAGCV85XMJfMFbp04bBuUnI30
         q0ovae3X3Q2ZOE6/RZgQ6OR0ZFQrbtFs86sIs5lhJh+nZRSFdm6mN0EmzArbDjvuG8GE
         YZnQ==
X-Gm-Message-State: AO0yUKUh0hwHe23wzF0HMUmnC4l5D47Q/BIO+BQCL4rmVib4nJwRj1mv
        N9Pyxthedq4Ou7m7jCGg4Yo=
X-Google-Smtp-Source: AK7set8WGiO9uO1y2Kx17udT13phNGe0bSgd1cg2nsPtglmslHjDs/RFu9dZmQFzwQRi6hr7RWcXQA==
X-Received: by 2002:a17:902:f251:b0:19a:7900:dd8d with SMTP id j17-20020a170902f25100b0019a7900dd8dmr5428295plc.35.1676568076565;
        Thu, 16 Feb 2023 09:21:16 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id a73-20020a63904c000000b004fb3e5681cesm1477147pge.20.2023.02.16.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 09:21:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] shorten_unambiguous_ref(): avoid sscanf()
References: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
        <Y+z3RfhAxW/2iNYP@coredump.intra.peff.net>
        <20230216055641.brlx3os2ucj3ywer@tb-raspi4>
        <CAPig+cR3fNVnLcfR0K85YgVo3go2p9cbC9ekdmm=orh0WQ+HwQ@mail.gmail.com>
Date:   Thu, 16 Feb 2023 09:21:15 -0800
In-Reply-To: <CAPig+cR3fNVnLcfR0K85YgVo3go2p9cbC9ekdmm=orh0WQ+HwQ@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 16 Feb 2023 01:16:35 -0500")
Message-ID: <xmqqlekxr0fo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> d) Mention MacOs here ?
>
> Certainly, a good idea.

Yes.

>> test_expect_success 'symbolic-ref --short handles complex utf8 case' '
>>         name="测试-加-增加-加-增加" &&
>>         git symbolic-ref TEST_SYMREF "refs/heads/$name" &&
>>         # In the real world, we saw problems with this case only under MacOs Ventura
>
> I'm on ancient High Sierra (10.13) using HFS+, so the problem is not
> Ventura-specific. The original bug report did mention Ventura (which
> presumably is using APFS).

I do not think the bug is in sscanf() and not in the code that deals
with filenames in the filesystem.  The symbolic-ref TEST_SYMREF is
implemented by writing the problematic string into a regular file,
and we read it as a stream of bytes---there is no chance for things
like filename normalization the filesystem tries to do to corrupt
it.  So reference to "under macOS Ventuara" I think is about their C
library, not a particular filesystem it uses.

How about a bit more detail on sscanf(), like this?

 t/t1401-symbolic-ref.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git c/t/t1401-symbolic-ref.sh w/t/t1401-symbolic-ref.sh
index be23be30c7..dafcb4d61b 100755
--- c/t/t1401-symbolic-ref.sh
+++ w/t/t1401-symbolic-ref.sh
@@ -192,11 +192,13 @@ test_expect_success 'symbolic-ref pointing at another' '
 test_expect_success 'symbolic-ref --short handles complex utf8 case' '
 	name="测试-加-增加-加-增加" &&
 	git symbolic-ref TEST_SYMREF "refs/heads/$name" &&
-	# In the real world, we saw problems with this case only
-	# when the locale includes UTF-8. Set it here to try to make things as
-	# hard as possible for us to pass, but in practice we should do the
-	# right thing regardless (and of course some platforms may not even
-	# have this locale).
+	# In the real world, we saw this case misbehaved on macOS only
+	# when the locale includes UTF-8, back when "symbolic-ref --short"
+	# used sscanf(3) as part of its implementation.  Set it here to
+	# try to make things as hard as possible for us to pass, but in
+	# practice we should do the right thing regardless (and of course
+	# some platforms may not even have this locale), as we no longer
+	# use platform sscanf(3) there.
 	LC_ALL=en_US.UTF-8 git symbolic-ref --short TEST_SYMREF >actual &&
 	echo "$name" >expect &&
 	test_cmp expect actual

