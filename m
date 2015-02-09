From: Dilyan Palauzov <dilyan.palauzov@aegee.org>
Subject: Re: git 2.2.2 annotate crash (strbuf.c:32)
Date: Mon, 09 Feb 2015 11:33:39 +0100
Message-ID: <54D88D03.1090501@aegee.org>
References: <54D7D634.2050807@aegee.org>	<20150209012858.GB21072@peff.net> <CAPig+cQ7iYq_c_MstfsMzArCZFM_0ORRa8Gi-YckaeZiWKN=4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 11:33:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKlf7-000738-SW
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 11:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760160AbbBIKdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 05:33:44 -0500
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:57323 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760024AbbBIKdn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 05:33:43 -0500
Received: from smtp.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1YKlev-0006zp-9h; Mon, 09 Feb 2015 11:33:41 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.0 smtp.aegee.org t19AXjIr030517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1423478026; i=dkim+MSA-tls@aegee.org;
	bh=nOI/6T49RyCXVf/iYnZs0/zNxtUM7WQSgLayXQV5aAo=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=h1sMwmFuOHIjY7dIjAOljiAXIGbmh4ETDfos5duCm1TDGCnLZ/vsTN6i7Yn4ko9EX
	 4wfxWJ0yLqGpXtcCyFlvuSY6qx+esTbzxkA9prPGt0U7ZG1EKUtBU0I/2/yHMNI+Ke
	 Wm8EttT6VHqbeW6qOgSlhoWGd5077oJW5w8QkfXGim/A0cSmPcremMTNm+k1MtI0xM
	 jj0ld2PFtxLRacVWR8Ws1zRdDn0btf4nI738DBFAqDDi4maRYSAVvIugCmzyqQSl87
	 p/kkn5zI/bEeqiS6SYug594J6vT3sdPbKDfHV7yPCwRvwXH1DASD3eZlJlGHbhVbik
	 /gpfX7/zbR6yLGU3fV0U+RjKHMnhHtvzsXYGkuM6n+OHacj6m/XwUEEfHl5oZEOg/r
	 nqV0eoQaIHP1bAhSFQtpUJntLaQyO/dtN4yTBOJ6QNz2h48IF9FTV1NsiUmFUxesfs
	 2Xev66HXds4EVM7sqWWVS/HyeSit4Lxw/ejartrecstMRhVxky7pXvtHRFZ+X2V3qM
	 ovbRjcFjF9viZGZYMfZormFGz1pkRfhAC6ivQKUZdywUQieW1eTM2B9oWKxTFcRzGs
	 ZfYY/qOLsZZKelyt0aWm+yq2MrCDxbBfoGZqfiMJuqEBusoPzfiAEw/vpksLP2 
