From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Tue, 2 Aug 2011 00:01:03 +0530
Message-ID: <CALkWK0npaR+FESUEBUJv_pyL1prshBBy9MifOn6UUG8rDOJnXQ@mail.gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com> <1312222025-28453-18-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:31:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnxGz-0003G5-Oi
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab1HASbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 14:31:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65382 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1HASbY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 14:31:24 -0400
Received: by wyg8 with SMTP id 8so1799594wyg.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=uTyVMEnyax0O/FpYMKAO3WMnUhi9JWQo/bol7FZYAHM=;
        b=U51XrSDOEoMjHGqBE0mkFcE+0CmqRVBplC9VsFLaaFJuapq3hs3qXoOa/5EWToyBb4
         nIbFjn2bT/ibD031JvNfz7L9yi22iNFsQuWvFPjaCnejYmMoldDrCxRqqf6H0MhG2ssJ
         iRTb7blkB2LNaBW6cU7eCk71AkujNq7ZrTylU=
Received: by 10.216.82.205 with SMTP id o55mr956543wee.64.1312223483133; Mon,
 01 Aug 2011 11:31:23 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 1 Aug 2011 11:31:03 -0700 (PDT)
In-Reply-To: <1312222025-28453-18-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178398>

Hi again,

Ramkumar Ramachandra writes:
> +test_expect_success 'malformed instruction sheet 1' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick base..anotherpi=
ck &&
> + =C2=A0 =C2=A0 =C2=A0 echo "resolved" >foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 git commit &&
> + =C2=A0 =C2=A0 =C2=A0 sed "s/pick /pick/" .git/sequencer/todo >new_s=
heet
> + =C2=A0 =C2=A0 =C2=A0 cp new_sheet .git/sequencer/todo
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick --continue
> +'

Ugh.  I forgot to chain using '&&' .

> +test_expect_success 'malformed instruction sheet 2' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick base..anotherpi=
ck &&
> + =C2=A0 =C2=A0 =C2=A0 echo "resolved" >foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 git commit &&
> + =C2=A0 =C2=A0 =C2=A0 sed "s/pick/revert/" .git/sequencer/todo >new_=
sheet
> + =C2=A0 =C2=A0 =C2=A0 cp new_sheet .git/sequencer/todo
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick --continue
> +'

Here too.

Please squash this in while reading -- thanks :)
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequ=
ence.sh
index 457ad76..626136a 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -195,8 +195,8 @@ test_expect_success 'malformed instruction sheet 1'=
 '
 	echo "resolved" >foo &&
 	git add foo &&
 	git commit &&
-	sed "s/pick /pick/" .git/sequencer/todo >new_sheet
-	cp new_sheet .git/sequencer/todo
+	sed "s/pick /pick/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
 	test_must_fail git cherry-pick --continue
 '

@@ -206,8 +206,8 @@ test_expect_success 'malformed instruction sheet 2'=
 '
 	echo "resolved" >foo &&
 	git add foo &&
 	git commit &&
-	sed "s/pick/revert/" .git/sequencer/todo >new_sheet
-	cp new_sheet .git/sequencer/todo
+	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
 	test_must_fail git cherry-pick --continue
 '

-- Ram
