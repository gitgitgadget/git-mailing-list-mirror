Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224A91F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 21:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfDWVV5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 17:21:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33671 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDWVV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 17:21:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id h5so8129257pfo.0
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GHqF+HRtUM2+DVxBZOXmYps7tDMutovncShWnd4TGIg=;
        b=Ovm83SLiDmC180RTB3ESueWRdIrnEsPi8DRYWoLvIsFy+AYIPfETqcmSH9HKBXznil
         zqWIwYHxgQRf6RkDSyY/rPbtRMjVVcJ0a6fM3DqfwB9dFK1jtsIL6FU/Z8alI1jzGaOD
         QgPyXg2Zt/upIAdkDnk3kKMLCkJBeXoQbZ3Hz8woPfW0unb4T/Z7rPColiIBkC0oxKZV
         sM3e2z0gwgj2F00vrTACyHjHQVXBByQsgnlxcJanCa5JoORcaElEnJTXD2z/BqkZzHZF
         7LgeZZs0wSM+rv/SvjSfcQhQUtemWHHGjL+JyYUGdRivdHzID8SgvMPeRrq3J6L/t6em
         GJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GHqF+HRtUM2+DVxBZOXmYps7tDMutovncShWnd4TGIg=;
        b=iLKHbX0KcqZdGMgOKLALnHufbhHOPfz8la6vRXqLwcvBMwekWc959r0spPXEBlLvX1
         6oGb7JJbTLXcR8jGW/ZDMCRuK53GcMb3dlXFYt73b8fkdR3tUVAtDPCJ9Z1sEbC6Cba/
         h88twNGXSuL3K8l67Hv3LVc9paK67Q/OocsD+xEhco/6mkBapvNNyZS+ftx4gKNvAWBh
         Uho+weEzo56Alv+u1t6UgTFKYgMo5duhB2IAJ2CGqW4L1AIWgnXdSlLycEpnmqtXhzl7
         CiFqBT7YVvq4f8nBNoYoNXB5U4Aohl6oB+sasaxcuiC/hlptFHquX2lmzLNQDET8CaQL
         nOOw==
X-Gm-Message-State: APjAAAW5ko/gDOr1DRaK6PzfitB0Hl2XA/9bH5/5wN7c/z4SYZjWXP7J
        rkXtaMNQsvgpsspEhD1A3XC26A==
X-Google-Smtp-Source: APXvYqw0Z8ZpGdqhnFW6brG691xZroySev2VyrA2o457OAfl1IGlpxCbO9GUPc3p641/I12gqJ/pSQ==
X-Received: by 2002:a65:47c6:: with SMTP id f6mr27044305pgs.173.1556054516282;
        Tue, 23 Apr 2019 14:21:56 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id z22sm17566028pgv.23.2019.04.23.14.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 14:21:55 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] blame: add the ability to ignore commits
To:     michael@platin.gs, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <[PATCH v6 0/6] blame: add the ability to ignore commits>
 <20190422222647.48628-1-michael@platin.gs>
From:   Barret Rhoden <brho@google.com>
Message-ID: <f6e2d990-e7c8-9636-ae2a-c824e140cebb@google.com>
Date:   Tue, 23 Apr 2019 17:21:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190422222647.48628-1-michael@platin.gs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael -

I cobbled something together that passes my old git tests and all but 
one of your tests, though an assertion fails when I use it for real. 
See below.

On 4/22/19 6:26 PM, michael@platin.gs wrote:
[snip]
> +static int *get_similarity(int *similarities, int max_search_distance_a,
> +			   int local_line_a, int local_line_b,
> +			   int closest_local_line_a) {
> +	assert(abs(local_line_a - closest_local_line_a) <= max_search_distance_a);

This assert fails.  In my example,
	local_line_a = 1
	closest_local_line_a = 12
	max_search_distance_a = 10

Backtrace tells me it was called here:

> +static void fuzzy_find_matching_lines_recurse(

[snip]

> +	for (i = invalidate_min; i < invalidate_max; ++i) {
> +		closest_local_line_a = get_closest_local_line(
> +			start_a, i,
> +			closest_line_calc_offset1,
> +			closest_line_calc_offset2,
> +			closest_line_calc_numerator,
> +			closest_line_calc_denominator);
> +		*get_similarity(similarities, max_search_distance_a,
> +				most_certain_line_a - start_a, i,
> +				closest_local_line_a) = -1;
> +	}

So it looks like that '12' came from get_closest_local_line(),  The args 
to that call were:

	start_a 258, i 3, off1 0, off2 258 num 83, denom 23

The equation reduces to 12 + off2 - start_a = 12

I don't know what those values mean, but it looks like A's values affect 
off2 and start_a, but those are only used at the very end of the 
calculation.  Does 'A' affect off1, numer, or denom?

Any thoughts?  What all is going on here?

If you want to play with it, it's at

	git@github.com:brho/git.git (master)

(Beware the push -f / forced update.  And I figured the repo would be 
preferable to spamming with unrelated patches).

If you want an example commit the assert fails on, it's this repo:
	
	git@github.com:brho/akaros.git
	master branch
	ignore-rev-file=.git-blame-ignore-revs
	file user/vmm/virtio_mmio.c

On an unrelated note:

 > The significant change here is that when a line is matched, its 
      > fingerprint is subtracted from the matched parent line's 
fingerprint. > This prevents two lines matching the same part of a 
parent line.

Does this limit us so that our second pass (the fallback when fuzzy 
failed) won't be able to match to a parent line that was already matched?


The test that is failing is your Expand Lines test.  The 'final' diff was:

--- a/1
+++ b/1
@@ -1,5 +1,7 @@
  aaa
-bbb
+bbbx
+bbbx
  ccc
-ddd
+dddx
+dddx
  eee

Which should be two diff chunks and two calls to guess_line_blames().

And the 'actual' was:

1
2
Final  (not 2)
3
4
Final  (not 2)
5

I didn't dig much, but your older stuff (when merged with mine) also 
didn't pass that test.  Maybe something with the offset/parent_slno stuff.

Thanks,

Barret

