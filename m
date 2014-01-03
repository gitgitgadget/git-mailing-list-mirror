From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 3/4] completion: fix branch.autosetup(merge|rebase)
Date: Sat,  4 Jan 2014 01:27:01 +0530
Message-ID: <1388779022-14536-4-git-send-email-artagnon@gmail.com>
References: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 20:57:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzArz-0003Ia-Dm
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 20:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbaACT5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 14:57:17 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36752 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbaACT5N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 14:57:13 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so15809418pde.28
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 11:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0tV6jTAtsZV55Tbaed4PdSZ3roxlfmGGEDVD9U9L2bs=;
        b=AD8GwO/pZXfwBef9bJKUw8zpk8e8AvhG07wZJRGU+OZuKlUKANTMpnsg/eRILMpyBU
         ySxj0AuA/6UK+ru4C+sKbSHeiHUY6IVR2zMhjoBuaIri5uIQToQV6RqHWYfUreAGaZcO
         rmvjg8xUxNhw9ZfNHEfYV5Q28qeTwEHVTPdqARJHYc5va5LGdciP5kUPim6zNWobS0yw
         LaQ85H+02TqqYsOMoL/d3KaBHW1yGqyJQbYWwoYvzzbccgK9weKY/dV+i98EtQRZ3rb4
         Ey4ACZxI/wzt3dDgWvyKmCBAxsOudQJDdPs6vLsLK8DDSn6zp62igBucVw/sGYvZmn/M
         sfJg==
X-Received: by 10.66.162.74 with SMTP id xy10mr74118872pab.4.1388779032801;
        Fri, 03 Jan 2014 11:57:12 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id e6sm110782903pbg.4.2014.01.03.11.57.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2014 11:57:12 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239931>

When attempting to complete

  $ git config branch.auto<TAB>

'autosetupmerge' and 'autosetuprebase' don't come up. This is because
"$cur" is matched with "branch.*" and a list of branches are
completed. Add 'autosetupmerge', 'autosetuprebase' to the list of
branches using __gitcomp_nl_append ().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bf358d6..75c7302 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1840,6 +1840,7 @@ _git_config ()
 	branch.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
 		__gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
+		__gitcomp_nl_append $'autosetupmerge\nautosetuprebase\n' "$pfx" "$cur_"
 		return
 		;;
 	guitool.*.*)
-- 
1.8.5.2.227.g53f3478
