Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB1C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 23:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbiCVXro (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 19:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbiCVXrn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 19:47:43 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077096E341
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 16:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1647992590;
    s=strato-dkim-0002; d=pdev.de;
    h=In-Reply-To:From:To:References:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=YyADkAump7JoX34ElySCh/i1Na+IMEoO3L67mY+d0xY=;
    b=Q/OTOD3DldS3OrEuMW/fly2UOQYpA3HfA7Oe3GcYzwLjHEZTqE/Hys+IhU5eryd54L
    Hd4yo3u6+ezBTV7on+lm8y/LlQxz19dhmSl2DAA4DCGwNyx+aJL7DxCOPLHI0sGfYQdf
    XW6luKJthwUvsU6zgc7uk6Y7+mpeG4S3tUx9Gx2WyR2kNFjZJXVf/Cc/iSUN9X35zuq8
    sBNig2+dyPumGpHOK1nlYYh2q6tPqx8PASi0hRrymbXezovWdSK5aLoHkaLoPpEvvFr6
    vRgLoL9XgpiBNEyDBKZ+l2+5emLIMkOXLlDHZ0sMRS+LrIOJpDhcYUau/UcS/L4XkU9K
    vUyA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":Pm0UfUGtd9+G9p9stmxCE5ta4sApnuCD/i3TNd+y2/o2oXSBVgRMI6humKUuozndgpwu8lZU36Vuuqfk0UbkMKm4wxnhxWLq"
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2003:c8:d713:c000:6600:6aff:fe94:255]
    by smtp.strato.de (RZmta 47.42.0 AUTH)
    with ESMTPSA id a06457y2MNhA2Fe
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <git@vger.kernel.org>;
    Wed, 23 Mar 2022 00:43:10 +0100 (CET)
Message-ID: <600744a4-8d5a-0ef3-6e75-e3637e7070aa@pdev.de>
Date:   Wed, 23 Mar 2022 00:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: BUG: %+ format placeholder and colors
Content-Language: en-US
References: <6f0d1c12-4cf8-bbdd-96d4-eae99317e2e4@pdev.de>
To:     Git ML <git@vger.kernel.org>
From:   Raphael Bauer <raphael@pdev.de>
In-Reply-To: <6f0d1c12-4cf8-bbdd-96d4-eae99317e2e4@pdev.de>
X-Forwarded-Message-Id: <6f0d1c12-4cf8-bbdd-96d4-eae99317e2e4@pdev.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am not familiar with using mailing list for bug tracking. I already 
reported this bug, but got no answer, so I wanted to mention it again.

* What did you do before the bug happened? (Steps to reproduce your issue)
git log --pretty=format:'%h%Cred%+d test' --graph

This also happens with a PAGER=cat environment, just to preclude this is 
related to the pager.

* What did you expect to happen? (Expected behavior)
A graph listing of commit hashes and, if ref names for this commit 
exist, a second line.
This line should be colored in red and contain the ref names as well as 
the string 'test'.
In the case of no refs, the string 'test' should appear in line with the 
commit hash, also in red.

* What happened instead? (Actual behavior)
In case of ref names / a second line, the color is missing completely.
The colors work correctly for the single line case (when no ref names 
are available).

* What's different between what you expected and what actually happened?
The %+d placeholder inserts newlines if the string is non-empty, but in 
doing so, resets any coloring information.
This is demonstrated by the string 'test' which should always show in 
red, but does so only if %+d is not expanded.
This makes it currently impossible to color anything with the %+ 
placeholder.


If this is already tracked, I apologize.