Received: from [192.168.0.16] (zuhause [212.202.110.243])
	(authenticated bits=0)
	by smtp.aegee.org (8.15.1/8.14.5) with ESMTPSA id t19AXjIr030517
	(version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 9 Feb 2015 10:33:46 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAPig+cQ7iYq_c_MstfsMzArCZFM_0ORRa8Gi-YckaeZiWKN=4w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.98.6 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263560>

Hello,

the point is that with exactly the same configuration on one computer 
there is crash and on another one things work just fine.

I found out that line builtin/blame.c:1675 makes the problems:

if (len) {
   printf("blame.c:1676, subject: %s, len: %i\n", subject, len);
-->  strbuf_add(&ret->summary, subject, len);  <--
} else
    strbuf_addf(&ret->summary, "(%s)", sha1_to_hex(commit->object.sha1));

commenting it out and compiling does not lead to crashing git anymore. 
You can find below the output of printf.

git clone git://git.cyrusimap.org/cyrus-imapd
git annotate timsieved/parser.c

*** Error in `git': double free or corruption (!prev): 
0x00000000022e4b40 ***
======= Backtrace: =========
/lib64/libc.so.6(+0x7ae36)[0x7f8f0fe2ce36]
/lib64/libc.so.6(+0x7bbb3)[0x7f8f0fe2dbb3]
git[0x41330b]
git[0x413cf6]
git[0x40f14f]
git[0x405ac5]
/lib64/libc.so.6(__libc_start_main+0xf5)[0x7f8f0fdd3a25]
git[0x4069b1]
======= Memory map: ========
00400000-005e1000 r-xp 00000000 09:00 36163 
  /usr/bin/git
007e0000-007e1000 r--p 001e0000 09:00 36163 
  /usr/bin/git
007e1000-007e8000 rw-p 001e1000 09:00 36163 
  /usr/bin/git
007e8000-00823000 rw-p 00000000 00:00 0
021c1000-023e8000 rw-p 00000000 00:00 0 
  [heap]
7f8f07bc3000-7f8f07c04000 rw-p 00000000 00:00 0
7f8f07c23000-7f8f07c25000 rw-p 00000000 00:00 0
7f8f07c25000-7f8f07c51000 r--p 00000000 09:01 4594075 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-cdc8608c4304cfdf5bbe28257fef594357bdd721.pack
7f8f07c51000-7f8f07d20000 r--p 00000000 09:01 4595166 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-2940fa128dee37fb4e0e5823cd6f9dff46da7c2b.pack
7f8f07d20000-7f8f07ea1000 r--p 00000000 09:01 4595225 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-115dbdfb66491440464600a7ef7ab1f85b3ad170.pack
7f8f07ea1000-7f8f07fa6000 r--p 00000000 09:01 4595449 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-6278b37ee884848bb77280ddcd95700f9c933d87.pack
7f8f07fa6000-7f8f080b4000 r--p 00000000 09:01 4594150 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-dca01159e601a45ed0a79ad9844d621698c6aafd.pack
7f8f080b4000-7f8f0918c000 r--p 00000000 09:01 4594031 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-a918d22dbf1c50ae9bfcf479a84877cca3fae689.pack
7f8f0918c000-7f8f0944f000 r--p 00000000 09:01 4594554 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-a918d22dbf1c50ae9bfcf479a84877cca3fae689.idx
7f8f0944f000-7f8f0f998000 r--p 00000000 09:00 3719644 
  /lib64/locale/locale-archive
7f8f0f998000-7f8f0f99b000 r-xp 00000000 09:00 3719642 
  /lib64/libdl-2.17.so
7f8f0f99b000-7f8f0fb9a000 ---p 00003000 09:00 3719642 
  /lib64/libdl-2.17.so
7f8f0fb9a000-7f8f0fb9b000 r--p 00002000 09:00 3719642 
  /lib64/libdl-2.17.so
7f8f0fb9b000-7f8f0fb9c000 rw-p 00003000 09:00 3719642 
  /lib64/libdl-2.17.so
7f8f0fb9c000-7f8f0fbb2000 r-xp 00000000 09:00 33467 
  /usr/lib64/libgcc_s.so.1
7f8f0fbb2000-7f8f0fdb1000 ---p 00016000 09:00 33467 
  /usr/lib64/libgcc_s.so.1
7f8f0fdb1000-7f8f0fdb2000 rw-p 00015000 09:00 33467 
  /usr/lib64/libgcc_s.so.1
7f8f0fdb2000-7f8f0ff58000 r-xp 00000000 09:00 3719720 
  /lib64/libc-2.17.so
7f8f0ff58000-7f8f10157000 ---p 001a6000 09:00 3719720 
  /lib64/libc-2.17.so
7f8f10157000-7f8f1015b000 r--p 001a5000 09:00 3719720 
  /lib64/libc-2.17.so
7f8f1015b000-7f8f1015d000 rw-p 001a9000 09:00 3719720 
  /lib64/libc-2.17.so
7f8f1015d000-7f8f10161000 rw-p 00000000 00:00 0
7f8f10161000-7f8f10178000 r-xp 00000000 09:00 3719597 
  /lib64/libpthread-2.17.so
7f8f10178000-7f8f10377000 ---p 00017000 09:00 3719597 
  /lib64/libpthread-2.17.so
7f8f10377000-7f8f10378000 r--p 00016000 09:00 3719597 
  /lib64/libpthread-2.17.so
7f8f10378000-7f8f10379000 rw-p 00017000 09:00 3719597 
  /lib64/libpthread-2.17.so
7f8f10379000-7f8f1037d000 rw-p 00000000 00:00 0
7f8f1037d000-7f8f10384000 r-xp 00000000 09:00 3719705 
  /lib64/librt-2.17.so
7f8f10384000-7f8f10583000 ---p 00007000 09:00 3719705 
  /lib64/librt-2.17.so
7f8f10583000-7f8f10584000 r--p 00006000 09:00 3719705 
  /lib64/librt-2.17.so
7f8f10584000-7f8f10585000 rw-p 00007000 09:00 3719705 
  /lib64/librt-2.17.so
7f8f10585000-7f8f10587000 r-xp 00000000 09:00 37211 
  /usr/lib64/libcharset.so.1.0.0
7f8f10587000-7f8f10786000 ---p 00002000 09:00 37211 
  /usr/lib64/libcharset.so.1.0.0
7f8f10786000-7f8f10787000 r--p 00001000 09:00 37211 
  /usr/lib64/libcharset.so.1.0.0
7f8f10787000-7f8f10788000 rw-p 00002000 09:00 37211 
  /usr/lib64/libcharset.so.1.0.0
7f8f10788000-7f8f10949000 r-xp 00000000 09:00 34361 
  /usr/lib64/libcrypto.so.1.0.0
7f8f10949000-7f8f10b49000 ---p 001c1000 09:00 34361 
  /usr/lib64/libcrypto.so.1.0.0
7f8f10b49000-7f8f10b71000 rw-p 001c1000 09:00 34361 
  /usr/lib64/libcrypto.so.1.0.0
7f8f10b71000-7f8f10b74000 rw-p 00000000 00:00 0
7f8f10b74000-7f8f10b90000 r-xp 00000000 09:00 215770 
  /usr/lib/libz.so.1.2.8
7f8f10b90000-7f8f10d8f000 ---p 0001c000 09:00 215770 
  /usr/lib/libz.so.1.2.8
7f8f10d8f000-7f8f10d90000 r--p 0001b000 09:00 215770 
  /usr/lib/libz.so.1.2.8
7f8f10d90000-7f8f10d91000 rw-p 0001c000 09:00 215770 
  /usr/lib/libz.so.1.2.8
7f8f10d91000-7f8f10e0d000 r-xp 00000000 09:00 215845 
  /usr/lib/libpcre.so.1.2.4
7f8f10e0d000-7f8f1100c000 ---p 0007c000 09:00 215845 
  /usr/lib/libpcre.so.1.2.4
7f8f1100c000-7f8f1100d000 r--p 0007b000 09:00 215845 
  /usr/lib/libpcre.so.1.2.4
7f8f1100d000-7f8f1100e000 rw-p 0007c000 09:00 215845 
  /usr/lib/libpcre.so.1.2.4
7f8f1100e000-7f8f1102f000 r-xp 00000000 09:00 3719713 
  /lib64/ld-2.17.so
7f8f1104e000-7f8f11050000 r--p 00000000 09:01 4594076 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-cdc8608c4304cfdf5bbe28257fef594357bdd721.idx
7f8f11050000-7f8f1105a000 r--p 00000000 09:01 4594116 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-ad62caaf95e2bad3a13acd988f7a6f07688561b4.idx
7f8f1105a000-7f8f1105b000 r--p 00000000 09:01 4595125 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-d1451c187b47b3cf453f5cccf4f48196e328e1f1.idx
7f8f1105b000-7f8f1105d000 r--p 00000000 09:01 4595373 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-3d3b97a2faba97f859e7494ceb203c7d843d92f3.idx
7f8f1105d000-7f8f1105f000 r--p 00000000 09:01 4595167 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-2940fa128dee37fb4e0e5823cd6f9dff46da7c2b.idx
7f8f1105f000-7f8f11066000 r--p 00000000 09:01 4595168 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-9953e8d5a616b261f6f39fb9cb8ebea445e20103.idx
7f8f11066000-7f8f11068000 r--p 00000000 09:01 4595226 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-6b8df09fd5d73b9aabc00ab842aa36a5fac3b3c0.idx
7f8f11068000-7f8f11079000 r--p 00000000 09:01 4595356 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-115dbdfb66491440464600a7ef7ab1f85b3ad170.idx
7f8f11079000-7f8f1107d000 r--p 00000000 09:01 4595450 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-6278b37ee884848bb77280ddcd95700f9c933d87.idx
7f8f1107d000-7f8f1107f000 r--p 00000000 09:01 4596221 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-55c71a461de5f4053accaab5f689e203c9214edc.idx
7f8f1107f000-7f8f11082000 r--p 00000000 09:01 4596222 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-dca01159e601a45ed0a79ad9844d621698c6aafd.idx
7f8f11082000-7f8f11102000 rw-p 00000000 00:00 0
7f8f11102000-7f8f111fe000 r--p 00000000 09:01 4596235 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-cc45af7de78fb5126dbcb26249372642a530b0d0.pack
7f8f111fe000-7f8f11205000 rw-p 00000000 00:00 0
7f8f1122b000-7f8f1122f000 r--p 00000000 09:01 4596236 
 
/mnt/new/home/didopalauzov/cyrus-imapd/.git/objects/pack/pack-cc45af7de78fb5126dbcb26249372642a530b0d0.idx
7f8f1122f000-7f8f11230000 r--p 00021000 09:00 3719713 
  /lib64/ld-2.17.so
7f8f11230000-7f8f11232000 rw-p 00022000 09:00 3719713 
  /lib64/ld-2.17.so
7fffd5411000-7fffd5432000 rw-p 00000000 00:00 0 
  [stack]
7fffd55f1000-7fffd55f2000 r-xp 00000000 00:00 0 
  [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0 
  [vsyscall]
blame.c:1676, subject: rewrite of the parser; survives -Wall
, len: 37
blame.c:1676, subject: updated copyright
, len: 17
blame.c:1676, subject: *** empty log message ***
, len: 25
lines 1-6/6 (END)Aborted

Greetings
   Dilyan

On 09.02.2015 05:39, Eric Sunshine wrote:
> On Sun, Feb 8, 2015 at 8:28 PM, Jeff King <peff@peff.net> wrote:
>> On Sun, Feb 08, 2015 at 10:33:40PM +0100, Dilyan Palauzov wrote:
>>
>>> I use git 2.2.2 and on my system git annotate crashed with the following
>>> log.
>>
>> I couldn't reproduce it with a few simple examples. Is it possible for
>> you to show us the repository and command that caused this?
>
> I also was unable to reproduce on either Mac OS X or Linux with git
> 2.2.2. Clues from the traceback suggest the cyrus-imapd project and
> annotation of timsieved/parser.c. I tried:
>
>    git clone git://git.cyrusimap.org/cyrus-imapd/
>    cd cyrus-imapd
>    git --no-pager annotate timsieved/parser.c
>
