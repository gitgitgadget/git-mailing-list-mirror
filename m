Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67B11F42D
	for <e@80x24.org>; Wed,  9 May 2018 11:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756185AbeEIL1n (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 07:27:43 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33525 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756076AbeEIL1m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 07:27:42 -0400
Received: by mail-ot0-f193.google.com with SMTP id l22-v6so39738220otj.0
        for <git@vger.kernel.org>; Wed, 09 May 2018 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=persson-cx.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AVfWgDkAG4qR3lOT+3ecO4A5RbYC0QwfkaO40NgNGks=;
        b=HDgdc4oCqNxWl0Oxsc3XChNGxznLVIc9f0VFUnll8dyvOKwpOMgo88Xkz3+VhfLtpP
         YrjnxHjPrkZBsn7pZ+Fxem3ii+9euxMd5OcP8ppRJrOFNNgkxWZQrbIOeun9krYv+Fkc
         Xyu2OkiAHcGrhFJXt8SuLk4Nc3lR748bNueAKp/h4AfTJJiws/bBcD576fRXcyLPc2mQ
         LUSERRTibFksi6Gn4ARJXolds8cF6XdqY+b3mrDPUOyPIhRqzGq8rz/fcn+pNODF6CmI
         cKLip6tsRkNs7U32PhMocRpHvfE7/y2S7fy3HaqAe1h89r/c4UgWoJUWCSBGCUJLd7ke
         WZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AVfWgDkAG4qR3lOT+3ecO4A5RbYC0QwfkaO40NgNGks=;
        b=bgqCssUeAEE64E97LaHGy1twaPVuvh4Bza2FrXqMdEmlopFHuyuC5JFcaWmRmuLbX5
         bwR1eZLYSksCwCuuVBboQePbIu1JbMe/ro0/6yBRY0qwxuTeYd7aTwVfs5eboA6dxhsE
         DeuIPKOhlNYmSie9QQXZfvAeQ5DBsV1v+2Lncd2o8q+YIaL69FqpB+AeWDVkShWiIyon
         6HvL+DI3U3HlhEDdBHrlkWs1yaoJdxkUA8ss42idaibaYQV4BTs4SlJs3jSyT2dpQmpS
         VjxjunE4CTx+NgWGPGYiqGuZStxC51KosQL9q8SqUJhDNTIISlJ1H/1NF3V1iZQbDUWR
         l8ZQ==
X-Gm-Message-State: ALQs6tDeOZOonPYTe7zlI54Fy8wfwoeUCIky0mKmroL6e4tOqigFbrUO
        yjI0hX8HWQp/M7chV1znTe1xU+ZYg1pAdY3+umY2HuW2Sio=
X-Google-Smtp-Source: AB8JxZpJwE/5G7WLWPcucj4pCZBmwJfvquszr7tfPqBQWhfXKgGY+potw46PskHm3GAZDzHoHBQjNzwK+HLenoFnTjk=
X-Received: by 2002:a9d:463:: with SMTP id 90-v6mr17419523otc.121.1525865261612;
 Wed, 09 May 2018 04:27:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:132d:0:0:0:0:0 with HTTP; Wed, 9 May 2018 04:27:21 -0700 (PDT)
From:   jens persson <jens@persson.cx>
Date:   Wed, 9 May 2018 13:27:21 +0200
Message-ID: <CAEoyyNJPZXUKi3W=Gs=3v8i4YnTL47G9oaHDoV5pvCLx78jUVQ@mail.gmail.com>
Subject: [PATCH] sha1dc: fix for compiling on AIX using IBM XLC compiler
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, first patch. I'm having trouble compiling on AIX using IBMs
compiler, leading to
unusable binaries. The following patch solved the problem for 2.17.0.
The patch below is cut&pasted via gmail to allow for firewalls, but
exists in an unmolested form on github:
https://github.com/MrShark/git/commit/44bfcaca6637e24548ec06f46fb6035a846b1=
4af

Best regards
/jp

Building on AIX using XLC every checkout gives an error:
fatal: pack is corrupted (SHA1 mismatch)
fatal: index-pack failed

Back tracking it was introduced in 2.13.2, most likely in [1]

Add a #ifdef guard based on macros defined at [2] and [3].

Should perhaps __xlc__ should should be changed to or combined with _AIX
based on the behavour of GCC on AIX or XL C on Linux.

1. https://github.com/git/git/commit/6b851e536b05e0c8c61f77b9e4c3e7cedea39f=
f8
2. https://www.ibm.com/support/knowledgecenter/SSGH2K_13.1.3/com.ibm.xlc131=
3.aix.doc/compiler_ref/macros_platform.html
3. https://www.ibm.com/support/knowledgecenter/SSGH2K_13.1.3/com.ibm.xlc131=
3.aix.doc/compiler_ref/xlmacros.html

Signed-off-by: jens persson <jens@persson.cx>
---
 sha1dc/sha1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 25eded139..68a8a0180 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -84,7 +84,7 @@
 /* Not under GCC-alike or glibc or *BSD or newlib */
 #elif (defined(__ARMEB__) || defined(__THUMBEB__) ||
defined(__AARCH64EB__) || \
        defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
-       defined(__sparc))
+       defined(__sparc) || (defined(__powerpc) && defined(__xlc__)))
 /*
  * Should define Big Endian for a whitelist of known processors. See
  * https://sourceforge.net/p/predef/wiki/Endianness/ and
--=20
2.11.0

--=20
jens persson
<jens@persson.cx>
M=C3=A4ster Olofsv=C3=A4g 24
S-224 66 LUND;SWEDEN
