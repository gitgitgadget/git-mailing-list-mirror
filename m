From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t4203 (mailmap): stop hardcoding commit ids and dates
Date: Fri, 15 Oct 2010 12:12:19 -0500
Message-ID: <20101015171219.GC10204@burratino>
References: <87tyksd9er.fsf@meyering.net>
 <20101011162153.GG25842@burratino>
 <AANLkTimpN5CAC5UbhC2Kydhu_BMouriQn1d6OL5vt09m@mail.gmail.com>
 <20101015061821.GE21830@burratino>
 <20101015075954.GA8557@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 19:15:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6nsr-0000SF-E8
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 19:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab0JORPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 13:15:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64825 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161Ab0JORPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 13:15:50 -0400
Received: by ewy20 with SMTP id 20so1239882ewy.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=y33mOOrIdkQGxXqD/QjU6qLm+cFgbdxSFfk+VVV0yX4=;
        b=aVYaVfzru5rPe5qJYiR0bLBvb/oTltxxE1o0oYf8Purn6/BNL/uT7qjaFoWiO8v1jO
         HXYsfujKKQVNkkROuOyABXOZezQgmvTsysqcERDd+8SF2e0kb2IaKCQ5cbF1kYvuXriR
         0gn5OlM51CkGfI3lYYh916lEkLsrOnAwOtHfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QEg5azqlyP4U53G24/ADXs+ouBxEVeol4MGcnjLrvDuXUEIeY4Bd02Qo7kNs5RZyxe
         KlRGTySGeTc4ihNbp8hAVhmrVvWbRM9Mv3PlxKWU3/y01KHRoSiivsRmaEiNhgMkBSV0
         sLCGauRcBCrN67SnyrgD8YEbHZWqIkNenJ2Sc=
Received: by 10.14.53.7 with SMTP id f7mr132099eec.34.1287162948978;
        Fri, 15 Oct 2010 10:15:48 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q51sm4568240eeh.10.2010.10.15.10.15.46
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 10:15:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101015075954.GA8557@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159126>

A seemingly innocuous change like adding test_tick somewhere can
completely upset the final mailmap test, since it checks commit
hashes and dates.  Make the test less fragile by fuzzing away the
unpredictable parts and leaving in the authors (which is what the
test is about, anyway).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -11,7 +11,6 @@ test_expect_success setup '
>  	git commit -m initial &&
>  	echo two >>one &&
>  	git add one &&
> -	test_tick &&
>  	git commit --author "nick1 <bugs@company.xx>" -m second
>  '

Here's a better fix.  Still no idea about the other failures =C3=86var
and Thomas were seeing.

 t/t4203-mailmap.sh |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 3c5188f..9198b30 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -4,6 +4,14 @@ test_description=3D'.mailmap configurations'
=20
 . ./test-lib.sh
=20
+fuzz_blame () {
+	sed "
+		s/$_x05[0-9a-f][0-9a-f][0-9a-f]/OBJID/g
+		s/$_x05[0-9a-f][0-9a-f]/OBJI/g
+		s/[-0-9]\{10\} [:0-9]\{8\} [-+][0-9]\{4\}/DATE/g
+	" "$@"
+}
+
 test_expect_success setup '
 	echo one >one &&
 	git add one &&
@@ -232,18 +240,18 @@ test_expect_success 'Log output (complex mapping)=
' '
=20
 # git blame
 cat >expect <<\EOF
-^3a2fdcb (A U Thor     2005-04-07 15:13:13 -0700 1) one
-7de6f99b (Some Dude    2005-04-07 15:13:13 -0700 2) two
-5815879d (Other Author 2005-04-07 15:14:13 -0700 3) three
-ff859d96 (Other Author 2005-04-07 15:15:13 -0700 4) four
-5ab6d4fa (Santa Claus  2005-04-07 15:16:13 -0700 5) five
-38a42d8b (Santa Claus  2005-04-07 15:17:13 -0700 6) six
-8ddc0386 (CTO          2005-04-07 15:18:13 -0700 7) seven
+^OBJI (A U Thor     DATE 1) one
+OBJID (Some Dude    DATE 2) two
+OBJID (Other Author DATE 3) three
+OBJID (Other Author DATE 4) four
+OBJID (Santa Claus  DATE 5) five
+OBJID (Santa Claus  DATE 6) six
+OBJID (CTO          DATE 7) seven
 EOF
-
 test_expect_success 'Blame output (complex mapping)' '
 	git blame one >actual &&
-	test_cmp expect actual
+	fuzz_blame actual >actual.fuzz &&
+	test_cmp expect actual.fuzz
 '
=20
 test_done
--=20
1.7.2.3
