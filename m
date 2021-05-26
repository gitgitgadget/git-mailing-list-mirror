Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D519CC2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 04:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9000613B9
	for <git@archiver.kernel.org>; Wed, 26 May 2021 04:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhEZEzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 00:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhEZEzs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 00:55:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1784EC061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 21:54:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c12so55775pfl.3
        for <git@vger.kernel.org>; Tue, 25 May 2021 21:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/OjuQP9asqFP+WX5UuWSrnArdP/99fKENxcQ2n5IwVE=;
        b=bv1rWzWsDoShiHWTbEN2/d04nbPNUsTIwi9jQ6CGyTbffOaMcGkvrcMrhDeLHLYbkZ
         JTlllH1nuDE3F+sV9YCkqsLig3swHnCeb7C/gzFaUN3kfEW6YzbcGSBgSqHkiBS5aAZx
         nKsHrn4XiruzE4uQMoD2Cmn6RjDAfbIyeQ46oXzZ+bg8/9vsGUkmYey5XjvofVl87wK4
         q7sPTsFz/SUrCpFADyoz5XWuVhHXJAJNV+EHzDwTc7AOyKnIic2N9AT0kRjmlW6ZzX1B
         SAej+0QBFdDa8Cvq0KDL1lAQtBlo+e7S7/OKAVe3+jeSns+oUQxnXLKM+pABMKy8sR2q
         e6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OjuQP9asqFP+WX5UuWSrnArdP/99fKENxcQ2n5IwVE=;
        b=tKOWGMbZTxhYFKWGfnNZ3MsSFjRk32ZLFbqyQh1OjvgnqMO0NMBax2wUrNpfWP97IV
         xSTqFHK8h5WMfI5dL0rjUL3pnCNACRT7BqfFvgpGQmUMlumH8wlcTD3jLm/DEc9oW9WP
         cqpqUYN4eKZ17d8YjzPkFa6I33qAd9fPc7b7xjc5EqNUHB+iiHPAswXPSTfFiMvB0o1W
         ZMNA7vVHpfT9F6QuOIKI2H1SDV0F4QR288x6xHzM47X2VEFGBfCkcKfyYLU0Z51bqRu4
         0vbrbbdRdsNdhDhinC0kTZ4aaEFpif335kCPMLhfimicQlrxbTwr4akz9RNAgpVyT6g+
         BjCQ==
X-Gm-Message-State: AOAM531ZGBM9llFqLM+bps4P/Hc1k5LtIax7OudiDonsNhLxZhFVBta4
        WUdVvsR0vPRSO+FofH64B8KawFM0Y2W3Bw==
X-Google-Smtp-Source: ABdhPJz9G1Bp9/V9w4qdTGuL8kfH5mcQLeTknfizwq7T4Rjnlc8gf4wihOBANz+8cz6ICcLmq4usJA==
X-Received: by 2002:a63:36c1:: with SMTP id d184mr22678493pga.47.1622004856107;
        Tue, 25 May 2021 21:54:16 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-83.three.co.id. [180.214.232.83])
        by smtp.gmail.com with ESMTPSA id k7sm3185201pjj.46.2021.05.25.21.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 21:54:15 -0700 (PDT)
Subject: Re: The top 1% of commit trailers
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <60ad75ac7ffca_2ae08208b@natae.notmuch>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <24504f19-eb8e-c725-723a-22efea7c865c@gmail.com>
Date:   Wed, 26 May 2021 11:54:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60ad75ac7ffca_2ae08208b@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

