Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0CA71F597
	for <e@80x24.org>; Tue, 31 Jul 2018 12:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbeGaONF (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:13:05 -0400
Received: from felt-1.demon.nl ([80.101.98.107]:33717 "EHLO felt.demon.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732233AbeGaONF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:13:05 -0400
Received: from [192.168.129.6] (x006.home.local [192.168.129.6])
        by felt.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id w6VCWmOO10158222;
        Tue, 31 Jul 2018 12:32:48 GMT
Subject: Re: Is detecting endianness at compile-time unworkable?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net>
 <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
 <20180729192753.GD945730@genre.crustytoothpaste.net>
 <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
 <20180729200623.GF945730@genre.crustytoothpaste.net>
 <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
 <87wotdt649.fsf@evledraar.gmail.com>
From:   Michael Felt <aixtools@felt.demon.nl>
Message-ID: <73cd8ad3-f093-b82e-9726-b27f2214629d@felt.demon.nl>
Date:   Tue, 31 Jul 2018 14:32:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87wotdt649.fsf@evledraar.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------91902AAA5543DB694032FFB1"
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------91902AAA5543DB694032FFB1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 7/30/2018 11:39 AM, Ævar Arnfjörð Bjarmason wrote:
> The reason we're in this hole is because we use this
> sha1collisiondetection library to do SHA-1, and the reason we have
> issues with it specifically (not OpenSSL et al) is because its only
> method of detecting endianness is at compile time.
When using gcc (no xlc available for Linux on Power)

POWER6 (Big Endian by definition)
root@x068:[/data/httpd/gcc]gcc -dM -E - < /dev/null | grep -i end
#define __ORDER_LITTLE_ENDIAN__ 1234
#define __BIG_ENDIAN__ 1
#define __FLOAT_WORD_ORDER__ __ORDER_BIG_ENDIAN__
#define __ORDER_PDP_ENDIAN__ 3412
#define _BIG_ENDIAN 1
#define __ORDER_BIG_ENDIAN__ 4321
#define __BYTE_ORDER__ __ORDER_BIG_ENDIAN__

SLES12 on POWER8
suse12test:~ # gcc -dM -E - < /dev/null | grep -i end
#define __ORDER_LITTLE_ENDIAN__ 1234
#define _LITTLE_ENDIAN 1
#define __FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __ORDER_PDP_ENDIAN__ 3412
#define __LITTLE_ENDIAN__ 1
#define __ORDER_BIG_ENDIAN__ 4321
#define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__

*So, for compile time tests, when gcc is the compiler it seems the
following defines are available**
**__BIG_ENDIAN__, _BIG_ENDIAN,  __LITTLE__ENDIAN__, _LITTLE_ENDIAN**
**or something based on the value of __BYTE_ORDER__*

I'll see if I can find something similar for xlc, but will only be able
to test xlc on AIX.

>
> This didn't use to be the case, it was changed in this commit:
> https://github.com/cr-marcstevens/sha1collisiondetection/commit/d597672
>
> Dan Shumow: Since the commit message doesn't say why, can you elaborate
> a bit on why this was done, i.e. is determining this at runtime harmful
> for performance? If not, perhaps it would be best to bring this back, at
> least as an option.


--------------91902AAA5543DB694032FFB1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 7/30/2018 11:39 AM, Ævar Arnfjörð
      Bjarmason wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:87wotdt649.fsf@evledraar.gmail.com">
      <pre wrap="">The reason we're in this hole is because we use this
sha1collisiondetection library to do SHA-1, and the reason we have
issues with it specifically (not OpenSSL et al) is because its only
method of detecting endianness is at compile time.</pre>
    </blockquote>
    When using gcc (no xlc available for Linux on Power)<br>
    <br>
    POWER6 (Big Endian by definition)<br>
    root@x068:[/data/httpd/gcc]gcc -dM -E - &lt; /dev/null | grep -i end<br>
    #define __ORDER_LITTLE_ENDIAN__ 1234<br>
    #define __BIG_ENDIAN__ 1<br>
    #define __FLOAT_WORD_ORDER__ __ORDER_BIG_ENDIAN__<br>
    #define __ORDER_PDP_ENDIAN__ 3412<br>
    #define _BIG_ENDIAN 1<br>
    #define __ORDER_BIG_ENDIAN__ 4321<br>
    #define __BYTE_ORDER__ __ORDER_BIG_ENDIAN__<br>
    <br>
    SLES12 on POWER8<br>
    suse12test:~ # gcc -dM -E - &lt; /dev/null | grep -i end<br>
    #define __ORDER_LITTLE_ENDIAN__ 1234<br>
    #define _LITTLE_ENDIAN 1<br>
    #define __FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__<br>
    #define __ORDER_PDP_ENDIAN__ 3412<br>
    #define __LITTLE_ENDIAN__ 1<br>
    #define __ORDER_BIG_ENDIAN__ 4321<br>
    #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__<br>
    <br>
    <b>So, for compile time tests, when gcc is the compiler it seems the
      following defines are available</b><b><br>
    </b><b>__BIG_ENDIAN__, _BIG_ENDIAN,  __LITTLE__ENDIAN__,
      _LITTLE_ENDIAN</b><b><br>
    </b><b>or something based on the value of __BYTE_ORDER__</b><br>
    <br>
    I'll see if I can find something similar for xlc, but will only be
    able to test xlc on AIX.<br>
    <br>
    <blockquote type="cite"
      cite="mid:87wotdt649.fsf@evledraar.gmail.com">
      <pre wrap="">

This didn't use to be the case, it was changed in this commit:
<a class="moz-txt-link-freetext" href="https://github.com/cr-marcstevens/sha1collisiondetection/commit/d597672" moz-do-not-send="true">https://github.com/cr-marcstevens/sha1collisiondetection/commit/d597672</a>

Dan Shumow: Since the commit message doesn't say why, can you elaborate
a bit on why this was done, i.e. is determining this at runtime harmful
for performance? If not, perhaps it would be best to bring this back, at
least as an option.</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------91902AAA5543DB694032FFB1--
