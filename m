From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: fix t0040-parse-options
Date: Fri, 28 Mar 2014 11:19:00 -0700
Message-ID: <xmqq7g7eb2zv.fsf@gitster.dls.corp.google.com>
References: <1396008298-1434-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 19:19:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTbMz-0002Hb-PP
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 19:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbaC1STF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 14:19:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaC1STD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 14:19:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55E1D76F1D;
	Fri, 28 Mar 2014 14:19:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xYo+NDy3jC9Z+H2L9MDIKXPz6K8=; b=onPB6p
	5lnCYRvZokQCs8/KTZi8P+9Q6fWLbZQn6Hy3XvGeEXchtz5+qL705ex5m3e1Dd43
	gkwygML3LZCAILOasNZBfXKXgLwfWPTc1SHR29YJ+SeUHYdV74B2Km79rlHOTlsR
	cU7NclXM/RgU0WDFYmIdCGdCf+1JP1ynuBPDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ebWtg5MvTkuMhUNo1EOTYipc0l+Vgtgd
	IAKiboC/MzzQkFtll9N6YLUg3p4Y0v3kid75mgZBH94ZOIV5qoBxM4O5PIiM+bWK
	1FiOSd6Sjtn35uTo9TgBgDQIRRgPitcp+NvAbOvQ0U5c1PUIPgdAZkoMsREH+yuU
	0GhjrsvSI8Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4278976F1C;
	Fri, 28 Mar 2014 14:19:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99ECE76F1A;
	Fri, 28 Mar 2014 14:19:01 -0400 (EDT)
In-Reply-To: <1396008298-1434-1-git-send-email-marat@slonopotamus.org> (Marat
	Radchenko's message of "Fri, 28 Mar 2014 16:04:58 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 70039EE8-B6A5-11E3-AAAE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245407>

Marat Radchenko <marat@slonopotamus.org> writes:

> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  test-parse-options.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/test-parse-options.c b/test-parse-options.c
> index 434e8b8..7840493 100644
> --- a/test-parse-options.c
> +++ b/test-parse-options.c
> @@ -11,6 +11,7 @@ static char *string = NULL;
>  static char *file = NULL;
>  static int ambiguous;
>  static struct string_list list;
> +static const char *default_string = "default";

That wastes 4 or 8 bytes compared to

	static const char default_string[] = "default";

no?

>  static int length_callback(const struct option *opt, const char *arg, int unset)
>  {
> @@ -60,7 +61,7 @@ int main(int argc, char **argv)
>  		OPT_STRING('o', NULL, &string, "str", "get another string"),
>  		OPT_NOOP_NOARG(0, "obsolete"),
>  		OPT_SET_PTR(0, "default-string", &string,
> -			"set string to default", (unsigned long)"default"),
> +			"set string to default", default_string),
>  		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
>  		OPT_GROUP("Magic arguments"),
>  		OPT_ARGUMENT("quux", "means --quux"),

I can see how this patch would not hurt, but at the same time, I
cannot see why this patch is a "FIX".  A string literal "default" is
a pointer to constant string, and being able to cast a pointer to
"unsigned long" is something that is done fairly commonly without
problems [*1*].  It needs to be explained why this change is needed
along the lines of...

	We prepare an element in an array of "struct option" with
	OPT_SET_PTR to point a variable to a literal string
	"default", but MSVC compiler fails to distim the doshes for
	such and such reasons.

        Work it around by moving the literal string outside the
	definition of the struct option, which MSVC can understand
	it.

in the log message.


[Footnote]

*1* The cast should actually be intptr_t for it to be kosher.  I
    also suspect that the cast should happen inside OPT_SET_PTR()
    macro defintion, like in the attached patch.

 parse-options.h      | 2 +-
 test-parse-options.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index d670cb9..7a24d2e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -129,7 +129,7 @@ struct option {
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, (p) }
+				      (h), PARSE_OPT_NOARG, NULL, (intptr_t)(p) }
 #define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
diff --git a/test-parse-options.c b/test-parse-options.c
index 434e8b8..10da63e 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -60,7 +60,7 @@ int main(int argc, char **argv)
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_SET_PTR(0, "default-string", &string,
-			"set string to default", (unsigned long)"default"),
+			"set string to default", "default"),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
