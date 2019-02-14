Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566A81F453
	for <e@80x24.org>; Thu, 14 Feb 2019 18:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfBNSmN (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 13:42:13 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:41706 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfBNSmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 13:42:13 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 440lcL1kBnz5tlB;
        Thu, 14 Feb 2019 19:42:10 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 93DDA309;
        Thu, 14 Feb 2019 19:42:09 +0100 (CET)
Subject: Re: [Bug report] git diff stat shows unrelated diff
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     git@vger.kernel.org, vincent.guittot@linaro.org
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d421fd13-5771-d103-5f77-d38a24afaef6@kdbg.org>
Date:   Thu, 14 Feb 2019 19:42:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.02.19 um 09:22 schrieb Viresh Kumar:
> Hello,
> 
> I am not sure if it is a bug or not, but the output I got wasn't what
> I was looking for. And so looking for some help. I was looking to send
> pull request [1] to PM maintainer and was generating the request
> against his tree [2], which already has kernel upto v5.0-rc6 merged in
> it.
> 
> These are my local branches:
> 
> Branch A:
> 
> 55538fbc79e9 cpufreq: qcom: Read voltage LUT and populate OPP
> f896d06665ec cpufreq: qcom-hw: Move to device_initcall
> 1c7fc5cbc339 (tag: v5.0-rc2) Linux 5.0-rc2
> 
> Branch B:
> 
> a4f342b9607d PM / OPP: Introduce a power estimation helper
> 285881b51eb5 PM / OPP: Remove unused parameter of _generic_set_opp_clk_only()
> bfeffd155283 (tag: v5.0-rc1) Linux 5.0-rc1
> 
> pm/linux-next branch already has Branch B merged in it (with an
> earlier pull request).
> 
> Branch C (7c139d3f0f99) is a merge of Branch A and Branch B. When I
> try to generate diff-stat with:
> 
> git diff -M --stat pm/linux-next..7c139d3f0f99
> 
> It shows me the diffstat between v5.0-rc1..v5.0-rc2 as well.
> 
> If I do
> 
> git diff -M --stat v5.0-rc2..7c139d3f0f99
> 
> it shows only the files that have changed in patches in branch A and
> B.
> 
> Since pm/linux-next already has Branch B and all the rcs upto rc6, I
> was expecting the output of first diffstat to be similar to second one
> (without branch B stuff). Is the expectation incorrect ?

Yes, I think your expectation is incorrect.

The meaning of .. is different between diff and the log commands. For
diff it is mostly just noise, that is your first diff command is
actually equivalent to

  git diff -M --stat pm/linux-next 7c139d3f0f99

It is quite obvious IMO that this is the diff between two end points.
What you most likely wanted to see is

  git diff -M --stat pm/linux-next...7c139d3f0f99

It shows the diff between a merge base of the two revisions and the
second one, i.e. between a where Branch C branched off of pm/linux-next
and its tip.

-- Hannes
