Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C0BD208E9
	for <e@80x24.org>; Mon, 30 Jul 2018 06:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeG3Hzx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 03:55:53 -0400
Received: from felt-1.demon.nl ([80.101.98.107]:33409 "EHLO felt.demon.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbeG3Hzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 03:55:53 -0400
Received: from [192.168.129.4] (x004.home.local [192.168.129.4])
        by felt.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id w6U6MBtW14221560;
        Mon, 30 Jul 2018 06:22:12 GMT
Subject: Re: git broken for AIX somewhere between 2.13.2 and 2.13.3
To:     Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net>
 <466c7a59-0535-e72c-6c90-5288a53b59a0@felt.demon.nl>
 <87zhy9u7rz.fsf@evledraar.gmail.com> <87in4x4t5y.fsf@igel.home>
From:   Michael <aixtools@felt.demon.nl>
Message-ID: <ddf55879-8c53-a172-adc6-c8942f1a1818@felt.demon.nl>
Date:   Mon, 30 Jul 2018 08:22:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87in4x4t5y.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/07/2018 23:40, Andreas Schwab wrote:
> On Jul 29 2018, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
>> Also, to you and anyone else with access to AIX: I'd be happy to figure
>> these issues out pro-actively if you give me a login to an AIX
>> machine. I promise not to do anything except compile/debug/test git on
>> it.
> The GCC compile farm <http://gcc.gnu.org/wiki/CompileFarm> has a machine
> running AIX, and is free to use for anyone working on free software.
My goal is less "to work on", more, "to package" and/or "to work with". 
Most others, including IBM, seem to use gcc as compiler - which is fine. 
However, on AIX I often see side-effects introduced by the GNU run-time 
environment needed on top of the xlc.rte provided as part of AIX.

In any case - my testing is using the xlc complier - so there are syntax 
differences. the compiler has many modes - by default I use 'xlc_r' that 
has the following default settings:
xlc_r:  use        = DEFLT_C
         crt        = /lib/crt0.o
         mcrt       = /lib/mcrt0.o
         gcrt       = /lib/gcrt0.o
         libraries  = -L/usr/vac/lib,-lxlopt,-lxlipa,-lxl,-lpthreads,-lc
         proflibs   = -L/lib/profiled,-L/usr/lib/profiled
         hdlibs     = -L/usr/vac/lib,-lhmd
         options    = 
-qlanglvl=extc99,-qcpluscmt,-qkeyword=inline,-qalias=ansi,-qthreaded,-D_THREAD_SAFE,-D__VACPP_MULTI__

DEFLT_C (for the curious, the default options is perhaps most 
interesting) is:
* common definitions

DEFLT_C:
         use           =DEFLT
         xlurt_cfg_path=/usr/vac/urt
         xlurt_cfg_name=urt_client.cfg

DEFLT_CPP:
         use           =DEFLT
         xlurt_cfg_path=/usr/vacpp/urt
         xlurt_cfg_name=urt_client.cfg

DEFLT:
         cppcomp   = /usr/vacpp/exe/xlCentry
         ccomp     = /usr/vac/exe/xlcentry
         code      = /usr/vac/exe/xlCcode
         cpp       = /usr/vac/exe/xlCcpp
         munch     = /usr/vacpp/exe/munch
         dis       = /usr/vac/exe/dis
         xlC       = /usr/vac/bin/xlc
         list      = /usr/vac/exe/xllist
         xslt      = /usr/vac/exe/XALAN
         transforms = /usr/vac/listings
         listlibs  = /usr/vac/lib
         cppinc    = /usr/vacpp/include
         ipa       = /usr/vac/exe/ipa
         cppfilt   = /usr/vacpp/bin/c++filt
         bolt      = /usr/vac/exe/bolt
         as        = /bin/as
         ld        = /bin/ld
         artool    = /bin/ar
         options   = 
-D_AIX,-D_AIX32,-D_AIX41,-D_AIX43,-D_AIX50,-D_AIX51,-D_AIX52,-D_AIX53,-D_AIX61,-D_IBMR2,-D_POWER
         options32 = -bpT:0x10000000,-bpD:0x20000000
         options32_bmaxdata = -bpT:0x10000000,-bpD:0x30000000
         options64 = -bpT:0x100000000,-bpD:0x110000000
         ldopt     = "b:o:e:u:R:H:Y:Z:L:T:A:k:j:"
         hdlibs    = -L/usr/vac/lib,-lhmd
         xlCcopt   = 
-qlanglvl=extc99,-qcpluscmt,-qkeyword=inline,-qalias=ansi
         crt_64    = /lib/crt0_64.o
         mcrt_64   = /lib/mcrt0_64.o
         gcrt_64   = /lib/gcrt0_64.o
         smplibraries = -lxlsmp
         palibraries  = -L/usr/vatools/lib,-lpahooks
         resexp     = /usr/vacpp/lib/res.exp
         genexports = /usr/vac/bin/CreateExportList
         vac_path   = /usr/vac
         vacpp_path = /usr/vacpp
         xlcmp_path = /usr/vac:/usr/vacpp
         xlc_c_stdinc   = /usr/vac/include:/usr/include
         xlc_cpp_stdinc = /usr/vacpp/include:/usr/include
         xlurt_msg_cat_name=vacumsg.cat
         __GNUC_MINOR__ = 3


>
> Andreas.
>

