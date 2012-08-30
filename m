From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/3] Improve branch UI for setting upstream information
Date: Thu, 30 Aug 2012 10:37:01 -0700
Message-ID: <7v1uios2ma.fsf@alter.siamese.dyndns.org>
References: <1346347393-8425-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 19:37:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T78g9-0008F2-Qd
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab2H3RhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Aug 2012 13:37:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab2H3RhE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2012 13:37:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE30B9ACB;
	Thu, 30 Aug 2012 13:37:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hkayX/86laSo
	zW7SxcQMukGgekA=; b=noJe03d2wT5zw4PcU/aKmbDLdGr0Xlu617NeRehWOz0K
	/ir2jKI/VvXFC0woE0e8ujK+qejlqh/fpcBNqHgCo7fPQtK/2EWikfzEI2NmD4iy
	BiRlQUnsY+0xwnuId08h7ZnIN7T4rozIRawkkIyB3Ofu61ZpemrfIVY1Drf0ma4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w4FWlE
	vJE788Vv86jV5Nfmt2TNzdiG0PSrF9rIlbPdsbHdPaoPrA/kw/q1ZY7jTWEyyl2Q
	zkss5+oAWRc1Oiq3P4yNvAJWyuGuQbCJIsgpRzwEprbFWgZxI9XnzKrarNbT85KD
	4jpuJSDEt4EPzuG+A29Vj0knh6bSVdcylNr10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B4B69ACA;
	Thu, 30 Aug 2012 13:37:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F20189AC7; Thu, 30 Aug 2012
 13:37:02 -0400 (EDT)
In-Reply-To: <1346347393-8425-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Thu, 30 Aug 2012 19:23:10
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F435B04-F2C9-11E1-887E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204559>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> As a result of making --unset-upstream fail if the given branch
> doesn't exist, I discovered a copy-paste error in on the the tests in
> the patch after it, so I'm resending the whole thing.
>
> The changes from the last reroll are the tightening of the situations
> where git will show an error message (not it's just if the branch is
> new and exists as remote-tracking) which I already sent as a reply in
> the other thread; and making --unset-upstream error out on bad input,
> which I already mentioned above.

Thanks.

In addition to "--unset-upstream must fail on i-dont-exist branch"
in [2/3], I am wondering if we would want to also make sure the
command fails when the upstream information is not set for the
branch, i.e. something like the following on top.

What do you think?

 t/t3200-branch.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git i/t/t3200-branch.sh w/t/t3200-branch.sh
index 1018e8b..a0aaedd 100755
--- i/t/t3200-branch.sh
+++ w/t/t3200-branch.sh
@@ -393,7 +393,9 @@ test_expect_success 'test --unset-upstream on HEAD'=
 \
      git branch --set-upstream-to my14 &&
      git branch --unset-upstream &&
      test_must_fail git config branch.master.remote &&
-     test_must_fail git config branch.master.merge'
+     test_must_fail git config branch.master.merge &&
+     test_must_fail git branch --unset-upstream
+'
=20
 test_expect_success 'test --unset-upstream on a particular branch' \
     'git branch my15
