From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] git-checkout.txt: a note about multiple checkout support for submodules
Date: Sat,  3 Jan 2015 16:41:27 +0700
Message-ID: <1420278087-14613-4-git-send-email-pclouds@gmail.com>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 10:42:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7LDp-0001z8-Vn
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 10:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbbACJmF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jan 2015 04:42:05 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34360 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbACJmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2015 04:42:03 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so24936721pdi.31
        for <git@vger.kernel.org>; Sat, 03 Jan 2015 01:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SQWe15qdDYcDc9g4VUKLhCNN2ODfSUZEKDHBS4KnnAI=;
        b=cOo/BrZXCeiqKJ0Y97se/dknkoWgh9DqqyFmv5X/09ksDMvF5OIsHhV6H+9GZmXquo
         Yy3oAp+vxISd258uSPE1ggtqsnKv6Rk0s0PBfEPRv7lkq5XdYs7xAc9tqhS3QtutIfqR
         7Sh/cROrunveWvrE07agNBqGYyx/RyEbIvwwQXyYApDzodu8oWCK07digwAugjeAAGWR
         02u7Vo0w4wHM8O10XkBaXWKosg9QGN93mmWm8UNC6qO6tqWbLNweUyGe5tGIggHBP5SV
         rxgYu8Dkvfm1EXo3IsTHFD2aWEMe5+BgLuNniO2ZsBXYYzNWKhShtQDZjyg98nLnpK0q
         q/cA==
X-Received: by 10.70.91.99 with SMTP id cd3mr127574629pdb.117.1420278122225;
        Sat, 03 Jan 2015 01:42:02 -0800 (PST)
Received: from lanh ([115.73.231.124])
        by mx.google.com with ESMTPSA id u5sm30461439pdh.54.2015.01.03.01.41.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jan 2015 01:42:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 03 Jan 2015 16:42:03 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261993>

The goal seems to be using multiple checkouts to reduce disk space.
But we have not reached an agreement how things should be. There are a
couple options.

 - You may want to keep $SUB repos elsewhere (perhaps in a central
   place) outside $SUPER. This is also true for nested submodules
   where a superproject may be a submodule of another superproject.

 - You may want to keep all $SUB repos in $SUPER/modules (or some
   other place in $SUPER)

 - We could even push it further and merge all $SUB repos into $SUPER
   instead of storing them separately. But that would at least require
   ref namespace enabled.

On top of that, git-submodule.sh expects $GIT_DIR/config to be
per-worktree, at least for the submodule.* part. Here I think we have
two options, either update config.c to also read
$GIT_DIR/config.worktree (which is per worktree) in addition to
$GIT_DIR/config (shared) and store worktree-specific vars in the new
place, or update git-submodule.sh to read/write submodule.* directly
from $GIT_DIR/config.submodule (per worktree).

These take time to address properly. Meanwhile, make a note to the
user that they should not use multiple worktrees in submodule context.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 52eaa48..72def5b 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -463,6 +463,9 @@ to `/path/main/.git/worktrees/test-next` then a fil=
e named
 `test-next` entry from being pruned.  See
 linkgit:gitrepository-layout[5] for details.
=20
+Multiple checkout support for submodules is incomplete. It is NOT
+recommended to make multiple checkouts of a superproject.
+
 EXAMPLES
 --------
=20
--=20
2.2.0.84.ge9c7a8a
