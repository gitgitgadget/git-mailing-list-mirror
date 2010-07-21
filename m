From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with
 test_must_fail
Date: Tue, 20 Jul 2010 19:01:01 -0500
Message-ID: <20100721000101.GB4282@burratino>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
 <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
 <AANLkTilzC8iMikfBieS_pcChP7_F4hA6bT1ydWHD4etP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	erick.mattos@gmail.com, jaredhance@gmail.com, drafnel@gmail.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 02:02:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObMlE-0008Bk-C8
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 02:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab0GUACA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 20:02:00 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60214 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab0GUAB7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 20:01:59 -0400
Received: by gxk23 with SMTP id 23so3268214gxk.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 17:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5Z8ITT3xeJm1hRBRvNLkk+IpL/ZDoqCQZAT0/Yc8yEU=;
        b=uBox4DJE1357Nf3LqZTJvurdNFYt37jIhsWJUjZdgVKApi6iM4UL7+sm5BV2jnP7FI
         COFXSnX/tIokBlCVJJqfWb9UGcmAucVA/L7zxmZ4pOnj8e5PBuxWiIcr6Nn5nvaNwBib
         GPnoYCb6XrQwyxTwNlxIAwSI1+uo2yKq95lr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EyRabJpoan/6WoykrETvCworuKmU1SbisGERkfiha4LjbqUFCJlJa11vQMdfffsypS
         aBhcicvd5D7yKQ+W3aLdGpyyBRZB0Au1wExvAUcAcfTjD4xRn/CfVTHVnxow7+coT+I7
         zjt5CVeAatt91lLLJjNMoHzvfcNgr2Rt4EzeA=
Received: by 10.224.115.16 with SMTP id g16mr6113204qaq.313.1279670518716;
        Tue, 20 Jul 2010 17:01:58 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id q30sm28613082qcq.0.2010.07.20.17.01.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 17:01:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilzC8iMikfBieS_pcChP7_F4hA6bT1ydWHD4etP@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151378>

=C6var Arnfj=F6r=F0 Bjarmason wrote:

> You must use "export PAGER;", not "export PAGER &&". export doesn't
> return zero on all systems when exporting, see previous changes in
> this regard in t/.

Nope.  Sorry I missed this before.

diff --git a/t/README b/t/README
index b906ceb..f81998b 100644
--- a/t/README
+++ b/t/README
@@ -259,11 +259,11 @@ Do:
 	test ...
=20
    That way all of the commands in your tests will succeed or fail. If
-   you must ignore the return value of something (e.g. the return
-   value of export is unportable) it's best to indicate so explicitly
-   with a semicolon:
+   you must ignore the return value of something (e.g., the return
+   after unsetting a variable that was already unset is unportable) it=
's
+   best to indicate so explicitly with a semicolon:
=20
-	export HLAGH;
+	unset HLAGH;
 	git merge hla &&
 	git push gh &&
 	test ...
--=20
