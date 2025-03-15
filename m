Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976B1F755E
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047759; cv=none; b=gRH6ddl8YYI9yZ5TG0FDfnjo3A1gZDEhZ85DSisk828Vcb+eNUo/wV9vAa72aokFvAxFT2V2svujpTln3HbKIFGOUKJHdkVaklSF7F3ICrnbtbWwJztUHi/0OhlbXN7Y9AWMny6jvr7but6EvMAml0M3NXdXToptw3d6PBF7QPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047759; c=relaxed/simple;
	bh=WLUwmh8mRgMSOWlm5HGOQVAuvwb7k5j9sKBkBaDaF9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCQpMKlAt2f6xVQN+inJ58COcijOrZtSDkkJd6Iy5XG35sKCCbTYFpZ5D7fX33u4UclQbgdoYPTymEx3w2hgLK/j7Ha7J5qb88fVZNE/bW3flQvmTU2TNuxiUj2VGQfJAD2jnWklhLg+BXW4ffW2jcJnmRELbLzPfCjNIHclv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=hdUch28i; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="hdUch28i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742047754; x=1742652554;
	i=oswald.buddenhagen@gmx.de;
	bh=D0RSNJgoEKQ9U6D9DvQs9BEOsY6Jdo31qhwE1yR2bAg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hdUch28iiZReYzcbbBWU5k46lWvVLNaR5KNVF5eg1D9qKiLEnFqiqdsN8RCC02Sb
	 FeNDzng8qYZ3IYRoMzNLyphYcHp7VfG5akAKyFLkWnMOKs9LcPXtFkz9Ab6/Xg3Dj
	 Xg5Hs9B1YQ9XgVp0OvgDGXwVimiaV1Jh1mRj2/8DEC2tkJUbOwa/ZHPX+THZULY2T
	 hyWHa7WjA+fiKCdxf6bB/lx1Xj/wZVqkpOWuuaeflKPZl7OgIXhL0LWE1HQ1E/lri
	 oqPkXBTI0HAKDY6Lyg6scPTFjron3KORd90JvB5p7gn70rDiHXYKJdKhv/u4i0NaJ
	 dajJCKciPH/cFqEkMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.111]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1t1leP00ql-00yBXS; Sat, 15
 Mar 2025 15:09:14 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1ttSCP-QDP-00; Sat, 15 Mar 2025 15:09:13 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] git-gui: heed core.commentChar/commentString
Date: Sat, 15 Mar 2025 15:09:13 +0100
Message-ID: <20250315140913.577422-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.49.0.416.g2f302f2ef0.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CiTATGpPJ8jTHBeurLCeY1hH5NGDPpxj44ox489QVOtv/+uVtFE
 lFxSluoNbIYYmfsgaxMs8WyF7FoFxVaaCU4v4Q8mnvouJeezd9LNyaQkzGEzxM3JGB4fTEn
 LvoEocLO5pIFG+bWNEMmBOe2MdBSwel6cxDWN2aBGutbkdXE3qdWLpfRjDgKAHnHDUhFEt5
 fse6NnI99B8tFU2CJCK3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JOgpZoq2a7E=;LGAnCaseT1IlpJ+X3P8WzMHZ6k5
 Izy3DMu2IT+Xq/iFLkppscOH18gxF5bVc7B7hKMYgsr0ZHu8hdWgaylc3ZXoKcdD818RZ8dtm
 nNkctqFC+jmMUZ5xC056BXA0q7gsUP1b31v4bA60oUcutZT1aWcQ55wc6/R1LKK59MrjP5HGA
 aV2TIoY9EK4Tp0RvoDHa5ASLmrB+kZnLgNBQ3B0edFkgxdTshL37IaZmfxAV7UN2gQ+xge1+w
 7OVoPGV348L03Vl2L0kt0rGtFZvJeTpbV3tjpUvRi7Z9S+b73zSsJcpUnpF5vcLqWAi5BPwBs
 gETaWnPGUvTiphuUziYAhX9LLJM/WEBjUo46WCYv1iKb8kIxJt8gezHbfKdhv2KR6TLYeQlQM
 mgVBN+kyPljEcw/GLZ/Sw3aRcPx2r4pgaWF5B3XtgS7kEIUwn7EFBeSrQa4Vnxqvweodo/jRH
 nHZeQhmvzd1cEM2oFyww0EwJWtswqxkD6BnT37cm9Y4b1+KJ5Bbg4A+e16CcKD4gIQumKHPtk
 RDkSwfTAPiEBmTpIb4iXU6y8oyp82Sv9fkb1UIv9CgYpYGKzxtpJ3XK0PxM/u2G93juT3PTV1
 GirHhYr/rbavCW59n9c2m4rqTpFBWemfYD1KS2J22UkyuXLgrJRORVQBR6X+BJ0zvzijr7uCU
 eGLKQx1bhwknH0arRqB46PKwDSdLeRjJxF/ehEqAGBs+UrPbxgNToKI7h2KTK4dkrhW53PvWD
 B1t9zg+oV4LS2UTIFYTl+2gYwPT+s1ugf6BWUPwoDUe8Ehh2LnRAJoKSsMi41JuoB16ZN2kiY
 iNjdus/Cb0HOqCLIQQOA4tvnEjXFCFIRI0fEn776eM1sk8WQ+g9s1bvD1Xjsamhmmdvdi32dw
 Ueu9O3zhLj9prFQUoRyH7v0ddhWeY1Eq0nyISGjKDxtu7a6UxPSjvUiBrkTfPSt0Ev8Sa2n4T
 JI0q0ukwXH3613AywT4paNxev2qB3ma+TAiiTSboc0iGolOSYbDVXFh0SMexLYC0LC5IFN0VX
 XIGgEPoAOLvGQZ8ONi+gbK9XO2/emA7IUBxcik484tVQqB7HMNvsJuaGBv/Md6arjZRnuiYhv
 VI+ko4X3gTw2eAkAlCruV8aYrBzOJ7a8oYo2gds12KTlObs56cExeulKi7ohVCTgxNjTaIzBg
 WmC1ditbXr0rSf8+vsRxxBiu0YuWgb6rTrq9T+gAgVFGuGd3URs1yQxCe/aj3QvTDFw2IQVOj
 Ix992qnO3dQP+bICg1ibv7pUb63BaYiZ5qcA3pLOea1+fhGxceUfELnhR0MtUinMEAaO//4yc
 4Zd0QhvnwYB70Q0vlrr4R4qUvFu2l7nK93MfMkI8X0cLzfs7X2MPt+ObOulbMSJYqObURsI7n
 ykX97I89bWotVdFs7rXh1rBXNUhdZiAOHFqguXddbpuUhQPsgHN2J45lGF0a0RJSOhXi7bnfW
 6KoWMPFDtjQHtl3g6Jplr9L1sx2H3tRY5gebfKw9cOYYxndD8

