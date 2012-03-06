From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Tue, 06 Mar 2012 10:49:06 -0800
Message-ID: <7vaa3ttvj1.fsf@alter.siamese.dyndns.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
 <1330903437-31386-2-git-send-email-greened@obbligato.org>
 <87aa3vzdoc.fsf@thomas.inf.ethz.ch> <nngy5re29zn.fsf@transit.us.cray.com>
 <878vje86cy.fsf@thomas.inf.ethz.ch> <87mx7tiyhh.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, "David A. Greene" <dag@cray.com>,
	<git@vger.kernel.org>
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Tue Mar 06 19:49:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4zRk-0001bR-8o
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 19:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025Ab2CFStK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 13:49:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965017Ab2CFStJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 13:49:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2645552B;
	Tue,  6 Mar 2012 13:49:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jcqZIccMtdEYykf/qXggavB8edw=; b=e9vRbn
	2esWzXat1KBjEhGcacZAbG+qbjCLpep9om6Dm3WkOBQSeIpGCSrMzVGKarG9Xbr4
	FwLOkSX2iHB10vOjsLhXhe7jTfchWeWlXDCDOx65vhTN3Y541AcUMCRTqYRwp4si
	QZXWrcBUsZrJ3EqqkQPi0458aIMTEI+3kd0/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dvxOlkAuMuGWh9vAOKQObu0+Nb7UFw3l
	JYwGwaRFtViOUYGu43rXRsqqyqOx5LqayyHv7l4FwxEA4vgcBGNOkAxLqlvibOME
	0jd84ZVhMozuHvhw3l4PmmB1gwpgqec5lq/MRxTPRz8S/a6uL0LYQq2JHgZ32qah
	nJSwqZSYCoA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6D71552A;
	Tue,  6 Mar 2012 13:49:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A15B5529; Tue,  6 Mar 2012
 13:49:07 -0500 (EST)
In-Reply-To: <87mx7tiyhh.fsf@smith.obbligato.org> (David A. Greene's message
 of "Tue, 06 Mar 2012 08:40:42 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E1E648A-67BD-11E1-A660-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192374>

greened@obbligato.org (David A. Greene) writes:

>> Don't we, right now, get stuff as follows:
>>
>>   item                   path
>>   --------------------------------------------
>>   test-lib.sh            $TEST_DIRECTORY
>
> Right now, yes, but it breaks for out-of-tree tests.  In the out-of-tree
> case, TEST_DIRECTORY doesn't contain test-lib.sh.  For exmaple, in

Could it be that the reason for the breakage is because you are
setting TEST_DIRECTORY to the directory that contains out-of-tree
tests, instead of $GIT_BUILD_DIR/t/ directory?

The place you perform your operations are relative to $TRASH_DIRECTORY,
and you would still find the main git relative to $GIT_BUILD_DIR.

Shouldn't TEST_DIRECTORY merely a short-hand for GIT_BUILD_DIR/t?
What do you find relative to $TEST_DIRECTORY that cannot be found
relative to GIT_BUILD_DIR/t?
