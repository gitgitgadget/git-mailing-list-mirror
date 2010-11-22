From: Tay Ray Chuan <rctay89@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20bash=20completion=3A=20add=20basic=20support=20for=20git-reflog?=
Date: Tue, 23 Nov 2010 01:09:09 +0800
Message-ID: <1290445749-4884-1-git-send-email-rctay89@gmail.com>
References: <1290274368-3212-1-git-send-email-rctay89@gmail.com> <20101122152409.GA7010@neumann> <AANLkTinJPQF-khzViED+ROyojEr9nHrcgwKQWsDugD7Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	SZEDER Gabor <szeder@ira.uka.de>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 22 18:09:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKZth-0003ra-Cl
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 18:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab0KVRJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 12:09:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56698 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab0KVRJg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 12:09:36 -0500
Received: by wwa36 with SMTP id 36so7577409wwa.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 09:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FZv1hf1BKkR5pRG6euqx5ql577ZIV5lYlzepwqx2hRc=;
        b=V1bmT9AYPQ4L4sDAuOV6Fno7/JihVFXhKiNjMS5XsCfFr6BXms5uYvg7/Qci3hSnTR
         9BIQJYh5Rla/ADSXyUKZr86EYJcPvhv9jYP22wAr4JOK16+ZLiva28ysY0pwHEjtaTdW
         yxK//9Ef6ZKSFxHBm/iUEREt/whoDKVKLB9eM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RUfGGOadZB+j4221QOfWvBRP0cHnUjqiipQ9E+yfN5gRW+2+mQE9YFeXZsg4KVoxlj
         sZvjId0Mt/1SrGftfezhiIjIJwa0x7qnZUqUuOpoS61D0ul2kFS4bBpPwHDwh8NqFfft
         QE2CWmQrTnW1UlHgI94qYKnJ21Capsx5P7YBM=
Received: by 10.227.138.82 with SMTP id z18mr6249173wbt.56.1290445774578;
        Mon, 22 Nov 2010 09:09:34 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id f14sm3443225wbe.20.2010.11.22.09.09.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 09:09:33 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <AANLkTinJPQF-khzViED+ROyojEr9nHrcgwKQWsDugD7Y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161902>

"Promote" the reflog command out of plumbing, so that we now run
completion for it. After all, it's listed under porcelain (ancillary),
and we do run completion for those commands.

Add basic completion for the three subcommands - show, expire, delete.
Try completing refs for these too.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed from v1:=20
 - picked up G=C3=A1bor's suggestion on using __git_find_on_cmdline()
   to correctly handle situations where subcommands are used with dashe=
d
   options.
 - don't "hide" reflog anymore - run completion for it too.

G=C3=A1bor: hmm, it really seems that reflog is treated as plumbing - n=
o completion
is done for it. Even get-tar-commit-id (I've never used this before) is=
 treated
better than reflog. Shall do something about it!

 contrib/completion/git-completion.bash |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index f710469..6732b1d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -735,7 +735,6 @@ __git_list_porcelain_commands ()
 		quiltimport)      : import;;
 		read-tree)        : plumbing;;
 		receive-pack)     : plumbing;;
-		reflog)           : plumbing;;
 		remote-*)         : transport;;
 		repo-config)      : deprecated;;
 		rerere)           : plumbing;;
@@ -1632,6 +1631,18 @@ _git_rebase ()
 	__gitcomp "$(__git_refs)"
 }
=20
+_git_reflog ()
+{
+	local subcommands=3D"show delete expire"
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
+
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+	else
+		__gitcomp "$(__git_refs)"
+	fi
+}
+
 __git_send_email_confirm_options=3D"always never auto cc compose"
 __git_send_email_suppresscc_options=3D"author self cc bodycc sob cccmd=
 body all"
=20
--=20
1.7.3.2.493.g2b058
