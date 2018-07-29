Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE273208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 20:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeG2WWD (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 18:22:03 -0400
Received: from felt-1.demon.nl ([80.101.98.107]:33345 "EHLO felt.demon.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726682AbeG2WWD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 18:22:03 -0400
Received: from [192.168.129.4] (x004.home.local [192.168.129.4])
        by felt.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id w6TKoAjW13500518;
        Sun, 29 Jul 2018 20:50:10 GMT
Subject: Re: git broken for AIX somewhere between 2.13.2 and 2.13.3
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net>
 <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
 <20180729192753.GD945730@genre.crustytoothpaste.net>
 <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
 <20180729200623.GF945730@genre.crustytoothpaste.net>
From:   Michael <aixtools@felt.demon.nl>
Message-ID: <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
Date:   Sun, 29 Jul 2018 22:50:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729200623.GF945730@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/07/2018 22:06, brian m. carlson wrote:
> On Sun, Jul 29, 2018 at 09:48:43PM +0200, Michael wrote:
>> On 29/07/2018 21:27, brian m. carlson wrote:
>>> Well, that explains it.  I would recommend submitting a patch to
>>> https://github.com/cr-marcstevens/sha1collisiondetection, and the we can
>>> pull in the updated submodule with that fix.
>> Not sure I am smart enough to do that. I'll have to download, build, and see
>> what it says.
> The issue is that somewhere in lib/sha1.c, you need to cause
> SHA1DC_BIGENDIAN to be set.  That means you need to figure out what
> compiler macro might indicate that.
I remember - roughly - a few decades back - having an assignment to 
write code to determine endianness. PDP and VAC were different iirc, and 
many other micro-processors besides the 8088/8086/z85/68k/etc..

If you are looking for a compiler macro as a way to determine this - 
maybe you have one for gcc, but not for xlc. I do not know it - currently :)

> I can tell you that a POWER- or
> PowerPC-specific one is going to be a bad choice unless it includes the
> endianness, since those chips come in little-endian versions as well.
Actually, the POWER8 and POWER9 (and I expect all future versions) 
support both. There are not separate chips. Per virtual machine - a mode 
is determined during boot (virtual power on) e.g., SLES11 only ran in 
BigEndian and SLES12 only runs in LittleEndian. afaik, RHEL was 
supplying both BE and LE distributions. AIX, as an OS, only runs in BE 
mode, and I expect IBM i (was os/400) is also only running in BE.
>
> _AIX might be a fine choice if you know that it only ever runs on
> big-endian chips.
Do you mean just testing for _AIX. That would be very very easy - yes!
>>> In the mean time, you could build using OpenSSL or the block SHA-1
>>> implementation, and switch back once things are in a good state.  I do
>>> recommend using SHA1DC for things long term, though, as attacks on SHA-1
>>> are only going to get better.
>> Any suggestions on where/how to do this?
>>
>> root@x066:[/data/prj/aixtools/git/git-2.13.2]./configure --help | grep -i
>> sha
>>    --sharedstatedir=DIR    modifiable architecture-independent data
>> [PREFIX/com]
>>    --datarootdir=DIR       read-only arch.-independent data root
>> [PREFIX/share]
>>
>> root@x066:[/data/prj/aixtools/git/git-2.13.2]./configure --help | grep ssl
>>    --with-openssl          use OpenSSL library (default is YES)
>>                            ARG can be prefix for openssl library and headers
> If you're using configure, you can use --with-openssl, or
> --with-openssl=PREFIX if your OpenSSL isn't in the standard location but
> is instead in PREFIX.
I'll look in configure to see if it is not finding openssl. I was 
assuming it was found - as everything else using GNU "auto" tools find 
it okay. i.e., /var/lib/libssl.a, etc..

Tomorrow!


