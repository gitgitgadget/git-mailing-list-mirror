From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5505-remote.29 not working correctly
Date: Mon, 15 Mar 2010 22:16:06 -0700
Message-ID: <7v7hpcvobt.fsf@alter.siamese.dyndns.org>
References: <OGVB8d37MB-s4H3VOECmd2htUvpq3B4NginojN-XskLyvHmnbfGA4Q@cipher.nrlssc.navy.mil> <7vwrxdueug.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Mar 16 06:16:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrP8j-0002BW-4w
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab0CPFQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:16:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab0CPFQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:16:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87FF0A252D;
	Tue, 16 Mar 2010 01:16:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7dRUhrPivdPw7XWTrfVOkJ7IsFw=; b=tkCkKV
	fmEWIW3tDsKX4NwqIjdEHT92WrJelfvUqtjyjUQsWaJd6uQ9PumIzkZmxVBxupry
	+GE4i4z2D8iAMXhrSTmnFdiU0Ne9rCJxuP883G/9Ql+tpUl7Drzp4gJRl9TlDg/o
	WzjE2UuJaTQQ9/QiM2OEeEEIaTHIug554Xb2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qCsAYV5sfs/SQAfQCPx5QbanK5EkYBni
	4T8xkg7MJz6wnOZ/yBU+r+V1fuDJrsqyaeQdjUeUQsVNLo5SMazhEGNRhq6CwHeb
	7ZIUhPAV6WWSghvF0LvykAN1lzzR61babEsS6iVFOMAR+3ZFZnhBRLDc9Y2oonCG
	LWiJuXim5fU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 65D85A252B;
	Tue, 16 Mar 2010 01:16:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2C25A252A; Tue, 16 Mar
 2010 01:16:07 -0400 (EDT)
In-Reply-To: <7vwrxdueug.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 15 Mar 2010 20\:26\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 087D6C64-30BB-11DF-8628-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142300>

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
>
>> The test titled 'remote prune to cause a dangling symref' is
>> not linked together with &&'s.  When the &&'s are added, it
>> does not complete successfully.
>
> Hmm, it looks like f8948e2 (remote prune: warn dangling symrefs,
> 2009-02-08) is internally inconsistent.  This is a fix directly on top of
> that commit.

Actually this is a bit deeper than that.  We don't get _any_ output to
either standard output nor standard error with the recent code.

If we change the test to:

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a82c5ff..ca88e29 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -507,8 +507,8 @@ test_expect_success 'remote prune to cause a dangling symref' '
 	(
 		cd seven &&
 		git remote prune origin
-	) 2>err &&
-	grep "has become dangling" err &&
+	) >err 2>&1 &&
+	grep "has become dangling" err || exit
 
 	: And the dangling symref will not cause other annoying errors
 	(

so it does not matter whether the output is set to standard output or
standard error, we can bisect this, which points at eafb452 (do_one_ref():
null_sha1 check is not about broken ref, 2009-07-22).

v1.6.3 and onwards seem to be broken.
