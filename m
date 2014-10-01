From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 23/32] prune: strategies for linked checkouts
Date: Wed, 01 Oct 2014 18:20:35 +0200
Message-ID: <542C29D3.7020205@kdbg.org>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com> <1411867366-3821-1-git-send-email-pclouds@gmail.com> <1411867366-3821-24-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 18:20:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZMdv-0008HF-0E
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 18:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbaJAQUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 12:20:39 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:41053 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751424AbaJAQUi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 12:20:38 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3j7N3v086pz5tlR;
	Wed,  1 Oct 2014 18:20:26 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CFE7619F5C3;
	Wed,  1 Oct 2014 18:20:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1411867366-3821-24-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257757>

Am 28.09.2014 um 03:22 schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
> +test_expect_success 'prune directories with gitdir pointing to nowhe=
re' '
> +	mkdir -p .git/worktrees/def/abc &&
> +	: >.git/worktrees/def/def &&
> +	echo "$TRASH_DIRECTORY"/nowhere >.git/worktrees/def/gitdir &&
> +	git prune --worktrees --verbose >actual &&
> +	test_i18ngrep "Removing worktrees/def: gitdir file points to non-ex=
istent location" actual &&
> +	! test -d .git/worktrees/def &&
> +	! test -d .git/worktrees
> +'
> ...
> +test_expect_success 'not prune recent checkouts' '
> +	test_when_finished rm -r .git/worktrees
> +	mkdir zz &&
> +	mkdir -p .git/worktrees/jlm &&
> +	echo "$TRASH_DIRECTORY"/zz >.git/worktrees/jlm/gitdir &&
> +	git prune --worktrees --verbose --expire=3D2.days.ago &&
> +	test -d .git/worktrees/jlm
> +'

These require the following fixups because MinGW git will understand
only DOS style absolute paths, but $TRASH_DIRECTORY is in
POSIX-MSYS-style /c/foo/bar.

--- 8< ---
Subject: [PATCH] fixup! prune: strategies for linked checkouts

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t2026-prune-linked-checkouts.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-c=
heckouts.sh
index 3622800..170aefe 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -57,7 +57,7 @@ test_expect_success 'prune directories with invalid g=
itdir' '
 test_expect_success 'prune directories with gitdir pointing to nowhere=
' '
 	mkdir -p .git/worktrees/def/abc &&
 	: >.git/worktrees/def/def &&
-	echo "$TRASH_DIRECTORY"/nowhere >.git/worktrees/def/gitdir &&
+	echo "$(pwd)"/nowhere >.git/worktrees/def/gitdir &&
 	git prune --worktrees --verbose >actual &&
 	test_i18ngrep "Removing worktrees/def: gitdir file points to non-exis=
tent location" actual &&
 	! test -d .git/worktrees/def &&
@@ -76,7 +76,7 @@ test_expect_success 'not prune recent checkouts' '
 	test_when_finished rm -r .git/worktrees
 	mkdir zz &&
 	mkdir -p .git/worktrees/jlm &&
-	echo "$TRASH_DIRECTORY"/zz >.git/worktrees/jlm/gitdir &&
+	echo "$(pwd)"/zz >.git/worktrees/jlm/gitdir &&
 	git prune --worktrees --verbose --expire=3D2.days.ago &&
 	test -d .git/worktrees/jlm
 '
--=20
2.0.0.12.gbcf935e
