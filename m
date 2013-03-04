From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule update: when using recursion, show full path
Date: Mon, 04 Mar 2013 01:06:08 +0100
Message-ID: <5133E570.7030507@web.de>
References: <5127C45C.2020204@web.de> <1362253499-48847-1-git-send-email-github.com@phor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Stefan Zager <szager@google.com>,
	William Entriken <github.com@phor.net>,
	Junio C Hamano <gitster@pobox.com>
To: William Entriken <fulldecent@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 01:06:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIvV-0007Wu-7q
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 01:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab3CDAGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 19:06:20 -0500
Received: from mout.web.de ([212.227.17.11]:52273 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab3CDAGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 19:06:19 -0500
Received: from [192.168.178.41] ([79.193.83.157]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0McWXI-1UTplj270q-00HuM5; Mon, 04 Mar 2013 01:06:12
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <1362253499-48847-1-git-send-email-github.com@phor.net>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:TUTizOzAhMqlf1zOLWY4YzZ87jMh9eRmndh6zRtf3KP
 AKJGODO+WwfeHauiVotquf7Tu9DCaipIynP5M9a4O46yw+BxKd
 AOYWdFqM1tHoyqDv3Jqi+1LjA0zx8hkAR2zRhauW+vmwzWNRLm
 uOvb5lyfQRf/v9uvVBEqWn8kPsMEXIfi7ZNAePZWNayH0TgQOv
 iVALEaNb7qIlYARrWgOow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217383>

Am 02.03.2013 20:44, schrieb William Entriken:
> Previously when using update with recursion, only the path for the
> inner-most module was printed. Now the path is printed relative to
> the directory the command was started from. This now matches the
> behavior of submodule foreach.
> 
> Signed-off-by: William Entriken <github.com@phor.net>

Thanks, this patch cleanly applies against maint and addresses all
issues from the previous rounds.

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

Junio, could you please squash in this additional test?

--------8<-------
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index feaec6c..70528b7 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -612,7 +612,8 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	rm -rf super_update_r2 &&
 	git clone super_update_r super_update_r2 &&
 	(cd super_update_r2 &&
-	 git submodule update --init --recursive &&
+	 git submodule update --init --recursive >actual &&
+	 test_i18ngrep "Submodule path .submodule/subsubmodule.: checked out" actual &&
 	 (cd submodule/subsubmodule &&
 	  git log > ../../expected
 	 ) &&
