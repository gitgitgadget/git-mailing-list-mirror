From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9010 fails when no svn is available
Date: Wed, 08 Dec 2010 22:53:59 -0800
Message-ID: <7vmxofh1x4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 07:54:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQaON-0001Ei-UM
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 07:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab0LIGyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 01:54:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab0LIGyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 01:54:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 557E629E8;
	Thu,  9 Dec 2010 01:54:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=w4Y0
	gHU8kzACokDwkh00oFxZYzw=; b=fDiP9cXG+OlEDZtiJpReVdcCjNDNWU58xwN1
	GiyyVAjrfm19JjpkJGivlQf9jw4wsDOvlUzNrhaX2oOYE4a6/ODgNNs31BBXLnWC
	RzYpIeRupFncCYJfyrjZa26PT/o5m8YBrjAP0Olonf/yTxOBfzySb84bbIzp+6/R
	3cxrWDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	cxv3DbQSOKfoB+6+rc/DrEr0lxLYP3DkWqbTZylvZphQliiy4e7+5EaSQgZINUgE
	LmUmITcr1MJ660CXScls7RBut997ulsHd+Sr5DXjvoguKt2PPfsKPKuoN/w66qQ0
	k6yeiCbxqKrzboTVPnrBuMW5F78f9cOHmbrBNNyy1QI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F52029E6;
	Thu,  9 Dec 2010 01:54:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 44D5829E5; Thu,  9 Dec 2010
 01:54:24 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A8A86CE-0361-11E0-BC2E-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163272>

Running test t9010 without svn currently errors out for no good reason.

The test uses "svnadmin" without checking if svn is available.  This was a
regression introduced by b0ad24b (t9010 (svn-fe): Eliminate dependency on
svn perl bindings, 2010-10-10) when it stopped including ./lib-git-svn.sh
that had the safety.

This should fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9010-svn-fe.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index fd851a4..faf9092 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -4,6 +4,12 @@ test_description='check svn dumpfile importer'
 
 . ./test-lib.sh
 
+if ! svnadmin -h >/dev/null 2>&1
+then
+	skip_all='skipping svn-fe tests, svn not available'
+	test_done
+fi
+
 svnconf=$PWD/svnconf
 export svnconf
 
