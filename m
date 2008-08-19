From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [PATCH] bash-completion: fix getting strategy list
Date: Tue, 19 Aug 2008 20:28:03 +0700
Message-ID: <20080819132803.GA26201@laptop>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 15:29:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVRH3-0001Xx-2a
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 15:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbYHSN2V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 09:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbYHSN2U
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 09:28:20 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:26814 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYHSN2U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 09:28:20 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1483439yxm.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ryh4SpxMmfbq+5L7wm8tVI42feGGopadSO8yJmlgp7c=;
        b=APeCXIDB0rXKTiMEtzTCQhwf467jz/uyTNIqRRFrkpaXFFDusIch7AxpN5N2UrK0W/
         dDM+KRfTHr6wf/LpJnbylfPlbDupC4AOyPj8ENxMoNYDU3Bg/xUpT49kRK5t7gPIOeWP
         yEzJXM6yCbvwh7RZJqPvU1x1BxD6fSnOnotX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hGq8ZisP78wbOcFhhyFU1rfgiY76z82sGxpSUESFiuiqH6NM7C297ZEUIy6meyptON
         8ZN+FRKorJbHu1/gr5liwNV6bRDymbKgyZ4gQFe2d/ycqsKEDPB286LCQm7wY9lzKNXy
         mlc+V2IES9XIqric97aqa2oBDDSTod6nUIqqU=
Received: by 10.114.180.18 with SMTP id c18mr6494685waf.128.1219152497504;
        Tue, 19 Aug 2008 06:28:17 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.133.90])
        by mx.google.com with ESMTPS id y25sm165758pod.8.2008.08.19.06.28.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 06:28:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 19 Aug 2008 20:28:03 +0700
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92856>

Bash completion needs to know what strategies git supports. Maybe
other similar tools have the same demand. So add=20
"git merge--show-strategies"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---

  On Tue, Aug 19, 2008 at 07:27:39PM +0700, Nguyen Thai Ngoc Duy wrote:
  > Probably missed since git-merge builtin effort:
  >=20
  > __git_merge_strategies ()
  > {
  >         if [ -n "$__git_merge_strategylist" ]; then
  >                 echo "$__git_merge_strategylist"
  >                 return
  >         fi
  >         sed -n "/^all_strategies=3D'/{
  >                 s/^all_strategies=3D'//
  >                 s/'//
  >                 p
  >                 q
  >                 }" "$(git --exec-path)/git-merge"
  > }
  >=20
  > It takes several seconds to finish that function.

  Maybe something like this?

 Documentation/git-merge.txt            |    4 ++++
 builtin-merge.c                        |    7 +++++++
 contrib/completion/git-completion.bash |    7 +------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 17a15ac..f3fe1c9 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
 	[-m <msg>] <remote> <remote>...
 'git merge' <msg> HEAD <remote>...
+'git merge' --show-strategies
=20
 DESCRIPTION
 -----------
@@ -37,6 +38,9 @@ include::merge-options.txt[]
 	least one <remote>.  Specifying more than one <remote>
 	obviously means you are trying an Octopus.
=20
+--show-strategies::
+	Show all available strategies. For internal use only.
+
 include::merge-strategies.txt[]
=20
=20
diff --git a/builtin-merge.c b/builtin-merge.c
index de025ac..613c96a 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -802,6 +802,13 @@ int cmd_merge(int argc, const char **argv, const c=
har *prefix)
 	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
 	struct commit_list **remotes =3D &remoteheads;
=20
+	/* needed for git bash completion and similar tools */
+	if (argc =3D=3D 2 && !strcmp(argv[1], "--show-strategies")) {
+		for (i =3D 0; i < ARRAY_SIZE(all_strategy); i++)
+			printf("%s\n", all_strategy[i].name);
+		return 0;
+	}
+
 	setup_work_tree();
 	if (unmerged_cache())
 		die("You are in the middle of a conflicted merge.");
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 158b912..1eea49a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -271,12 +271,7 @@ __git_merge_strategies ()
 		echo "$__git_merge_strategylist"
 		return
 	fi
-	sed -n "/^all_strategies=3D'/{
-		s/^all_strategies=3D'//
-		s/'//
-		p
-		q
-		}" "$(git --exec-path)/git-merge"
+	$(git --exec-path)/git-merge --show-strategies
 }
 __git_merge_strategylist=3D
 __git_merge_strategylist=3D"$(__git_merge_strategies 2>/dev/null)"
--=20
1.6.0.96.g2fad1.dirty
