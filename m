From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/5] pretty: user format ignores i18n.logOutputEncoding setting
Date: Thu, 20 Jun 2013 13:37:34 -0700
Message-ID: <7v8v24selt.fsf@alter.siamese.dyndns.org>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
	<ed75c8cbcfbbac336e2384e2f566e42264154918.1371720245.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 22:37:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uplbz-0006Wi-2h
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 22:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965511Ab3FTUhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 16:37:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965283Ab3FTUhh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 16:37:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDEE22AD0D;
	Thu, 20 Jun 2013 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X7ftchbO786rJ7QDToFRs2/yz7Q=; b=Er3VfG
	6iOdRaKEmcof4ilTB8y6qs5afJhYdSWONVmrCdgBjM4ap6MHGIWmcIL+NwjnjzjU
	ZmiRSshGUFBi47uWdDGf0S/uizr5ouS2mMqlES5QjF/ulzKmhvFPZE1DuqhKx9eT
	Nzu6bM8cyeakK0LIe17hfxa1cPByMfzLBycxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TAen86xmz9cf3mS9GCekIpXuQQIZeP+r
	wXt0FVzUiH6RK1YyKPK7PAD9zFp7gBhxP5DlT+LbTxLs6Mw64ScJsF38m6T8kc/L
	ufrWlHk1AJc80RtUU7edbFSK7fQkXr2ls2ApHVELjqu18l1enKP47ashkbW/3Ay+
	RCM89W3ro2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2C352AD0C;
	Thu, 20 Jun 2013 20:37:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA02C2AD0B;
	Thu, 20 Jun 2013 20:37:35 +0000 (UTC)
In-Reply-To: <ed75c8cbcfbbac336e2384e2f566e42264154918.1371720245.git.Alex.Crezoff@gmail.com>
	(Alexey Shumkin's message of "Thu, 20 Jun 2013 13:26:21 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DA9BEB2-D9E9-11E2-983F-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228533>

Alexey Shumkin <Alex.Crezoff@gmail.com> writes:

Subject: Re: [PATCH v5 5/5] pretty: user format ignores i18n.logOutputEncoding setting

That is a statement of fact, and does not tell much to the reader.

I think you are saying that in the current implementation,
logoutputencoding is not honored in user format, that it is a bug
that needs to be fixed (as opposed to "that is by design, the
scripts that read from --format='' is responsible for doing the
conversion"), and that this patch fixes it.

So

	pretty: --format output should honor logOutputEncoding

or something?  At least it says what is the _desired_ outcome with
"should", hints that the status-quo is different from that desired
outcome and implies that this is a patch to fix it.

The "Subject" line is very important as that is the only thing we
see in many summarizing output format, e.g. shortlog, cover letter
and merge message.

> The following two commands are expected to give the same output to a terminal:
>
> 	$ git log --oneline --no-color
> 	$ git log --pretty=format:'%h %s'
>
> However, the former pays attention to i18n.logOutputEncoding
> configuration, while the latter does not when it format "%s".
> Log messages written in an encoding i18n.commitEncoding which differs
> from terminal encoding are shown corrupted with the latter even
> when i18n.logOutputEncoding and terminal encoding are the same.
>
> The same corruption is true for
> 	$ git diff --submodule=log
> and
> 	$ git rev-list --pretty=format:%s HEAD
> and
> 	$ git reset --hard
>
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> ---
>  builtin/reset.c                  |  8 ++++++--
>  builtin/rev-list.c               |  1 +
>  builtin/shortlog.c               |  1 +
>  log-tree.c                       |  1 +
>  submodule.c                      |  3 +++
>  t/t4041-diff-submodule-option.sh | 10 +++++-----
>  t/t4205-log-pretty-formats.sh    | 34 +++++++++++++++++-----------------
>  t/t6006-rev-list-format.sh       |  8 ++++----
>  t/t7102-reset.sh                 |  2 +-
>  9 files changed, 39 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 6032131..b23ed63 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -92,11 +92,15 @@ static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
>  
>  static void print_new_head_line(struct commit *commit)
>  {
> -	const char *hex, *body;
> +	const char *hex, *body, *encoding;
>  
>  	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
>  	printf(_("HEAD is now at %s"), hex);
> -	body = strstr(commit->buffer, "\n\n");
> +	encoding = get_log_output_encoding();
> +	body = logmsg_reencode(commit, NULL, encoding);


> +	if (!body)
> +		body = commit->buffer;

Does this happen?  I thought body, without an error, can be the same
as commit->buffer.

> +	body = strstr(body, "\n\n");
>  	if (body) {
>  		const char *eol;
>  		size_t len;

Do we have a leak here?  body may point at a new piece of memory
logmsg_reencode() have allocated to hold the UTF-8 version of your
8859-5 message in commit->buffer.

It would be more like this, no?

diff --git a/builtin/reset.c b/builtin/reset.c
index 6032131..8d22ffe 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -92,11 +92,13 @@ static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
 
 static void print_new_head_line(struct commit *commit)
 {
-	const char *hex, *body;
+	const char *hex, *body, *msg, *encoding; 
 
 	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	printf(_("HEAD is now at %s"), hex);
-	body = strstr(commit->buffer, "\n\n");
+
+	msg = logmsg_reencode(commit, NULL, get_log_output_encoding());
+	body = strstr(msg, "\n\n");
 	if (body) {
 		const char *eol;
 		size_t len;
@@ -107,6 +109,7 @@ static void print_new_head_line(struct commit *commit)
 	}
 	else
 		printf("\n");
+	logmsg_free(msg, commit);
 }
 
 static void update_index_from_diff(struct diff_queue_struct *q,
