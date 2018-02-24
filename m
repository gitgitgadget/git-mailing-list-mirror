Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38521F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeBXAqD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:46:03 -0500
Received: from gproxy3-pub.mail.unifiedlayer.com ([69.89.30.42]:58383 "EHLO
        gproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751674AbeBXAqC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Feb 2018 19:46:02 -0500
X-Greylist: delayed 1251 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Feb 2018 19:46:02 EST
Received: from cmgw4 (unknown [10.0.90.85])
        by gproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 10D4840250
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 17:25:09 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw4 with 
        id EQR51x00X0QvKlu01QR8lQ; Fri, 23 Feb 2018 17:25:09 -0700
X-Authority-Analysis: v=2.2 cv=G85sK5s5 c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=Op4juWPpsa0A:10 a=uPAkQHdKeDEV1LCO42oA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:Date:To:Reply-To:From:Subject:Message-ID:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/ASWBJmeNS6sCkHrQJKdJ36/R9VnuKq1c4jpQTO2bXo=; b=fRMIKxkhoh5WKfXD3A1XFp2Ud2
        zGsf/FJ4/tr6YJuX1Mb4K2PRxSZYsyetYTMPZ954MHUlw2oC3scyLF8xYYkDr2u+UTdzI3KdEabZh
        tAZmXrLHaZhlE6ovcHoKB/9oi;
Received: from pool-74-104-137-100.bstnma.fios.verizon.net ([74.104.137.100]:53520 helo=homebase)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <paul@mad-scientist.net>)
        id 1epNeD-0010yM-7x
        for git@vger.kernel.org; Fri, 23 Feb 2018 17:25:05 -0700
Message-ID: <1519431904.3405.933.camel@mad-scientist.net>
Subject: Git 2.16.2: Build failure linking static libcurl / static SSL
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Git mailing list <git@vger.kernel.org>
Date:   Fri, 23 Feb 2018 19:25:04 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 74.104.137.100
X-Exim-ID: 1epNeD-0010yM-7x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-74-104-137-100.bstnma.fios.verizon.net (homebase) [74.104.137.100]:53520
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm compiling Git with my own static libcurl and my own static
LibreSSL.  They live in two different locations.

Building Curl with a pointer to my LibreSSL works fine, and compiling
Git works fine: the correct -I options are added to the compile line
when I configure with --with-openssl=/path/to/libressl/dist

However, linking fails to find the crypto and ssl libraries, because
the OPENSSLDIR lib directory is not added to the link line with -L. 
The link line in question is from Makefile:

  git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
        $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
                $(CURL_LIBCURL) $(LIBS)
  git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
        $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
                $(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)

The OpenSSL libraries are included in CURL_LIBCURL, but the -L flags
are not:

        ifdef NEEDS_SSL_WITH_CURL
                CURL_LIBCURL += -lssl
                ifdef NEEDS_CRYPTO_WITH_SSL
                        CURL_LIBCURL += -lcrypto
                endif
        endif

This section needs to add in the OPENSSL_LINK variable, or maybe it has
to go directly in the git-http-fetch/push recipe, I'm not sure which is
appropriate.  There seems to be a lot of different variables that have
similar content, that maybe should be aligned (OPENSSL_LIBSSL,
OPENSSL_LINK, LIB_4_CRYPTO, CURL_LIBCURL, etc.)

But, the -L is definitely missing:

  gcc -g -O2 -I. -DGIT_HOST_CPU="\"x86_64\"" -DHAVE_ALLOCA_H -I/work/src/git/Linux-Release-make/dist/include -I/work/src/libressl/Linux-Release-make/dist/include -DNO_GETTEXT -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -pthread -DHAVE_PATHS_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"' -o git-http-fetch   http.o http-walker.o http-fetch.o common-main.o \
        -L/work/src/git/Linux-Release-make/dist/lib -L/work/src/git/Linux-Release-make/dist/lib -lcurl -lssl -lcrypto -lidn libgit.a xdiff/lib.a  -lz -pthread -lrt
  ld: error: cannot find -lssl
  ld: error: cannot find -lcrypto

Note how the -I.../libressl/.../include option is present, but the
-L.../libressl/.../lib option is missing.
