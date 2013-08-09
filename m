From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] remote-hg: shared repo upgrade fix
Date: Fri,  9 Aug 2013 17:38:02 -0500
Message-ID: <1376087884-32060-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?J=C3=B6rn=20Hees?= <dev@joernhees.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 00:42:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7vNn-0001hk-I9
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 00:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031374Ab3HIWmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 18:42:01 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36627 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031355Ab3HIWmA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 18:42:00 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so6959829obb.18
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ApqEi2C7cN4nxdDkuK/bE3rFnNG2BdtbZwZVqFu7XcQ=;
        b=ejjJc02vKZxvgpfb3bHQ756I2c8clYjYaZgy6DIkQaTY5Z0DCdknPsMBiAwqDbbrNh
         7tSkvNfqcyxqomk/V64iSm4iFbn3N/anj59/wrpXGsUizgodqosUuTW3GERvQUToxVj+
         jnjZCvKAFZEteFKMUMh7nP/0EJOBltWz00oUbGh7/tJBsSXmZMwI1+1HNdWMlS0HWswT
         PDDdkOhgYVQCampoXTxQUAob1Y8Fx8ng0kkqx9dthgoK+AsWPZAD6wXyvM/yCR+B6HaM
         toY5t08k8ORQQgXgFxt+S5P9SANs4SBm3d9JJw+Mg8iX5+51CYz2jtKveUyUATk4De2/
         LJ/g==
X-Received: by 10.182.148.8 with SMTP id to8mr2374604obb.17.1376088118009;
        Fri, 09 Aug 2013 15:41:58 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hm1sm21169030obb.9.2013.08.09.15.41.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 15:41:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.267.gbb4989f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232048>

Hi,

Same as before, except with commit messages updated, and improved the second
patch:

--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -400,8 +400,9 @@ def get_repo(url, alias):
                 local_hg = os.path.join(shared_path, x, 'clone', '.hg')
                 if not os.path.exists(local_hg):
                     continue
-                shutil.copytree(local_hg, hg_path)
-                break
+                if not os.path.exists(hg_path):
+                    shutil.move(local_hg, hg_path)
+                shutil.rmtree(os.path.join(shared_path, x, 'clone'))
 
         # setup shared repo (if not there)
         try:

Felipe Contreras (2):
  remote-hg: ensure shared repo is initialized
  remote-hg: add shared repo upgrade

 contrib/remote-helpers/git-remote-hg | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
1.8.3.267.gbb4989f
