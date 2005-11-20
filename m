From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: [PATCH] Support username and password inside URL
Date: Sun, 20 Nov 2005 12:05:47 +0200
Message-ID: <873blriqh0.fsf@litku.valo.iki.fi>
References: <87u0e71zpx.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Nov 20 11:07:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edm5I-0007Ze-MT
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 11:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVKTKFw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 05:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVKTKFw
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 05:05:52 -0500
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:57017 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1750778AbVKTKFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 05:05:52 -0500
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep30-app.kolumbus.fi
          with ESMTP
          id <20051120100548.FDUA1672.fep30-app.kolumbus.fi@litku.valo.iki.fi>
          for <git@vger.kernel.org>; Sun, 20 Nov 2005 12:05:48 +0200
To: git@vger.kernel.org
In-Reply-To: <87u0e71zpx.fsf@litku.valo.iki.fi> (Kalle Valo's message of "Sun,
	20 Nov 2005 10:38:02 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12376>

Currently usage of curl was so that netrc was mandatory and passwords in URL
weren't allowed. Change netrc to optional to make HTTP basic authentication
with username and password in URL also work.

Here's an example of such URL:

http://foo:bar@www.example.com/auth.git/

Signed-off-by: Kalle Valo <Kalle.Valo@iki.fi>

---

 git-clone.sh     |    2 +-
 git-fetch.sh     |    2 +-
 git-ls-remote.sh |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

applies-to: 8839be40e9401452691ae1b0bf4c86ac616b7bb6
43a79922ab5d3468f0e8614d526b693772d8b1d6
diff --git a/git-clone.sh b/git-clone.sh
index c09979a..8af0d5f 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -23,7 +23,7 @@ fi
 
 http_fetch () {
 	# $1 = Remote, $2 = Local
-	curl -nsfL $curl_extra_args "$1" >"$2"
+	curl -sfL --netrc-optional $curl_extra_args "$1" >"$2"
 }
 
 clone_dumb_http () {
diff --git a/git-fetch.sh b/git-fetch.sh
index 6586e77..e983cef 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -234,7 +234,7 @@ do
 	    $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
 	    print "$u";
 	' "$remote_name")
-	head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted") &&
+	head=$(curl -sfL --netrc-optional $curl_extra_args "$remote/$remote_name_quoted") &&
 	expr "$head" : "$_x40\$" >/dev/null ||
 		die "Failed to fetch $remote_name from $remote"
 	echo >&2 Fetching "$remote_name from $remote" using http
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index f0f0b07..af8f4b1 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -42,7 +42,7 @@ http://* | https://* )
         if [ -n "$GIT_SSL_NO_VERIFY" ]; then
             curl_extra_args="-k"
         fi
-	curl -nsf $curl_extra_args "$peek_repo/info/refs" ||
+	curl -sf --netrc-optional $curl_extra_args "$peek_repo/info/refs" ||
 		echo "failed	slurping"
 	;;
 
---
0.99.9.GIT
