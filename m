Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B943207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 18:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbdFZS3K convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 26 Jun 2017 14:29:10 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:50817 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbdFZS3I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 14:29:08 -0400
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v5QIT6Zx013731
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 26 Jun 2017 18:29:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v5QIT5QE019130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 26 Jun 2017 18:29:06 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v5QIT5SP025151;
        Mon, 26 Jun 2017 18:29:05 GMT
Received: from oracle.com (/24.246.5.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Jun 2017 11:29:05 -0700
Date:   Mon, 26 Jun 2017 14:29:03 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     ?var Arnfj?r? Bjarmason <avarab@gmail.com>
Cc:     Michael Kebe <michael.kebe@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
Message-ID: <20170626182903.ysdhwiuvqqqtisgq@oracle.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <87lgofcf7r.fsf@gmail.com>
 <CAKKM46syoE90y-+5okxtk7A982ztaDFem8aL6GrxWhS4gGSGqg@mail.gmail.com>
 <87h8z2dig8.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87h8z2dig8.fsf@gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* ?var Arnfj?r? Bjarmason <avarab@gmail.com> [170626 08:47]:
> 
> On Mon, Jun 26 2017, Michael Kebe jotted:
> 
> > No luck with the patch.
> >
> > Still got:
> >
> >     CC sha1dc/sha1.o
> > sha1dc/sha1.c:43:58: error: operator '==' has no right operand
> >       (defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) ||   \
> >                                                           ^
> > gmake: *** [sha1dc/sha1.o] Error 1
> 
> Does this patch change anything, with or without the previous patch:
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 047172d173..1327aea229 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -131,6 +131,14 @@
>  # else
>  # define _XOPEN_SOURCE 500
>  # endif
> +
> +/*
> + * Bring in macros defining _BIG_ENDIAN etc. Should be brought in by
> + * the likes of stdio.h, but include it here in case it hasn't been
> + * included already.
> + */
> +#include <sys/isa_defs.h>
> +
>  #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
>        !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
>        !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
> 

This addition still fails on Solaris for me.  It appears that _BIG_ENDIAN is
defined but with no value on this platform.


> >
> > Greetings
> > Michael
> >
> > 2017-06-26 10:42 GMT+02:00 Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
> >>
> >> On Mon, Jun 26 2017, Michael Kebe jotted:
> >>
> >>> When compiling 2.13.2 on Solaris SPARC I get this error:
> >>>
> >>>     CC sha1dc/sha1.o
> >>> sha1dc/sha1.c:41:58: error: operator '==' has no right operand
> >>>  #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
> >>>                                                           ^
> >>> gmake: *** [sha1dc/sha1.o] Error 1
> >>>
> >>> The define _BIG_ENDIAN is set by Solaris on SPARC systems. So the
> >>> check in line 41 gives this error.
> >>>
> >>> The _BIG_ENDIAN define is used few line below for defining
> >>> SHA1DC_BIGENDIAN. This is needed for Solaris SPARC systems.
> >>> See
> >>> https://github.com/cr-marcstevens/sha1collisiondetection/commit/33a694a9ee1b79c24be45f9eab5ac0e1aeeaf271
> >>
> >> I can see why this would error out. In sys/isa_defs.h on SPARC there's
> >> just `#define _BIG_ENDIAN`
> >> (http://src.illumos.org/source/xref/illumos-gate/usr/src/uts/common/sys/isa_defs.h),
> >> and (on Linux):
> >>
> >>     $ cat /tmp/test.c
> >>     #define _FOO
> >>     #define _BAR 1
> >>     #if (_BAR == _FOO)
> >>     #endif
> >>     $ gcc -E /tmp/test.c
> >>     # 1 "/tmp/test.c"
> >>     # 1 "<built-in>"
> >>     # 1 "<command-line>"
> >>     # 31 "<command-line>"
> >>     # 1 "/usr/include/stdc-predef.h" 1 3 4
> >>     # 32 "<command-line>" 2
> >>     # 1 "/tmp/test.c"
> >>     /tmp/test.c:3:18: error: operator '==' has no right operand
> >>      #if (_BAR == _FOO)
> >>
> >> What I don't get is how this would have worked for Liam then (see
> >> 20170613020939.gemh3m5z6czgwmzp@oracle.com). Differences in Solaris
> >> versions and how their headers look like?

I am running Linux and 2.13.2 compiles and works fine for me on SPARC.


If you want to keep the compact layout you have in the #if defined()
portion, you can get away with reversing the logic as follows:

--------- >8 -------------
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index facea1bb5..808b520cd 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -36,20 +36,20 @@
 #undef SHA1DC_BIGENDIAN
 #endif

-#if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
+#if !(defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))

-#if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
-     (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
-     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )
+#if (defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN) || defined(__BIG_ENDIAN__) || \
+     defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
+     defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
+     defined(__sparc))
 #define SHA1DC_BIGENDIAN
 #endif
 
 #else
+#if ((defined(_BYTE_ORDER) && defined(_BIG_ENDIAN)) || \
+     (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
+     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )

-#if (defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN) || defined(__BIG_ENDIAN__) || \
-     defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
-     defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
-     defined(__sparc))
 #define SHA1DC_BIGENDIAN
 #endif

