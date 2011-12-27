From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add post-fetch hook
Date: Tue, 27 Dec 2011 15:23:41 -0800
Message-ID: <7vehvp4n0i.fsf@alter.siamese.dyndns.org>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
 <7vsjk99exw.fsf@alter.siamese.dyndns.org>
 <20111226023154.GA3243@gnu.kitenet.net>
 <7vlipz930t.fsf@alter.siamese.dyndns.org>
 <20111226155152.GA29582@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Dec 28 00:23:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfgN5-0004PH-Fu
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 00:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322Ab1L0XXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 18:23:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954Ab1L0XXp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 18:23:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D7F57DF8;
	Tue, 27 Dec 2011 18:23:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GLAnDmgCn8sDE0rGGS0RIUYAd1M=; b=rsbNzE
	nwY6SwcOa5KU3nuVzHOrytWYs5nTNYNTpbwEKulSAuwIAq0XrAmfvedIOKiGVeQA
	SDalP9Oqo1N8OQBNAGpQS1jLWLxnbXT1SCkt8HevQEEr8WfrWp1NF1bKXQtX9sH0
	1XLuagBpVnvPCiaMFyaMgSzzzV01PNMq/GTrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MgVzprYMsFdGrx7siGIaJso+hIoxvCAL
	oZnnbaS4GXJGlHswy2kgUumZfQSQpZ7KcNfcnA3dxzXxicJTSH+TqCmnBRjRLS2Z
	a4CV7fysXJAJ2vgqdkjXiGvXgtNVgQssfnN9P33xAN5vqEwFrUMijIlPKcor3fLj
	oa5vNHCyqDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 131957DF7;
	Tue, 27 Dec 2011 18:23:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39BBB7DF4; Tue, 27 Dec 2011
 18:23:43 -0500 (EST)
In-Reply-To: <20111226155152.GA29582@gnu.kitenet.net> (Joey Hess's message of
 "Mon, 26 Dec 2011 11:51:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1252508-30E1-11E1-9F46-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187736>

Joey Hess <joey@kitenet.net> writes:

> From 073b0921bb5988628e7af423924c410f522f403a Mon Sep 17 00:00:00 2001
> From: Joey Hess <joey@kitenet.net>
> Date: Mon, 26 Dec 2011 10:53:27 -0400
> Subject: [PATCH 2/2] add tweak-fetch hook
>
> The tweak-fetch hook is fed lines on stdin for all refs that were fetched,
> and outputs on stdout possibly modified lines. Its output is parsed and
> used when git fetch updates the remote tracking refs, records the entries
> in FETCH_HEAD, and produces its report.
> ---

Just a few style things, as this is not a signed-off patch yet.

> @@ -162,6 +162,35 @@ This hook can be used to perform repository validity checks, auto-display
>  differences from the previous HEAD if different, or set working dir metadata
>  properties.
>  
> +tweak-fetch
> +~~~~~~~~~~

The underline does not match what is being underlined. Does this format well?

> +This hook is invoked by 'git fetch' (commonly called by 'git pull'), after
> +refs have been fetched from the remote repository. It is not executed, if
> +nothing was fetched.
> +
> +The output of the hook is used to update the remote-tracking branches, and
> +`.git/FETCH_HEAD`, in preparation for for a later merge operation done by
> +'git merge'.
> +
> +It takes no arguments, but is fed a line of the following format on
> +its standard input for each ref that was fetched.
> +
> +  <sha1> SP not-for-merge|merge SP <remote-refname> SP <local-refname> LF
> +
> +Where the "not-for-merge" flag indicates the ref is not to be merged into the
> +current branch, and the "merge" flag indicates that 'git merge' should
> +later merge it. The `<remote-refname>` is the remote's name for the ref
> +that was pulled, and `<local-refname>` is a name of a remote-tracking branch,

s/pulled/fetched/; I think. The remainder of the new text seems to use the
right terminology.

> +int feed_tweak_fetch_hook (int in, int out, void *data)

No SP between function name and the opening parenthesis of its parameter
list. We have SP after control-flow keywords e.g. "for (;;)" though.

Does this name need to be external (same question to many other new
functions in this patch)?

The "in" parameter seems unused. Does it have to be there for the "feed"
callback of the generic hook driver? As long as it is the "feed" callback,
I think that it just needs to take "out" and no "in", no?

> +	for (ref = data; ref; ref = ref->next) {
> +		strbuf_addstr(&buf, sha1_to_hex(ref->old_sha1));
> +		strbuf_addch(&buf, ' ');
> +		strbuf_addstr(&buf, ref->merge ? "merge" : "not-for-merge");
> +		strbuf_addch(&buf, ' ');

strbuf_addf()?

But this might be a moot point, as J6t seems to have valid worries on
running functions that allocate memory in general...

> +	ret = write_in_full(out, buf.buf, buf.len) != buf.len;
> +	if (ret)
> +		warning("%s hook failed to consume all its input",
> +				tweak_fetch_hook);
> +	close(out);

I was hoping that this part would be part of more generic hook driver
infrastructure. Even if we were to take this series before we refactor
existing other hook drivers, in order to avoid duplicated work later, we
could at least start from a right implementation of a generic hook driver
with a single user (which is the "tweak-fetch" hook driver), no?

> +struct ref *parse_tweak_fetch_hook_line (char *l, 
> +		struct string_list *existing_refs)
> +{
> +	struct ref *ref = NULL, *peer_ref = NULL;
> +	struct string_list_item *peer_item = NULL;
> +	char *words[4];
> +	int i, word=0;

SP around assingment and initialization "var = val" (throughout this
patch).

> +	char *problem;
> +
> +	for (i=0; l[i]; i++) {

Likewise.

> +		if (isspace(l[i])) {
> +			l[i]='\0';
> +			words[word]=l;
> +			l+=i+1;
> +			i=0;
> +			word++;
> +			if (word > 3) {
> +				problem="too many words";
> +				goto unparsable;
> +			}
> +		}
> +	}
> +	if (word < 3) {
> +		problem="not enough words";
> +		goto unparsable;
> +	}

Perhaps loop for up-to ARRAY_SIZE(words) times and use strchr()?

> +	if (strcmp(words[1], "merge") == 0) {

We tend to say "if (!strcmp(...))" instead.

> +		ref->merge=1;
> +	}
> +	else if (strcmp(words[1], "not-for-merge") != 0) {

Likewise.

> +struct refs_result read_tweak_fetch_hook (int in) {

Opening brace at column 1 of the next line.

> +			if (prevref) {
> +				prevref->next=ref;
> +				prevref=ref;
> +			}
> +			else {

	if (...) {
		...
	} else {
		...
	}

> +/* The hook is fed lines of the form:
> + * <sha1> SP <not-for-merge|merge> SP <remote-refname> SP <local-refname> LF
> + * And should output rewritten lines of the same form.
> + */

	/*
         * We write our multi-line comments
         * like this (applies to a few other comments
         * in this patch).
         */
