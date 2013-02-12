From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: do not export mandir/htmldir/infodir
Date: Tue, 12 Feb 2013 15:09:53 -0800
Message-ID: <7vehgldt8e.fsf_-_@alter.siamese.dyndns.org>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com> <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
 <7vip5xdtt6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:10:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Ozk-00006J-Si
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758849Ab3BLXKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:10:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758831Ab3BLXKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:10:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9A8EC2B5;
	Tue, 12 Feb 2013 18:10:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aHIeg8L/a/GkAHC22+NAg+zQJWQ=; b=TDgnRc
	QmfqPsy8kugtgCRbPXgmHzDk3pweVMMUy+gXV7Shaxldvf5n3ZBkGe6IkI9WkPJa
	JU00OBMw5L7ej5YBPm4+LrsJy4pZ1qnV8UfcBCBi1Gvl5TlPkJ5iwaSTq/dPEFPl
	o1CbabnZVOAgx3L/mack7IAf3TBmEeI9BWDGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s2lB0QPtMDA82m/R8ChtTNHIOkh5wIMl
	qC/o1jggSUpebvolbdCDGaqt03lAsUL2m5nkep0NG7o9X3cqyiiU8TKc7C257KQE
	e547+vBKQmOqleqa3aZu3tLAyZUKkNdv1draOAnj3z6BzhzKBUUFwrrnLxsiBMyl
	2rYJdqmKFxM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3377BC2AE;
	Tue, 12 Feb 2013 18:10:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4456BC29C; Tue, 12 Feb 2013
 18:10:02 -0500 (EST)
In-Reply-To: <7vip5xdtt6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Feb 2013 14:57:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56DE166A-7569-11E2-A032-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216218>

These are defined in the main Makefile to be funny values that are
optionally relative to an unspecified location that is determined at
runtime.  They are only suitable for hardcoding in the binary via
the -DGIT_{MAN,HTML,INFO}_PATH=<value> C preprocessor options, and
are not real paths, contrary to what any sane person, and more
importantly, the Makefile in the documentation directory, would
expect.

A longer term fix is to introduce runtime_{man,html,info}dir variables
to hold these funny values, and make {man,html,info}dir variables
to have real paths whose default values begin with $(prefix), but
as a first step, stop exporting them from the top-level Makefile.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1dae2c5..26b697d 100644
--- a/Makefile
+++ b/Makefile
@@ -359,7 +359,7 @@ lib = lib
 # DESTDIR=
 pathsep = :
 
-export prefix bindir sharedir mandir htmldir sysconfdir gitwebdir localedir
+export prefix bindir sharedir sysconfdir gitwebdir localedir
 
 CC = cc
 AR = ar
-- 
1.8.1.3.675.g524d3b9
