From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive and core.eol
Date: Tue, 11 Jan 2011 20:24:24 +0100
Message-ID: <4D2CAE68.3000908@lsrfire.ath.cx>
References: <AANLkTi=kfE88F7dY5F_xtbEuh9DyUcN+ymeXqLMWztGQ@mail.gmail.com> <4D28683B.4020400@lsrfire.ath.cx> <AANLkTi==eqwrwq-P6czDvOH5GDEi6WgvRUuZ2dMoiK7e@mail.gmail.com> <4D29AF80.5060008@lsrfire.ath.cx> <AANLkTinxVCQuTMeKHQ9mLbs=94fck90rwJwa1DhzGPmX@mail.gmail.com> <AANLkTi=WyzVzPkhOAMC2A8Dd=Zj_P-7YMVP-GaUz0-Qm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>, eyvind.bernhardsen@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 11 20:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcjpn-0003We-Be
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378Ab1AKTYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 14:24:43 -0500
Received: from india601.server4you.de ([85.25.151.105]:37222 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191Ab1AKTYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 14:24:42 -0500
Received: from [192.168.2.104] (p4FFD944D.dip.t-dialin.net [79.253.148.77])
	by india601.server4you.de (Postfix) with ESMTPSA id 773E22F8059;
	Tue, 11 Jan 2011 20:24:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTi=WyzVzPkhOAMC2A8Dd=Zj_P-7YMVP-GaUz0-Qm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164978>

Am 10.01.2011 14:00, schrieb Erik Faye-Lund:
> On Mon, Jan 10, 2011 at 1:11 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> test. So now I've got to figure out what is different between your
>> test and mine. Perhaps I misdiagnosed to begin with?
>>
> 
> No, it doesn't quite seem like I misdiagnosed, but your test had
> different expectations than I have after reading the documentation. I
> expected core.autocrlf=true + core.eol=lf to pretty much be identical
> to core.autocrlf=false, but only because LF->LF conversion is a NOP.
> 
> 'core.autocrlf' is documented as meaning the same as setting the
> 'text' attribute to 'auto' for all files, plus "files that contain
> CRLF in the repository will not be touched". I figured that last part
> shouldn't affect me as I only had LFs in the repository.
> 
> If I disable core.autocrlf, I get what I want (no matter what I set
> core.eol to, it seems). But I still don't understand WHY
> core.autocrlf=true + core.eol=lf outputs CRLF.
> 
> It seems to me that there's a big gap between what the documentation
> claims and what actually happens here.

Having stared a bit at the test results, I think you only need to accept
that setting core.autocrlf=true during output overrules any core.eol
setting and gives you CRLF line endings no matter what's in the repository.

core.autocrlf=input overrules core.eol, too, in that no output conversion
takes place, no matter what the latter is set to.

I don't know if this is intended or even useful -- I don't use the options
myself, so I don't grok the possible use cases.  Perhaps something like
this can help?  Or do we need code changes?


diff --git a/Documentation/config.txt b/Documentation/config.txt
index ff7c225..6082f77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -202,7 +202,7 @@ core.eol::
 	'lf', 'crlf' and 'native', which uses the platform's native
 	line ending.  The default value is `native`.  See
 	linkgit:gitattributes[5] for more information on end-of-line
-	conversion.
+	conversion.  This variable is ignored if `core.autocrlf` is set.
 
 core.safecrlf::
 	If true, makes git check if converting `CRLF` is reversible when
@@ -257,7 +257,8 @@ core.autocrlf::
 	setting if you want to have `CRLF` line endings in your
 	working directory even though the repository does not have
 	normalized line endings.  This variable can be set to 'input',
-	in which case no output conversion is performed.
+	in which case no output conversion is performed.  This variable
+	overrules `core.eol`.
 
 core.symlinks::
 	If false, symbolic links are checked out as small plain files that
