From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH] git-completion.bash: replace zsh notation that breaks bash 3.X
Date: Fri, 18 Jan 2013 02:31:05 -0800
Message-ID: <1358505065-16913-1-git-send-email-drafnel@gmail.com>
Cc: felipe.contreras@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 18 11:31:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw9EX-0006Cx-DV
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 11:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116Ab3ARKbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 05:31:16 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:46160 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab3ARKbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 05:31:15 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so2044099pad.4
        for <git@vger.kernel.org>; Fri, 18 Jan 2013 02:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ruzQe7JHZWrpwxjraxfbz1AFJouHf63YZ1+R+j+sGEc=;
        b=CTWU1hEe9JYj+qA415L6plm9VJGldin/9no6NM/Kmyulju+AzulhUpSMxl0Uih0UEr
         m3oxxs7VXuHkU620qniwErwI8IDFlxprwrRfOmDllqQ6505FWWE+yjhoJDYINAOda/hR
         Ci4bEYKsHuOunI9X7VfPTn4JNWXC/dwZ2zKyHDWf5ioG5K4VDNghuIjSssqm8/4v7MY7
         n4bSiE3OBwwyb9jP2ZAf9lucJQbeXX7fbkSJpB1/s+PhJnQ+a5r0paK5UKSVZ5CZkEJh
         65IAaOEki/xC42VpAhMBncBEV12qfBvFlBR2nKOtHI7QwtXzn9vIJLEXYmpFx/tRXaG5
         yhIw==
X-Received: by 10.68.223.131 with SMTP id qu3mr3717147pbc.89.1358505075129;
        Fri, 18 Jan 2013 02:31:15 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id sg7sm2874808pbb.3.2013.01.18.02.31.13
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jan 2013 02:31:14 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213909>

When commit d8b45314 began separating the zsh completion from the bash
completion, it introduced a zsh completion "bridge" section into the bash
completion script for zsh users to use until they migrated to the zsh
script.  The zsh '+=()' append-to-array notation prevents bash 3.00.15 on
CentOS 4.x from loading the completion script and breaks test 9902.  We can
easily work around this by using standard Bash array notation.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a4c48e1..c14e329 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2431,7 +2431,7 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 				--*=*|*.) ;;
 				*) c="$c " ;;
 				esac
-				array+=("$c")
+				array[$(($#array+1))]="$c"
 			done
 			compset -P '*[=:]'
 			compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-- 
1.8.1.1.252.gdb33759
