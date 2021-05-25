Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04450C4707F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 22:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61FA613F5
	for <git@archiver.kernel.org>; Tue, 25 May 2021 22:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhEYWLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 18:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhEYWLW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 18:11:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526AC061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 15:09:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c196so23559507oib.9
        for <git@vger.kernel.org>; Tue, 25 May 2021 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=ni2l8OLSwof37ob/5LXvJIbrJte1bAagaK46XoyNjrs=;
        b=NTkKZgyoNqt2ahSyH2fVFPN23GgJIP0UHZoplVEq5LnLHFR0Cl89naQYc3gd3ezHr/
         NcXQfoPgmMCjcgN+I09lqwOP5ZIsu8lyr45w4/W5k58HANW4HdrJb3/ov1yS31EZ4Pl2
         wQSifeWRUEFlUvHLQGLl9E8jzJanIpb9jg3EHWkrbK+P3VrRjUNjh9rbWI1UkWfU0ynF
         /U0SqzLcXG+FT+fXvlcz/6vr7D8RZ2esqhBvtGw2PYukUQ598R1n2XOCyDl061kcmsBa
         Klv4+he+qCe3ShF0F3dMNxiGONNPETJrj1iL2X0yf6p9W7ked2Js+PI0qvUimLPvn7s9
         /cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=ni2l8OLSwof37ob/5LXvJIbrJte1bAagaK46XoyNjrs=;
        b=X7TCu7VpJpc5IjVgucIlpjNI8Pnmmnu4jiRG1vGnde7jBXBKULHRyk1OWH3nBpm9aN
         r7jm9/C+6aKVgowM7i5beaMEVHBPrKYIlGOPnZCo9mnRCQZT8LvPdo8hqmXvlHXv5gGd
         WNg9v9QawOwCo/Z1mQjIOjALcxfrj09QCFvDfosfDwaV3459jO2r7d1hrLjGA+GKX6kl
         Wh02KTesqz8EZbdqru5PMk23EQiagAUS5gsH9Hpew2FX68FY4Wu6ETKZUJciBysWuQtI
         x1nSUqB9eeMDhAi5ung5fA9RGwnOen+xzg4+3Ghp4efsHb1Jwxp37rS2mD/uqhz8TX+o
         eUEg==
X-Gm-Message-State: AOAM532Jd0mnHtMJIolRavnv3rmQ9ibkDr7LRRNz1hGz1URtGhn/rJVo
        aBnWeaf0kWWHYPxohg4daW2LXBbe/9fQLg==
X-Google-Smtp-Source: ABdhPJxzJeXFASovFhFzl3u6Z/SVkAAmDdGNa0KPlRE8lvnOB/mAhb4GCC2Gw5GkwgXNatyw8CPuMg==
X-Received: by 2002:a05:6808:13cb:: with SMTP id d11mr349904oiw.138.1621980590475;
        Tue, 25 May 2021 15:09:50 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r10sm3451289oic.4.2021.05.25.15.09.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:09:50 -0700 (PDT)
Date:   Tue, 25 May 2021 17:09:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <60ad75ac7ffca_2ae08208b@natae.notmuch>
Subject: The top 1% of commit trailers
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I wrote a little script [1] to get the quantiles (e.g. top 1%) of commit
trailers for the git.git project. Perhaps some of you are interested in
the result.

The top 1% is comprised of just two lines: Acked-by and Reviewed-by.
They alone account for 47% of all the lines.

The top 10% is shared between 16 lines, and they gather a whopping 96% of
the total line wealth.

The top 25% is shared between 33 lines, they have 98% wealth. To belong
on this group a line only needs to have more than 3 instances.

That means the bottom 75% only has 3 occurrences or less.

The median is 1. So 50% (in fact more than that; 100 of 155) only has one
occurrence.

Just to see this distribution visually, I plotted their frequency
compared with a Pareto distribution (80:20); they almost match
perfectly:

https://i.imgur.com/1wQgSlP.png

This should not be surprising to anyone that has studied income
distributions; in commit trailer lines--just like in people (and plenty
of other things)--the rich get richer.

Cheers.

Top 1%
------
  1. acked-by (1945)
  2. reviewed-by (1729)

Total wealth: 47%

