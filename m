From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 15:52:51 -0700
Message-ID: <xmqqob14a14s.fsf@gitster.dls.corp.google.com>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
	<1395093144-6786-2-git-send-email-quintus.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 23:53:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPgOz-0004Z7-CY
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 23:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbaCQWw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 18:52:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbaCQWwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 18:52:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12DC87517A;
	Mon, 17 Mar 2014 18:52:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sAJDTRuWFFbHtJ5AMJTSB8dHeC8=; b=JCScpt
	YKuiYqCjZj5aKSHiaW/ePRBjiNWp8x8ZMm/82Y2YmAEeXyBQQNR+kLpWGdxj5Tjy
	5I5hlLy5mpGewFKQOTAkit0ZC7qBmw8uCQMQgh5AjOSR1BeIwMwgPPQVDaUkVT9E
	WHTnzx+dHQhw7fnQKqGXtdEIPC58P1oFIGnYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fz6AawQqFkIgN4FXJ015jHvG/SSKIQOw
	8HTkMkP1gHvISd7SmU+/0ahqYzK7GIwp9IEc4tOChjF3jUDpcdWkuiEdJuWRvaqF
	ZVtG3QbC0KxvV7SO8oRQRrEPMBEWd5HHDTtPFe+WWTet7cJ9mcY38rrzUCPzl5H2
	HVZcRMY20ZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBA1675179;
	Mon, 17 Mar 2014 18:52:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F4CF75177;
	Mon, 17 Mar 2014 18:52:54 -0400 (EDT)
