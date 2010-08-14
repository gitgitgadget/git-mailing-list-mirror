From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] t9010 (svn-fe): use Unix-style path in URI
Date: Fri, 13 Aug 2010 19:04:50 -0500
Message-ID: <20100814000450.GG2153@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <20100813000848.GA8076@burratino>
 <4C65BA46.9010604@kdbg.org>
 <20100813234723.GC2153@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 02:06:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok4Gu-00029Q-AY
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 02:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203Ab0HNAGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 20:06:43 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52691 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756436Ab0HNAGn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 20:06:43 -0400
Received: by vws3 with SMTP id 3so1674580vws.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4PCGL7EL3b7g9FLRPzR9vNwFNbQ8MmyyTgst6yCf1Ws=;
        b=XKRsqGoP3ucmYj4JGwrqsbK8+LhCoPPZPFppSmO9R+3ShgwhcfkSSoQWuPB1wxMPsY
         1wd6COpo9k0sGB5TFFLvbYlD8xQTVDKB0FlEn8WeocaD/ATyvCeKK7gw/gHhiSXIUtjg
         827T+Nk/N4B4SPrV2daSyB/xh/p6tc8hZ680Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XYNWxzOdjgsvrSE+Lb3lX8d0DUt66WEcNE6tHbwKQc8fYzX1Ll6hEX+Cyj1bd5eBSL
         WhtqA4s4DcV79wjZ15QLB/kvymDFCwmLyKDKRr7P9t9MqkJu/pr+EyPZbKK3wXq34c/u
         jid9tu9I0b2/Jm4qNauz4hEPKM/A62QiPRA7Q=
Received: by 10.220.59.202 with SMTP id m10mr1213495vch.199.1281744402316;
        Fri, 13 Aug 2010 17:06:42 -0700 (PDT)
Received: from burratino ([64.134.175.141])
        by mx.google.com with ESMTPS id w1sm2042630vbl.18.2010.08.13.17.06.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 17:06:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100813234723.GC2153@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153533>

Ever since v1.6.3-rc0~101^2~14 (Tests on Windows: $(pwd) must return
Windows-style paths, 2009-03-13), there is a subtle difference between
$(pwd) and $PWD in tests: the former returns Windows-style paths as
might be output by git and the latter Unix-style paths which msys
programs tend to prefer.

In file:// URIs, Unix-style paths are needed.  Before: =E2=80=9Csvn exp=
ort=E2=80=9D
declares it cannot find

 file://c:/apps/git/git/t/trash directory/simple-svco

After: =E2=80=9Csvn export=E2=80=9D successfully finds

 file:///c/apps/git/git/...

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index bf9bbd6..dd8e78e 100644
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -10,7 +10,7 @@ test_dump() {
 	test_expect_success "$dump" '
 		svnadmin create "$label-svn" &&
 		svnadmin load "$label-svn" < "$TEST_DIRECTORY/$dump" &&
-		svn_cmd export "file://$(pwd)/$label-svn" "$label-svnco" &&
+		svn_cmd export "file://$PWD/$label-svn" "$label-svnco" &&
 		git init "$label-git" &&
 		test-svn-fe "$TEST_DIRECTORY/$dump" >"$label.fe" &&
 		(
--=20
1.7.2.1.544.ga752d.dirty
