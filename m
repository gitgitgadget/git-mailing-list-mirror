From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/4] remote-helpers: trivial test fixes
Date: Sat, 06 Apr 2013 19:03:02 +0200
Message-ID: <51605546.3080503@web.de>
References: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:41:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWX9-0001D7-Dc
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab3DFRDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 13:03:21 -0400
Received: from mout.web.de ([212.227.15.3]:60905 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013Ab3DFRDV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 13:03:21 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Ma2lb-1UAzAv3Xah-00LqNo; Sat, 06 Apr 2013 19:03:04
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
X-Provags-ID: V02:K0:OHgYmEGDWY8V0XEV6z+Vrx/xwFqJIlf35IJkI/XJnnE
 bxa4daTCeVZxOfGRoxJYBJNsYkBI8w6X1NfrCMjWRTDcWQ+h5X
 yONXUaD2RRSTBY8MSzM7fDrH24hPppXUdR/x5w2NS8z5YZ9tnU
 DwVBRNI7puc6ERgMcmaUUpDmfcf3RnIlTF3eJE5y9/potzj4hb
 xRRzda0HbIqfwwJ1cS2Yw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220224>

On 04.04.13 17:36, Felipe Contreras wrote:
> Hi,
> 
> A reroll, now we do some checks, just avoid test-lint-duplicates, and fix the
> outsanding shell portability issue. The rest is the same.
> 
> Felipe Contreras (4):
>   remote-bzr: avoid echo -n
>   remote-helpers: fix the run of all tests
>   remote-bzr: remove stale check code for tests
>   remote-hg: fix hg-git test-case
> 
>  contrib/remote-helpers/Makefile          |  1 +
>  contrib/remote-helpers/test-bzr.sh       | 16 +---------------
>  contrib/remote-helpers/test-hg-hg-git.sh |  1 -
>  3 files changed, 2 insertions(+), 16 deletions(-)
> 
Sorry being late, now I installed bzr and hg on one of my machines 

One defect found: "\s" is not portable on all grep versions
A "*" is not a "basic regular expression", so we need to use egrep


diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 5f81dfa..2e80c11 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -115,7 +115,7 @@ test_expect_success 'update bookmark' '
   git push
   ) &&
 
-  hg -R hgrepo bookmarks | grep "devel\s\+3:"
+  hg -R hgrepo bookmarks | egrep "devel[[:space:]]+3:"
 '
2 mninor nits:

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 8450432..7970f9e 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -13,7 +13,7 @@ if ! test_have_prereq PYTHON; then
 fi
 
 if ! "$PYTHON_PATH" -c 'import bzrlib'; then
-       skip_all='skipping remote-bzr tests; bzr not available'
+       skip_all='skipping remote-bzr tests; python bzrlib not available'
        test_done
 fi
 
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 3f253b7..5d87282 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -21,7 +21,7 @@ if ! "$PYTHON_PATH" -c 'import mercurial'; then
 fi
 
 if ! "$PYTHON_PATH" -c 'import hggit'; then
-       skip_all='skipping remote-hg tests; hg-git not available'
+       skip_all='skipping remote-hg tests; python hggit not available'
        test_done
 fi

(And as a micro-nit: the indenting deserves some better indentation:
TAB could be used for *.sh, and sub-shells could be indentented one TAB:


test_expect_success 'update bookmark' '
	test_when_finished "rm -rf gitrepo*" &&
	(
		cd hgrepo &&
		hg bookmark devel

/Torsten