Top 10%
-------
  3. helped-by (1336)
  4. reported-by (960)
  5. mentored-by (379)
  6. suggested-by (281)
  7. cc (222)
  8. noticed-by (165)
  9. tested-by (153)
 10. improved-by (88)
 11. thanks-to (65)
 12. based-on-patch-by (50)
 13. contributions-by (43)
 14. co-authored-by (41)
 15. requested-by (28)
 16. original-patch-by (28)

Total wealth: 96%

Top 25%
-------
 17. inspired-by (23)
 18. explained-by (9)
 19. found-by (8)
 20. trivially-acked-by (7)
 21. commit-message-by (7)
 22. fixes (7)
 23. initial-patch-by (7)
 24. reported-and-tested-by (6)
 25. diagnosed-by (6)
 26. based-on-a-patch-by (6)
 27. liked-by (5)
 28. author (5)
 29. reference (5)
 30. encouraged-by (5)
 31. from (4)
 32. analyzed-by (4)
 33. initial-test-by (4)

Total wealth: 98%

Bottom 50%
----------
 59. cheered-on-by (1)
 60. signed-off (1)
 61. confirmed-by (1)
 62. hopefully-signed-off-by (1)
 63. thanked-by (1)
 64. rediffed-against-next-by (1)
 65. completely-acked-by (1)
 66. test-proposed-by (1)
 67. patch-submitted-by (1)
 68. credit-to (1)
 69. deemed-obviously-correct-by (1)
 70. backtraced-by (1)
 71. tested-on-mingw-by (1)
 72. looks-good-by (1)
 73. test-updates-by (1)
 74. tested-on-freebsd-by (1)
 75. tested-on-aix-by (1)
 76. kind-of-noticed-by (1)
 77. patch-by (1)
 78. okay-then-by (1)
 79. looks-right-to-me-by (1)
 80. reviewd-by (1)
 81. wished-for-by (1)
 82. acked-and-tested-by (1)
 83. re-suggested-by (1)
 84. originally-submitted-by (1)
 85. looks-fine-to-me-by (1)
 86. based-on-patch-from (1)
 87. see (1)
 88. initial-version-by (1)
 89. worriedly-acked-by (1)
 90. initial-fix-by (1)
 91. mentored-and-acked-by (1)
 92. x-gentoo-bug (1)
 93. works-around (1)
 94. tipping-vote-by (1)
 95. debugged-by (1)
 96. helpd-by (1)
 97. heavylifting-by (1)
 98. inspired-by-patch-by (1)
 99. inspired-by-code-by (1)
100. based-on-code-from (1)
101. based-on-code-by (1)
102. tracked-down-by (1)
103. picked-from (1)
104. discovered-by (1)
105. improved-and-acked-by (1)
106. based-on-commit-message-by (1)
107. updated-by (1)
108. discussion-triggered-by (1)
109. sugested-by (1)
110. reported-tested-and-explained-by (1)
111. initial-work-by (1)
112. brown-paper-bag-fixes-by (1)
113. test-written-by (1)
114. test-added-by (1)
115. bug-spotted-and-fixed-by (1)
116. inputs-from (1)
117. with-suggestions-by (1)
118. more-spots-found-by (1)
119. message-proposed-by (1)
120. revised-by (1)
121. reported-and-analyzed-by (1)
122. prompted-by (1)
123. clarified-by (1)
124. reviewed-and-improved-by (1)
125. brought-to-attention-by (1)
126. reminded-by (1)
127. adapted-by (1)
128. edited-by (1)
129. hepled-by (1)
130. test-adapted-from (1)
131. clever-idea-by (1)
132. fix-suggested-by (1)
133. reported-and-suggested-by (1)
134. history-dug-by (1)
135. derived-from-code-by (1)
136. fix-proposed-by (1)
137. benchmarked-by (1)
138. issue-found-by (1)
139. test-provided-by (1)
140. test-code-by (1)
141. reported-at (1)
142. signeg-off-by (1)
143. wording-by (1)
144. also-reported-by (1)
145. issue-on-macos-explained-by (1)
146. issue-on-macos-reported-by (1)
147. researched-by (1)
148. explanation-by (1)
149. rported-by (1)
150. change-id (1)
151. rebased-by (1)
152. inspired-by-a-patch-by (1)
153. simplified-testcase-and-bisection-by (1)
154. heled-by (1)
155. pointed-out-by (1)
156. suggestions-by (1)
157. original-implementation-by (1)
158. summary (1)

Total wealth: 1%

[1] https://gist.github.com/felipec/ce491d351c88e4acbdbf6bc02a47223d

-- 
Felipe Contreras
