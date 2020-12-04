Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9FC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFCC224BE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgLDCsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 21:48:24 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:60685 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726956AbgLDCsX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Dec 2020 21:48:23 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1659BDE4
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 21:47:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 03 Dec 2020 21:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lYbCOL
        NlxC64ORl05ynK8Y6gIGaf57S/j8PKney8WEQ=; b=lP7GU4u29273N6gUQd9RFb
        KLow2BIvROa/G/mu1LbpTzZxc18AdtQvWQFaLJKlj/J3b35rqYdGEFRjFuk1MyOp
        nJWnWU7rHY1cVmBCIYvJS+AUimqT8a7u05xz2zybmKqHhJQ1xVfrrRcDZLa0M+G0
        T4s7GsxQJ4w8z5KjZomqmpt9+J2pMTysh/WdkpKdxM+G81sZ9ae42u0RgjnLKOXw
        2bGPaIVeVgMAWUyu0PCS2nDAHz/G2FXyEjLSiqh3yxo7BGR+H/JWDb8TnRNFUhEH
        WboIe5gaABNhmrFYsNgmDCJf+zolzZYuy0/Rl74IKjGG636zTY94/7jHlqmUoeRQ
        ==
X-ME-Sender: <xms:SaPJX7HHngLxHB5XSvK5wH8NB_kEWcWinKOQAYpkhq6RIOMLlQJfcA>
    <xme:SaPJX4SNpcIOo4q0Q4y3_Y7pOPDLjvcRxQmLltLkG7wpyYGZvvXOw32Ad1UpSJ4lk
    XUitMGa9IyTWwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeijedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefvhf
    fukffffgggtgfgsehtkeertddtfeejnecuhfhrohhmpeffrghnihgvlhcuoegurghnihgv
    lheshhgvrghthhdrtggtqeenucggtffrrghtthgvrhhnpeevleehgeekjeeftedvgedvle
    dvkeejveeiheeftdejffdtfeeuheegudeggffffeenucfkphepudektddrudehtddrheek
    rdeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gurghnihgvlheshhgvrghthhdrtggt
X-ME-Proxy: <xmx:SaPJX6DOdiyZ_DezPC2HLhfsFylvnDwPiL07UIB7N4y7rLbfMx4k1g>
    <xmx:SaPJXw2nZKlrUIAAVriH1LAcE-7T5XTnE1DURZ96QvSryd0-uobDvA>
    <xmx:SaPJXwXY6-LXpcjAkCtqMouScBd5_s-JTLAO2kufEda_NDXejYsQoA>
    <xmx:SaPJX6cJ12C8kWxxeYT0Yj2BCmRNh1lys_IJgrAB1MribYEQhXJ_vQ>
Received: from [192.168.20.41] (180-150-58-69.b4963a.mel.static.aussiebb.net [180.150.58.69])
        by mail.messagingengine.com (Postfix) with ESMTPA id 13F351080057
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 21:47:36 -0500 (EST)
To:     git@vger.kernel.org
From:   Daniel <daniel@heath.cc>
Subject: Bug: git log -L manpage claims regexes are supported, but they are
 not
Message-ID: <147444de-7653-d067-596a-9448ae6b8cac@heath.cc>
Date:   Fri, 4 Dec 2020 13:47:34 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Context:

   $ git version
git version 2.25.1

   $ git log -L ^/bootstrap-sass/,+2 Gemfile
fatal: -L argument not 'start,end:file' or ':funcname:file': 
^/bootstrap-sass/,+2


I expected the above to work, based on the contents of `git help log`, 
which describes the regex format.

This regex format works correctly in `git blame -L`, and it appears the 
manpage was copied across but not the implementation.


$ git help log

        -L <start>,<end>:<file>, -L :<funcname>:<file>
            Trace the evolution of the line range given by 
"<start>,<end>" (or the function name regex <funcname>) within the 
<file>. You may not give any pathspec limiters. This is
            currently limited to a walk starting from a single revision, 
i.e., you may only give zero or one positive revision arguments, and 
<start> and <end> (or <funcname>) must
            exist in the starting revision. You can specify this option 
more than once. Implies --patch. Patch output can be suppressed using 
--no-patch, but other diff formats (namely
            --raw, --numstat, --shortstat, --dirstat, --summary, 
--name-only, --name-status, --check) are not currently implemented.

            <start> and <end> can take one of these forms:

            •   number

                If <start> or <end> is a number, it specifies an 
absolute line number (lines count from 1).

            •   /regex/

                This form will use the first line matching the given 
POSIX regex. If <start> is a regex, it will search from the end of the 
previous -L range, if any, otherwise from the
                start of file. If <start> is “^/regex/”, it will search 
from the start of file. If <end> is a regex, it will search starting at 
the line given by <start>.

            •   +offset or -offset

                This is only valid for <end> and will specify a number 
of lines before or after the line given by <start>.

            If “:<funcname>” is given in place of <start> and <end>, it 
is a regular expression that denotes the range from the first funcname 
line that matches <funcname>, up to the
            next funcname line. “:<funcname>” searches from the end of 
the previous -L range, if any, otherwise from the start of file. 
“^:<funcname>” searches from the start of file.


