From: Robert Watson <robert.oo.watson@gmail.com>
Subject: [PATCH] Fix git-pull output message
Date: Wed, 28 Sep 2005 11:02:38 +0100
Message-ID: <72499e3b05092803027175bab0@mail.gmail.com>
Reply-To: Robert Watson <robert.oo.watson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Sep 28 12:03:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKYlt-0007Ko-N6
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 12:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVI1KCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 06:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVI1KCj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 06:02:39 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:57310 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751208AbVI1KCi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 06:02:38 -0400
Received: by qproxy.gmail.com with SMTP id v40so315475qbe
        for <git@vger.kernel.org>; Wed, 28 Sep 2005 03:02:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=feuFI/icdmEwr5+CSnLrRISXYtvTNhWu1EYHv1PIPJ00Nh+Kq9jpHKK3nZyksxC6868Y+d3mJhSHkDjmwBX5KdcVN9dhYh8BUVYfypNYuVkmP8dnB0tOeCsI7u4Ct5CpL6rvdK+dZGb95Q6sCnJ9nuORJzVwFsKcnNqkmh/z8pc=
Received: by 10.64.241.5 with SMTP id o5mr984188qbh;
        Wed, 28 Sep 2005 03:02:38 -0700 (PDT)
Received: by 10.64.203.14 with HTTP; Wed, 28 Sep 2005 03:02:38 -0700 (PDT)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9424>

(git)$ git-pull
Fetching refs/heads/master from
http://www.kernel.org/pub/scm/git/git.git using http
* committish: 3cc35e29ec252d0dca1139106fbaa70cb9ad6ef1
  branch 'master' of http://www.kernel.org/pub/scm/git/git
* refs/heads/origin: same as branch 'master' of
http://www.kernel.org/pub/scm/git/git
Already up-to-date. Yeeah!

Notice that the git.git directory is truncated.  It seems the
intension is to truncate at the .git
directory level.  The following patch fixes it.

diff --git a/git-fetch.sh b/git-fetch.sh
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -70,7 +70,7 @@ append_fetch_head () {
     *)
        note_="$remote_name of " ;;
     esac
-    remote_1_=$(expr "$remote_" : '\(.*\)\.git/*$') &&
+    remote_1_=$(expr "$remote_" : '\(.*/\)\.git/*$') &&
        remote_="$remote_1_"
     note_="$note_$remote_"
