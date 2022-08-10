Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB7C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiHJPqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiHJPqW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:46:22 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE45275C7
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:21 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f2a4c51c45so18231437fac.9
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=dLV7KImkwZEjK0igfAAAuL3QB3ctQWY4uvlufGp3P3k=;
        b=VjSfn5GH7VyrAf6xgPOjoT9bkBJCgJXCzMvjH7FW9jN/sSOEHGUytzn7LfR5QQna9f
         cNb74dKtIvTqTX+VN1qptwY1woLR16Qhnp0K7HiF7ZMsRWmCPHJ459a/iMgp3YDc5uhW
         hJJhN62EmgQhjDAhVT/k+eYGiYofz/8agnwvWQRrEbFFvu2xznmr6xEktXT4VG0yGkEh
         GAA+vVnus6dGmq1uzO9D3j+80EU+gsyY3/JBBy/0fM7JnHGfzHj8Hgy7Auz/vsFMbal7
         hbNXUtJgNDzeu69jOjSgXcU2cY8BKm4/flAQUILag/7FNf+CqBaqQVeEgvC193M7R/na
         q9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=dLV7KImkwZEjK0igfAAAuL3QB3ctQWY4uvlufGp3P3k=;
        b=DWAQpOFUNDrcUFGp7LYIw2wKKhCKifbrtXTdn1mY5wdUfokGC6w0hN9jo2RYcC1Q0G
         EIPctaqquOsbf/dJj6opbJi+X94HP27llpQy8loMSwUDXiwsVafqc9bbmrQf1W6HMbjy
         ESG8Ni8uMt937Z9heQ43aTdDyGJH4SsqgvceP7/Kk/LjYRwrrV/G6CZt2q4a8qo/slYP
         08CIjzebyjpWAacsXcxq1nZhMvGWbZ4dl4htXguaVPYKOrCWkYRvpfOWEG64J0gyUCNQ
         wsFgzQay8CdRvjqrCrTGoUDQK7G1kLTwPu0aNINtUibuHpg/uPYMTyyhQ2WQq16Mc5kD
         /vbA==
X-Gm-Message-State: ACgBeo3m6+XDIE0T8wAjIq1Regd9wJsrrnNrw7tTg3Mtr7sRKf6NZQ02
        13BQFV8bfvZuc9r6don4oqJADPkgYCI=
X-Google-Smtp-Source: AA6agR5Oxzedpl7UyAY59pJZ0wu35gt1aIxiy7I7/Ip2pR2hU2y+9URV8uQ9qW3jHRD5Ee7T9RG7Zg==
X-Received: by 2002:a05:6870:9111:b0:10e:ad89:e5c8 with SMTP id o17-20020a056870911100b0010ead89e5c8mr1710786oae.96.1660146380159;
        Wed, 10 Aug 2022 08:46:20 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q7-20020a056870328700b0010d15f11512sm3853644oac.4.2022.08.10.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:46:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/7] mergetools: vimdiff: regression fixes and improvements
Date:   Wed, 10 Aug 2022 10:46:11 -0500
Message-Id: <20220810154618.307275-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

These patches make vimdiff3 actually work, along with many single window
cases.

Since 3 the patches have been reorganized to do the tab reoganization
first, and then the rest become simple. I also dropped one intermediate
patch which isn't necessary.

Felipe Contreras (7):
  mergetools: vimdiff: fix comment
  mergetools: vimdiff: make vimdiff3 actually work
  mergetools: vimdiff: silence annoying messages
  mergetools: vimdiff: fix for diffopt
  mergetools: vimdiff: rework tab logic
  mergetools: vimdiff: fix single window layouts
  mergetools: vimdiff: simplify tabfirst

 mergetools/vimdiff | 102 +++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 59 deletions(-)

