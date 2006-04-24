From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Push over HTTP now works with refs/heads/foo instead of foo
Date: Mon, 24 Apr 2006 11:36:13 +0200
Message-ID: <4fb292fa0604240236m44bf1c0bm21f851a1f834f070@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 24 11:36:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXxUR-0006KI-7E
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 11:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWDXJgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 05:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWDXJgP
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 05:36:15 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:31835 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932099AbWDXJgP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 05:36:15 -0400
Received: by nproxy.gmail.com with SMTP id l24so858793nfc
        for <git@vger.kernel.org>; Mon, 24 Apr 2006 02:36:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PegKRer4pHgwODYXfI4dfktIhDIIwxe9G0fOGqagvUXqKrosoifu5fEtPxuLgefkteBqGNNRguWNZDspJfnSLVzgiyOu/d0xzHRUX07O6Bvzbnd6DyxTQkUjhvzFZ92W17SHzltII7YY0IPQ3HKkenGnllApab9HE8tZWAj48RE=
Received: by 10.48.246.10 with SMTP id t10mr2622496nfh;
        Mon, 24 Apr 2006 02:36:13 -0700 (PDT)
Received: by 10.49.5.5 with HTTP; Mon, 24 Apr 2006 02:36:13 -0700 (PDT)
To: pasky@suse.cz
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19094>

Hi,

git-http-push now accept :
git-http-push http://doo.com/git/bar.git/ master:refs/heads/pr/my_passwd

instead of :
git-http-push http://doo.com/git/bar.git/ master:pr/my_passwd

And old syntax doesn't work anymore (unable to create remote branches).

Here is a patch :

diff -Nur cogito-0.17.2/cg-push cogito-0.17.2-mine/cg-push
--- cogito-0.17.2/cg-push	2006-04-08 03:02:49.000000000 +0200
+++ cogito-0.17.2-mine/cg-push	2006-04-24 11:33:34.748845600 +0200
@@ -69,8 +69,7 @@
 sprembranch=":refs/heads/$rembranch"

 if [ "${uri#http://}" != "$uri" -o "${uri#https://}" != "$uri" ]; then
-	# git-http-push doesn't like $sprembranch
-	git-http-push "$uri/" "$locbranch:$rembranch" "${tags[@]}"
+	git-http-push "$uri/" "$locbranch$sprembranch" "${tags[@]}"
 elif [ "${uri#git+ssh://}" != "$uri" ]; then
  send_pack_update "$name" "$(echo "$uri" | sed
's#^git+ssh://\([^/]*\)\(/.*\)$#\1:\2#')" "$locbranch$sprembranch"
"${tags[@]}"
 elif [ "${uri#rsync://}" != "$uri" ]; then


--
Beber
#e.fr@freenode
