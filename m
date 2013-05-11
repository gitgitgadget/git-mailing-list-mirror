From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-bzr: Do not use unportable sed "\+"
Date: Sat, 11 May 2013 12:45:10 -0700
Message-ID: <7vobchwbax.fsf@alter.siamese.dyndns.org>
References: <201305111525.53130.tboegi@web.de>
	<7vwqr5wdqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: felipe.contreras@gmail.com, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 11 21:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbFjY-0001zI-Q0
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 21:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab3EKTpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 15:45:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53507 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364Ab3EKTpN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 15:45:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB4211EC6F;
	Sat, 11 May 2013 19:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jFekp4ywjyoDu2REPZGr5r1+djQ=; b=R3Xsm3
	2QGEnslYe/yE+CJle0MxY4JFbPc2eh9ttEyy9LOr1DLxIJEdeDUHm5dmut+o6RFf
	VXFYZMCQKPyk6tPsxPa50VxCOYweiiy8SV+rEFfjE5Ach7N25ltGRHC1V3KGnzPb
	njOhkLeKlKBqGJ6hRdOBjdXheJn6lRTeP67sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=THYWgJaA2txeYjK9XpguIsGz9uI0OzRM
	tgPEKFGfss7GVhBZD8724va0v/n7HA3iiIsMZcaW9Y+KUihBpK09FwS49v6drpdo
	G5bkvxxpjR+UKbISbkBtW3avYc90xsnx3Wji6xUvGza+VEeIPAcPEXDuADc5Fck/
	HoCk0W2alzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C37561EC6E;
	Sat, 11 May 2013 19:45:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B1E01EC6D;
	Sat, 11 May 2013 19:45:12 +0000 (UTC)
In-Reply-To: <7vwqr5wdqm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 11 May 2013 11:52:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B4CE836-BA73-11E2-BE72-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224004>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  Is there another one in t/t5551-http-fetch.sh that checks
> the tags?

I think your sed will see the same breakage for the one in 5551 (my
sed is unfortunately GNU and ".\+" does not break it).  Could you
test this patch with:

     GIT_TEST_LONG=YesPlease GIT_TEST_HTTPD=YesPlease \
     ./t5551-http-fetch.sh

Thanks.

 t/t5551-http-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index b23efbb..4a3184e 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -209,7 +209,7 @@ test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
 
 	# now assign tags to all the dangling commits we created above
 	tag=$("$PERL_PATH" -e "print \"bla\" x 30") &&
-	sed -e "s/^:\(.\+\) \(.\+\)$/\2 refs\/tags\/$tag-\1/" <marks >>packed-refs
+	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
 	)
 '
 
