Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8071F404
	for <e@80x24.org>; Fri, 29 Dec 2017 20:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdL2UDj (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 15:03:39 -0500
Received: from river.fysh.org ([87.98.248.19]:54471 "EHLO river.fysh.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751304AbdL2UDi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 15:03:38 -0500
X-Greylist: delayed 982 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2017 15:03:38 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fysh.org; s=20170316;
        h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=B1xqt2h7nRwmgyBVDt+fLW7CcIwSDfZTa0J2HFKyt3E=;
        b=lm5yJh3w6abL1uCeSLH4ZhJyAbRJs3dx03jul8jWIUr08iAeupfwZH2A17UbwI1HA9l8rntVSWwBUdM1riqTp1kU5Q7HyazVuOCqX0dNJ8PYIS071IsgKIExLO2VYb/PiODo4yKUAx/umQR0Iof0VSGjqAaRyORfMortWW7JqPA=;
Received: from zefram by river.fysh.org with local (Exim 4.84_2 #1 (Debian))
        id 1eV0ca-0004Sw-7K; Fri, 29 Dec 2017 19:47:12 +0000
Date:   Fri, 29 Dec 2017 19:47:12 +0000
From:   Zefram <zefram@fysh.org>
To:     git@vger.kernel.org
Subject: [BUG] git bisect colour output contrary to configuration
Message-ID: <20171229194712.GA15930@fysh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My ~/.gitconfig sets color.ui=never, which should prevent attempts
at colouring output from all git commands.  I do not have any git
configuration enabling colour in any situation (such as for specific
commands).  But when a git bisect completes, the output identifying
the first bad commit includes escape sequences to colour the "commit
3e6..." line yellow.  Excerpt of strace output (with many irrelevant
lines omitted):

23851 write(1, "3e6fc602e433dbd76941ac0ef7a438a77fbe9a05 is the first bad commit\n", 65) = 65
23851 open("/home/zefram/.gitconfig", O_RDONLY) = 3
23851 read(3, "[user]\n\tname = Zefram\n\temail = zefram@fysh.org\n\tsigningkey = 0x8E1E1EC1\n\n[color]\n\tui = never\n", 4096) = 93
23851 write(1, "\33[33mcommit 3e6fc602e433dbd76941ac0ef7a438a77fbe9a05\33[m\n", 56) = 56

Given the configuration, that line should be free of escape sequences.

I'm mainly using git 2.1.4 via Debian, but I've also
reproduced this problem with the latest from git.git (commit
1eaabe34fc6f486367a176207420378f587d3b48, tagged v2.16.0-rc0).

-zefram