Range-diff against v3:
1:  20c5abdbc8 = 1:  20c5abdbc8 mergetools: vimdiff: fix comment
2:  8d466e06aa ! 2:  f0bf1bc1c2 mergetools: vimdiff: make vimdiff3 actually work
    @@ Commit message
         2022-03-30) this was broken by generating a command that never creates
         windows, and therefore vim never shows the diff.
     
    -    In order to show the diff, the windows need to be created first, and
    -    then when they are hidden the diff remains (if hidenoff isn't set).
    -
         The layout support implementation broke the whole purpose of vimdiff3,
         and simply shows MERGED, which is no different from simply opening the
         file with vim.
     
    -    Setting the `hidden` option makes it work as intended.
    +    In order to show the diff, the windows need to be created first, and
    +    then when they are hidden the diff remains (if hidenoff isn't set), but
    +    by setting the `hidden` option the initial buffers are marked as hidden
    +    thus making the feature work.
     
         Suggested-by: Fernando Ramos <greenfoo@u92.eu>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
3:  95bfab5813 = 3:  b8deea49a6 mergetools: vimdiff: silence annoying messages
4:  08f6b2bce2 = 4:  66455480e5 mergetools: vimdiff: fix for diffopt
5:  2bff74f499 < -:  ---------- mergetools: vimdiff: fix single window layouts
6:  39e8277317 ! 5:  9d3a12237d mergetools: vimdiff: rework tab logic
    @@ Commit message
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## mergetools/vimdiff ##
    +@@ mergetools/vimdiff: gen_cmd_aux () {
    + 	debug_print "LAYOUT    : $LAYOUT"
    + 	debug_print "CMD       : $CMD"
    + 
    +-	if test -z "$CMD"
    +-	then
    +-		CMD="echo" # vim "nop" operator
    +-	fi
    +-
    + 	start=0
    + 	end=${#LAYOUT}
    + 
     @@ mergetools/vimdiff: gen_cmd_aux () {
      
      	# Step 2:
    @@ mergetools/vimdiff: gen_cmd_aux () {
      
     -	if ! test -z "$index_new_tab"
     -	then
    --		before="-tabnew | silent execute 'bufdo diffthis'"
    +-		before="-tabnew"
     -		after="tabnext"
     -		index=$index_new_tab
     -		terminate="true"
    @@ mergetools/vimdiff: gen_cmd () {
     +	IFS=+
     +	for tab in $LAYOUT
     +	do
    -+		test -n "$CMD" && CMD="$CMD | tabnew | silent execute 'bufdo diffthis'"
    ++		if test -z "$CMD"
    ++		then
    ++			CMD="echo" # vim "nop" operator
    ++		else
    ++			CMD="$CMD | tabnew"
    ++		fi
    ++
     +		CMD=$(gen_cmd_aux "$tab" "$CMD")
     +	done
     +	IFS=$oldIFS
      
      
    - 	# Add an extra "-c" option to move to the first tab (notice that we
    + 	# Adjust the just obtained script depending on whether more than one
     @@ mergetools/vimdiff: run_unit_tests () {
    - 	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b\" -c \"tabfirst\""
    - 	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b\" -c \"tabfirst\""
    - 	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
    --	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
    -+	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
    - 	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b\" -c \"tabfirst\""
    - 	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
    --	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | 2b | wincmd l | 1b\" -c \"tabfirst\""
    --	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
    --	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
    -+	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b\" -c \"tabfirst\""
    -+	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
    -+	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
    + 	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
    + 	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
    + 	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
    +-	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
    ++	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
    + 	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
    + 	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
    +-	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
    +-	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
    +-	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
    ++	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
    ++	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
    ++	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
      
      	EXPECTED_TARGET_01="MERGED"
      	EXPECTED_TARGET_02="LOCAL"
7:  92df35208d < -:  ---------- mergetools: vimdiff: restore selective diff mode
-:  ---------- > 6:  ac1b102da0 mergetools: vimdiff: fix single window layouts
-:  ---------- > 7:  579ec52bc1 mergetools: vimdiff: simplify tabfirst
-- 
2.37.1

