Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366371F597
	for <e@80x24.org>; Tue, 31 Jul 2018 10:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbeGaLqD (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 07:46:03 -0400
Received: from felt-1.demon.nl ([80.101.98.107]:33679 "EHLO felt.demon.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727524AbeGaLqD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 07:46:03 -0400
Received: from [192.168.129.6] (x006.home.local [192.168.129.6])
        by felt.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id w6VA6Gvu10289246;
        Tue, 31 Jul 2018 10:06:16 GMT
Subject: Re: Is detecting endianness at compile-time unworkable?
To:     Daniel Shumow <shumow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net>
 <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
 <20180729192753.GD945730@genre.crustytoothpaste.net>
 <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
 <20180729200623.GF945730@genre.crustytoothpaste.net>
 <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
 <87wotdt649.fsf@evledraar.gmail.com>
 <xmqq600wkc4i.fsf@gitster-ct.c.googlers.com>
 <xmqqh8kgfuba.fsf@gitster-ct.c.googlers.com>
 <CADMpRy7f_Zr7Ay7bU_5eBS+7yO-58EVsEGE0k9qxefS-TO+z8w@mail.gmail.com>
From:   Michael Felt <aixtools@felt.demon.nl>
Message-ID: <599fc1eb-d295-fe63-4d86-168d569c876c@felt.demon.nl>
Date:   Tue, 31 Jul 2018 12:06:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADMpRy7f_Zr7Ay7bU_5eBS+7yO-58EVsEGE0k9qxefS-TO+z8w@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------702AD11D25B7E2ED7A370D0C"
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------702AD11D25B7E2ED7A370D0C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I have just replied to 
https://github.com/cr-marcstevens/sha1collisiondetection/pull/42

I checked a gcc compiler on AIX, and I have the defines for vac.

I do not have access yet to SLES or RHEL (or Ubuntu), just a "free 
Debian" on my Power6.

* my conclusions|recommendations:

a) AIX is always Big Endian, the define _AIX can be used to determine if AIX

b) POWER7 and earlier are always Big Endian

c) assuming lscpu is always available on Linux systems a command (in 
configure?) could be used:

root@x074:/usr/bin# lscpu | grep -i endian
Byte Order:            Big Endian

