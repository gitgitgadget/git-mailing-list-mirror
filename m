From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow generating a non-default set of documentation
Date: Sun, 07 Oct 2012 15:45:52 -0700
Message-ID: <7vsj9poq8v.fsf@alter.siamese.dyndns.org>
References: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
 <20121007214855.GB1743@sigill.intra.peff.net>
 <7v626lq5g4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:46:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKzbq-0003ks-94
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 00:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab2JGWp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 18:45:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab2JGWpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 18:45:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92DA39022;
	Sun,  7 Oct 2012 18:45:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X5Cflwr/7Gn925UYF38ojRCWxCo=; b=ApTveW
	0QEkqHn/xzTpvTrGLmDPlmO371ulDd8E94bHcs1/EHiIzb1BscOPBpsLIKei5ezg
	dqMOfmTThzsJjqWChp25fUNNQ65x5oBATbt1T6bYfm4iWhmzC91YSBc073IXtD47
	1nkBVIjsEWxBH3FicCoOn5zubf1MkRUvODo78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XDCyRgatRBjnzf5MiytWdrFFKz6z4Mf3
	yWpHZv6xPqpQyHzQejs5Fdao7v4/m+nBOgmclf6zVyXAU2aeWnYyXgTMMbbGKjyo
	+Y+bryRmx/CzHO8QtUivabUWCzO7+Hgz0tWrPFkUzGqDwoSC8bbzxXlELQCcX/Eu
	/f2LccX1DOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 804F89020;
	Sun,  7 Oct 2012 18:45:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB69E901F; Sun,  7 Oct 2012
 18:45:53 -0400 (EDT)
In-Reply-To: <7v626lq5g4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 07 Oct 2012 15:32:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C033EFB6-10D0-11E2-88EE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207210>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Why not do it like this:
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 267dfe1..ca10313 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -152,7 +152,8 @@ endif
>>  endif
>>  endif
>>  
>> -all: html man
>> +DEFAULT_DOC_TARGET ?= html man
>> +all: $(DEFAULT_DOC_TARGET)
>>  
>>  html: $(DOC_HTML)
>>  
>>
>> which covers both cases? That is also how we handle DEFAULT_TEST_TARGET.
>
> Surely, and thanks.

So here is a proposed update based on your idea, to be squashed on
top (i.e. the change to the top-level Makefile in the posted patch
is not reverted).

Does it make sense?


 Documentation/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git c/Documentation/Makefile w/Documentation/Makefile
index 063fa69..0f8fdf8 100644
--- c/Documentation/Makefile
+++ w/Documentation/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+all::
+
 MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
@@ -65,6 +68,8 @@ endif
 -include ../config.mak.autogen
 -include ../config.mak
 
+DEFAULT_DOC_TARGET ?= html man
+
 #
 # For docbook-xsl ...
 #	-1.68.1,	no extra settings are needed?
@@ -151,7 +156,7 @@ ifndef V
 endif
 endif
 
-all: html man
+all:: $(DEFAULT_DOC_TARGET)
 
 html: $(DOC_HTML)
 
