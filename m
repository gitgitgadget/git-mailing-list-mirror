Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA62C433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 23:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiDDXGw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 4 Apr 2022 19:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242361AbiDDXGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 19:06:25 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24BB31533
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 15:30:36 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 234MUXvx098758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Apr 2022 18:30:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
Subject: RE: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
Date:   Mon, 4 Apr 2022 18:30:28 -0400
Organization: Nexbridge Inc.
Message-ID: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdhIc26DvJ616oHdSNO0Qk9SgMkcOQ==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 4, 2022 4:43 PM,  Junio C Hamano wrote:
>To: git@vger.kernel.org
>Cc: git-packagers@googlegroups.com
>Subject: [ANNOUNCE] Git v2.36.0-rc0
>
>An early preview release Git v2.36.0-rc0 is now available for
>testing at the usual places.  It is comprised of 661 non-merge
>commits since v2.35.0, contributed by 80 people, 25 of which are
>new faces [*].

I rather expected this... build error hit very early on both NonStop ia64 and x86:

cc -c99 -o wrapper.o -c     -WRVU=J06.21 -g -O2 -Winline -I/usr/local-ssl3.0/include -I. -DGIT_HOST_CPU="\"NSE\"" -DCURL_STATICLIB -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND -DNO_D_TYPE_IN_DIRENT -DNO_ST_BLOCKS_IN_STRUCT_STAT -DNO_NSEC -DNO_GETTEXT -DNO_SYS_SELECT_H -DNO_POLL_H -DNO_SYS_POLL_H -DOLD_ICONV -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK -DNO_PTHREADS -DHAVE_LIBCHARSET_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY -DHAVE_OPENSSL_CSPRNG  -DSA_RESTART=0 -DHAVE_STRING_H=1 -DFREAD_READS_DIRECTORIES -DNO_POLL -Icompat/poll -DNO_STRCASESTR -DNO_STRLCPY -DNO_SETENV -DNO_MKDTEMP -DNO_UNSETENV -DNO_MMAP -DNO_PREAD -DNO_INTPTR_T -DNO_HSTRERROR -DNO_MEMMEM -Icompat/regex -DSHELL_PATH='"/usr/coreutils/bin/bash"'  wrapper.c

  	int res = RAND_bytes(buf, len);
  	          ^
"wrapper.c", line 817: error(114): identifier "RAND_bytes" is undefined

I thought we did not have a direct reference to OpenSSL. What do I need here to resolve this?

--Randall