d) some linux systems (in any case latest versions of RHEL and SLES 
enterprise) should have a file named lparcfg in /proc 
(/proc/{powerppc|ppc64|ppc64le|ppc64el}/lparcfg - and it might be in 
that file. Need to get onto a (POWER8|POWER9) system to check.

Hope this helps:

details re: define of _AIX

root@x068:[/data/httpd/gcc]gcc -dM -E - < /dev/null | grep AIX | head -1
#define _AIX 1

michael@x071:[/home/michael]/usr/bin/grep -p DEFLT: 
/etc/vac.cfg.[567][123] | grep options\
         options   = 
-D_AIX,-D_AIX32,-D_AIX41,-D_AIX43,-D_AIX50,-D_AIX51,-D_AIX52,-D_AIX53,-D_IBMR2,-D_POWER
         options   = 
-D_AIX,-D_AIX32,-D_AIX41,-D_AIX43,-D_AIX50,-D_AIX51,-D_AIX52,-D_AIX53,-D_AIX61,-D_IBMR2,-D_POWER
         options   = 
-D_AIX,-D_AIX32,-D_AIX41,-D_AIX43,-D_AIX50,-D_AIX51,-D_AIX52,-D_AIX53,-D_AIX61,-D_AIX71,-D_IBMR2,-D_POWER
         options   = 
-D_AIX,-D_AIX32,-D_AIX41,-D_AIX43,-D_AIX50,-D_AIX51,-D_AIX52,-D_AIX53,-D_AIX61,-D_AIX71,-D_AIX72,-D_IBMR2,-D_POWER

michael@x071:[/home/michael]ls /etc/vac.cfg.[567][123]
/etc/vac.cfg.53  /etc/vac.cfg.61  /etc/vac.cfg.71  /etc/vac.cfg.72


On 7/30/2018 8:39 PM, Daniel Shumow wrote:
> The change was definitely made for performance. Removing the if 
> statements, conditioned upon endianess was an approx 10% improvement, 
> which was very important to getting this library accepted into git.
>
> Thanks,
> Dan
>
>
> On Mon, Jul 30, 2018 at 11:32 AM, Junio C Hamano <gitster@pobox.com 
> <mailto:gitster@pobox.com>> wrote:
>
>     Junio C Hamano <gitster@pobox.com <mailto:gitster@pobox.com>> writes:
>
>     > Ævar Arnfjörð Bjarmason <avarab@gmail.com
>     <mailto:avarab@gmail.com>> writes:
>     >
>     >> And, as an aside, the reason we can't easily make it better
>     ourselves is
>     >> because the build process for git.git doesn't have a facility
>     to run
>     >> code to detect this type of stuff (the configure script is always
>     >> optional). So we can't just run this test ourselves.
>     >
>     > It won't help those who cross-compile anyway.  I thought we declared
>     > "we make a reasonable effort to guess the target endianness from the
>     > system header by inspecting usual macros, but will not aim to cover
>     > every system on the planet---instead there is a knob to tweak it for
>     > those on exotic platforms" last time we discussed this?
>
>     Well, having said all that, I do not think I personally mind if
>     ./configure learned to include a "compile small program and run it
>     to determine byte order on the build machine" as part of "we make a
>     reasonable effort" as long as it cleanly excludes cross building
>     case (and the result is made overridable just in case we misdetect
>     the "cross-ness" of the build).
>
>


--------------702AD11D25B7E2ED7A370D0C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>I have just replied to
      <a class="moz-txt-link-freetext" href="https://github.com/cr-marcstevens/sha1collisiondetection/pull/42">https://github.com/cr-marcstevens/sha1collisiondetection/pull/42</a></p>
    <p>I checked a gcc compiler on AIX, and I have the defines for vac.</p>
    <p>I do not have access yet to SLES or RHEL (or Ubuntu), just a
      "free Debian" on my Power6.</p>
    <p>* my conclusions|recommendations:</p>
    <p>a) AIX is always Big Endian, the define _AIX can be used to
      determine if AIX<br>
    </p>
    <p>b) POWER7 and earlier are always Big Endian</p>
    <p>c) assuming lscpu is always available on Linux systems a command
      (in configure?) could be used:</p>
    <p>root@x074:/usr/bin# lscpu | grep -i endian<br>
      Byte Order:            Big Endian<br>
    </p>
    <p>d) some linux systems (in any case latest versions of RHEL and
      SLES enterprise) should have a file named lparcfg in /proc
      (/proc/{powerppc|ppc64|ppc64le|ppc64el}/lparcfg - and it might be
      in that file. Need to get onto a (POWER8|POWER9) system to check.<br>
    </p>
    Hope this helps:<br>
    <br>
    details re: define of _AIX<br>
    <br>
    root@x068:[/data/httpd/gcc]gcc -dM -E - &lt; /dev/null | grep AIX |
    head -1<br>
    #define _AIX 1<br>
    <br>
    michael@x071:[/home/michael]/usr/bin/grep -p DEFLT:
    /etc/vac.cfg.[567][123] | grep options\<br>
            options   =
-D_AIX,-D_AIX32,-D_AIX41,-D_AIX43,-D_AIX50,-D_AIX51,-D_AIX52,-D_AIX53,-D_IBMR2,-D_POWER<br>
            options   =
-D_AIX,-D_AIX32,-D_AIX41,-D_AIX43,-D_AIX50,-D_AIX51,-D_AIX52,-D_AIX53,-D_AIX61,-D_IBMR2,-D_POWER<br>
            options   =
-D_AIX,-D_AIX32,-D_AIX41,-D_AIX43,-D_AIX50,-D_AIX51,-D_AIX52,-D_AIX53,-D_AIX61,-D_AIX71,-D_IBMR2,-D_POWER<br>
            options   =
-D_AIX,-D_AIX32,-D_AIX41,-D_AIX43,-D_AIX50,-D_AIX51,-D_AIX52,-D_AIX53,-D_AIX61,-D_AIX71,-D_AIX72,-D_IBMR2,-D_POWER<br>
    <br>
    michael@x071:[/home/michael]ls /etc/vac.cfg.[567][123]<br>
    /etc/vac.cfg.53  /etc/vac.cfg.61  /etc/vac.cfg.71  /etc/vac.cfg.72<br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 7/30/2018 8:39 PM, Daniel Shumow
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CADMpRy7f_Zr7Ay7bU_5eBS+7yO-58EVsEGE0k9qxefS-TO+z8w@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr">The change was definitely made for performance. 
        Removing the if statements, conditioned upon endianess was an
        approx 10% improvement, which was very important to getting this
        library accepted into git.
        <div><br>
        </div>
        <div>Thanks,<br>
          Dan</div>
        <div><br>
        </div>
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">On Mon, Jul 30, 2018 at 11:32 AM, Junio
          C Hamano <span dir="ltr">&lt;<a
              href="mailto:gitster@pobox.com" target="_blank"
              moz-do-not-send="true">gitster@pobox.com</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div class="HOEnZb">
              <div class="h5">Junio C Hamano &lt;<a
                  href="mailto:gitster@pobox.com" moz-do-not-send="true">gitster@pobox.com</a>&gt;
                writes:<br>
                <br>
                &gt; Ævar Arnfjörð Bjarmason &lt;<a
                  href="mailto:avarab@gmail.com" moz-do-not-send="true">avarab@gmail.com</a>&gt;
                writes:<br>
                &gt;<br>
                &gt;&gt; And, as an aside, the reason we can't easily
                make it better ourselves is<br>
                &gt;&gt; because the build process for git.git doesn't
                have a facility to run<br>
                &gt;&gt; code to detect this type of stuff (the
                configure script is always<br>
                &gt;&gt; optional). So we can't just run this test
                ourselves.<br>
                &gt;<br>
                &gt; It won't help those who cross-compile anyway.  I
                thought we declared<br>
                &gt; "we make a reasonable effort to guess the target
                endianness from the<br>
                &gt; system header by inspecting usual macros, but will
                not aim to cover<br>
                &gt; every system on the planet---instead there is a
                knob to tweak it for<br>
                &gt; those on exotic platforms" last time we discussed
                this?<br>
                <br>
              </div>
            </div>
            Well, having said all that, I do not think I personally mind
            if<br>
            ./configure learned to include a "compile small program and
            run it<br>
            to determine byte order on the build machine" as part of "we
            make a<br>
            reasonable effort" as long as it cleanly excludes cross
            building<br>
            case (and the result is made overridable just in case we
            misdetect<br>
            the "cross-ness" of the build).<br>
            <br>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------702AD11D25B7E2ED7A370D0C--
