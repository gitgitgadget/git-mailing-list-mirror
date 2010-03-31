From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/1] Add new indent-with-tab whitespace check
Date: Wed, 31 Mar 2010 09:23:00 -0700
Message-ID: <7vwrwstq8r.fsf@alter.siamese.dyndns.org>
References: <1269698881-26443-1-git-send-email-chris@arachsys.com>
 <1269698881-26443-2-git-send-email-chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 18:23:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx0hN-0003hz-BT
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 18:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567Ab0CaQXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 12:23:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757412Ab0CaQXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 12:23:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB684A6B9A;
	Wed, 31 Mar 2010 12:23:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IanW2oLr2Rk0sHu6ZTUaWHSP1Rw=; b=wKijCG
	yr8JP1HWyCcAYcOKw39gyMFensfXdZdy5493MuurZt21Gzpxx37Hc9Ve/U/aV/Fa
	ojFakhmEHD0OJfuq41VOPSoJUrZiLo3muavaFWIKLnyYnzDEeWtmutSQ3APeGiX7
	Dz0Iqa/Rs2XRsyPm3ni+dPd85DlOVn7UkWLXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j3Z4szAT8kFs0GIB+Ht4qAKMl0hNqdp/
	y0rYUYosUHmRK4BVbvioctEwUvGW3EzxHpEwarH77kooXnn7vUn75B3L1FtBqyMi
	93/1U5TVRbXCChbm5R9Vj7e519K/T7WrCT8fkGjFLA4jd3Q8v3zeDhx6tBkch3Gs
	1u0bZYVu7UI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C0AFCA6B96;
	Wed, 31 Mar 2010 12:23:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B86EDA6B89; Wed, 31 Mar
 2010 12:23:01 -0400 (EDT)
