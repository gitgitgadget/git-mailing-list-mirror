Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A80E784BD
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbjJBPR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbjJBPR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:17:26 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDA790
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:17:23 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7741b18a06aso1080472985a.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696259842; x=1696864642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/JrzZBN1Z5E/OkB7RIAN9dOewloh1E1K7ijouojC1E=;
        b=CJ2uXUi4jOmrPu8kKodxMZW5JQkXNlOQZ0r0oZjjY3vzCFYo6h6RsNT1nYnT3ZbviT
         nj4/JbcK6xP0l9lhYdh44C2DnFcl4QE4q0BMsbCjwnhZYhlP2r1jy5/PXp2rdNvXAiC0
         e5M+nNJr1c8Ta5sd5eylEI2rBKeYibLjkFF1le7KA+98Hbb4f3uK1NFCCY9QDoASAim5
         3PhDt0nlQCFOig11/3hI0M61pmw3u6mwgNXIup5uFI/nGpnjQ3GqWl3pcI4Av5/8td9T
         cbfNFk+5HiXG5rXyOUGTDka4rycTeiCGDVCAlNdmYVFqf60ggdOixP4Rytl3S7VpCjjN
         uBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259842; x=1696864642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/JrzZBN1Z5E/OkB7RIAN9dOewloh1E1K7ijouojC1E=;
        b=Ra3Z8JBiDfwIm6g2vnkKaz7OCMxS9qmFvEljkPdUh5vQAMt3SeIaiTYh0SQuHTOme0
         Q1m8Nrwz6arfao/SO9DkzAONAL73lmKlT208J+0djcEK8Izv6GI41+ycaShDHs12SSFE
         SeAIPP4lgJm2qb3Vai86treZvGaCIMl4fNYaikVsWm8qlXugnEVN2p0hao9ItA/of8WP
         P2HIjsyU0NzWWvn7h8AwyQypevi2J0k2xYs/grz07e6YmusCctuJDbP3OuaYMELovL2D
         I0DW6mZLTJjKimHNkD4RL7g77+DFw2HTkSbDH4ZG/HeQ5gsf7uv79JufPSBsT8sfJGBt
         LW6w==
X-Gm-Message-State: AOJu0YwtlVJMiWy78tIRA3IX9V304jvZsqZfovgGtWa/gPF0klX58EWD
        TyhYZrBrQnX1aN2e50IlxMMJKKq3MuRecAHHEYnw7A==
X-Google-Smtp-Source: AGHT+IGIE1JKYC+O3niLOEvcoYozu+adm8AZI3OQbaZHEmpV+0/DCyHYuCRwoGDS1mWB/kay0kWGrQ==
X-Received: by 2002:a0c:dd90:0:b0:63d:3bea:f663 with SMTP id v16-20020a0cdd90000000b0063d3beaf663mr12569335qvk.47.1696259842316;
        Mon, 02 Oct 2023 08:17:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a10b000b0076f19b9e96fsm3291142qkk.107.2023.10.02.08.17.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:17:22 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:17:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 0/12] Welcome / Conservancy Update
Message-ID: <ZRrfAdX0eNutTSOy@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Taylor Blau, Notetaker: Keanen Wold)

* Software Freedom Conservancy status report
* We have about $89k in the Git project account (up ~$20k from last year)
   * Biggest expense is Heroku - Fusion has been covering the bill
      * There's on and off work on porting from a Rails app to a static site:
        https://github.com/git/git-scm.com/issues/942
   * Dan Moore from FusionAuth has been providing donations
   * Ideally we are able to move away from using Heroku, but in the meantime
     we'll have coverage either from (a) FusionAuth, or (b) Heroku's new
     open-source credit system
* We have more money than we have plans for, we're looking for ideas[a] on how
  to spend this money such as funding people to visit our conferences and
  sponsoring students to learn more about Git
* Trademark considerations for people using "Git" in their product names
   * We do have general council and are trying to think more about what the Git
     trademark means
   * Question - are there other conservancy products who have trademark issues
      * They hold all trademarks for their projects
      * Git has had the most problems with people/products using Git in their
        name
      * They reach out with letters, etc. and have not had to take legal action
        in most cases
   * Question - how do we enforce the rules when we have GitHub and GitLab?
      * The trademark has exemptions for Hub and Lab
      * We need to hold the line for the trademark for new companies, etc. using
        the name otherwise we lose our leverage to protect the name
   * Question - have the trademark ‘offenses' been growing?
      * It's been pretty stable
      * We're looking to be fair
   * Additional questions can be sent to Pono
