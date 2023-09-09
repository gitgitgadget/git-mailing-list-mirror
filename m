Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2CAEE14AA
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 20:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbjIIU6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 16:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjIIU6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 16:58:05 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Sep 2023 13:57:57 PDT
Received: from mail8.parnet.fi (mail8.parnet.fi [77.234.108.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180E019F
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 13:57:56 -0700 (PDT)
Received: from mail9.parnet.fi (mail9.parnet.fi [77.234.108.21])
        by mail8.parnet.fi  with ESMTP id 389Kgjui020416-389Kgjuj020416;
        Sat, 9 Sep 2023 23:42:46 +0300
Received: from foo.martin.st (host-97-144.parnet.fi [77.234.97.144])
        by mail9.parnet.fi (Postfix) with ESMTPS id 89A45A1450;
        Sat,  9 Sep 2023 23:42:43 +0300 (EEST)
Date:   Sat, 9 Sep 2023 23:42:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
To:     git@vger.kernel.org
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Regression in git diff with stdin, with -R
Message-ID: <d42579a0-f438-9b4c-97e4-58724dbe4a4@martin.st>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-FE-Policy-ID: 3:14:2:SYSTEM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Since 1e3f26542a6ecd3006c2c0d5ccc0bae4a700f7e5, "diff --no-index: support 
reading from named pipes", one usecase about diffing with stdin has 
broken.

I see that this patch was preceded by adding some extra tests around 
diffing with stdin - but one case seem to have been missed.

"git diff --no-index - regularfile" still works fine as it did before, 
also "git diff --no-index regularfile -" also still works. (I.e. stdin can 
either be the first or second file argument - both work.)

However if using the -R option to reverse the diff direction, i.e. "git 
diff --no-index -R - regularfile" or "git diff --no-index -R regularfile 
-", I'm now getting the following error:

     fatal: stat '-': No such file or directory

// Martin

