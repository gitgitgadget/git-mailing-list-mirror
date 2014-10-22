From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] Documentation/technical: signature formats
Date: Wed, 22 Oct 2014 17:16:53 +0200
Message-ID: <13b090185cb5a36cddf8c1ba4fcd6fe52e109084.1413990838.git.git@drmicha.warpmail.net>
References: <cover.1413990838.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 17:17:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgxeu-0006u3-CE
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 17:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbaJVPQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 11:16:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34154 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752535AbaJVPQ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2014 11:16:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by gateway2.nyi.internal (Postfix) with ESMTP id 2601C209B4
	for <git@vger.kernel.org>; Wed, 22 Oct 2014 11:16:57 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 22 Oct 2014 11:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=C9uYyfKF2KRO1h
	ZYPWEX2IA+HpM=; b=lF1WkAM3pErRmQnbM5qJxi4FiUmtv3NasaOWfhfzP+B0lw
	c5kQ/Ocuoz4/X3n4xqQCLv8bT0uaYcfZhz8PoWKJ4EpD/UN7XwRK0xkpoRjeNoC1
	8AHUqmdMYurrSiH4546uPu2pdUSPyBHVP7nWIq5cWwAw3Ky6CoS9XHHoNd2fc=
X-Sasl-enc: JRXbPbLtId6yiFZzBjuPnJkVaHHZbFjMl6MrYjXGd5cR 1413991016
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BCB0AC00014;
	Wed, 22 Oct 2014 11:16:56 -0400 (EDT)
