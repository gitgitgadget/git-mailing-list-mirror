From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/14] Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual
 C++
Date: Fri, 21 Aug 2009 15:11:47 -0700
Message-ID: <7vfxbkbyvw.fsf@alter.siamese.dyndns.org>
References: <cover.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 <7vr5v4dgz0.fsf@alter.siamese.dyndns.org> <200908212341.37531.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Marius Storm-Olsen" <mstormo@gmail.com>,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 00:12:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MecLG-00023P-MJ
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 00:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932869AbZHUWME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 18:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932859AbZHUWMD
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 18:12:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390AbZHUWMC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 18:12:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6491213F07;
	Fri, 21 Aug 2009 18:12:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NW69cbqp6L9GQDXDvKUY1ngF0DM=; b=ffE30w
	sksUW4LZAgfNOkg2KvXiDBHrSRqDmwbiTDkX7E9b3HmavSpRNP9k65cXGztAJbOu
	U2E4r6naqLq3rp9dn1YzSOxYGj3f2T5bQY40Zr9SzHj7qf+GsKiyuX108/FsamCH
	ratHR71HgFFiROUASbnuaJgRqrq+jZX+gLHpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cv1kCpZmrT9VisoZZurTz5p7SOnwe8tV
	LGC5lLbyJ8dbDmBL5kMob4c9nFDHyiAAQmN0VYzO8UbpLnBBd7slUn5G3ryRsIkV
	ZbNgseV7KHgOkJG6rPyCIwKLiuIU0cQOxBLrpDx9cWncCFgS5ahbIkKNtWFTQ1wG
	jbXdzCI/g7A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 08B6A13F03;
	Fri, 21 Aug 2009 18:11:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C53613F01; Fri, 21 Aug
 2009 18:11:48 -0400 (EDT)
In-Reply-To: <200908212341.37531.j6t@kdbg.org> (Johannes Sixt's message of
 "Fri\, 21 Aug 2009 23\:41\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3636198-8E9F-11DE-B4D0-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126764>

Johannes Sixt <j6t@kdbg.org> writes:

> Not quite. The parameter *is* the size of the buffer and vsnprintf does not 
> write beyond the buffer. However, it has the awkward behavior that if the 
> buffer is too short by exactly one byte...

Thanks; I was fooled by the leading comment.  How about ...

 compat/snprintf.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/compat/snprintf.c b/compat/snprintf.c
index 6c0fb05..4d07087 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -3,7 +3,8 @@
 /*
  * The size parameter specifies the available space, i.e. includes
  * the trailing NUL byte; but Windows's vsnprintf expects the
- * number of characters to write without the trailing NUL.
+ * number of characters to write, and does not necessarily write the
+ * trailing NUL.
  */
 #ifndef SNPRINTF_SIZE_CORR
 #if defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4
