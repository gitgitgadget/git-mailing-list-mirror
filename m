From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] new git check-ignore sub-command
Date: Mon, 24 Sep 2012 15:31:33 -0700
Message-ID: <7v7grjxdbu.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 00:31:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGHBs-0002Tb-Id
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 00:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884Ab2IXWbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 18:31:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54980 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778Ab2IXWbi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 18:31:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E8BB832E;
	Mon, 24 Sep 2012 18:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t3KbxSUKQnvnEuej4SgqMTNBjoI=; b=Gox+5T
	v/HDU2UxjNNE8ATNw1rgCoyrOBgVMD8R36B7Et5CrUdHgQ077qg1cudrrCtwApaG
	wzWB4imKcwByr6AH7kLWR4/eJAj5C28WUE4Y0iizE/JgoSXwE2qGxbLR6bvTbAih
	SrFsUCWuTRAh1rP3wxAd/f3ygIM4kH66n2R/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YtIa5reBa+eJ+KzVmZf52u3cvXkhfeNc
	NeQLX3OCepy8NSfN9G0IRQj7si9Azbj1P19h0BnTjHx6kbo3yQ2PHOX57J2YOrxn
	xHE6K6mtEf5YrgbP5sFqY4o1IrkgLgha9O8pmsp3yWNRiVvHGY7jMl5i1CtUWWTU
	s9WYaSuiO/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C92D832D;
	Mon, 24 Sep 2012 18:31:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 679DD832C; Mon, 24 Sep 2012
 18:31:35 -0400 (EDT)
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 20 Sep 2012 20:46:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 992E8CFC-0697-11E2-B4E4-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206331>

Adam Spiers <git@adamspiers.org> writes:

>  t/t0007-ignores.sh                                | 587 ++++++++++++++++++++++

I needed this to make it pass the test. I didn't see anything that
is passed to expect_in via $text that would benefit from "echo -e"
but I did not look too carefully; you may have had a reason to write
"-e" there, and this patch may break for somebody else (namely, you),
in which case please explain and justify the use of "-e" better. We
need a solution that does not rely on the bash-ism.

Thanks.

-- >8 --

"echo -e" is a bash-ism that does not seem to be needed in the
context of this test (both bash and dash passes the test without
the extraneous "-e", but having "-e" breaks test run under dash).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0007-ignores.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0007-ignores.sh b/t/t0007-ignores.sh
index a0f571e..7fd7e53 100755
--- a/t/t0007-ignores.sh
+++ b/t/t0007-ignores.sh
@@ -19,7 +19,7 @@ expect_in () {
 	then
 		>"$dest" # avoid newline
 	else
-		echo -e "$text" >"$dest"
+		echo "$text" >"$dest"
 	fi
 }
 
-- 
1.7.12.1.451.gb433296
