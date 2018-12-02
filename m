Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2055E211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 10:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbeLBKxR (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 05:53:17 -0500
Received: from mout.web.de ([212.227.15.3]:57339 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbeLBKxR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 05:53:17 -0500
Received: from [192.168.178.36] ([79.237.241.17]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwU2B-1hZksu37GR-018KWO; Sun, 02
 Dec 2018 11:52:51 +0100
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence
 check
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
 <87ftw62sld.fsf@evledraar.gmail.com>
 <20181112162150.GB7612@sigill.intra.peff.net>
 <87d0ra2b3z.fsf@evledraar.gmail.com> <87bm6u2akf.fsf@evledraar.gmail.com>
 <878t1x2t3e.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de>
Date:   Sun, 2 Dec 2018 11:52:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <878t1x2t3e.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4n3dnqebDQM38fosHWOgvGrU1xjXJ9caoG6z/IkuMpW1FDZxLe0
 alE2swl5kZIcksTbZm76mC5HGheDHT60zhTSAD91NHUn2TSLEyBAHGhp82NGGShqyl1P4/w
 +HPCO3C++iLS2+d/+zgs1V4saSUtGGufsbfXnUVU6AgBP1wS6UWh9a6w9XX00YT/CebJn9o
 EoYc5NM0ZFgm3Ua9tg1gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hvw2o4s40zI=:U5hIjJizotLu690lqpX4jq
 P/cKn349gVj2X+byhmxeAoSC6aS+Jl2c1dameXqV2zxLiZdmzR4kQuPFW0YCXSC2N2fGdMBdf
 iOCvk8zRkSDQfzjlJEiP35o9QQHskq3ogNMm7mi9H4iD0KJKcD3hllqdWbfVMA+SxBcInQran
 5AgSo4pqSR7x3Wr+3mAtGn1smYkyO4WMJEdUH7qrLuQQXrsUi9KvLD9hWH+eR/NGf74zHYOSX
 YDzH3HmrLd3AtdEoH26raAGbM2F9QwJR5v9tmZQGREv23iWs08ECcUAzJ50Ji94Ckwo+ae3gD
 Rzcp8lRZcIh6fRITfHPFmtew8BFxKesGwVkcLTuNwPKIgEUFNBCd7EgLyp57+FwCG1X69C3/5
 XkZG0gZ8f1BcXvQauIZR2+/8rXa4sIG0pXdK3n/QdxucVIDnMJq6L+lJB38F5Auh7ag92cT0C
 NQGp4WDYOIObkx6xbKV9JgMOazhjKwL/wxiYDJIH+91PNNZ6e7RKEv7mTgj3CFR9mp9R87LxU
 SYyHZH2QB1ss+6FCaRr4eaMU2hl4yjLWua6HdEy2JJSQ7K63ldv8P1+KLLcmzbYdwtpwQGMqL
 E5J9cAz7vUvWTi6GwXMXC7UKwQb6wYkCE0V5Dtg6Tru34MEwWqg4Tw+dG92VRBV659IKdDCaB
 Z2+xo/HuBn3mY5ys3pGeAV9SeoSVKyUl+oHDX0QJ/yoZpUaMeXNjXWwucY9fOPXognDrKNpnm
 9PCDMMGpDD2oX9+8DaTqmJJRFc8DWNG2S5UzkUDGg4I6lX+U56kfMENx43KNY7QG4Ggl21yut
 HLCHxBq6/Z5njlOGqT/K6C8MYxaXbvYl+lZ4HQy2BjJkG9n+x6u6ZhHj0EU8wgUrayKUsURu4
 3c/500AH4JpnX6grXhv6S3v8gIicKSTACgJQexWrQ1qv5mRKpERxlwalHKF3QP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.11.2018 um 11:02 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Mon, Nov 12 2018, Ævar Arnfjörð Bjarmason wrote:
> 
>> On Mon, Nov 12 2018, Ævar Arnfjörð Bjarmason wrote:
>>
>>> I get:
>>>
>>>     Test                                             origin/master     peff/jk/loose-cache      avar/check-collisions-config
>>>     ------------------------------------------------------------------------------------------------------------------------
>>>     0008.2: index-pack with 256*1 loose objects      4.31(0.55+0.18)   0.41(0.40+0.02) -90.5%   0.23(0.36+0.01) -94.7%
>>>     0008.3: index-pack with 256*10 loose objects     4.37(0.45+0.21)   0.45(0.40+0.02) -89.7%   0.25(0.38+0.01) -94.3%
>>>     0008.4: index-pack with 256*100 loose objects    4.47(0.53+0.23)   0.67(0.63+0.02) -85.0%   0.24(0.38+0.01) -94.6%
>>>     0008.5: index-pack with 256*250 loose objects    5.01(0.67+0.30)   1.04(0.98+0.06) -79.2%   0.24(0.37+0.01) -95.2%
>>>     0008.6: index-pack with 256*500 loose objects    5.11(0.57+0.21)   1.81(1.70+0.09) -64.6%   0.25(0.38+0.01) -95.1%
>>>     0008.7: index-pack with 256*750 loose objects    5.12(0.60+0.22)   2.54(2.38+0.14) -50.4%   0.24(0.38+0.01) -95.3%
>>>     0008.8: index-pack with 256*1000 loose objects   4.52(0.52+0.21)   3.36(3.17+0.17) -25.7%   0.23(0.36+0.01) -94.9%
>>>
>>> I then hacked it to test against git.git, but skipped origin/master for
>>> that one because it takes *ages*. So just mine v.s. yours:
>>>
>>>     $ GIT_PERF_REPEAT_COUNT=3 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run peff/jk/loose-cache avar/check-collisions-config p0008-index-pack.sh
>>>     [...]
>>>     Test                                             peff/jk/loose-cache   avar/check-collisions-config
>>>     ---------------------------------------------------------------------------------------------------
>>>     0008.2: index-pack with 256*1 loose objects      12.57(28.72+0.61)     12.68(29.36+0.62) +0.9%
>>>     0008.3: index-pack with 256*10 loose objects     12.77(28.75+0.61)     12.50(28.88+0.56) -2.1%
>>>     0008.4: index-pack with 256*100 loose objects    13.20(29.49+0.66)     12.38(28.58+0.60) -6.2%
>>>     0008.5: index-pack with 256*250 loose objects    14.10(30.59+0.64)     12.54(28.22+0.57) -11.1%
>>>     0008.6: index-pack with 256*500 loose objects    14.48(31.06+0.74)     12.43(28.59+0.60) -14.2%
>>>     0008.7: index-pack with 256*750 loose objects    15.31(31.91+0.74)     12.67(29.23+0.64) -17.2%
>>>     0008.8: index-pack with 256*1000 loose objects   16.34(32.84+0.76)     13.11(30.19+0.68) -19.8%
>>>
>>> So not much of a practical difference perhaps. But then again this isn't
>>> a very realistic test case of anything. Rarely are you going to push a
>>> history of something the size of git.git into a repo with this many
>>> loose objects.
>>>
>>> Using sha1collisiondetection.git is I think the most realistic scenario,
>>> i.e. you'll often end up fetching/pushing something roughly the size of
>>> its entire history on a big repo, and with it:
>>>
>>>     Test                                             peff/jk/loose-cache   avar/check-collisions-config
>>>     ---------------------------------------------------------------------------------------------------
>>>     0008.2: index-pack with 256*1 loose objects      0.16(0.04+0.01)       0.05(0.03+0.00) -68.8%
>>>     0008.3: index-pack with 256*10 loose objects     0.19(0.04+0.02)       0.05(0.02+0.00) -73.7%
>>>     0008.4: index-pack with 256*100 loose objects    0.32(0.17+0.02)       0.04(0.02+0.00) -87.5%
>>>     0008.5: index-pack with 256*250 loose objects    0.57(0.41+0.03)       0.04(0.02+0.00) -93.0%
>>>     0008.6: index-pack with 256*500 loose objects    1.02(0.83+0.06)       0.04(0.03+0.00) -96.1%
>>>     0008.7: index-pack with 256*750 loose objects    1.47(1.24+0.10)       0.04(0.02+0.00) -97.3%
>>>     0008.8: index-pack with 256*1000 loose objects   1.94(1.70+0.10)       0.04(0.02+0.00) -97.9%
>>>
>>> As noted in previous threads I have an in-house monorepo where (due to
>>> expiry policies) loose objects hover around the 256*250 mark.
>>>
>>> The script, which is hacky as hell and takes shortcuts not to re-create
>>> the huge fake loose object collection every time (takes ages). Perhaps
>>> you're interested in incorporating some version of this into a v2. To be
>>> useful it should take some target path as an env variable.
>>
>> I forgot perhaps the most useful metric. Testing against origin/master
>> too on the sha1collisiondetection.git repo, which as noted above I think
>> is a good stand-in for making a medium sized push to a big repo. This
>> shows when the loose cache becomes counterproductive:
>>
>>     Test                                             origin/master     peff/jk/loose-cache       avar/check-collisions-config
>>     -------------------------------------------------------------------------------------------------------------------------
>>     0008.2: index-pack with 256*1 loose objects      0.42(0.04+0.03)   0.17(0.04+0.00) -59.5%    0.04(0.03+0.00) -90.5%
>>     0008.3: index-pack with 256*10 loose objects     0.49(0.04+0.03)   0.19(0.04+0.01) -61.2%    0.04(0.02+0.00) -91.8%
>>     0008.4: index-pack with 256*100 loose objects    0.49(0.04+0.04)   0.33(0.18+0.01) -32.7%    0.05(0.02+0.00) -89.8%
>>     0008.5: index-pack with 256*250 loose objects    0.54(0.03+0.04)   0.59(0.43+0.02) +9.3%     0.04(0.02+0.01) -92.6%
>>     0008.6: index-pack with 256*500 loose objects    0.49(0.04+0.03)   1.04(0.83+0.07) +112.2%   0.04(0.02+0.00) -91.8%
>>     0008.7: index-pack with 256*750 loose objects    0.56(0.04+0.05)   1.50(1.28+0.08) +167.9%   0.04(0.02+0.00) -92.9%
>>     0008.8: index-pack with 256*1000 loose objects   0.54(0.05+0.03)   1.95(1.68+0.13) +261.1%   0.04(0.02+0.00) -92.6%
>>
>> I still think it's best to take this patch series since it's unlikely
>> we're making anything worse in practice, the >50k objects case is a
>> really high number, which I don't think is worth worrying about.
>>
>> But I am somewhat paranoid about the potential performance
>> regression. I.e. this is me testing against a really expensive and
>> relatively well performing NetApp NFS device where the ping stats are:
>>
>>     rtt min/avg/max/mdev = 0.155/0.396/1.387/0.349 ms
>>
>> So I suspect this might get a lot worse for setups which don't enjoy the
>> same performance or network locality.
> 
> I tried this with the same filer mounted from another DC with ~10x the
> RTT:
> 
>     rtt min/avg/max/mdev = 11.553/11.618/11.739/0.121 ms
> 
> But otherwise the same setup (same machine type/specs mounting it). It
> had the opposite results of what I was expecting:
> 
>     Test                                             origin/master     peff/jk/loose-cache      avar/check-collisions-config
>     ------------------------------------------------------------------------------------------------------------------------
>     0008.2: index-pack with 256*1 loose objects      7.78(0.04+0.03)   2.75(0.03+0.01) -64.7%   0.40(0.02+0.00) -94.9%
>     0008.3: index-pack with 256*10 loose objects     7.75(0.04+0.04)   2.77(0.05+0.01) -64.3%   0.40(0.02+0.00) -94.8%
>     0008.4: index-pack with 256*100 loose objects    7.75(0.05+0.02)   2.91(0.18+0.01) -62.5%   0.40(0.02+0.00) -94.8%
>     0008.5: index-pack with 256*250 loose objects    7.73(0.04+0.04)   3.19(0.43+0.02) -58.7%   0.40(0.02+0.00) -94.8%
>     0008.6: index-pack with 256*500 loose objects    7.73(0.04+0.04)   3.64(0.83+0.05) -52.9%   0.40(0.02+0.00) -94.8%
>     0008.7: index-pack with 256*750 loose objects    7.73(0.04+0.02)   4.14(1.29+0.07) -46.4%   0.40(0.02+0.00) -94.8%
>     0008.8: index-pack with 256*1000 loose objects   7.73(0.04+0.03)   4.55(1.72+0.09) -41.1%   0.40(0.02+0.01) -94.8%
> 
> I.e. there the cliff of where the cache becomes counterproductive comes
> much later, not earlier. The sha1collisiondetection.git repo has 418
> objects.
> 
> So is it cheaper to fill a huge cache than look up those 418? I don't
> know, haven't dug. But so far what this suggests is that we're helping
> slow FSs to the detriment of faster ones.
> 
> So here's the same test not against NFS, but the local ext4 fs (CO7;
> Linux 3.10) for sha1collisiondetection.git:
> 
>     Test                                             origin/master     peff/jk/loose-cache        avar/check-collisions-config
>     --------------------------------------------------------------------------------------------------------------------------
>     0008.2: index-pack with 256*1 loose objects      0.02(0.02+0.00)   0.02(0.02+0.01) +0.0%      0.02(0.02+0.00) +0.0%
>     0008.3: index-pack with 256*10 loose objects     0.02(0.02+0.00)   0.03(0.03+0.00) +50.0%     0.02(0.02+0.00) +0.0%
>     0008.4: index-pack with 256*100 loose objects    0.02(0.02+0.00)   0.17(0.16+0.01) +750.0%    0.02(0.02+0.00) +0.0%
>     0008.5: index-pack with 256*250 loose objects    0.02(0.02+0.00)   0.43(0.40+0.03) +2050.0%   0.02(0.02+0.00) +0.0%
>     0008.6: index-pack with 256*500 loose objects    0.02(0.02+0.00)   0.88(0.80+0.09) +4300.0%   0.02(0.02+0.00) +0.0%
>     0008.7: index-pack with 256*750 loose objects    0.02(0.02+0.00)   1.35(1.27+0.09) +6650.0%   0.02(0.02+0.00) +0.0%
>     0008.8: index-pack with 256*1000 loose objects   0.02(0.02+0.00)   1.83(1.70+0.14) +9050.0%   0.02(0.02+0.00) +0.0%
> 
> And for mu.git, a ~20k object repo:
> 
>     Test                                             origin/master     peff/jk/loose-cache       avar/check-collisions-config
>     -------------------------------------------------------------------------------------------------------------------------
>     0008.2: index-pack with 256*1 loose objects      0.59(0.91+0.06)   0.58(0.93+0.03) -1.7%     0.57(0.89+0.04) -3.4%
>     0008.3: index-pack with 256*10 loose objects     0.59(0.91+0.07)   0.59(0.92+0.03) +0.0%     0.57(0.89+0.03) -3.4%
>     0008.4: index-pack with 256*100 loose objects    0.59(0.91+0.05)   0.81(1.13+0.04) +37.3%    0.58(0.91+0.04) -1.7%
>     0008.5: index-pack with 256*250 loose objects    0.59(0.91+0.05)   1.23(1.51+0.08) +108.5%   0.58(0.91+0.04) -1.7%
>     0008.6: index-pack with 256*500 loose objects    0.59(0.90+0.06)   1.96(2.20+0.12) +232.2%   0.58(0.91+0.04) -1.7%
>     0008.7: index-pack with 256*750 loose objects    0.59(0.92+0.05)   2.72(2.92+0.17) +361.0%   0.58(0.90+0.04) -1.7%
>     0008.8: index-pack with 256*1000 loose objects   0.59(0.90+0.06)   3.50(3.67+0.21) +493.2%   0.57(0.90+0.04) -3.4%

OK, here's another theory: The cache scales badly with increasing
numbers of loose objects because it sorts the array 256 times as it is
filled.  Loading it fully and sorting once would help, as would using
one array per subdirectory.

We can simulate the oid_array operations with test-sha1-array.  It has
no explicit sort command, but we can use for_each_unique for that; we
just have to add 127.5 extra calls (that don't sort) to get the same
amount of output in the two latter cases, to be able to compare just
the sort time:

  for command in '
      foreach (0..255) {
        $subdir = sprintf("%02x", $_);
        foreach (1..$ARGV[0]) {
          printf("append %s%038d\n", $subdir, $_);
        }
        # intermediate sort
        print "for_each_unique\n";
      }
    ' '
      foreach (0..255) {
        $subdir = sprintf("%02x", $_);
        foreach (1..$ARGV[0]) {
          printf("append %s%038d\n", $subdir, $_);
        }
      }
      # sort once at the end
      print "for_each_unique\n";
      # ... and generate roughly the same amount of output
      foreach (0..127) {
        print "for_each_unique\n";
      }
    ' '
      foreach (0..255) {
        $subdir = sprintf("%02x", $_);
        foreach (1..$ARGV[0]) {
          printf("append %s%038d\n", $subdir, $_);
        }
        # sort each subdirectory separately
        print "for_each_unique\n";
	# ... and generate roughly the same amount of output
        foreach (0..127) {
          print "for_each_unique\n";
        }
        print "clear\n";
      }
    '
  do
    time perl -e "$command" 1000 | t/helper/test-tool sha1-array | wc -l
  done

My results:

  32896000

  real    0m6.521s
  user    0m5.269s
  sys     0m2.234s
  33024000

  real    0m3.464s
  user    0m2.178s
  sys     0m2.251s
  33024000

  real    0m3.353s
  user    0m2.179s
  sys     0m1.939s

So this adds up to a significant amount of time spent on sorting.  Here's
a patch, on top of next:

-- >8 --
Subject: [PATCH] object-store: use one oid_array per subdirectory for loose cache

The loose objects cache is filled one subdirectory at a time as needed.
It is stored in an oid_array, which has to be resorted after each add
operation.  So when querying a wide range of objects the array needs to
be resorted up to 256 times -- once for each subdirectory.  This is not
efficient.

Use one oid_array for each subdirectory.  This ensures that entries have
to only be sorted once.

It speeds up cache operations in a repository with ca. 100 loose
objects per subdirectory (it's used for collision checks for the
placeholders %h, %t and %p):

$ git count-objects
25805 objects, 302452 kilobytes

$ (cd t/perf && ./run HEAD^ HEAD ./p4205-log-pretty-formats.sh)
[...]
Test                        HEAD^             HEAD
--------------------------------------------------------------------
4205.1: log with %H         0.56(0.52+0.04)   0.57(0.54+0.02) +1.8%
4205.2: log with %h         0.92(0.86+0.06)   0.66(0.62+0.04) -28.3%
4205.3: log with %T         0.56(0.52+0.04)   0.57(0.55+0.01) +1.8%
4205.4: log with %t         0.92(0.88+0.04)   0.67(0.62+0.05) -27.2%
4205.5: log with %P         0.57(0.54+0.02)   0.57(0.54+0.03) +0.0%
4205.6: log with %p         0.92(0.86+0.05)   0.64(0.60+0.04) -30.4%
4205.7: log with %h-%h-%h   1.02(0.98+0.04)   0.72(0.69+0.03) -29.4%

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This patch goes on top of next.  p4205 is better suited to show the
cost of sorting in the loose objects cache than the slooow index-pack.
This change does fix the index-pack regression on ext4 for me as well,
though.  Not sure it warrants adding a loose objects test to p5302.

 object-store.h | 2 +-
 object.c       | 5 ++++-
 packfile.c     | 4 +++-
 sha1-file.c    | 5 +++--
 sha1-name.c    | 8 +++++---
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/object-store.h b/object-store.h
index 8dceed0f31..ee67a50980 100644
--- a/object-store.h
+++ b/object-store.h
@@ -20,7 +20,7 @@ struct object_directory {
 	 * Be sure to call odb_load_loose_cache() before using.
 	 */
 	char loose_objects_subdir_seen[256];
-	struct oid_array loose_objects_cache;
+	struct oid_array loose_objects_cache[256];
 
 	/*
 	 * Path to the alternative object store. If this is a relative path,
diff --git a/object.c b/object.c
index c29a97a7e9..965493ba76 100644
--- a/object.c
+++ b/object.c
@@ -484,8 +484,11 @@ struct raw_object_store *raw_object_store_new(void)
 
 static void free_object_directory(struct object_directory *odb)
 {
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(odb->loose_objects_cache); i++)
+		oid_array_clear(&odb->loose_objects_cache[i]);
 	free(odb->path);
-	oid_array_clear(&odb->loose_objects_cache);
 	free(odb);
 }
 
diff --git a/packfile.c b/packfile.c
index 56496bb425..3ef6a241b7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -995,7 +995,9 @@ void reprepare_packed_git(struct repository *r)
 	struct object_directory *odb;
 
 	for (odb = r->objects->odb; odb; odb = odb->next) {
-		oid_array_clear(&odb->loose_objects_cache);
+		int i;
+		for (i = 0; i < ARRAY_SIZE(odb->loose_objects_cache); i++)
+			oid_array_clear(&odb->loose_objects_cache[i]);
 		memset(&odb->loose_objects_subdir_seen, 0,
 		       sizeof(odb->loose_objects_subdir_seen));
 	}
diff --git a/sha1-file.c b/sha1-file.c
index 05f63dfd4e..d2f5e65865 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -933,7 +933,8 @@ static int quick_has_loose(struct repository *r,
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
 		odb_load_loose_cache(odb, subdir_nr);
-		if (oid_array_lookup(&odb->loose_objects_cache, &oid) >= 0)
+		if (oid_array_lookup(&odb->loose_objects_cache[subdir_nr],
+				     &oid) >= 0)
 			return 1;
 	}
 	return 0;
@@ -2173,7 +2174,7 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    append_loose_object,
 				    NULL, NULL,
-				    &odb->loose_objects_cache);
+				    &odb->loose_objects_cache[subdir_nr]);
 	odb->loose_objects_subdir_seen[subdir_nr] = 1;
 	strbuf_release(&buf);
 }
diff --git a/sha1-name.c b/sha1-name.c
index b24502811b..fdb22147b2 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -94,14 +94,16 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 	     odb && !ds->ambiguous;
 	     odb = odb->next) {
 		int pos;
+		struct oid_array *loose_subdir_objects;
 
 		odb_load_loose_cache(odb, subdir_nr);
-		pos = oid_array_lookup(&odb->loose_objects_cache, &ds->bin_pfx);
+		loose_subdir_objects = &odb->loose_objects_cache[subdir_nr];
+		pos = oid_array_lookup(loose_subdir_objects, &ds->bin_pfx);
 		if (pos < 0)
 			pos = -1 - pos;
-		while (!ds->ambiguous && pos < odb->loose_objects_cache.nr) {
+		while (!ds->ambiguous && pos < loose_subdir_objects->nr) {
 			const struct object_id *oid;
-			oid = odb->loose_objects_cache.oid + pos;
+			oid = loose_subdir_objects->oid + pos;
 			if (!match_sha(ds->len, ds->bin_pfx.hash, oid->hash))
 				break;
 			update_candidates(ds, oid);
-- 
2.19.2