In-Reply-To: <1395093144-6786-2-git-send-email-quintus.public@gmail.com>
	(Quint Guvernator's message of "Mon, 17 Mar 2014 17:52:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E00A5FE2-AE26-11E3-80CD-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244305>

Quint Guvernator <quintus.public@gmail.com> writes:

> memcmp() is replaced with negated starts_with() when comparing strings
> from the beginning and when it is logical to do so. starts_with() looks
> nicer and it saves the extra argument of the length of the comparing
> string.
>
> Signed-off-by: Quint Guvernator <quintus.public@gmail.com>
> ---

Thanks.  This probably needs retitled, though (hint: "replaces"?
who does so?) and the message rewritten (see numerous reviews on
other GSoC micros from Eric).

> diff --git a/builtin/apply.c b/builtin/apply.c
> index 0189523..de84dce 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1631,7 +1631,7 @@ static int parse_fragment(const char *line, unsigned long size,
>  		 * l10n of "\ No newline..." is at least that long.
>  		 */
>  		case '\\':
> -			if (len < 12 || memcmp(line, "\\ ", 2))
> +			if (len < 12 || !starts_with(line, "\\ "))
>  				return -1;
>  			break;
>  		}
> @@ -1646,7 +1646,7 @@ static int parse_fragment(const char *line, unsigned long size,
>  	 * it in the above loop because we hit oldlines == newlines == 0
>  	 * before seeing it.
>  	 */
> -	if (12 < size && !memcmp(line, "\\ ", 2))
> +	if (12 < size && starts_with(line, "\\ "))
>  		offset += linelen(line, size);
>  
>  	patch->lines_added += added;

The above two looks sensible.

I sense that there is a bonus point for an independent follow-up
patch to unify the conflicting definitions of what an incomplete
line should look like.  Hint, hint...

> @@ -1673,7 +1673,7 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
>  	unsigned long oldlines = 0, newlines = 0, context = 0;
>  	struct fragment **fragp = &patch->fragments;
>  
> -	while (size > 4 && !memcmp(line, "@@ -", 4)) {
> +	while (size > 4 && starts_with(line, "@@ -")) {

If there were a variant of starts_with() that works on a counted
string, and rewriting this using it to

	while (starts_with_counted(line, size, "@@ -")) {

would make perfect sense, but as written above, I do not think it is
an improvement.

> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 3e1d5c3..4135980 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -193,7 +193,7 @@ static int verify_format(const char *format)
>  		at = parse_atom(sp + 2, ep);
>  		cp = ep + 1;
>  
> -		if (!memcmp(used_atom[at], "color:", 6))
> +		if (starts_with(used_atom[at], "color:"))
>  			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
>  	}
>  	return 0;

Good.

> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 640ab64..640c28f 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -57,7 +57,7 @@ static int verify_tag(char *buffer, unsigned long size)
>  
>  	/* Verify type line */
>  	type_line = object + 48;
> -	if (memcmp(type_line - 1, "\ntype ", 6))
> +	if (!starts_with(type_line - 1, "\ntype "))
>  		return error("char%d: could not find \"\\ntype \"", 47);
>  
>  	/* Verify tag-line */

Good.

> @@ -66,7 +66,7 @@ static int verify_tag(char *buffer, unsigned long size)
>  		return error("char%"PRIuMAX": could not find next \"\\n\"",
>  				(uintmax_t) (type_line - buffer));
>  	tag_line++;
> -	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
> +	if (!starts_with(tag_line, "tag ") || tag_line[4] == '\n')
>  		return error("char%"PRIuMAX": no \"tag \" found",
>  				(uintmax_t) (tag_line - buffer));

Not quite.  I suspect that what actually makes this strange and
tricky is that this "no tag found" check is misplaced.  It found the
type line, expects that the next line is a tag line, and instead of
validating the remainder of type line, it does this thing, and then
verifies the actual type string, and for that, it needs tag_line
variable to stay where it is.

If we flipped the order of things around the codepath a bit, then we
should be able to first validate the type line, and then use
skip-prefix to skip the "tag " part (while validating that that line
actually begins with "tag ") and check the tag name is a non-empty
string that consists of a good character.  All of that is a topic
for a separate patch.

> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 3cfe02d..23ef424 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -81,14 +81,14 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  		}
>  
>  		/* Ignore commit comments */
> -		if (!patchlen && memcmp(line, "diff ", 5))
> +		if (!patchlen && !starts_with(line, "diff "))
>  			continue;
>  		/* Parsing diff header?  */
>  		if (before == -1) {
> -			if (!memcmp(line, "index ", 6))
> +			if (starts_with(line, "index "))
>  				continue;
> -			else if (!memcmp(line, "--- ", 4))
> +			else if (starts_with(line, "--- "))
>  				before = after = 1;
>  			else if (!isalpha(line[0]))
>  				break;

Looks good.

> @@ -96,14 +96,14 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  
>  		/* Looking for a valid hunk header?  */
>  		if (before == 0 && after == 0) {
> -			if (!memcmp(line, "@@ -", 4)) {
> +			if (starts_with(line, "@@ -")) {
>  				/* Parse next hunk, but ignore line numbers.  */
>  				scan_hunk_header(line, &before, &after);
>  				continue;
>  			}
>  
>  			/* Split at the end of the patch.  */
> -			if (memcmp(line, "diff ", 5))
> +			if (!starts_with(line, "diff "))
>  				break;
>  
>  			/* Else we're parsing another header.  */

Looks good.

> diff --git a/connect.c b/connect.c
> index 4150412..5ae2aaa 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -30,11 +30,11 @@ static int check_ref(const char *name, int len, unsigned int flags)
>  		return 0;
>  
>  	/* REF_HEADS means that we want regular branch heads */
> -	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
> +	if ((flags & REF_HEADS) && starts_with(name, "heads/"))
>  		return 1;
>  
>  	/* REF_TAGS means that we want tags */
> -	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
> +	if ((flags & REF_TAGS) && starts_with(name, "tags/"))
>  		return 1;
>  
>  	/* All type bits clear means that we are ok with anything */

Looks good.

> diff --git a/imap-send.c b/imap-send.c
> index 0bc6f7f..019de18 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -524,7 +524,7 @@ static struct imap_cmd *v_issue_imap_cmd(struct imap_store *ctx,
>  	if (Verbose) {
>  		if (imap->num_in_progress)
>  			printf("(%d in progress) ", imap->num_in_progress);
> -		if (memcmp(cmd->cmd, "LOGIN", 5))
> +		if (!starts_with(cmd->cmd, "LOGIN"))
>  			printf(">>> %s", buf);
>  		else
>  			printf(">>> %d LOGIN <user> <pass>\n", cmd->tag);

Looks good.

> @@ -802,7 +802,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>  				resp = DRV_OK;
>  			else {
>  				if (!strcmp("NO", arg)) {
> -					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp(cmd, "[TRYCREATE]", 11))) { /* SELECT, APPEND or UID COPY */
> +					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || starts_with(cmd, "[TRYCREATE]"))) { /* SELECT, APPEND or UID COPY */
>  						p = strchr(cmdp->cmd, '"');
>  						if (!issue_imap_cmd(ctx, NULL, "CREATE \"%.*s\"", (int)(strchr(p + 1, '"') - p + 1), p)) {
>  							resp = RESP_BAD;
> @@ -827,7 +827,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>  				} else /*if (!strcmp("BAD", arg))*/
>  					resp = RESP_BAD;
>  				fprintf(stderr, "IMAP command '%s' returned response (%s) - %s\n",
> -					 memcmp(cmdp->cmd, "LOGIN", 5) ?
> +					 !starts_with(cmdp->cmd, "LOGIN") ?
>  							cmdp->cmd : "LOGIN <user> <pass>",
>  							arg, cmd ? cmd : "");
>  			}

Looks good.

> diff --git a/remote.c b/remote.c
> index 5f63d55..bd02b0e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1149,7 +1149,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
>  	case 1:
>  		break;
>  	case 0:
> -		if (!memcmp(dst_value, "refs/", 5))
> +		if (starts_with(dst_value, "refs/"))
>  			matched_dst = make_linked_ref(dst_value, dst_tail);
>  		else if (is_null_sha1(matched_src->new_sha1))
>  			error("unable to delete '%s': remote ref does not exist",

Looks good.
