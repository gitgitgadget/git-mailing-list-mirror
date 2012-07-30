From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 10:51:52 -0700
Message-ID: <7vobmxqgqv.fsf@alter.siamese.dyndns.org>
References: <1343664610-479-1-git-send-email-dangra@gmail.com>
 <7v6295rxmb.fsf@alter.siamese.dyndns.org>
 <CAHCkQtPmJdFBk7G-EP70FwtkRk11Utp+rppjNrEZFtZgOVrObA@mail.gmail.com>
 <7vsjc9qh33.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:52:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svu8P-0006vg-4Z
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab2G3Rv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 13:51:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071Ab2G3Rvz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 13:51:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F6DF9E82;
	Mon, 30 Jul 2012 13:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ssX0MnupsEuo
	MCeWOsgNBudisuo=; b=lvlUtfFiqh41GcELj179eCM1PJBYUhTEtqZY69QKxZbD
	1bq4kSXgWxr/6Wyggyev8koZjjPyR5tCY7qWe1yC4Qq9BeMlGdVhxEup8oz0Od7w
	n6TEo6Eg/V7EF7Lnr3jLtzNdfbKvV2Ohgn+6C7LM1SK0YFtQSh0HNCkG2Z7sS9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cOk3Fd
	0t1E5A6dhwprOmA0LnamZy/o0Wozu0k1bs4lioPjh/jEXxplktyexmT45ABmpVSx
	HJ0pfnB2JcmkEyO7JT9l6hc9efafVvUMuphslfsmTDBAZ+6jM7NRVfffOuEJajgT
	zMz3dkeycmETHvjazAS7wE6bmVY8ZY8WElS3A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DA069E81;
	Mon, 30 Jul 2012 13:51:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 302DD9E80; Mon, 30 Jul 2012
 13:51:54 -0400 (EDT)
In-Reply-To: <7vsjc9qh33.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 30 Jul 2012 10:44:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FAAC302-DA6F-11E1-A13E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202595>

Junio C Hamano <gitster@pobox.com> writes:

> Daniel Gra=C3=B1a <dangra@gmail.com> writes:
> ...
>> is it still better than "git rev-parse --max-count=3D1 HEAD" seen in
>> t7406-submodule.update.sh?
>
> "git rev-parse --max-count=3D1 HEAD" will show "--max-count=3D1\n"
> followed by the value of HEAD, so if the expected result and the
> actual result were both prepared by that command, the comparison
> would succeed (as the irrelevant --max-count=3D1 line will appear in
> both output), but honestly, I do not think it makes any sense.

Thanks for noticing; I'll queue this.

-- >8 --
Subject: [PATCH] t7406: fix misleading "rev-parse --max-count=3D1 HEAD"

The test happened to use "rev-parse --max-count=3D1 HEAD" consistently
to prepare the expected output and the actual output, so the
comparison between them gave us a correct success/failure because
both output had irrelevant "--max-count=3D1" in it.

But that is not an excuse to keep it broken.  Replace it a more
meaningful construct "rev-parse --verify HEAD".

Noticed by Daniel Gra=C3=B1a while working on his submodule tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7406-submodule-update.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 807f761..f4e6602 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -305,7 +305,7 @@ test_expect_success 'submodule update continues aft=
er checkout error' '
 	 git submodule init &&
 	 git commit -am "new_submodule" &&
 	 (cd submodule2 &&
-	  git rev-parse --max-count=3D1 HEAD > ../expect
+	  git rev-parse --verify HEAD >../expect
 	 ) &&
 	 (cd submodule &&
 	  test_commit "update_submodule" file
@@ -322,7 +322,7 @@ test_expect_success 'submodule update continues aft=
er checkout error' '
 	 git checkout HEAD^ &&
 	 test_must_fail git submodule update &&
 	 (cd submodule2 &&
-	  git rev-parse --max-count=3D1 HEAD > ../actual
+	  git rev-parse --verify HEAD >../actual
 	 ) &&
 	 test_cmp expect actual
 	)
@@ -351,7 +351,7 @@ test_expect_success 'submodule update continues aft=
er recursive checkout error'
 	  test_commit "update_submodule_again_again" file
 	 ) &&
 	 (cd submodule2 &&
-	  git rev-parse --max-count=3D1 HEAD > ../expect &&
+	  git rev-parse --verify HEAD >../expect &&
 	  test_commit "update_submodule2_again" file
 	 ) &&
 	 git add submodule &&
@@ -366,7 +366,7 @@ test_expect_success 'submodule update continues aft=
er recursive checkout error'
 	 ) &&
 	 test_must_fail git submodule update --recursive &&
 	 (cd submodule2 &&
-	  git rev-parse --max-count=3D1 HEAD > ../actual
+	  git rev-parse --verify HEAD >../actual
 	 ) &&
 	 test_cmp expect actual
 	)
@@ -398,12 +398,12 @@ test_expect_success 'submodule update exit immedi=
ately in case of merge conflict
 	 ) &&
 	 git checkout HEAD^ &&
 	 (cd submodule2 &&
-	  git rev-parse --max-count=3D1 HEAD > ../expect
+	  git rev-parse --verify HEAD >../expect
 	 ) &&
 	 git config submodule.submodule.update merge &&
 	 test_must_fail git submodule update &&
 	 (cd submodule2 &&
-	  git rev-parse --max-count=3D1 HEAD > ../actual
+	  git rev-parse --verify HEAD >../actual
 	 ) &&
 	 test_cmp expect actual
 	)
@@ -432,12 +432,12 @@ test_expect_success 'submodule update exit immedi=
ately after recursive rebase er
 	 ) &&
 	 git checkout HEAD^ &&
 	 (cd submodule2 &&
-	  git rev-parse --max-count=3D1 HEAD > ../expect
+	  git rev-parse --verify HEAD >../expect
 	 ) &&
 	 git config submodule.submodule.update rebase &&
 	 test_must_fail git submodule update &&
 	 (cd submodule2 &&
-	  git rev-parse --max-count=3D1 HEAD > ../actual
+	  git rev-parse --verify HEAD >../actual
 	 ) &&
 	 test_cmp expect actual
 	)
--=20
1.7.12.rc0.80.gb93a609
