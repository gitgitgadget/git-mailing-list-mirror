From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] [submodule] Add depth to submodule update
Date: Tue, 25 Jun 2013 00:49:25 +0200
Message-ID: <20130624224925.GC32270@paksenarrion.iveqy.com>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 00:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrFZr-0003LB-5n
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 00:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab3FXWtf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 18:49:35 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:37155 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab3FXWte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 18:49:34 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so11065746lab.5
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f+DAESNqa7lBeIRB+N6cLtP22XqvShXfZIMhpGpor7w=;
        b=y5A5okP/k0bFBGFsBIdwG9xd5NsbYv9SrcD66D86SYSDLra1KP5iefkm/EsbO9QJjD
         n6gmex1K/oKB6w2SUjQX2sGZEWcTSXcnzERZzhbs+RvYrHfXuxw3AT5xknnorA3F8jcG
         dcH1c7ESX4MeIDTASa6eokW84Z1O8cDOUpvbllXOnH5nERuo4BfBOzCN5TzlCjc91ti1
         T2418MN28RLpDUuguRVmtizyXwCk3CltfVgJpiTV5ebdWiTq4D0IGLBUkwk/YSbRKzEC
         MdVQNw1eedkz9sUk5LueNelXkDNhGw7tSUacCQv7BwqrPVvxSOqJo4Wu0pih4SpD9y2X
         KLEg==
X-Received: by 10.152.27.40 with SMTP id q8mr12306725lag.75.1372114173078;
        Mon, 24 Jun 2013 15:49:33 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id am8sm7566057lac.1.2013.06.24.15.49.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 15:49:32 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UrFZd-00008S-Mi; Tue, 25 Jun 2013 00:49:25 +0200
Content-Disposition: inline
In-Reply-To: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228917>

Used only when a clone is initialized. This is useful when the submodul=
e(s)
are huge and you're not really interested in anything but the latest co=
mmit.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git-submodule.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..b102fa8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -211,12 +211,18 @@ module_clone()
 	name=3D$2
 	url=3D$3
 	reference=3D"$4"
+	depth=3D$5
 	quiet=3D
 	if test -n "$GIT_QUIET"
 	then
 		quiet=3D-q
 	fi

+	if test -n "$depth"
+	then
+		depth=3D"--depth=3D$depth"
+	fi
+
 	gitdir=3D
 	gitdir_base=3D
 	base_name=3D$(dirname "$name")
@@ -233,7 +239,7 @@ module_clone()
 		mkdir -p "$gitdir_base"
 		(
 			clear_local_git_env
-			git clone $quiet -n ${reference:+"$reference"} \
+			git clone $quiet $depth -n ${reference:+"$reference"} \
 				--separate-git-dir "$gitdir" "$url" "$sm_path"
 		) ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path=
' failed")"
@@ -676,6 +682,9 @@ cmd_update()
 		--checkout)
 			update=3D"checkout"
 			;;
+		--depth)
+			depth=3D$2
+			;;
 		--)
 			shift
 			break
@@ -735,7 +744,7 @@ Maybe you want to use 'update --init'?")"

 		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" || exit
+			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exi=
t
 			cloned_modules=3D"$cloned_modules;$name"
 			subsha1=3D
 		else
--
1.8.0


--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