X-Mailer: git-send-email 2.1.2.756.gfa53a0a
In-Reply-To: <cover.1413990838.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various formats for storing signatures have accumulated by now.
Document them to keep track (and maybe avoid yet another one).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/Makefile                       |   1 +
 Documentation/technical/signature-format.txt | 126 +++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 Documentation/technical/signature-format.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cea0e7a..2638c0c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -74,6 +74,7 @@ TECH_DOCS += technical/protocol-common
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
+TECH_DOCS += technical/signature-format
 TECH_DOCS += technical/trivial-merge
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
new file mode 100644
index 0000000..80f0a47
--- /dev/null
+++ b/Documentation/technical/signature-format.txt
@@ -0,0 +1,126 @@
+Git signature format
+====================
+
+== Overview
+
+Git uses cryptographic signatures in various places, currently
+objects (tags, commits, mergetags) and transactions (pushes).
+In every case, the command which is about to create an object or
+transaction determines a payload from that, calls gpg to obtain
+a detached signature for the payload and embeds the signature
+into the object or transaction.
+
+Signatures always begin with `-----BEGIN PGP SIGNATURE-----`
+and end with `-----END PGP SIGNATURE-----`.
+
+== Tag signatures
+
+- created by: `git tag -s`
+- payload: annotated tag object
+- embedding: append the signature to the tag object
+- example: tag `stag` with tag message `tagmess`
+
+----
+object 8cbad082a020b7d4ef729b14e1a654c4f60791c6
+type commit
+tag stag
+tagger Michael J Gruber <git@drmicha.warpmail.net> 1351067460 +0200
+
+tagmess
+-----BEGIN PGP SIGNATURE-----
+Version: GnuPG v1.4.12 (GNU/Linux)
+
+iQIcBAABCgAGBQJQh6dPAAoJELR76rQkz552ZBEP/3vkpftZnhsUkGhqXXptnRhz
+5A3n+BqFTsh4d4C15lcRcevwTyyQF61vrFKFRE7Cl5XVqVHowW0al+Dx7j5p35Mz
+PqBZUbEkBFc9xY8WasQYbJl5yDboc8Ora71SEJ1k59duETXmZ67ISpEe6HF3d2xK
+3BGfqaBMwU+Aql0pDMtysoOgEgs7d/Vin9gIXJcqAvw71bpNyZvFUln3do2eLC/v
+VW0bVvAN3B66fLx3li8hEZ4wfrg0Uui5zSN95+uc2DUGW03BNR/sKhYXstHAoqef
+4WIAD70e+9vArh8WqPTIUWl0w+1ixgVvGckHXHW10MdwkoVtwo4tawRxngLBKuI9
+pUu7dc/TIVl15z/y1EmQ25rB4WV9M9W+uRauUi/T3c0hfSuZkB6B1tCu3QStPbWz
+AK3O6Neoni2NgMDLmrWzgDZA3Z/+h9RBV/kNda0RpbWZYJOJILBR+Q8+BZOwDZX/
+hu/tITC7IHVJgMXYGlEFybEn/clbtLsZr8zLlSZyropl0mvUBLeBCrjYBQuDN86g
+yew/Tzs9T5MEFagUkbRERz5rP5OIE9XpXcHMsZve7cCL3YQy0LOkZk3RZKUsbv8g
+MVU1px5/ImBkr0MU0XZxstsAV0YPiON3+qMOnrdGuFx11YQi6cmIA2eww2KPqzHY
+YKirAGNintaD8yXAlwLd
+=wF8p
+-----END PGP SIGNATURE-----
+----
+
+== Commit signature
+
+- created by: `git commit -s`
+- payload: commit object
+- embedding: header entry `gpgsig`
+  (content is preceded by a space)
+- example: commit with commit message `sigtest`
+
+----
+tree 14461762125c079e55a9684ae3a96e27de5b3f2f
+parent da19995926ec89e48297a3163b0f5190af3a8650
+author Michael J Gruber <git@drmicha.warpmail.net> 1325088101 +0100
+committer Michael J Gruber <git@drmicha.warpmail.net> 1325088101 +0100
+gpgsig -----BEGIN PGP SIGNATURE-----
+ Version: GnuPG v1.4.11 (GNU/Linux)
+ 
+ iQIcBAABCgAGBQJO+z1lAAoJELR76rQkz552xOoQAJgV6sstR8cge760X7awb00V
+ svN+pcc1TtJZecYWakCIe6dGPAK2Yk1AwExV0tbAQskPxYIqwnuysXHvVlmyJh5P
+ 1N033YSRc8j59YNQNaLIAh6+c59cKcZdWQyrA1HFVWGqoafCD2+nMglb/JbN9jqQ
+ 5gsxfFGoE0blT+BnMrchzPL4kjMJQBszV5ccATu3iIgSv23p5rA4tm3/P44enIsH
+ U9nYODlKmzsAulThQoSd4Qk0MNIg86MjIXanPkj4S+TLLgDa6Zf8W3m28IiRwPF1
+ WemWpQ9VwSSHKuGVyHGG2OErtDDftILcYtjW5c/UnLw38hWPwc+KxVmAdEBY3vgk
+ OACDEDLqAWgc4rLdWgkoxieIi0aKN+iN4kogbEtSl4VzgvX0iGLZP8cyJnGxHria
+ Qz2UcesNqVPPqOxsIJKpr3CByrh2WDzH8W3tvGuy5q8EsTx5uF1HGoYb3PIx76QG
+ 3ClhL5Wtjk3/iQnycWo60eKMJccLbv+uoXzUP3LA0prt0K3a+52pWVppt8RW1L6u
+ kALJjsc44gr04v/fo5x6zkgFFt+8e/YWDZO+vwCJDmCyqggEvA5dj6i0y2B+hZjL
+ RVG0RATLroPgMa6oHSEVEbP+Ui4JZ3k3fRLIOupb0qjHtv/cvB7kcXevpdQUFGs0
+ 6kmaMJBcWutA6HrosuP/
+ =9PhX
+ -----END PGP SIGNATURE-----
+
+sigtest
+----
+
+== Mergetag signature
+
+- created by: `git merge` on signed tag
+- payload/embedding: the whole signed tag object is embedded into
+  the (merge) commit object of header entry `mergetag`
+- example: merge of the signed tag `stag` as above
+
+----
+tree ceb2177fea91ec9369e012dbe794419ee0731ce7
+parent 9c20ba82367dab0fe4789e2be400a7fb0c447c34
+parent 8cbad082a020b7d4ef729b14e1a654c4f60791c6
+author Michael J Gruber <git@drmicha.warpmail.net> 1412951117 +0200
+committer Michael J Gruber <git@drmicha.warpmail.net> 1412951117 +0200
+mergetag object 8cbad082a020b7d4ef729b14e1a654c4f60791c6
+ type commit
+ tag stag
+ tagger Michael J Gruber <git@drmicha.warpmail.net> 1351067460 +0200
+ 
+ tagmess
+ -----BEGIN PGP SIGNATURE-----
+ Version: GnuPG v1.4.12 (GNU/Linux)
+ 
+ iQIcBAABCgAGBQJQh6dPAAoJELR76rQkz552ZBEP/3vkpftZnhsUkGhqXXptnRhz
+ 5A3n+BqFTsh4d4C15lcRcevwTyyQF61vrFKFRE7Cl5XVqVHowW0al+Dx7j5p35Mz
+ PqBZUbEkBFc9xY8WasQYbJl5yDboc8Ora71SEJ1k59duETXmZ67ISpEe6HF3d2xK
+ 3BGfqaBMwU+Aql0pDMtysoOgEgs7d/Vin9gIXJcqAvw71bpNyZvFUln3do2eLC/v
+ VW0bVvAN3B66fLx3li8hEZ4wfrg0Uui5zSN95+uc2DUGW03BNR/sKhYXstHAoqef
+ 4WIAD70e+9vArh8WqPTIUWl0w+1ixgVvGckHXHW10MdwkoVtwo4tawRxngLBKuI9
+ pUu7dc/TIVl15z/y1EmQ25rB4WV9M9W+uRauUi/T3c0hfSuZkB6B1tCu3QStPbWz
+ AK3O6Neoni2NgMDLmrWzgDZA3Z/+h9RBV/kNda0RpbWZYJOJILBR+Q8+BZOwDZX/
+ hu/tITC7IHVJgMXYGlEFybEn/clbtLsZr8zLlSZyropl0mvUBLeBCrjYBQuDN86g
+ yew/Tzs9T5MEFagUkbRERz5rP5OIE9XpXcHMsZve7cCL3YQy0LOkZk3RZKUsbv8g
+ MVU1px5/ImBkr0MU0XZxstsAV0YPiON3+qMOnrdGuFx11YQi6cmIA2eww2KPqzHY
+ YKirAGNintaD8yXAlwLd
+ =wF8p
+ -----END PGP SIGNATURE-----
+
+Merge tag 'stag' into HEAD
+
+tagmess
+
+Conflicts:
+	...
+----
-- 
2.1.2.756.gfa53a0a
