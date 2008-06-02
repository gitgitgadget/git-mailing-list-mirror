From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v2] test-lib.sh: set PERL5LIB instead of GITPERLLIB
Date: Mon,  2 Jun 2008 16:13:16 +0200
Message-ID: <1212415996-32130-1-git-send-email-LeWiemann@gmail.com>
References: <4843FEE2.1070708@gmail.com>
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 16:15:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3And-0005hG-IO
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 16:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760464AbYFBONQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 10:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757832AbYFBONQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 10:13:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:10398 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756098AbYFBONP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 10:13:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so745921fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=Q8g7IRCZOcwRG5kY7qpBZvKZw43Vllk3fACAdwvhs2k=;
        b=Z5UCM9fUv6hDTIS8xJSiO8v7F7P5e2cwxr6bCD1mW6cB0SeAN5NY3YoLa4qJ5firXZMc8sYqJS8jj/ADxBw9LdnqErBRGsuFhidqxfpySFjzcnFF8pnP6bRhDMz7aVM0CStrJg4f+91c4XuibH19M/FxixtD+5Jg60eqT+1Q9gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=vXl4CYCeWvL4s9PqlbykaKxHHGegrnUmvUTqiuNjKp1+HKdt8LMYoc75ZNKoFQVakxZ1UZzH3GR4dBQR+2ptO6o0gFGedZSxgZvYGpmpLg6Nw/ZK11jpEkQ7+k4Ucny8CF9yWKuZRgyQvo1eazndw/WdiZf9+FXQ0hx5fADwaHc=
Received: by 10.86.58.3 with SMTP id g3mr924826fga.21.1212415993950;
        Mon, 02 Jun 2008 07:13:13 -0700 (PDT)
Received: from fly ( [91.33.205.25])
        by mx.google.com with ESMTPS id l19sm4333739fgb.7.2008.06.02.07.13.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 07:13:13 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K3Ami-0008Ma-Li; Mon, 02 Jun 2008 16:13:16 +0200
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <4843FEE2.1070708@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83525>

From: Lea Wiemann <lewiemann@gmail.com>

By setting PERL5LIB for the tests, we enable Perl test scripts to just
say "use Git;" without adding the GITPERLLIB paths to @INC beforehand.

Also, unset GITPERLLIB so that user-set paths in GETPERLLIB don't
cause the wrong module to be loaded.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Added since v1: Unset GITPERLLIB.

 t/test-lib.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 99b63da..8ea0511 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -454,8 +454,10 @@ GIT_CONFIG_NOSYSTEM=1
 GIT_CONFIG_NOGLOBAL=1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
 
-GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
-export GITPERLLIB
+unset GITPERLLIB
+test -n "$PERL5LIB" && PERL5LIB=":$PERL5LIB"
+PERL5LIB="$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git$PERL5LIB"
+export PERL5LIB
 test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
-- 
1.5.5.GIT
