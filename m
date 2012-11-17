From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 4/5] completion: get rid of compgen
Date: Sat, 17 Nov 2012 02:38:17 +0100
Message-ID: <1353116298-11798-5-git-send-email-felipe.contreras@gmail.com>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 02:39:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZXNC-0004aQ-KT
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 02:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959Ab2KQBiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 20:38:50 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39206 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab2KQBit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 20:38:49 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1411525bkw.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 17:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OA/yNYvvO4nqUYe1kw218tQawbr/AewHFncRdzXonBU=;
        b=ol4faFwyv0XtWWUIyHGtu1khk5E/EsxTetbf2p3W4RUKUGZMgAm31wtHG75wvb4AJ+
         pSSwBv9AHvED569WwT1OhBdh71zyq6A+1N29egZy/f87Ica+LYQkfKXp2sF6tvhc73K2
         Z2CylUlrznMWPiTKveuh0ZJYRa3zyT7oyORjSbml8WVgoMQcozr9Hu6apedKVlh+VC0h
         QVyjJgD/q3X+870rjlabZ+4tpxYYy+yOFDi+nzXOIX4o0LP/hX/uVDwMdgFeNdOSOZa7
         9y4O+EOx5OMeeqidN92JMZ7/oAcdYl+is1Rowfe1n0NSiGGcneU3aRgjajGokpdaM8gg
         +NhQ==
Received: by 10.204.8.215 with SMTP id i23mr2654746bki.44.1353116328999;
        Fri, 16 Nov 2012 17:38:48 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id fm5sm2003021bkc.5.2012.11.16.17.38.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Nov 2012 17:38:48 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209929>

The functionality we use is very simple, plus, this fixes a known
breakage 'complete tree filename with metacharacters'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 975ae13..ad3e1fe 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -227,7 +227,11 @@ fi
 
 __gitcompadd ()
 {
-	COMPREPLY=($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
+	for x in $1; do
+		if [[ "$x" = "$3"* ]]; then
+			COMPREPLY+=("$2$x$4")
+		fi
+	done
 }
 
 # Generates completion reply with compgen, appending a space to possible
-- 
1.8.0
