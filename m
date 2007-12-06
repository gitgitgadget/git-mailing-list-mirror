From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add option --path to allow to run tests with real systems.
 You must install git before running this test.
Date: Thu, 6 Dec 2007 15:23:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712061422010.27959@racer.site>
References: <20071206134817.GA8523@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1755104978-1196954611=:27959"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 16:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0IaW-0004vB-Iu
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 16:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbXLFPYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 10:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXLFPYE
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 10:24:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:48900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750954AbXLFPYC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 10:24:02 -0500
Received: (qmail invoked by alias); 06 Dec 2007 15:24:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 06 Dec 2007 16:24:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WttQvLxfWksp8owm/0C3wA46E0Y5y0Nve4fpBCS
	tTWRz1mCMrma+F
X-X-Sender: gene099@racer.site
In-Reply-To: <20071206134817.GA8523@laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67293>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1755104978-1196954611=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 6 Dec 2007, Nguyễn Thái Ngọc Duy wrote:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  On Thu, Dec 06, 2007 at 10:15:05AM +0700, Nguyen Thai Ngoc Duy wrote:
>  > On Dec 6, 2007 2:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  > > This is wrong, isn't it?  $path may point at the freshly built but not
>  > > installed git executable, but it reports --exec-path the location that
>  > > git-foo and friends are to be _eventually_ installed, not the location
>  > > they are sitting after built, being tested, waiting to be installed.
>  > >
>  > Yes, forgot to mention you must do "make install" first :)
>  > 
> 
>  Perhaps a check to remind people to 'make install' like this?

Well, the whole point of "make test" is to be sure that it works before 
installing it.

How about something completely different?

-- snipsnap --

 t/test-lib.sh |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 90b6844..ee87b83 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -296,7 +296,18 @@ test_done () {
 
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in trash subdirectory.
-PATH=$(pwd)/..:$PATH
+
+# Test libexec, while we are at it
+
+test -d test-bin || mkdir test-bin || error "t/test-bin/ could not be created"
+for file in ../git ../git-sh-setup ../test-*
+do
+	target=test-bin/"$(basename "$filename")"
+	test -x "$file" && test ! -x "$target" &&
+		ln -s ../"$file" test-bin/
+done
+
+PATH=$(pwd)/test-bin:$PATH
 GIT_EXEC_PATH=$(pwd)/..
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 GIT_CONFIG=.git/config
---1463811741-1755104978-1196954611=:27959--