On 26/05/21 05.09, Felipe Contreras wrote:
> Hi,
> 
> I wrote a little script [1] to get the quantiles (e.g. top 1%) of commit
> trailers for the git.git project. Perhaps some of you are interested in
> the result.
> 
> The top 1% is comprised of just two lines: Acked-by and Reviewed-by.
> They alone account for 47% of all the lines.
> 
> The top 10% is shared between 16 lines, and they gather a whopping 96% of
> the total line wealth.
> 
> The top 25% is shared between 33 lines, they have 98% wealth. To belong
> on this group a line only needs to have more than 3 instances.
> 
> That means the bottom 75% only has 3 occurrences or less.
> 
> The median is 1. So 50% (in fact more than that; 100 of 155) only has one
> occurrence.
> 
> Just to see this distribution visually, I plotted their frequency
> compared with a Pareto distribution (80:20); they almost match
> perfectly:
> 
> https://i.imgur.com/1wQgSlP.png
> 
> This should not be surprising to anyone that has studied income
> distributions; in commit trailer lines--just like in people (and plenty
> of other things)--the rich get richer.
> 
> Cheers.
> 
> Top 1%
> ------
>    1. acked-by (1945)
>    2. reviewed-by (1729)
> 
> Total wealth: 47%
> 
> Top 10%
> -------
>    3. helped-by (1336)
>    4. reported-by (960)
>    5. mentored-by (379)
>    6. suggested-by (281)
>    7. cc (222)
>    8. noticed-by (165)
>    9. tested-by (153)
>   10. improved-by (88)
>   11. thanks-to (65)
>   12. based-on-patch-by (50)
>   13. contributions-by (43)
>   14. co-authored-by (41)
>   15. requested-by (28)
>   16. original-patch-by (28)
> 
> Total wealth: 96%
> 
> Top 25%
> -------
>   17. inspired-by (23)
>   18. explained-by (9)
>   19. found-by (8)
>   20. trivially-acked-by (7)
>   21. commit-message-by (7)
>   22. fixes (7)
>   23. initial-patch-by (7)
>   24. reported-and-tested-by (6)
>   25. diagnosed-by (6)
>   26. based-on-a-patch-by (6)
>   27. liked-by (5)
>   28. author (5)
>   29. reference (5)
>   30. encouraged-by (5)
>   31. from (4)
>   32. analyzed-by (4)
>   33. initial-test-by (4)
> 
> Total wealth: 98%
> 
> Bottom 50%
> ----------
>   59. cheered-on-by (1)
>   60. signed-off (1)
>   61. confirmed-by (1)
>   62. hopefully-signed-off-by (1)
>   63. thanked-by (1)
>   64. rediffed-against-next-by (1)
>   65. completely-acked-by (1)
>   66. test-proposed-by (1)
>   67. patch-submitted-by (1)
>   68. credit-to (1)
>   69. deemed-obviously-correct-by (1)
>   70. backtraced-by (1)
>   71. tested-on-mingw-by (1)
>   72. looks-good-by (1)
>   73. test-updates-by (1)
>   74. tested-on-freebsd-by (1)
>   75. tested-on-aix-by (1)
>   76. kind-of-noticed-by (1)
>   77. patch-by (1)
>   78. okay-then-by (1)
>   79. looks-right-to-me-by (1)
>   80. reviewd-by (1)
>   81. wished-for-by (1)
>   82. acked-and-tested-by (1)
>   83. re-suggested-by (1)
>   84. originally-submitted-by (1)
>   85. looks-fine-to-me-by (1)
>   86. based-on-patch-from (1)
>   87. see (1)
>   88. initial-version-by (1)
>   89. worriedly-acked-by (1)
>   90. initial-fix-by (1)
>   91. mentored-and-acked-by (1)
>   92. x-gentoo-bug (1)
>   93. works-around (1)
>   94. tipping-vote-by (1)
>   95. debugged-by (1)
>   96. helpd-by (1)
>   97. heavylifting-by (1)
>   98. inspired-by-patch-by (1)
>   99. inspired-by-code-by (1)
> 100. based-on-code-from (1)
> 101. based-on-code-by (1)
> 102. tracked-down-by (1)
> 103. picked-from (1)
> 104. discovered-by (1)
> 105. improved-and-acked-by (1)
> 106. based-on-commit-message-by (1)
> 107. updated-by (1)
> 108. discussion-triggered-by (1)
> 109. sugested-by (1)
> 110. reported-tested-and-explained-by (1)
> 111. initial-work-by (1)
> 112. brown-paper-bag-fixes-by (1)
> 113. test-written-by (1)
> 114. test-added-by (1)
> 115. bug-spotted-and-fixed-by (1)
> 116. inputs-from (1)
> 117. with-suggestions-by (1)
> 118. more-spots-found-by (1)
> 119. message-proposed-by (1)
> 120. revised-by (1)
> 121. reported-and-analyzed-by (1)
> 122. prompted-by (1)
> 123. clarified-by (1)
> 124. reviewed-and-improved-by (1)
> 125. brought-to-attention-by (1)
> 126. reminded-by (1)
> 127. adapted-by (1)
> 128. edited-by (1)
> 129. hepled-by (1)
> 130. test-adapted-from (1)
> 131. clever-idea-by (1)
> 132. fix-suggested-by (1)
> 133. reported-and-suggested-by (1)
> 134. history-dug-by (1)
> 135. derived-from-code-by (1)
> 136. fix-proposed-by (1)
> 137. benchmarked-by (1)
> 138. issue-found-by (1)
> 139. test-provided-by (1)
> 140. test-code-by (1)
> 141. reported-at (1)
> 142. signeg-off-by (1)
> 143. wording-by (1)
> 144. also-reported-by (1)
> 145. issue-on-macos-explained-by (1)
> 146. issue-on-macos-reported-by (1)
> 147. researched-by (1)
> 148. explanation-by (1)
> 149. rported-by (1)
> 150. change-id (1)
> 151. rebased-by (1)
> 152. inspired-by-a-patch-by (1)
> 153. simplified-testcase-and-bisection-by (1)
> 154. heled-by (1)
> 155. pointed-out-by (1)
> 156. suggestions-by (1)
> 157. original-implementation-by (1)
> 158. summary (1)
> 
> Total wealth: 1%
> 
> [1] https://gist.github.com/felipec/ce491d351c88e4acbdbf6bc02a47223d
> 

Why did you deliberately exclude Signed-off-by trailer? I don't see
that trailer above.

For some trailers that have only 1 occurrence, these are typos of
intended trailers (such as heled-by and helpd-by which means
helped-by).

-- 
An old man doll... just what I always wanted! - Clara
