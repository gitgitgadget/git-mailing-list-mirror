From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] completion: ignore custom merge strategies when pre-generating
Date: Mon, 26 Oct 2009 13:31:55 -0700
Message-ID: <1256589116-6998-2-git-send-email-bebarino@gmail.com>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:32:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2WEt-0000Dl-1g
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 21:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834AbZJZUcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 16:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbZJZUcF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 16:32:05 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41351 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760AbZJZUcE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 16:32:04 -0400
Received: by mail-fx0-f218.google.com with SMTP id 18so12431506fxm.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=mGSw0JUebdLVGhI4cco+BK5OB9O4bAZlgZSDBFgReS4=;
        b=AWWcUZ1AwTtgWWoMoi44tTg4tqL8tAJ8oO+XzFwC8lxivFbvU1v5lYoX3g68pnDyVf
         wchq//RZ9SyoGPKTSZlctpjowFMrrbSGf54PQK6PcnDRZ+thBWppsHstxb5ZDC5zXNnb
         9aywk9c1XQ/GC35sRsvA9p8IqkXp2hdG3Y1tY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dsRlWGt283lYyn4VeYLfVf5s20RicY761P/bv7v+xRgl8U6T0kSqZCh78nbf3ejuic
         d04FHnpQ93QeVWgHDH5f0C35VI/BuV7CIgv50KydY3VpLymMbzbuXkVxe8/4lj994yyK
         hW9fZ4721yi//2MurNXGNif/+trhTgblYX8wQ=
Received: by 10.204.34.203 with SMTP id m11mr14972546bkd.79.1256589128560;
        Mon, 26 Oct 2009 13:32:08 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id b17sm1062522fka.43.2009.10.26.13.32.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 13:32:07 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 26 Oct 2009 13:32:02 -0700
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256589116-6998-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131267>

Since the Makefile adds the build directory to PATH, we get the merge
strategies twice. Ignore custom merge strategies which are just the
builtin merge strategies (octopus.sh, ours.sh, etc.) anyway.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash.generate |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash.generate b/contrib/completion/git-completion.bash.generate
index 6487fd5..b66254a 100755
--- a/contrib/completion/git-completion.bash.generate
+++ b/contrib/completion/git-completion.bash.generate
@@ -9,6 +9,7 @@ __git_merge_strategies ()
 {
 	git merge -s help 2>&1 |
 	sed -n -e '/[Aa]vailable strategies are: /,/^$/{
+		/^[Aa]vailable custom strategies are: / d
 		s/\.$//
 		s/.*://
 		s/^[ 	]*//
-- 
1.6.5.2.181.gd6f41
