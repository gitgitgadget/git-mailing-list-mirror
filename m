Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB4C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 17:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73174610CC
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 17:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhJMRPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:15:18 -0400
Received: from devianza.investici.org ([198.167.222.108]:56405 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJMRPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 13:15:15 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2021 13:15:14 EDT
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4HTzS76wsRz6vJ8
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
        s=stigmate; t=1634144727;
        bh=GiYXh2O7sBOIcyT1s5+hPY4fuHCPXzqB93x77HFVbFU=;
        h=From:To:Subject:Date:From;
        b=q7iP1xo+8sz1g1kMZJwdIZZhFvDCU4Zc2WDinKBTguggqlI0xeYntz+47Em0y+rxD
         9dnSNYlutfqYkVYY6PqDkU0t1LzOH/FlNWtU69VtxzjCzbGWhUa0ejQhk5HTasibVw
         yW7qYgqR6tPPvCFn4hYTSzqAUFViL0Hw26ItQDck=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: andrea.monaco@autistici.org) by localhost (Postfix) with ESMTPSA id 4HTzS75QbFz6vJ0
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:05:27 +0000 (UTC)
From:   Andrea Monaco <andrea.monaco@autistici.org>
To:     git@vger.kernel.org
Subject: Possibly wrong assignment in config.c
Date:   Wed, 13 Oct 2021 19:05:26 +0200
Message-ID: <87pms8rh2h.fsf@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello,


while building git I get the following warning:


config.c: In function 'git_config_copy_or_rename_section_in_file':
config.c:3358:17: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
 3358 |       output[0] = '\t';
      |       ~~~~~~~~~~^~~~~~
config.c:3264:7: note: at offset -1 to object 'buf' with size 1024 declared here
 3264 |  char buf[1024];
      |       ^~~


concerning these lines:

  output -= 1;
  output[0] = '\t';


Perhaps it has some merit.  output is previously equal to an array
buf[1024], so the assignment apparently goes outside allocated memory.



Let me know,

Andrea Monaco
