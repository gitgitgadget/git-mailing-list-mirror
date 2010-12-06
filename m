From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv3] parse-remote: handle detached HEAD
Date: Mon,  6 Dec 2010 11:20:11 +0100
Message-ID: <1291630811-16584-1-git-send-email-santi@agolina.net>
References: <7vfwubtw1g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 11:20:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPYBM-0004qB-8f
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 11:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785Ab0LFKUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 05:20:23 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62558 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab0LFKUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 05:20:22 -0500
Received: by wyb28 with SMTP id 28so11838424wyb.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 02:20:21 -0800 (PST)
Received: by 10.227.141.134 with SMTP id m6mr5287860wbu.183.1291630817688;
        Mon, 06 Dec 2010 02:20:17 -0800 (PST)
Received: from localhost.localdomain (189.194.19.95.dynamic.jazztel.es [95.19.194.189])
        by mx.google.com with ESMTPS id x28sm2246052weq.16.2010.12.06.02.20.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 02:20:16 -0800 (PST)
X-Mailer: git-send-email 1.7.3.3.399.g0d2be.dirty
In-Reply-To: <7vfwubtw1g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162989>

get_remote_merge_branch with zero or one arguments returns the
upstream branch. But a detached HEAD does no have an upstream branch,
as it is not tracking anything. Handle this case testing the exit code
of "git symbolic-ref -q HEAD".

Reported-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---

> If that is the case, shouldn't we be not calling "echo" at all to beg=
in
> with?  IOW, shouldn't the code read more like this?
>
>        curr_branch=3D$(git symbolic-ref -q HEAD) &&
>        test "$origin" =3D "$default" &&
>        echo ...

Or course, you are right. I didn't know/think about the exit
code... Thanks.

Santi

 git-parse-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5f47b18..4da72ae 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -66,7 +66,7 @@ get_remote_merge_branch () {
 	    origin=3D"$1"
 	    default=3D$(get_default_remote)
 	    test -z "$origin" && origin=3D$default
-	    curr_branch=3D$(git symbolic-ref -q HEAD)
+	    curr_branch=3D$(git symbolic-ref -q HEAD) &&
 	    [ "$origin" =3D "$default" ] &&
 	    echo $(git for-each-ref --format=3D'%(upstream)' $curr_branch)
 	    ;;
--=20
1.7.3.3.399.g0d2be.dirty
