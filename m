Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA9C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E6660F22
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbhJGUdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:33:47 -0400
Received: from mout.web.de ([212.227.15.3]:53035 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242542AbhJGUdo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633638704;
        bh=Dakxct9u6oZluwVSzgunqgIzxAG9Bv7dPg7f31p+L0s=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=ZfMME7WUSdEPUh2GWqJ3doOz+oxTbNAaE6xnrNmCfJLCF4FMo82lIsb3MC2522SEk
         FW2HA9ExSFv2STeDLnovR94fZLxUFaEO8KVbuUbX4xVBXnq++WQ10/cgaXcsjdZIVG
         Omn7xkVMv8cAXyxSvP0gYrL1jvPM5MkhxskO36OM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MSs2H-1mONK12v6T-00Rrm0; Thu, 07 Oct 2021 22:31:44 +0200
Subject: [PATCH 2/3] read-cache: add verify_path_internal()
To:     git@vger.kernel.org
References: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Robert Leftwich <robert@gitpod.io>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a3629513-3851-8474-aa07-d7fafc85c21d@web.de>
Date:   Thu, 7 Oct 2021 22:31:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l5ggE6e1eN/2HSe7VtGEtjR/8aDzDXPwU2TTd7wPESMRceJiC7y
 jBXo+ZpAUo5QOwuqCsVk6U67NnJ52JnxErfy8/TdYju2DtQxaxnns78MPZEaZi+JPndgJVX
 rqHEhCXakFvGkB2fI81YNJv2h/D2OAF/V1e5TsaRJpTJjb8OLc9DuJYciVpXZcfGFL8Tq42
 Yk8UDN6NCdCHPS2DXQm1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5k7ROhbIE1o=:iBIoo7UmHjBzGCQsY+nCCU
 bpre0pj7tCfI+Bzgn58pZB7BYVFN/lQj4zp+a2MRwkMwDFtC+nts2S2rZqvVRU7iNCFeu+bvm
 hA8P9RzERmIk2O7ztkxT1hdtn2egdCJZTPliVmHsAVvvfctMoSGO0jWLH/lmPW9ljxaIdwDoV
 OEGFDpW6Fruj+mIFVvZN6/VG+SX9SKUe6wUsZ9BkCaXEdORa/pOde8yNc8qK/BOeOrUoajaLy
 olwZ8oqHokyiPMgsIlBZoTifvtXwXNANWmRZvgXHJ4Jydw5159EJaiN3qoQN6onOfEQP/k8/B
 G+lMJKc7pLTOEfYqjSgdKuxu/jrw/Z1wpkTnzK/iVUDSiVLXZG43Ef8ZUvPpgQWsDI53ljx1A
 AaAeWBP/7LRWINbinALyD087MkLXcx9mBYKUvizUzArcPgJfzdK2rVr6vjJeyV603d58sI0w0
 9/j+a0D7Y7Yz98FyAb9slIipWh4XXymthgK7c9/fZfYBmJkeLR0pAagppbO0TNwzPFMpHOvIG
 w51413D2mq9gQzMByRQqrgY5NUeBv42Tjrv+W1WODT3k+5mqP7+wgMfuxeLKfveD3/lgX0Dut
 w3pizCVCEMnRsD7vAbdqMa0UKBSbo1bWUErGR99Dd3ndwxDWDEgOMYqVXPSioSABTv4EByq2V
 rDpoN/yPyqWzsyx/W67qhTWRwSqPEVjlPN9Ldwc1BAAsGlcz/9AzF8NnwlaT4f4DwrJH4xqlm
 ro8LQ5DNFQeBurM99kf5vFOtVZ3aBz7kZK42R6AqtC4V7Syjj8Tl+kjhdGHqNiGk8D3ye5dQk
 nCJerlpILE1nwUe1Fgm/zKyiUL51i/lckcx9HFWaWBmOcKDars8SQpNO73LrEqYb+JFjgVRti
 4gYQFSuw5ZbIkskzAOC80Qmm+lUl2cj16tGhjOcK+0tsJc4OiMz61tn5qs3xX6asnz/4k0k17
 cTH5t/I5VJ0sL9tA/duKAFeJPdUzCwc+1qQmQIZ+saaNB97aoypv3+iC/Ef4esHu6kgDe5v1x
 Rh/8BxVJ/cjRKSvhajIgSDkQn1PGo3bP5g3esJTWj+EOcCWLJur8ukVA2QWw8AqN31y/JF/Ut
 9REuuzY7U/PqwU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn verify_path() into an internal function that distinguishes between
valid paths and those with trailing directory separators and rename it
to verify_path_internal().  Provide a wrapper with the old behavior
under the old name.  No functional change intended.  The new function
will be used in the next patch.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 read-cache.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index b0a06db5c5..5b6fc08e46 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -849,6 +849,19 @@ struct cache_entry *make_empty_transient_cache_entry(=
size_t len,
 	return xcalloc(1, cache_entry_size(len));
 }

+enum verify_path_result {
+	PATH_OK,
+	PATH_INVALID,
+	PATH_DIR_WITH_SEP,
+};
+
+static enum verify_path_result verify_path_internal(const char *, unsigne=
d);
+
+int verify_path(const char *path, unsigned mode)
+{
+	return verify_path_internal(path, mode) !=3D PATH_INVALID;
+}
+
 struct cache_entry *make_cache_entry(struct index_state *istate,
 				     unsigned int mode,
 				     const struct object_id *oid,
@@ -993,60 +1006,62 @@ static int verify_dotfile(const char *rest, unsigne=
d mode)
 	return 1;
 }

-int verify_path(const char *path, unsigned mode)
+static enum verify_path_result verify_path_internal(const char *path,
+						    unsigned mode)
 {
 	char c =3D 0;

 	if (has_dos_drive_prefix(path))
-		return 0;
+		return PATH_INVALID;

 	if (!is_valid_path(path))
-		return 0;
+		return PATH_INVALID;

 	goto inside;
 	for (;;) {
 		if (!c)
-			return 1;
+			return PATH_OK;
 		if (is_dir_sep(c)) {
 inside:
 			if (protect_hfs) {

 				if (is_hfs_dotgit(path))
-					return 0;
+					return PATH_INVALID;
 				if (S_ISLNK(mode)) {
 					if (is_hfs_dotgitmodules(path))
-						return 0;
+						return PATH_INVALID;
 				}
 			}
 			if (protect_ntfs) {
 #if defined GIT_WINDOWS_NATIVE || defined __CYGWIN__
 				if (c =3D=3D '\\')
-					return 0;
+					return PATH_INVALID;
 #endif
 				if (is_ntfs_dotgit(path))
-					return 0;
+					return PATH_INVALID;
 				if (S_ISLNK(mode)) {
 					if (is_ntfs_dotgitmodules(path))
-						return 0;
+						return PATH_INVALID;
 				}
 			}

 			c =3D *path++;
 			if ((c =3D=3D '.' && !verify_dotfile(path, mode)) ||
 			    is_dir_sep(c))
-				return 0;
+				return PATH_INVALID;
 			/*
 			 * allow terminating directory separators for
 			 * sparse directory entries.
 			 */
 			if (c =3D=3D '\0')
-				return S_ISDIR(mode);
+				return S_ISDIR(mode) ? PATH_DIR_WITH_SEP :
+						       PATH_INVALID;
 		} else if (c =3D=3D '\\' && protect_ntfs) {
 			if (is_ntfs_dotgit(path))
-				return 0;
+				return PATH_INVALID;
 			if (S_ISLNK(mode)) {
 				if (is_ntfs_dotgitmodules(path))
-					return 0;
+					return PATH_INVALID;
 			}
 		}

=2D-
2.33.0
