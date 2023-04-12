Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A2DC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 13:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDLNmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 09:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDLNms (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 09:42:48 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6440C7A9C
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1681306949; i=markus.heidelberg@web.de;
        bh=8JJA/TAdL1tkeQ/SeTHYu0nU2sYC6tbicEcwjQbz/Ok=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=T41LgYgI0OLoAr4nOybkGbBtCabLzWQPI66K3l9faReA/Im3fa/6ar9+bLMcfFZ/M
         tYHf+giyp+muZzpkBiXb1fDRSTYCmUElO9gYqtJ23/vN8qfuMqRyA5ytlYcwYqoadI
         tq6DsF5TyNMgcLtshb7lhs1SsHzvGrZ8sb+3ZmoTSsOsX2NsDCJrseR8dgZ/ZhqpJM
         anMYEbHtxR9Xv3Bt6hcA2RUExCQX7vt/BLuNjmTcTTKT0uDFo0UrsgFjxlfi+E8iZC
         FVavwgnFi65QrJDNcOo5DD9s2dk0FECU+TDPrvQhsIUCE+0q1qX7FfrLP805fU/AP/
         sgKINvUfqGmSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([46.223.163.182]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Mx0Ix-1qapzD3gLr-00y1Bn; Wed, 12 Apr 2023 15:42:28 +0200
From:   Markus Heidelberg <markus.heidelberg@web.de>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Markus Heidelberg <markus.heidelberg@web.de>
Subject: [filter-repo PATCH] convert-svnexternals: fix parsing of wrongly transformed SVN revisions
Date:   Wed, 12 Apr 2023 15:41:19 +0200
Message-Id: <20230412134119.28257-1-markus.heidelberg@web.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lmNLgEA05O+MddBob9Rt+WHoCB3kgOdI0EtXUheAU8082vBPTvw
 QlCvUgF6T3zgxQ0zYW4LmI8je0bIO7D60I/xUfnfx5Z4lx0jW5iM0hJGlltwz+/E2GfkJHJ
 Ie5/VID/726ei1IYbnJsvF9Jov4zxA7gIpKId8lIoJASoWnZNIwLugQKeN103pYqKNxj9jc
 EhYfmG+LwreHliqwrymow==
UI-OutboundReport: notjunk:1;M01:P0:oOoHJLS/D20=;gvdA4uLpR/WqOEqwIYWqKcaqD3c
 vrI7hDqdqXK/wcI4jhLqiKjWfQubTUTX4Y537phS/ncR37xwtJ7L9I5xUFuwOqAdNW6ot71aC
 f8t9RC3IGG6su8q3c4+pieg8yyiaaM7P6JohnBH7/m2xSeoQgsx710Z1h+aujZ+V6pA5pFtSW
 yXsE4wWyNdmfcyqd5lhSxdv/FCuZabzongV//0AIJz7G2dbkhSw96l3PkVGCuGe7GEQeqqNRZ
 ex9+bEdcS+NxiuGoxdCL3EL6VNkDSKfsYDFAVQOjSC8E9+xNYB/aoMyIv/tZViF4Pycu7NlTs
 0iwqmMHixUZIhHf/OKJTE1h5ABdkXJfh+wMRY8qHGcFEM5F8mpp0LlwyBXxJlnQA4DF2sMsVg
 77PUxE2EXYZ+m9V/jFRTwSeIASRHGckoBEZkZX0SGgIRoBmUhDgIkCe11V7LQ2GwDw9x1vxJ9
 XjZ1tFIq28N8T5af5sBOdbF0JRfNYWdaurQjMRQknWNS4ptxDIlhwvxGy1ADZU+2awD0Wb8Y8
 i7LxKSNo8pQqbODStyNRBUxcVs1Xiu34jRP215OtYRGzLcRmuV/vf0alPxhO1T5N0s6D4Bm2g
 PWodyxsRzGGcOdYc5O4AdpPiVQ7GwfskkTme1haXiIDFceEQShdY5vs9DoryXFeAuLjjKkrP+
 XpHtq9aXYXlIwedZcMjOhvoEPWsTR0dLeiRcTj6hh/u9Wycl2FrsVCh/BfFK+fgyCz9cCXFgs
 ZtilHwOiXzEK01buDvUnITwfzpLS7jVPcP4Ie5epZ9swneU4VzLKm4tqeSogeuUHd+E4Qeglx
 2cjgBuYGX3kPhj9Ma4xnHe7CJmcfI0FTI1xd27u5OaEfaky6TimBCw3GdghUV3THgayP81w1O
 xwB0/PLVJh7JWeJHRawWwkl9SYkgCAJbG8ZXHTaLrPPseb6Sn+Gp/0KqQqVO85cLf+bRbhJ+j
 4sWjy8t+cO6PCo6ZuSjSDxy1UJY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SVN revision numbers from svn:externals property, which are a multiple
of 1024 (2^10), are transformed by SubGit to contain a binary suffix
("k", "m" and "g" have been checked) in .gitsvnextmodules file.
These aren't valid revision numbers in SVN either.

Examples:
  1024 -> 1k
  2048 -> 2k
  1048576 -> 1m
  1049600 -> 1025k
  1073741824 -> 1g

This led to the following error:
    svn_rev =3D int(parsed_config[section]['revision'])
ValueError: invalid literal for int() with base 10: '1k'

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
=2D--
 contrib/filter-repo-demos/convert-svnexternals | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/contrib/filter-repo-demos/convert-svnexternals b/contrib/filt=
er-repo-demos/convert-svnexternals
index 0c81507..39ff288 100644
=2D-- a/contrib/filter-repo-demos/convert-svnexternals
+++ b/contrib/filter-repo-demos/convert-svnexternals
@@ -254,6 +254,21 @@ def get_absolute_svn_url(svnext_url, svn_root_url):

   return True, svnext_url

+def parse_revision_value(value):
+  """
+  Parse the value of key 'revision' from a .gitsvnextmodules file and ret=
urn it
+  as integer.
+
+  Used to handle non-numeric values like 1k, 2k, 3k etc. added by SubGit
+  instead of 1024, 2048, 3072 etc., likewise 1m, 2m, ..., 1g, ...
+  """
+  suffix =3D value[-1]
+  if suffix in "kmg":
+    mult =3D {"k": 1024, "m": 1024**2, "g": 1024**3}
+    return int(value[0:-1]) * mult[suffix]
+  else:
+    return int(value)
+
 def add_submodule_tree_entry(commit, parsed_config, section):
   """
   Add a submodule entry to the tree of a Git commit.
@@ -271,7 +286,7 @@ def add_submodule_tree_entry(commit, parsed_config, se=
ction):

   # Get SVN revision
   if parsed_config.has_option(section, 'revision'):
-    svn_rev =3D int(parsed_config[section]['revision'])
+    svn_rev =3D parse_revision_value(parsed_config[section]['revision'])
   else:
     # TODO: revision has to be guessed according to commit timestamp, ski=
p for now
     return False
=2D-
2.40.0

