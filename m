Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE16C433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F962076D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ONFH7lOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgGPRMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:12:17 -0400
Received: from mout.web.de ([212.227.15.4]:40515 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgGPRMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 13:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594919514;
        bh=H2D3kBzXDW68WEIfrGuBWxCp9gidvlRuLlJnkzI+ISo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ONFH7lOEt3cz5MzTUMgvMYjNW6eA98CxpjEw2UvQ8EhtxVWQISs1pZ8tEcEQZaVzN
         SKZUPOFlAMZCbgUKs/8iMYR1ZUzWck9fd/CuGQj4/Y40l4oPpvzOlG8CHDHQJ+deiZ
         gI7+Pq5VSJY4dL1bKCT5Pe/1U8h4rc2Oybn6CHac=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyE3J-1ksg870181-015W0G; Thu, 16
 Jul 2020 19:11:54 +0200
Subject: Re: [PATCH v12 5/5] read-cache: speed up has_dir_name (part 2)
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Brandon Williams <bwilliamseng@gmail.com>
References: <20170419170618.16535-1-git@jeffhostetler.com>
 <20170419170618.16535-6-git@jeffhostetler.com>
 <20200704172708.GC11341@szeder.dev> <xmqqr1tp9mf8.fsf@gitster.c.googlers.com>
 <be8dec3e-087e-b973-280d-3d0d2e481de6@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6d769a78-72aa-5b5d-9cc7-41b8c0ddf9d8@web.de>
Date:   Thu, 16 Jul 2020 19:11:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <be8dec3e-087e-b973-280d-3d0d2e481de6@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uh/sOh7dZQ6Exa/JrLWsQuHfQni8KDsShED+hsi8W/csviUGnU7
 2iyA5SfkhO7pxwxKc8tBMrqLC4nwuOEpji8WJLeaiDD4EzxDoJt6vcP+eI72SkcPVBcu0RT
 ehHdJsGibAInWklvH5VLe98PzcELArd0vGJoMuaJBWQ2gRZIKHOaRxYp8pXtQdpVII0zozV
 Oxzja5gsc+l9R5a5bWQpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ln4KdIIH5uA=:ftNyWx3cpTapT4N5jPyBDs
 alRmEzDL6UTuP575YPT6mpqCWuBgbDdtgqWWT38p98WteqOBHE0XEVIgPOIikKgtUX+8MJs3f
 aYcf4yBXMZOaayGPlqeP1RDwekU//y/i4s2xJZHtznQQOBQBcs3g6yhgTUUliaDGXcEUnxQdU
 JbXMz/LcNF61JIn78ZfUEP9jSRcUCFJpZNTzq+2FdElJ/NFDOswQA3WdRiDQVUE9uAbtcKfvG
 L5RYAbPmhPGBLtYjv0VmE1jUpbKgF6/v/KxG1ZBHvRjtfbYznTk08rOdNdZiAk2lz+kM2X3wX
 5OIieDfYkg/s60EbvkaeZfSeu819+1n/jaLU0KykaN7XmfTz5dFIIOPyRINfAKD6++2bFzRm5
 4tiScy+Z30gmxoiONNieg/G2eWH52TDcuShB1eED1Zup9lvHQfsUqU6iaousISu3PO+NLwg7G
 KOVqYct4QGOCRCYQ/CC2yqhZPMga9kDrJ7iZWKRPH0pIh4koN+TOJvPgxEH2C9eGkjLVnZEhm
 3UKycOQFfEsSihhhuW0D7ITiJvlWmG7cCl0eDyLM650N+2bJk3md/4gofsVxb+vtSkmA4SAHW
 ErT/a9XaD7Vy46fcRNvSDPVw71xBddwaS2FtwSbwtc7qvDsqaZ7gaLTd4n39DWuCQT/kIyfn+
 s+Zrra108bPT+7a1YeUpd07rpLUqcvObWCSg/v+cMTRv6I1eI8zd3qnhzHPFnt98KuUYHwnP3
 rur+Wq8oI47145LlJEyXp5knmKe7hitQXaLlpkqmrQ44F0+8fBX7O3dHDt2NHZEC72WEuXaOT
 4clUIUFrIUWMYB5eaRLaQX1Tbz5BoKopxsCYhpOegV4VDGGp5WWdcbs8zbqWs0kIETHlqTqXe
 /tZdhs28ZLfVh+l8kQsHP9Ngxbd1pf9JiFGfFUi/KVcBNfUr9AihHB55D9Xq5SMt2bJQmEk++
 3YfxYz8QWxZzSimWgQSne2cIYV5jtiXlz8FRZODyWPjFroNJp4jiv4wKzPcdQCler0eJ7UGLx
 PFgk5NGhEjd0mSt7axJoemGIwzBU+zuMNlkLmLSeCA6bOfWRJLRVgivPQa3Pg2sAwCJJoVm9q
 Yz3sfsuF1wnLIpfaf5oM7WqTezeujCwjZdSnkqTKhoFg4OcecoxH4Na+WyK3RpSv9+t8iBJbe
 L4qjeH1J6+CfKMmJHo7P4LMYK6K474+uCK6mKTFsyd0AJdetTqJAZXxP54UuwwRd7ZOTL+q2g
 qswslrxVFSEMqDr7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.20 um 15:49 schrieb Jeff Hostetler:
>
>
> On 7/6/20 2:39 AM, Junio C Hamano wrote:
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * last: xxx/yy-file (because '-' sorts befo=
re '/')
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * this: xxx/yy/abc
>>>
>>> This is problematic, because the index can already contain 'xxx/yy' as
>>> a file, when adding 'xxx/yy/abc', but since 'xxx/yy' as a file sorts
>>> before 'xxx/yy-file', the short-circuiting here doesn't see it and
>>> thus leaves the d-f collision undetected.=C2=A0 Consequently, even Git
>>> porcelain commands can create tree objects with duplicate entries, as
>>> demonstrated in the tests below.
>>
>> Yeah, the "optimization" is quite bogus.=C2=A0 Thanks for catching it.
>>
>
> yes, thanks!

OK, so now we just need to fix it.  Like this perhaps?

=2D- >8 --
=46rom f4b2c70a34bb612e2ccc23a31e2ba8e01dedc373 Mon Sep 17 00:00:00 2001
Subject: [PATCH] read-cache: remove bogus shortcut

has_dir_name() has some optimizations for the case where entries are
added to an index in the correct order.  They kick in if the new entry
sorts after the last one.  One of them exits early if the last entry has
a longer name than the directory of the new entry.  Here's its comment:

/*
 * The directory prefix lines up with part of
 * a longer file or directory name, but sorts
 * after it, so this sub-directory cannot
 * collide with a file.
 *
 * last: xxx/yy-file (because '-' sorts before '/')
 * this: xxx/yy/abc
 */

However, a file named xxx/yy would be sorted before xxx/yy-file because
'-' sorts after NUL, so the length check against the last entry is not
sufficient to rule out a collision.  Remove it.

Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Suggested-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 read-cache.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index aa427c5c17..8ed1c29b54 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -1171,20 +1171,6 @@ static int has_dir_name(struct index_state *istate,
 				return retval;
 			}

-			if (istate->cache_nr > 0 &&
-				ce_namelen(istate->cache[istate->cache_nr - 1]) > len) {
-				/*
-				 * The directory prefix lines up with part of
-				 * a longer file or directory name, but sorts
-				 * after it, so this sub-directory cannot
-				 * collide with a file.
-				 *
-				 * last: xxx/yy-file (because '-' sorts before '/')
-				 * this: xxx/yy/abc
-				 */
-				return retval;
-			}
-
 			/*
 			 * This is a possible collision. Fall through and
 			 * let the regular search code handle it.
=2D-
2.27.0
