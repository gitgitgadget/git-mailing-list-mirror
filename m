Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6E020A17
	for <e@80x24.org>; Mon, 16 Jan 2017 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbdAPWlx (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 17:41:53 -0500
Received: from p3plsmtpa12-05.prod.phx3.secureserver.net ([68.178.252.234]:33176
        "EHLO p3plsmtpa12-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750877AbdAPWlw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Jan 2017 17:41:52 -0500
Received: from jessie.local ([82.181.81.240])
        by :SMTPAUTH: with SMTP
        id TFwqcDCYF7CSITFwwcq1rr; Mon, 16 Jan 2017 15:40:27 -0700
Date:   Tue, 17 Jan 2017 00:40:22 +0200
From:   Max Kirillov <max@max630.net>
To:     Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [BUG/RFC] Git Gui: GIT_DIR leaks to spawned Git Bash
Message-ID: <20170116224022.GA8539@jessie.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfJrItZxeZrAy59XeeBVIy5S6Aot0G5H4nqPpcgpdACac4+p+tzgPosnmNpOY2es4/tqCzilDjvAesPecokV3l44Tyy+8vjxSIXGfOpL49Io/rQ1tOLQk
 aZiM/+Fi80CR+sMMJ+maj8+WcjciFmUUvDxzF5e2hs0fG5unnXksfhMVBuZF1H4Nwo9gLq/cfZnAraOwkCBgZY+nSPo+rXZI8KJlbm8x2H7LF3035z9v7ykV
 bjKHgqFlgi1ElSEmqcVCtQc6SgTcQrmL2aif145NQgw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

Apparently various GIT_* environment variables (most
interesting is GIT_DIR but AFAIR there were more) leak to
shell session launched from Git Gui's "Git Bash" menu item.
Which can cause unexpected results if user navigates in that
shell to some other repository (in can also include starting
another terminal window etc. to make user forget original
context) and tries to do something there.

I think is would be appropriate to clean up the environment
while starting any program from git gui. It may have
downside that the environment could be set intentionally,
and now is's removed, but (1) there seems to be no way to
distinguish intentionally vs automatically set GIT_DIR, and
(2) the spawned program may be intended to be used
independly even if the environment was set intentionally for
git gui.

But I would like to note that I find it wrong for the "git"
dispatcher to set up any enrironment to the spawned
command-specific executable. Because it mixes the concerns
of that variables - are they user-settable variables to
tweak the git's behavior, or internal ones to transport the
discovered paths and other info to scripts which cannot do
the standard discovery? Not clear. There has been bugs
related to that already, for example [1].

[1] https://public-inbox.org/git/1409784120-2228-1-git-send-email-max@max630.net/

-- 
Max
