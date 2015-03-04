From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/7] Documentation/config.txt: describe the structure first and then meaning
Date: Wed,  4 Mar 2015 13:33:19 -0800
Message-ID: <1425504803-16039-4-git-send-email-gitster@pobox.com>
References: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
 <1425504803-16039-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 22:33:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGvH-0007Ex-RX
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbbCDVdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:33:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752638AbbCDVde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:33:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 770B23C773;
	Wed,  4 Mar 2015 16:33:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=WlSL
	O4Li756Ezpq0eMSxIpf8+5A=; b=vYeSxZwgY+EpVY1usOKfu5XZBXHUxmoRzWi3
	e0f4XDoaJEaWgM3OV9r2rwjNQHgUBBt4quasm12ebHQKGRLtrHT7Q4mhDba06fYB
	89OulMjC/VYdfyQXt7rdcLZHCZZsffUU1kya1ZpWlFV/KVl6J4Reovht1girl/nF
	H5zBIZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=lbFrvY
	X2JtdD2195y+d0+U2pyn5LbnXXpK+uNQlZWIMyU25LYY/uhhU+hDrIfcTZR/D9fU
	uoOGdQ5oz0XUSKsxB0wJdqPT3zbyixYdlQNCHlhOo1MmcEpBhVki8Qng/8gIVD2L
	5Ypn2i/YEM69qEF9M7dgDCmmPdsYHkffBP38U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C9A93C772;
	Wed,  4 Mar 2015 16:33:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9601D3C771;
	Wed,  4 Mar 2015 16:33:32 -0500 (EST)
X-Mailer: git-send-email 2.3.1-318-g5233f23
In-Reply-To: <1425504803-16039-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1B53C2EC-C2B6-11E4-8DC8-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264782>

A line can be continued via a backquote-LF and can be chomped at a
comment character.  But that is not specific to string-typed values.
It is common to all, just like unquoted leading and trailing
whitespaces are stripped and inter-word spacing are retained.

Move the description around and desribe these structural rules
first, then introduce the double-quote facility as a way to override
them, and finally mention various types of values.

Note that these structural rules only apply to the value part of the
configuration file.  E.g.

    [aSection] \
        name \
	= value

does not work, because the rules kick in only after seeing "name =".
Both the original and the updated text are phrased in an awkward way
by singling out the "value" part of the line because of this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 405bf25..1444614 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -59,32 +59,31 @@ is taken as 'name' and the variable is recognized as boolean "true".
 The variable names are case-insensitive, allow only alphanumeric characters
 and `-`, and must start with an alphabetic character.
 
-Leading and trailing whitespace in a variable value is discarded.
-Internal whitespace within a variable value is retained verbatim.
+A line that defines a value can be continued to the next line by
+ending it with a `\`; the backquote and the end-of-line are
+stripped.  Leading whitespaces after 'name =', the remainder of the
+line after the first comment character '#' or ';', and trailing
+whitespaces of the line are discarded unless they are enclosed in
+double quotes.  Internal whitespaces within the value are retained
+verbatim.
 
-The values following the equals sign in variable assign are all either
-a string, an integer, or a boolean.  Boolean values may be given as yes/no,
-1/0, true/false or on/off.  Case is not significant in boolean values, when
-converting value to the canonical form using '--bool' type specifier;
-'git config' will ensure that the output is "true" or "false".
-
-String values may be entirely or partially enclosed in double quotes.
-You need to enclose variable values in double quotes if you want to
-preserve leading or trailing whitespace, or if the variable value contains
-comment characters (i.e. it contains '#' or ';').
-Double quote `"` and backslash `\` characters in variable values must
-be escaped: use `\"` for `"` and `\\` for `\`.
+Inside double quotes, double quote `"` and backslash `\` characters
+must be escaped: use `\"` for `"` and `\\` for `\`.
 
 The following escape sequences (beside `\"` and `\\`) are recognized:
 `\n` for newline character (NL), `\t` for horizontal tabulation (HT, TAB)
 and `\b` for backspace (BS).  No other char escape sequence, nor octal
 char sequences are valid.
 
-Variable values ending in a `\` are continued on the next line in the
-customary UNIX fashion.
+The values following the equals sign in variable assign are all either
+a string, an integer, or a boolean.  Boolean values may be given as yes/no,
+1/0, true/false or on/off.  Case is not significant in boolean values, when
+converting value to the canonical form using '--bool' type specifier;
+'git config' will ensure that the output is "true" or "false".
 
 Some variables may require a special value format.
 
+
 Includes
 ~~~~~~~~
 
-- 
2.3.1-316-g7c93423
