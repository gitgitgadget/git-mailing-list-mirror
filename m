Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5DEB1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeCYQcT (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:32:19 -0400
Received: from mout.web.de ([212.227.17.11]:57589 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753281AbeCYQcS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:32:18 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrK0u-1eaefR1OyC-0134vN; Sun, 25
 Mar 2018 18:32:05 +0200
Subject: Re: [PATCH 4/3] sha1_name: use bsearch_pack() in unique_in_pack()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        stolee@gmail.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net
References: <20180321224226.GA74743@genre.crustytoothpaste.net>
 <20180322174010.120117-1-dstolee@microsoft.com>
 <71b5cef0-abad-001f-6a23-3f2d874b9709@web.de>
 <xmqqvadkf7rd.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c56cd048-f0d1-3ed2-6e4e-5063d97071be@web.de>
Date:   Sun, 25 Mar 2018 18:32:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqvadkf7rd.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Cp6TAeR3UMsLtwAk0bz2XiKjPqBcHxqDC8ImzSKYXST9igexSKt
 AZjspiU2kf5Z8D5DqEaxb0eQky7sEuFfkYgOQYW5QwQtFTqveHarV09TIezDQ1PBa61TR30
 RTZ4o7bGQ3mXY0X7vMwtG69KIZSWw98MhcIx5Rh+cmkNVoSAF+/RcZ3WDj//pezmOgaKCYF
 KVuL0P6quAYSUNxyXg7zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1xmIlkuWWeE=:8ZCtY5qz20wYP77AOl0Ja4
 uKmhoxpK5o+Kjo1QQ5p0OLk7STZ1Sb4vHx8VgkQboYtciGT+t6bReKnzS3J9r/eDmApBNXOR+
 cwj1RmYWS65X59aUYQjwkkvZQQ50H50SVPXwlyanwOraYDiPBi+5CdQhrJSt457mnAiE7ukoP
 EdwrxJ8/RXc2CWv1WRzbPvmZZNiUuvSssoJA5TvAj9mTF5HWQ6wnchx8Ibgc59ndRz7iS4FGE
 6+qYqPFk81XQ8jx7RDlkC9ikjZnqV1Imera9oNBxZ0Lnc04ASg+LhL5X8MTVWxObsPmCCCud0
 wxTMp9+2N5WD4rYtyGbjKAqvHW4X2g0uRdcb/yDvUummEmbElSJBu3R3ty7eN8OqwPbwHx43Q
 EifSZTMNaIhIA1GUFJO7GCl5mYOlykWNfgKGulfFLyN297SiBluAaBuVUfwjhRSfOmWA+zYkT
 g7cKxrLM5WRr2u3JkvNbvlLF8qYELlwstLgUSXuHc+luzZQ4DhzKO+pBNCD8sEFa25vhudO7g
 KV/mPqe+E0uybZ5bTYfyAXFLhtX7/100lm7S3t5NsLwEgHnJ6F/i0Rl7+Yz9ctlsgSBo2xV70
 CklJODojqkdqnuJVovuLKuXtATR6JxfOYCN+g5Mnr7uJP+egVa774DEX9xlcuZ/w0ryyDWM8L
 ev4k6JCyG2qJ/gZV31zIYZcSw51NvbwQsR94e6D1zmBbfHycqt3hHJmw9kbszpQrRmU8Jccwc
 rHuF5jjfwOQbXE9cra8u0V9kigcUD8kF1a+E+WBBcY+mG3BdEpAox3KOb7DlRqYc21yPSYqt6
 XbRefz6q94lBGoyEIdAALWn+Zt3CfLu56Nl6ZW5HsyS4sW3PYc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.03.2018 um 18:19 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Replace the custom binary search in unique_in_pack() with a call to
>> bsearch_pack().  This reduces code duplication and makes use of the
>> fan-out table of packs.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> This is basically the same replacement as done by patch 3.  Speed is
>> less of a concern here -- at least I don't know a commonly used
>> command that needs to resolve lots of short hashes.
> 
> Looks correct.  Did you find this by eyeballing, or do you have some
> interesting tool you use?

I was looking for SHA1 binary searches using something like this:

	git grep -e '/ 2' -e hashcmp -W --all-match

René