In-Reply-To: <1269698881-26443-2-git-send-email-chris@arachsys.com> (Chris
 Webb's message of "Sat\, 27 Mar 2010 14\:08\:01 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B042CC5A-3CE1-11DF-9398-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143683>

Chris Webb <chris@arachsys.com> writes:

> The indent-with-tab rule warns about any tab characters used in initial
> indent, and highlights them in git diff --check.
>
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
>  cache.h |    1 +
>  ws.c    |   26 ++++++++++++++++++++------
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 2928107..d87bd85 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1040,6 +1040,7 @@ void shift_tree_by(const unsigned char *, const unsigned char *, unsigned char *
>  #define WS_INDENT_WITH_NON_TAB	04
>  #define WS_CR_AT_EOL           010
>  #define WS_BLANK_AT_EOF        020
> +#define WS_INDENT_WITH_TAB     040
>  #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
>  #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
>  extern unsigned whitespace_rule_cfg;
> diff --git a/ws.c b/ws.c
> index c089338..e44a711 100644
> --- a/ws.c
> +++ b/ws.c
> @@ -18,6 +18,7 @@ static struct whitespace_rule {
>  	{ "cr-at-eol", WS_CR_AT_EOL, 1 },
>  	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
>  	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
> +	{ "indent-with-tab", WS_INDENT_WITH_TAB, 0 },

User's existing attribute setting that uses "indent" as an abbreviation
for "indent-with-non-tab" will probably be broken by this naming.

This sounds more like "tab-in-indent".  Naming the option that way would
give it an added benefit of allowing it to be abbreviated to "tab" by the
parser.

I think WS_TAB_IN_INDENT are incompatible with either WS_SPACE_BEFORE_TAB
or WS_INDENT_WITH_TAB.  Don't we want to notice such a combination as an
error?

> @@ -163,23 +169,31 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
>  		}
>  	}
>  
> -	/* Check for space before tab in initial indent. */
> +	/* Check for indent using tab or space before tab in initial indent. */
>  	for (i = 0; i < len; i++) {
>  		if (line[i] == ' ')
>  			continue;
>  		if (line[i] != '\t')
>  			break;

> -		if ((ws_rule & WS_SPACE_BEFORE_TAB) && written < i) {
> +		if (ws_rule & WS_INDENT_WITH_TAB) {
> +			result |= WS_INDENT_WITH_TAB;
> +			if (stream) {
> +				fwrite(line + written, i - written, 1, stream);
> +				fputs(ws, stream);
> +				fwrite(line + i, 1, 1, stream);
> +				fputs(reset, stream);
> +			}
> +		} else if ((ws_rule & WS_SPACE_BEFORE_TAB) && written < i) {

Adding this new code as a new second branch for if-elif-else chain would
match the order of options better.

>  			result |= WS_SPACE_BEFORE_TAB;
>  			if (stream) {
>  				fputs(ws, stream);
>  				fwrite(line + written, i - written, 1, stream);
>  				fputs(reset, stream);
> +				fwrite(line + i, 1, 1, stream);
>  			}
> -		} else if (stream)
> -			fwrite(line + written, i - written, 1, stream);
> -		if (stream)
> -			fwrite(line + i, 1, 1, stream);
> +		} else if (stream) {
> +			fwrite(line + written, i - written + 1, 1, stream);
> +		}

I think it is a good change, and a necessary one for adding this new
feature.

The original code assumed that this loop always detected an after seeing a
"good" letter (hence the writing of the current letter was unconditional),
but the patch makes it more clear what is being checked and what is being
highlighted by the logic between SPACE_BEFORE_TAB and TAB_IN_INDENT
codepaths.

I'll queue this with s/indent-with-tab/tab-in-indent/ tweak to 'pu' but
the topic would need:

 - detecting incompatible settings;
 - tests;
 - docs;
 - matching change to apply --whitespace=fix;

before moving to 'next', I think.  Here is what I tentatively will queue,
with an updated log message.

Thanks.

-- >8 --
From: Chris Webb <chris@arachsys.com>
Date: Sat, 27 Mar 2010 14:08:01 +0000
Subject: [PATCH] Add tab-in-indent whitespace error class

Some projects and languages use coding style where no tab character
is used to indent the lines.

This only adds support for "apply --whitespace=warn" and "diff --check";
follow-up patches need to add "apply --whitespace=fix", tests and docs.

Signed-off-by: Chris Webb <chris@arachsys.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |    1 +
 ws.c    |   24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 6dcb100..030af32 100644
--- a/cache.h
+++ b/cache.h
@@ -1040,6 +1040,7 @@ void shift_tree_by(const unsigned char *, const unsigned char *, unsigned char *
 #define WS_INDENT_WITH_NON_TAB	04
 #define WS_CR_AT_EOL           010
 #define WS_BLANK_AT_EOF        020
+#define WS_TAB_IN_INDENT       040
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
 extern unsigned whitespace_rule_cfg;
diff --git a/ws.c b/ws.c
index c089338..d0b6c54 100644
--- a/ws.c
+++ b/ws.c
@@ -18,6 +18,7 @@ static struct whitespace_rule {
 	{ "cr-at-eol", WS_CR_AT_EOL, 1 },
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
+	{ "tab-in-indent", WS_TAB_IN_INDENT, 0 },
 };
 
 unsigned parse_whitespace_rule(const char *string)
@@ -125,6 +126,11 @@ char *whitespace_error_string(unsigned ws)
 			strbuf_addstr(&err, ", ");
 		strbuf_addstr(&err, "indent with spaces");
 	}
+	if (ws & WS_TAB_IN_INDENT) {
+		if (err.len)
+			strbuf_addstr(&err, ", ");
+		strbuf_addstr(&err, "tab in indent");
+	}
 	return strbuf_detach(&err, NULL);
 }
 
@@ -163,7 +169,7 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		}
 	}
 
-	/* Check for space before tab in initial indent. */
+	/* Check indentation */
 	for (i = 0; i < len; i++) {
 		if (line[i] == ' ')
 			continue;
@@ -175,11 +181,19 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 				fputs(ws, stream);
 				fwrite(line + written, i - written, 1, stream);
 				fputs(reset, stream);
+				fwrite(line + i, 1, 1, stream);
 			}
-		} else if (stream)
-			fwrite(line + written, i - written, 1, stream);
-		if (stream)
-			fwrite(line + i, 1, 1, stream);
+		} else if (ws_rule & WS_TAB_IN_INDENT) {
+			result |= WS_TAB_IN_INDENT;
+			if (stream) {
+				fwrite(line + written, i - written, 1, stream);
+				fputs(ws, stream);
+				fwrite(line + i, 1, 1, stream);
+				fputs(reset, stream);
+			}
+		} else if (stream) {
+			fwrite(line + written, i - written + 1, 1, stream);
+		}
 		written = i + 1;
 	}
 
-- 
1.7.0.3.513.gc8ed0
