From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] replace --edit: respect core.editor
Date: Wed, 20 Apr 2016 08:38:03 +0200 (CEST)
Message-ID: <a7b889d525f99fecfb9d4a890fd2a5d4bf3001e0.1461134258.git.johannes.schindelin@gmx.de>
References: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 08:38:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aslmF-0007uS-GS
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 08:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbcDTGiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 02:38:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:59765 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092AbcDTGiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 02:38:15 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MFcg9-1avmSO0LK9-00Ec3M; Wed, 20 Apr 2016 08:38:05
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ARIZoIx1YSc1eAvm7Xv66zR4K36hwdfGeA90NK/8QCpBmXqCWqF
 dUF5WTrIk1mHZtNIUeK/bXUVSoZwIGo6yIhihgltccpk0IR/XEHHjO7azX0pzVCi3D8KVKC
 v0WyQb38A6e3wkVVqzGkxNZGvelhTAWOiucW3H9Pis/R1Qsv7Vg8gJkJzsXvukI50I5cdrV
 XmUrcEUK9tsmTxmiWNBlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9xGspzDlqlc=:cWfiel1uBtjjnsI1t2NPiE
 44TSzrykE6YJjeX9KDXk6yI9EsoWOMXe6lHmQ/NwoXWkOfuMQ9QNAYGokruZb8JbAlt6I0a1u
 BoDWuTzAMy4W00AJSiDCq5Fa9J6HX0uCmXsh70c/50PQ54WpWP6Rxx2ktey1fpWF8ubxvdX8S
 2VdT89P7TCBUvBJLMZOus5YIR33zjZbzObUhP5BzPwH1iSRygus6YC38BefFijwtjfSI5PIRZ
 fCXbZ0GRuMGeCrNP+OotOFXKU1XExb8F/89cE46GdHDvhp9w4t1y25mG0gzfCsWDabqTIqh/+
 IrynbmioM81cw8dpKQWxjZ7qmZ1uMjCg6+xFG/wVWFjnwriN5mxffCqRx/3o8rDP0aNlczb57
 RS79WM4eMtOkkSeKUg8RkWouZNiNMFtUqii8CmIwXlwlCNyk3D2cqzGZeB9uYZZd31ONYP352
 riQh6MXJllfFGdHF5HIDamtFZ8Q1EGJzcwe6NF3z61uIgPGj1YLQ8z0Oo+jgj/PJuW7F58uLD
 u9Mhx57xv7Tfq4wkSndhHrzQEoMVXYRCelO5ia9CqvkraqNvo9mv4e9ZS1ZmHBdYyLk5zagYU
 Lwg+a1lxY+pX8x6YvdxVk86bKOztazGsdDRYCKup6+61G1TvdIBPWYIRV4rFaU70ypUgworUW
 4ccoqKSgK672WUzug4WS9XW2UEtt/SYPOu+0A8E+L26mC7NU1LpSUYmL0KtMgpI7i26imKU0q
 ViYhL+kiS8wrASfZCUyyXXJJ2IKyTIKtOEnCHVwxlGQR6EvaGz39C3Y+VhoDXv8nctCtGLZW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291986>

We simply need to read the config, is all.

This fixes https://github.com/git-for-windows/git/issues/733

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c | 1 +
 1 file changed, 1 insertion(+)
Interdiff vs v1:

 diff --git a/builtin/replace.c b/builtin/replace.c
 index 02b13f6..b58c714 100644
 --- a/builtin/replace.c
 +++ b/builtin/replace.c
 @@ -440,6 +440,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
  	};
  
  	check_replace_refs = 0;
 +	git_config(git_default_config, NULL);
  
  	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
  
 @@ -475,7 +476,6 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
  		return replace_object(argv[0], argv[1], force);
  
  	case MODE_EDIT:
 -		git_config(git_default_config, NULL);
  		if (argc != 1)
  			usage_msg_opt("-e needs exactly one argument",
  				      git_replace_usage, options);


diff --git a/builtin/replace.c b/builtin/replace.c
index 748c6ca..b58c714 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -440,6 +440,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	};
 
 	check_replace_refs = 0;
+	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
 
-- 
2.8.1.207.g7b140d3
