From: Michele Marcionelli <michele.marcionelli@math.ethz.ch>
Subject: push problem with anonymous access
Date: Sat, 2 Jul 2011 00:32:48 +0200
Message-ID: <9490CEEB-485B-4EC0-B75B-8ED8F0833712@math.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 02 00:32:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcmGf-0008Rp-HQ
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 00:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914Ab1GAWcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 18:32:52 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:13282 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756745Ab1GAWcw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2011 18:32:52 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sat, 2 Jul
 2011 00:32:46 +0200
Received: from [10.0.0.13] (85.1.201.213) by mail.ethz.ch (172.31.51.111) with
 Microsoft SMTP Server (TLS) id 14.1.289.1; Sat, 2 Jul 2011 00:32:50 +0200
X-Mailer: Apple Mail (2.1084)
X-Originating-IP: [85.1.201.213]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176539>

Dear all

I configured apache as described on the man page:

SetEnv GIT_PROJECT_ROOT /var/www/vhosts/git/root
SetEnv GIT_HTTP_EXPORT_ALL
ScriptAlias /git/ /scratch/local/app/git/current/libexec/git-core/git-h=
ttp-backend/

And then the following 2 repositories (also as described in the page):

# (1) authentication for both reads and writes
<LocationMatch /git/math/private_test.git>
   AuthType Basic
   AuthName "Git Access"
   Require user admin
   AuthUserFile /var/www/vhosts/git/htpasswd
</LocationMatch>

# (2) anonymous read access but authenticated write access
<LocationMatch "/git/math/public_test.git/git-receive-pack$">
   AuthType Basic
   AuthName "Git Access"
   Require user admin
   AuthUserFile /var/www/vhosts/git/htpasswd
</LocationMatch>

Now: with the repository (1) I can do everything, clone & push. With th=
e repository (2) I can only clone and when I try to push as follow:

export GIT_SSL_NO_VERIFY=3Dtrue
git clone https://git.math.ethz.ch/git/math/public_test.git
cd public_test
echo foo >> TODO
git commit TODO -m bar
git push

I get followin errors to "stderr":
error: Cannot access URL https://git.math.ethz.ch/git/math/public_test.=
git/, return code 22
fatal: git-http-push failed

An to the apache access_log & error_log files:
=3D=3D> /var/log/httpd/git-ssl.access_log <=3D=3D
85.1.201.213 - - [02/Jul/2011:00:13:32 +0200] "GET /git/math/public_tes=
t.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 403 - "-" "git/1.7=
=2E5.4"
85.1.201.213 - - [02/Jul/2011:00:13:33 +0200] "GET /git/math/public_tes=
t.git/info/refs HTTP/1.1" 200 59 "-" "git/1.7.5.4"
85.1.201.213 - - [02/Jul/2011:00:13:33 +0200] "GET /git/math/public_tes=
t.git/HEAD HTTP/1.1" 200 23 "-" "git/1.7.5.4"
85.1.201.213 - - [02/Jul/2011:00:13:33 +0200] "PROPFIND /git/math/publi=
c_test.git/ HTTP/1.1" 404 - "-" "git/1.7.5.4"
=3D=3D> /var/log/httpd/git-ssl.error_log <=3D=3D
[Sat Jul 02 00:13:33 2011] [error] [client 85.1.201.213] Request not su=
pported: '/var/www/vhosts/git/root/math/public_test.git/'

Any Idea?

Thx, Michele


--
Michele Marcionelli =B7 mm@ethz.ch =B7 +41 44 632 6193
* Please consider the environment before printing
