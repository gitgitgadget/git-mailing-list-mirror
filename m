From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH/RFC] Added -crlf attribute for test patch files
Date: Wed, 1 Apr 2009 13:59:50 +0300
Message-ID: <85647ef50904010359r639f5278t23c85d7c91a59d6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 13:01:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoyCH-0008O4-CV
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 13:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbZDAK7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 06:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbZDAK7z
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 06:59:55 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51838 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbZDAK7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 06:59:54 -0400
Received: by fxm2 with SMTP id 2so2877485fxm.37
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/BgME5/UvjPfDDwspmAh7c26fmLLCwUFcYBCV0IAQo0=;
        b=qHlwVUaqzot1a9L5yJqMWjqeCyhVB4d4G/Kby40v1HsTVXznPfNCKOWoV637c+cv84
         zXeVmA/1JlHDKqqeGMjfcOuduhtPSLvoSD+Ozo8JaxNHC2RIZYu/4hUZSv2fkz6L0+Ro
         sdc6iukRpYCxLIhqIlkSYNGwbvMrd3A3brSu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=IKtMPUn/fH1G22HG0CS0Y0NP96NhXY0bNr83X4Oy/yLY4IvnhZxiXGsvlKGpP087Z8
         DUptt9PbrkyHa1JjSDip3e0c/Nj95KjTsgSNT1h+7iTGJ0QOw4idpoua5rdP0KKnYJQD
         2AhWIEFo895qRmLomGGomAUWxU0hSZzo7/XXg=
Received: by 10.204.31.75 with SMTP id x11mr2763545bkc.0.1238583590080; Wed, 
	01 Apr 2009 03:59:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115370>

The method RawParseUtils.nextLF(byte[],int,char) used for parsing
patches expects \n as a line separator. However on MinGW git
uses \r\n as line separator for text files by default, and patch
files in egit/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch
are treated as text files. This caused test suit failure. To prevent
test suit failure, "-crlf" attribute is added for patch files.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
I'm not completely sure whether I have fixed a correct place.
MinGW itself uses \n as line separator in patches. Thus I think
it is an error to have \r\n in the patch file, so I have fixed
patch files rather than parsing code. Other possible solution
is to fix nextLF() to handle \r\n as well.

Without this fix the egit could not be built on the maven when
it is checked out using MinGW git.

 .../tst-rsrc/org/spearce/jgit/patch/.gitattributes |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644
org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/.gitattributes

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/.gitattributes
b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/.gitattributes
new file mode 100644
index 0000000..b38f87f
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/.gitattributes
@@ -0,0 +1 @@
+*.patch -crlf
-- 
1.6.0.2.1172.ga5ed0
