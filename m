From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] config: allow http.<url>.* any user matching
Date: Mon, 22 Jul 2013 11:00:01 -0700
Message-ID: <7vehaqcw66.fsf@alter.siamese.dyndns.org>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
	<7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 20:00:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1KP7-0002ka-PM
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 20:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440Ab3GVSAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 14:00:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52540 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932114Ab3GVSAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 14:00:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1A6332AD9;
	Mon, 22 Jul 2013 18:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QNxGdFLy+yG323rqmZnv4FaRYPg=; b=Za4Faw
	NeAJRJVbocCkTW7cW3cCHv3BwlFzaY3g4/SJkbkU2bTUJ0gfsbRR34WDOto3mvPU
	MYYa1P8tVmTUh7l49Ec5VMQlNvrWbcGuTPfVT4dsJeFsJC/q/B4GoHXj5iZSJHi9
	4SxrMeYuK+YMO+tJvsrTkrMKcRKMXDim7nFYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=atRBwedCExwkfh8CMyqdMxEkF90o9PWc
	k2t59/zs1dTFVSHbLkiQYa/6hMM8QiPrxdFP7QOsybaE+oq9oHmFWuFxwieaq3lV
	LjvLT4LnHvgkrbyAynCVUPfH8lcBKQ0YJRH4t2QBA2fYPqHY/Q4xRG5qBUPaF1PE
	UzY84/77y2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E390532AD8;
	Mon, 22 Jul 2013 18:00:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A239132AD4;
	Mon, 22 Jul 2013 18:00:03 +0000 (UTC)
In-Reply-To: <7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Mon, 22 Jul 2013 05:56:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88EF8564-F2F8-11E2-9C0B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230984>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Previously the <url> had to specify an exactly matching user name
> and password if those were present in the url being matched against.
>
> Now the password portion is always ignored and omitting the user
> name from <url> allows it to match against any user name.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  Documentation/config.txt |  29 +++--

Thanks.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e461f32..c418adf 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1517,15 +1517,26 @@ http.<url>.*::
>  	Any of the http.* options above can be applied selectively to some urls.
>  	For example "http.https://example.com.useragent" would set the user
>  	agent only for https connections to example.com.  The <url> value
> +	matches a url if it refers to the same scheme, host and port and the
> +	path portion is an exact match or a prefix that matches at a "/"
> +	boundary.  If <url> does not include a user name, it will match a url
> +	with any username otherwise the user name must match as well (the
> +	password part, if present in the url, is always ignored).  Longer <url>
> +	path matches take precedence over shorter matches no matter what order
> +	they occur in.  For example, if both "https://user@example.com/path" and
> +	"https://example.com/path/name" are used as a config <url> value and
> +	then "https://user@example.com/path/name/here" is passed to a git
> +	command, the settings in the "https://example.com/path/name" section
> +	will be preferred because that <url> has a longer path length match than
> +	"https://user@example.com/path" even though the latter did match the
> +	user.  For same length matches, the last one wins except that a same
> +	length <url> match that includes a user name will be preferred over a
> +	same length <url> match that does not.  The urls are normalized before
> +	matching so that equivalent urls that are simply spelled differently
> +	will match properly.  Environment variable settings always override any
> +	matches.  The urls that are matched against are those given directly to
> +	git commands.  This means any urls visited as a result of a redirection
> +	do not participate in matching.

A solid wall of text is somewhat hard to read, so I'd queue the
equivalent of the following "git diff -w" output on top.  I also was
trying to see if we can clarify the "length comparison" only refers
to the length of the path part, excluding the length of "user@"
(i.e. when comparing "https://user@example.com/path" with
"https://example.com/path", they are of the same length), which you
can see in the first three lines below.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c418adf..635ed5d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1521,9 +1521,11 @@ http.<url>.*::
 	path portion is an exact match or a prefix that matches at a "/"
 	boundary.  If <url> does not include a user name, it will match a url
 	with any username otherwise the user name must match as well (the
-	password part, if present in the url, is always ignored).  Longer <url>
-	path matches take precedence over shorter matches no matter what order
-	they occur in.  For example, if both "https://user@example.com/path" and
+	password part, if present in the url, is always ignored).  A <url>
+	with longer path matches take precedence over shorter matches no matter
+	what order they occur in the configuration file.
++
+For example, if both "https://user@example.com/path" and
 "https://example.com/path/name" are used as a config <url> value and
 then "https://user@example.com/path/name/here" is passed to a git
 command, the settings in the "https://example.com/path/name" section

I am not yet convinced that the precedence rule specified in this
what we want (I do not have an example why it is *not* what we want,
either).  Another definition could be "if user@ is present in the
request, give lower precedence to config entries for the site
without user@ than entries with user@", and I do not have a strong
opinion myself which one between the two is better (and there may be
third and other possible rule).

Comments?
