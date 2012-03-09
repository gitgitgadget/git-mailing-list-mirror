From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix incorrect line number report for bad gitconfig
Date: Fri, 09 Mar 2012 14:58:25 -0800
Message-ID: <7v8vj94c1a.fsf@alter.siamese.dyndns.org>
References: <20120309223014.GA6380@gnutiken.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
To: Martin Stenberg <martin@gnutiken.se>
X-From: git-owner@vger.kernel.org Fri Mar 09 23:58:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68m0-0008C3-KS
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 23:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab2CIW62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 17:58:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab2CIW61 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 17:58:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B17C77DC;
	Fri,  9 Mar 2012 17:58:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RJ7/Qqc536sM6pWhIcDqA8rlrq8=; b=tN8EY8
	MQdQxc9+XAVd1CmCxY0RNUQs+FzG07rjYKiBmcAb3eShkHoX0wFLbS3WsFGaPyR7
	TZKzo4BC7396JJXvo8b5OvKXVMtS5lUVlUXmE3cDgyyy/IzoV6CTj4sgyGopK82L
	3QkETI0WqJaXxxBt7GE74H5QgWq3jtBfwJq18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ugWuXfgtwGZlOh1DR1ck74viruV3Cuuk
	/oN05JMs9Duju0m9em/EXVB65i7AlbJZk5Rk64H6DYK4G6A+IV2Ea+OF4MfFHr7G
	FsJuxQiCl8wf85g87KznoTgcylkKzilT36K9IWIyu0fAJ/wpg4bZHQDVnKKiTAX7
	2J4KGXXO7GU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42C9677DB;
	Fri,  9 Mar 2012 17:58:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF87A77D9; Fri,  9 Mar 2012
 17:58:26 -0500 (EST)
In-Reply-To: <20120309223014.GA6380@gnutiken.se> (Martin Stenberg's message
 of "Fri, 9 Mar 2012 23:30:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6162B972-6A3B-11E1-9CC8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192754>

Martin Stenberg <martin@gnutiken.se> writes:

> From c88f00e06cb877f9d944fdec480f53a7a42dd990 Mon Sep 17 00:00:00 2001
> From: Martin Stenberg <martin@gnutiken.se>
> Date: Fri, 9 Mar 2012 22:57:54 +0100
> Subject: [PATCH] fix incorrect line number report for bad gitconfig

Please drop these four lines. The commit object name is no use to
me, and the other lines duplicate what you have in the mail header.

> A .gitconfig section with a missing "]" reports the next line as beeing bad,
> same goes to a value with a missing end quote.

If you say ".gitconfig", it gives a false impression to the readers
that this is only limited to parsing of $HOME/.gitconfig, which is
not the problem you are addressing.  "A section in a config file"
would be a better phrasing.

s/beeing/being/;

> This happens because the error is not detected until the end of the line, when
> line number is already increased. Fix this issue by decreasing line number by
> one for these cases.
> Signed-off-by: Martin Stenberg <martin@gnutiken.se>

Please have a paragraph break before your S-o-b: line.

Thanks. Review of the patch text follows.

> ---
>  config.c |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/config.c b/config.c
> index ad03908..8d96ba1 100644
> --- a/config.c
> +++ b/config.c
> @@ -196,8 +196,10 @@ static char *parse_value(void)
>  	for (;;) {
>  		int c = get_next_char();
>  		if (c == '\n') {
> -			if (quote)
> +			if (quote) {
> +				cf->linenr--;
>  				return NULL;
> +			}
>  			return cf->value.buf;
>  		}
>  		if (comment)
> @@ -286,8 +288,10 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
>  static int get_extended_base_var(char *name, int baselen, int c)
>  {
>  	do {
> -		if (c == '\n')
> +		if (c == '\n') {
> +			cf->linenr--;
> ...
>  		}

We might want to consolidate the error-return codepath in this
function to a single place by judicious use of "goto", perhaps like
this:

 config.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index ad03908..e222e85 100644
--- a/config.c
+++ b/config.c
@@ -287,7 +287,7 @@ static int get_extended_base_var(char *name, int baselen, int c)
 {
 	do {
 		if (c == '\n')
-			return -1;
+			goto error_incomplete_line;
 		c = get_next_char();
 	} while (isspace(c));
 
@@ -299,13 +299,13 @@ static int get_extended_base_var(char *name, int baselen, int c)
 	for (;;) {
 		int c = get_next_char();
 		if (c == '\n')
-			return -1;
+			goto error_incomplete_line;
 		if (c == '"')
 			break;
 		if (c == '\\') {
 			c = get_next_char();
 			if (c == '\n')
-				return -1;
+				goto error_incomplete_line;
 		}
 		name[baselen++] = c;
 		if (baselen > MAXNAME / 2)
@@ -316,6 +316,9 @@ static int get_extended_base_var(char *name, int baselen, int c)
 	if (get_next_char() != ']')
 		return -1;
 	return baselen;
+error_incomplete_line:
+	cf->linenr--;
+	return -1;
 }
 
 static int get_base_var(char *name)
