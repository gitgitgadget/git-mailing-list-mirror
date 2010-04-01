From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [RFC 1/1] Add new indent-with-tab whitespace check
Date: Thu, 01 Apr 2010 11:51:46 -0700
Message-ID: <7vsk7fovjx.fsf_-_@alter.siamese.dyndns.org>
References: <1269698881-26443-1-git-send-email-chris@arachsys.com>
 <1269698881-26443-2-git-send-email-chris@arachsys.com>
 <7vwrwstq8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 20:52:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxPUn-0001o4-JX
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 20:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756997Ab0DASv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 14:51:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044Ab0DASvy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 14:51:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92240A6BD1;
	Thu,  1 Apr 2010 14:51:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZBn5z6DrpSjCAEb0kp0vycgiBww=; b=KAQePh
	VnsKjPBa3p01hXNarTEigxwLBNIyW73INFuLOcC2uAXOrYZQwDoEO2vqFooTOHaM
	HCkpFxyTG5aBzb2lxPJJSKYvKwFpas1ejVTJIHKlg98DWbxqJOrqeBBa8Cl6bNRQ
	vu6SbVm5zPasNyZazghqU7QS3u0cy/afzwdRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XARJY241n4LLMupIGWjwVYEgZY1rla9o
	XKW/61rr4xpFRJDzY8/PUlQ4ISpj15Tq1CS6qAdMee3XrTGvXv4R0AvtUxFSkr1v
	Z6O9j1cKXd70l7WNpxQ3VelZs6C3QW5Vfdaj/p/vEhk92goJmZ51I9JTaaLWpYDu
	crCI8F8l/Yc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2FB0A6BD0;
	Thu,  1 Apr 2010 14:51:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E013EA6BCE; Thu,  1 Apr
 2010 14:51:47 -0400 (EDT)
In-Reply-To: <7vwrwstq8r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 31 Mar 2010 09\:23\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1D9AA9C-3DBF-11DF-9A2E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143740>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/ws.c b/ws.c
>> index c089338..e44a711 100644
>> --- a/ws.c
>> +++ b/ws.c
>> @@ -18,6 +18,7 @@ static struct whitespace_rule {
>>  	{ "cr-at-eol", WS_CR_AT_EOL, 1 },
>>  	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
>>  	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
>> +	{ "indent-with-tab", WS_INDENT_WITH_TAB, 0 },
>
> User's existing attribute setting that uses "indent" as an abbreviation
> for "indent-with-non-tab" will probably be broken by this naming.

There is another issue with this change.  Because "whitespace" without any
string in .gitattributes are defined to cause all the whitespace breakages
known to git to be caught, and tab-in-indent is inherently incompatible
with indent-with-non-tab, this cannot be supported without changing the
definition of "default set of whitespace breakage classes".

The intention of allowing .gitattributes to say "*.txt whitespace" is to
let the users and projects say:

    I trust the competence and good judgement made by git developers
    regarding whitespace issues.  They may devise a new algorithm to catch
    common whitespace errors that the current tool may not catch, and when
    that happens, I'd like my project to take advantage of the new code
    and catch the newly defined classes of errors.
    
and that is why we include all whitespace-rule except for the ones that
loosens error conditions to the set of breakages we catch for such a
specification.

So on top of the replacement I sent earlier, I think we would need a patch
like the attached.  The topic still needs:

>  - detecting incompatible settings;
>  - tests;
>  - docs;
>  - matching change to apply --whitespace=fix;

but otherwise with this patch I think it is usable by me ;-)

Thanks.

-- >8 --
whitespace: we cannot "catch all errors known to git" anymore

Traditionally, "*.txt whitespace" in .gitattributes file has been an
instruction to catch _all_ classes of whitespace errors known to git.

This however has to change, as the recently introduced "tab-in-indent"
is inherently incompatible with "indent-with-non-tab".  As we do not want
to break configuration of existing users, add a mechanism to allow marking
selected rules to be excluded from "all rules known to git".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ws.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/ws.c b/ws.c
index d0b6c54..c7b4f91 100644
--- a/ws.c
+++ b/ws.c
@@ -10,7 +10,8 @@
 static struct whitespace_rule {
 	const char *rule_name;
 	unsigned rule_bits;
-	unsigned loosens_error;
+	unsigned loosens_error:1,
+		not_in_all:1;
 } whitespace_rule_names[] = {
 	{ "trailing-space", WS_TRAILING_SPACE, 0 },
 	{ "space-before-tab", WS_SPACE_BEFORE_TAB, 0 },
@@ -18,7 +19,7 @@ static struct whitespace_rule {
 	{ "cr-at-eol", WS_CR_AT_EOL, 1 },
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
-	{ "tab-in-indent", WS_TAB_IN_INDENT, 0 },
+	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
 };
 
 unsigned parse_whitespace_rule(const char *string)
@@ -83,7 +84,8 @@ unsigned whitespace_rule(const char *pathname)
 			unsigned all_rule = 0;
 			int i;
 			for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++)
-				if (!whitespace_rule_names[i].loosens_error)
+				if (!whitespace_rule_names[i].loosens_error &&
+				    !whitespace_rule_names[i].not_in_all)
 					all_rule |= whitespace_rule_names[i].rule_bits;
 			return all_rule;
 		} else if (ATTR_FALSE(value)) {
