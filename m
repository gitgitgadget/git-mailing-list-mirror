From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 195b7ca6 breaks t9010 at current master
Date: Mon, 28 Mar 2011 23:24:46 -0500
Message-ID: <20110329042446.GB25693@elie>
References: <AANLkTik0CNXY9bKGOa9Xmai_OPQgExfLsFs1yN2pCVr8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 06:24:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4QUF-0007Eb-1B
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 06:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab1C2EYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 00:24:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39160 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab1C2EYx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 00:24:53 -0400
Received: by ywj3 with SMTP id 3so1451469ywj.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 21:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IRmSuV53oUmetui7HNCO70cmwj5gF8v60GdKc386HAw=;
        b=rtTcSNBtXfHq6n0n+/54LVjxquPWXnm3bF1VPjBKCnCqgkl8n0bagjd1BCrLXMo5Nf
         pvAcxFCGM5S91ohVA7kiazusa3ONVnGmaEm+u1AYaPO9oFr3uddq00sfuRcl0dsABMQB
         4UjsYu/8IiA4dqns69VcSOb6D/Uens6/gQv+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=P1zR8pR+7Iy9kPcIWj8UQ4J+/XYfZqx7X9V3C6G/zoijardE7sHP1f1UaCfmN4rv0r
         rBDHoiIRufjUU2r9gxHrqnQkHQurhR2GOV0h/Fd3rX6KePJhoS6yLceWRb6pkI/80ynZ
         eIoh6udS8rFm4ZNg0hvAU8nYRCzrRiXMz/6/4=
Received: by 10.236.73.201 with SMTP id v49mr2643110yhd.339.1301372692694;
        Mon, 28 Mar 2011 21:24:52 -0700 (PDT)
Received: from elie (adsl-76-206-232-54.dsl.chcgil.sbcglobal.net [76.206.232.54])
        by mx.google.com with ESMTPS id x63sm2319312yhn.4.2011.03.28.21.24.50
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 21:24:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik0CNXY9bKGOa9Xmai_OPQgExfLsFs1yN2pCVr8@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170221>

Hi,

=C3=98yvind A. Holm wrote:

> When running "make test" at current master (v1.7.4.2-406-gbe919d5),
> t9010-svn-fe.sh fails. Bisecting shows that 195b7ca6 ("vcs-svn: handl=
e
> log message with embedded NUL") breaks the test.

Could you try with the following patch applied?  It comes from
squashing the last two patches from the svn-fe branch:

* tests: make sure input to sed is newline terminated
* vcs-svn: add missing cast to printf argument

Sorry for the breakage.
---
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 478c860..6f6175a 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -407,7 +407,7 @@ test_expect_success 'NUL in log message, file conte=
nt, and property name' '
 	OBJID
 	:000000 100644 OBJID OBJID A	greeting
 	EOF
-	printf "\n%s" "something with an ASCII NUL (Q)" >expect.message &&
+	printf "\n%s\n" "something with an ASCII NUL (Q)" >expect.message &&
 	printf "%s\n" "helQo" >expect.hello1 &&
 	printf "%s\n" "link hello" >expect.hello2 &&
 	{
@@ -465,7 +465,11 @@ test_expect_success 'NUL in log message, file cont=
ent, and property name' '
 		git diff-tree --root --stdin |
 		sed "s/$_x40/OBJID/g"
 	} >actual &&
-	git cat-file commit HEAD | nul_to_q | sed -ne "/^\$/,\$ p" >actual.me=
ssage &&
+	{
+		git cat-file commit HEAD | nul_to_q &&
+		echo
+	} |
+	sed -ne "/^\$/,\$ p" >actual.message &&
 	git cat-file blob HEAD^:greeting | nul_to_q >actual.hello1 &&
 	git cat-file blob HEAD:greeting | nul_to_q >actual.hello2 &&
 	test_cmp expect actual &&
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 2e5bb67..99ed70b 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -51,7 +51,8 @@ void fast_export_commit(uint32_t revision, const char=
 *author,
 		   *author ? author : "nobody",
 		   *author ? author : "nobody",
 		   *uuid ? uuid : "local", timestamp);
-	printf("data %"PRIuMAX"\n", log->len + strlen(gitsvnline));
+	printf("data %"PRIuMAX"\n",
+		(uintmax_t) (log->len + strlen(gitsvnline)));
 	fwrite(log->buf, log->len, 1, stdout);
 	printf("%s\n", gitsvnline);
 	if (!first_commit_done) {
--=20
