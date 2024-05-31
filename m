Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0615B96F
	for <git@vger.kernel.org>; Fri, 31 May 2024 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183937; cv=none; b=VDDUYxEB5sFGuXwxVJzNMVFTllmK7zxl2e42WTq4Xp26JMgkI+UBrsQyJavRbZUEFkDkWnTiOv6nGUIOXkqNpoKzNgHMPZFeLmhHpNQSfDxpviuhmk0ABDDYLudiwWyeGP8+ZieWNfRGd3qD6gPwMmHKMDaP9JeIa4YPrc65GEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183937; c=relaxed/simple;
	bh=33S4NT3JboEbvQAehMPcCfGMBxTWn5I+Pi6ybKm0j8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3Z/00bJWu4ekVQmbS0LoHHhdNj8HQfqp9c/fSEdsEam4pk+P4DOnZf3YzmIVuHDq8rPJq1jS6Vfi5lsliI3Ai20H1gCXC6ffo2CCXqPZcCLrUHmRiQ02rXfgu/vhgU6t3mwM2dX5UnQVr3BCdheFY4ZL0+bfrHoSzCiyv3NF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=J11+DRVC; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="J11+DRVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717183919; x=1717788719; i=tboegi@web.de;
	bh=1Qs+HgmB/FCZyPUV8AiVzcig6cuQ6Un85HkSLzyCF0U=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J11+DRVCTKdazxoHKPStLkrZGegcEVM7zImqCVyAMs76CXdo13snR5cHkcPgfHF8
	 yzDFINAlx4BrahOGpGnaUuowE0xYZudjIBiz/6V692zxmf5fE8WZU39yEcrpMaw4Z
	 zJbrm6hlVkIgjkIdvuGAjHvN7QdrDO0c8mayVBtb0zaTaRZDiSzX1U6LqovEWIKcP
	 cFrrAI8MravyjacN7OfNbLP+nKCIVBngKNk9uRITzS4Ua/Z5e0iLNb9Es3CzoL69Q
	 IVXGQCoxKGwIZl6TYgNHYyiSdADaw0iwED4e3InyBFhWOLdxsQyUtyOyZhZ7g+Gtt
	 Lj+kgy5VluaW4SKKMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([81.231.143.213]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MXGK4-1ryKwb31u2-00KTDn; Fri, 31 May 2024 21:31:59 +0200
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	takimoto-j@kba.biglobe.ne.jp
Subject: [PATCH v4 1/1] macOS: ls-files path fails if path of workdir is NFD
Date: Fri, 31 May 2024 21:31:56 +0200
Message-ID: <20240531193156.28046-1-tboegi@web.de>
X-Mailer: git-send-email 2.41.0.394.ge43f4fd0bd
In-Reply-To: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5E1nVOrVScXHpgiSknb8QeDuFLEyGEjDOLxs4AVp3vybcyGXJ/s
 qySPC19DHT83tZUQGjNCOCiw/xAB3mIRrOyZhYxts8apTagkKgWJpY5SFScjXBORq9UeHu9
 qgdo/naq0y8ceABRI5qUGKV5rHtiOX7DDwz4oVhx61XhMnX55SXt0otvZhFHVXdNELu0D4t
 AElRMChdZI3TXEoHTuvwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rFFHBKG6VSU=;7untMLA+oBQHNoVY+KWKbITkCGp
 xQ/RKZUM4nH4c6AuEVtUw7bMiw/pn1QxBbkBnI415dRwPQKb6Er4GK2bPKCUaH06KO6toWnGA
 dEiSzTF02DyXsAV2500AC3wPzjYmU/8BO0yoUQoj+zVX7UCGQZiuVMUXuDsyfZzO9RyqbCpYL
 czMTsfb97ut3uRlH/tYnqJQ03o9aCnisrk1O1SBu87ruMthJifZ9KnLWKoLM16JYS7aE+Lcfc
 iSNrOlaBd1YHxtq5CPw54Ol1OH/NmC3kHHQiC+m4kW5Hg+lT2Q8QS4FjeKBDOU6LRdu+3xUfl
 4hRCqIdlaS2eeBoT4FGB6AGKbMYZLjt11PHmv1khj3fjU9Od7E/OhuLznrVSgtMxRxDhCH7it
 0/q1nhNV3l4oKQPUsipD8mwKFuBePTDc9JCAa3zOC9BXc5ihzFYoY2C/BlAb98a1nzbck/5l7
 5OGfKfLn7d6odZW0F1qLfVCzYLX7XKvAu4bn8x/FenHD/rn7jkftDPsFLHJwYMgv6WjLrH26N
 pZPuJkSCqlxV+V6MI01MR/w3euDeq/D7UDdbCrBcj1dafpDPu+/tCXMMgBNf44YSN+EJCTH2v
 6eziGyO9l+pj/ksweqVajXhrtzY6dc5zYtw5TOF1O6XvRFtpqYkocFVL519ZIJGgulPk7nAX0
 ks/dOF2wJc4D/p6EgDntlIxKZXVnATpAU5Jcb6W/4A/M9rLqWMV/kpgv0QNVDw08YAIBWOPiQ
 3J6eyTCB+mGQYNqud2aHZ22KDgyi74BqvD3EV0ikuvgDOCp0b+9QmBwbZ3mMo2pXnlAM6I5Jv
 g8zt0Ggx2DoK0A+5qMNOgztW1MVZpn98eOM1Cd7QB7pf0=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Under macOS, `git ls-files path` does not work (gives an error)
if the absolute 'path' contains characters in NFD (decomposed).
This happens when core.precomposeunicode is true, which is the
most common case. The bug report says:

$ cd somewhere          # some safe place, /tmp or ~/tmp etc.
$ mkdir $'u\xcc\x88'    # =C3=BC in NFD
$ cd =C3=BC                  # or cd $'u\xcc\x88' or cd $'\xc3\xbc'
$ git init
$ git ls-files $'/somewhere/u\xcc\x88'   # NFD
  fatal: /somewhere/=C3=BC: '/somewhere/=C3=BC' is outside repository at '=
/somewhere/=C3=BC'
$ git ls-files $'/somewhere/\xc3\xbc'    # NFC
(the same error as above)

In the 'fatal:' error message, there are three =C3=BC;
the 1st and 2nd are in NFC, the 3rd is in NFD.

Add test cases that follows the bug report, with the simplification
that the '=C3=BC' is replaced by an '=C3=A4', which is already used as NFD=
 and
NFC in t3910.

The solution is to add a call to precompose_string_if_needed()
to this code in setup.c :
`work_tree =3D precompose_string_if_needed(get_git_work_tree());`

There is, however, a limitation with this very usage of Git:
The (repo) local .gitconfig file is not used, only the global
"core.precomposeunicode" is taken into account, if it is set (or not).
To set it to true is a good recommendation anyway, and here is the
analyzes from Jun T :

The problem is the_repository->config->hash_initialized
is set to 1 before the_repository->commondir is set to ".git".
Due to this, .git/config is never read, and precomposed_unicode
is never set to 1 (remains -1).

run_builtin() {
    setup_git_directory() {
        strbuf_getcwd() {   # setup.c:1542
            precompose_{strbuf,string}_if_needed() {
                # precomposed_unicode is still -1
                git_congig_get_bool("core.precomposeunicode") {
                    git_config_check_init() {
                        repo_read_config() {
                            git_config_init() {
                                # !!!
                                the_repository->config->hash_initialized=
=3D1
                                # !!!
                            }
                            # does not read .git/config since
                            # the_repository->commondir is still NULL
                        }
                    }
                }
                returns without converting to NFC
            }
            returns cwd in NFD
        }

        setup_discovered_git_dir() {
            set_git_work_tree(".") {
                repo_set_worktree() {
                    # this function indirectly calls strbuf_getcwd()
                    # --> precompose_{strbuf,string}_if_needed() -->
                    # {git,repo}_config_get_bool("core.precomposeunicode")=
,
                    # but does not try to read .git/config since
                    # the_repository->config->hash_initialized
                    # is already set to 1 above. And it will not read
                    # .git/config even if hash_initialized is 0
                    # since the_repository->commondir is still NULL.

                    the_repository->worktree =3D NFD
                }
            }
        }

        setup_git_env() {
            repo_setup_gitdir() {
                repo_set_commondir() {
                    # finally commondir is set here
                    the_repository->commondir =3D ".git"
                }
            }
        }

    } // END setup_git_directory

Reported-by: Jun T <takimoto-j@kba.biglobe.ne.jp>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
=2D--
 setup.c                      |  2 +-
 t/t3910-mac-os-precompose.sh | 39 +++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 2e607632db..61f61496ec 100644
=2D-- a/setup.c
+++ b/setup.c
@@ -48,7 +48,7 @@ static int abspath_part_inside_repo(char *path)
 	size_t wtlen;
 	char *path0;
 	int off;
-	const char *work_tree =3D get_git_work_tree();
+	const char *work_tree =3D precompose_string_if_needed(get_git_work_tree(=
));
 	struct strbuf realpath =3D STRBUF_INIT;

 	if (!work_tree)
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 898267a6bd..6d5918c8fe 100755
=2D-- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -37,6 +37,27 @@ Alongc=3D$Alongc$Alongc$Alongc$Alongc$Alongc           =
#50 Byte
 Alongc=3D$Alongc$Alongc$Alongc$Alongc$Alongc           #250 Byte
 Alongc=3D$Alongc$AEligatu$AEligatu                     #254 Byte

+
+ls_files_nfc_nfd () {
+	test_when_finished "git config --global --unset core.precomposeunicode" =
&&
+	prglbl=3D$1
+	prlocl=3D$2
+	aumlcreat=3D$3
+	aumllist=3D$4
+	git config --global core.precomposeunicode $prglbl &&
+	(
+		rm -rf .git &&
+		mkdir -p "somewhere/$prglbl/$prlocl/$aumlcreat" &&
+		mypwd=3D$PWD &&
+		cd "somewhere/$prglbl/$prlocl/$aumlcreat" &&
+		git init &&
+		git config core.precomposeunicode $prlocl &&
+		git --literal-pathspecs ls-files "$mypwd/somewhere/$prglbl/$prlocl/$aum=
llist" 2>err &&
+		>expected &&
+		test_cmp expected err
+	)
+}
+
 test_expect_success "detect if nfd needed" '
 	precomposeunicode=3D$(git config core.precomposeunicode) &&
 	test "$precomposeunicode" =3D true &&
@@ -211,8 +232,8 @@ test_expect_success "unicode decomposed: git restore -=
p . " '
 '

 # Test if the global core.precomposeunicode stops autosensing
-# Must be the last test case
 test_expect_success "respect git config --global core.precomposeunicode" =
'
+	test_when_finished "git config --global --unset core.precomposeunicode" =
&&
 	git config --global core.precomposeunicode true &&
 	rm -rf .git &&
 	git init &&
@@ -220,4 +241,20 @@ test_expect_success "respect git config --global core=
.precomposeunicode" '
 	test "$precomposeunicode" =3D "true"
 '

+test_expect_success "ls-files false false nfd nfd" '
+	ls_files_nfc_nfd false false $Adiarnfd $Adiarnfd
+'
+
+test_expect_success "ls-files false true nfd nfd" '
+	ls_files_nfc_nfd false true $Adiarnfd $Adiarnfd
+'
+
+test_expect_success "ls-files true false nfd nfd" '
+	ls_files_nfc_nfd true false $Adiarnfd $Adiarnfd
+'
+
+test_expect_success "ls-files true true nfd nfd" '
+	ls_files_nfc_nfd true true $Adiarnfd $Adiarnfd
+'
+
 test_done
=2D-
2.41.0.394.ge43f4fd0bd