This amends 1ae85ff6d (git-gui: strip comments and consecutive empty
lines from commit messages, 2024-08-13) to deal with custom comment
characters/strings.

The magic commentString value "auto" is not handled, because the option
makes no sense to me - it does not support comments in templates and
hook output, and it seems far-fetched that someone would introduce
comments during editing the message.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Change-Id: Iafc0580e818cb5058cfacbafe6e5da40679a1b1c

--

Cc: Johannes Sixt <j6t@kdbg.org>

the textfield label munging is modeled after b9a43869c9 (without
introducing the same compatibility problem with tcl 8.5), but i'm not
positive it's actually a good idea to have it - it looks a bit messy,
while providing info that the command line client assumes to be known.
---
 git-gui/git-gui.sh     | 11 ++++++++++-
 git-gui/lib/commit.tcl |  4 +++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 887d6d596c..ed14ba679b 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -880,16 +880,24 @@ proc apply_config {} {
 			color::sync_with_theme
 		}
 	}
+
+	global comment_string
+	set comment_string [get_config core.commentstring]
+	if {$comment_string eq {}} {
+		set comment_string [get_config core.commentchar]
+	}
 }
=20
 set default_config(branch.autosetupmerge) true
 set default_config(merge.tool) {}
 set default_config(mergetool.keepbackup) true
 set default_config(merge.diffstat) true
 set default_config(merge.summary) false
 set default_config(merge.verbosity) 2
 set default_config(user.name) {}
 set default_config(user.email) {}
+set default_config(core.commentchar) "#"
+set default_config(core.commentstring) {}
=20
 set default_config(gui.encoding) [encoding system]
 set default_config(gui.matchtrackingbranch) false
@@ -3416,15 +3424,16 @@ ${NS}::label $ui_coml \
 	-anchor w \
 	-justify left
 proc trace_commit_type {varname args} {
-	global ui_coml commit_type
+	global ui_coml commit_type comment_string
 	switch -glob -- $commit_type {
 	initial       {set txt [mc "Initial Commit Message:"]}
 	amend         {set txt [mc "Amended Commit Message:"]}
 	amend-initial {set txt [mc "Amended Initial Commit Message:"]}
 	amend-merge   {set txt [mc "Amended Merge Commit Message:"]}
 	merge         {set txt [mc "Merge Commit Message:"]}
 	*             {set txt [mc "Commit Message:"]}
 	}
+	append txt [mc " (Lines starting with '%s' will be discarded)" $comment_s=
tring]
 	$ui_coml conf -text $txt
 }
 trace add variable commit_type write trace_commit_type
diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 208dc2817c..a570f9cdc6 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -211,7 +211,9 @@ You must stage at least 1 file before you can commit.
 	# Strip trailing whitespace
 	regsub -all -line {[ \t\r]+$} $msg {} msg
 	# Strip comment lines
-	regsub -all {(^|\n)#[^\n]*} $msg {\1} msg
+	global comment_string
+	set cmt_rx [strcat {(^|\n)} [regsub -all {\W} $comment_string {\\&}] {[^\=
n]*}]
+	regsub -all $cmt_rx $msg {\1} msg
 	# Strip leading empty lines
 	regsub {^\n*} $msg {} msg
 	# Compress consecutive empty lines
--=20
2.49.0.416.g2f302f2ef0.dirty

