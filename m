Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9635BC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 02:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7363D206F6
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 02:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbjXBQWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGGC0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGGC0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 22:26:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF039C061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 19:26:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so68376pfn.9
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=BIy34BxMaUnW6J3vyf01BNzAtV+DYJ6hJ6aQk0Ss56s=;
        b=PbjXBQWEAeDynF9OaFKZWGqo4E3HHQffKHu9J/xqgyGiJGmuYp9yGzMYgEUFQ6SiCV
         mNbbi2YAFZJlnkIw7nOzvHXQ0uZKBCaxIMJ35tj0gqRKvGyOn6c680ukm8m8leh3+MaT
         /maa40wNQiXYIrHGGM8hN13ldUKHGTGvjXIIhY29O9+6tA05vSM7X9vjmTH+T3wlFTHr
         lRPDjl/H9gQqm6wFSREJZLN2DgnJXVaNyk8FKPR7PQcVjw40RZLpmmCp+xup74C7Wjw+
         tcFxEPteALVkh1Df/DgXTsawWZrL9BTh2WQ7AxGbrBAvEj97HrdIqdoEJI+q+L6sjlPA
         VnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=BIy34BxMaUnW6J3vyf01BNzAtV+DYJ6hJ6aQk0Ss56s=;
        b=A3JjdFxM6QEOeQCOthezH43GtZ+cF2aKJMpzIIF4mQbghLp1i/PDpM8+RC45JhZdLz
         ASvihka2Jz3dQYfhZS+CnRCtTp5v391ktDRnAAobhMH5todK+YKvQlIGCPJoJZIfXWrA
         fAiRtwdrX+tn1+Ghqa23BfLM1kPPbjTHyEXvX9BWluqI7qn6FmQqHmhhbaxos9KBeOau
         Xncss6tgZPkg0spTpVSIk0E0BqlsoaZ9UBtFwVhygZMifvu/VzKB2ygtmQj73/CrAc9C
         CuTmvQaiUkbyigt/m76NFKUlgyYbe6Hu/o9xazu28lk/7QLvjnYDksL6aKD5+GGnBSQ5
         cijw==
X-Gm-Message-State: AOAM530efTszZ1HmEc5Wjlt051FOwdA0+WkBYdCib9zXqwJ79SfVThxN
        Cdttvvh3Faf5WpdmigXQPgg=
X-Google-Smtp-Source: ABdhPJxXg2dm87xcI8NSjtCWwotu1CW6fs/WRnu/HuYrjypYqkkSljcdrjblmsehgJgRF6AUZ5UJ/g==
X-Received: by 2002:a63:e60b:: with SMTP id g11mr44130821pgh.188.1594088779300;
        Mon, 06 Jul 2020 19:26:19 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:2e25:1ed8:b84b:a378:b9b2:c27c])
        by smtp.gmail.com with ESMTPSA id 129sm20846757pfv.161.2020.07.06.19.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 19:26:18 -0700 (PDT)
Date:   Tue, 7 Jul 2020 07:54:25 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     abhishekkumar8222@gmail.com
Cc:     git@vger.kernel.org, stolee@gmail.com, jnareb@gmail.com
Subject: [GSOC] Blog about weeks 4, 5
Message-ID: <20200707022425.GA1649@Abhishek-Arch>
Reply-To: 20200617093328.GA1327@abhishek-arch
References: <20200706182213.GA51227@Abhishek-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706182213.GA51227@Abhishek-Arch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone!

Over the last two weeks, I have worked on refining the performance
report on generation numbers. Here are our conclusions:

- Corrected Commit Dates With Monotonically Offset (i.e.  generation
  number v5) performs better than topological levels but is still walks
  too many commits when compared with Corrected Commit Dates.

Number of commits walked (git merge-base v4.8 v4.9, on linux repository):

Topological Level                          : 635579
Corrected Commit Date                      : 167468
Corrected Commit Date With Monotonic Offset: 506577

As such, I am expecting that we will store Corrected Commit Date in an
additional chunk (called "generation data chunk") and store topological
levels into CDAT. Thus, old Git clients can operate as expected, with
new Git clients using the better generation number.

- Using a new chunk does affect the locality of reference but did not
  impact the performance appreciably.
- This does increase the size of commit graph file by nearly 5%.

You can read more in my report [1] and the pull request with
instructions to replicate the results [2].

[1]: https://lore.kernel.org/git/20200703082842.GA28027@Abhishek-Arch/T/#mda33f6e13873df55901768e8fd6d774282002146
[2]: https://github.com/abhishekkumar2718/git/pull/1

I talk a bit more about a patch I worked on, trying to improve
performance of commit graph write using buffers which ultimately did not
work and is dropped. Up next is actually implementing the generation
number and take care of all little details.

https://abhishekkumar2718.github.io/programming/2020/07/05/gsoc-weeks-4-5.html

Feedback and suggestions welcome!

Thanks
- Abhishek

--------

Re-sending this email as I forgot to cc git@vger.kernel.org
