From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Sat, 14 May 2016 12:23:41 -0700
Message-ID: <xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat May 14 21:23:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1fAG-0000gG-Pq
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 21:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbcENTXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 15:23:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753696AbcENTXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 15:23:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BDDF718B56;
	Sat, 14 May 2016 15:23:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mv8uB+HHfdT5oUhFImCHBHz0U7g=; b=gIicXk
	A2nqmIjbkfo7FanJzswl8iCqUPrfDDI6/s5RT1K/PEdDoy7Md4aB9ZSbimd1U3W5
	2FMRrlDq8JqRMCBU8L4EBRcL90A7hNq5tNUKlLs5uSWj+Yvx7ChoFut7AGGSkP9v
	oQ/VRqV+f5fJlfqNf/o27ZvCaVGL+JwJzTgIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hMwaufDqGpkkjG0OR5oMPap4YFkABfOn
	i3iqg0wmrXKE3YOjoNWOX9lfioCtVdelAP93+yZbs/5H7nosYEiny3FzVKC8dXrb
	qE3jT6ZhSNx6hNNVOTceMTUEOzI/hFTuKZIso8mQuAW9d3IXCG4RVkgAzBZ/RA+a
	gLpURkcBUi0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B5FC918B55;
	Sat, 14 May 2016 15:23:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F20518B53;
	Sat, 14 May 2016 15:23:42 -0400 (EDT)
In-Reply-To: <20160513231326.8994-6-sbeller@google.com> (Stefan Beller's
	message of "Fri, 13 May 2016 16:13:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5EE90958-1A09-11E6-AA9C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294625>

Stefan Beller <sbeller@google.com> writes:

> Labels were originally designed to manage large amount of
> submodules, the discussion steered this in a more general
> direction, such that other files can be labeled as well.

s/other files/any path/.

> Labels are meant to describe arbitrary set of files, which
> is not described via the tree layout.

Let's avoid "are meant to", which is merely to give you an excuse to
say "it was meant to ... but the implementation did not quite achieve
that goal".

    The "label" attribute can be attached to paths, and the pathspec
    mechanism is extended via the new ":(label=X)pattern/to/match"
    syntax to filter paths so that it requires paths to not just
    match the given pattern but also have the specified labels
    attached for them to be chosen.

or something?

> +Attaching labels to path
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +`label`
> +^^^^^^^^^^
> +By the value of this attribute you can specify a list of arbitrary strings
> +to be attached to a path as labels. These labels can be used for
> +easier paths matching using pathspecs (linkgit:gitglossary[1]).
> +It is recommended to use only alphanumeric characters, dashes and
> +underscores for the labels.

Make this recomendation stronger to requirement.  It is always
possible to loosen it later, but once we allow random things even
with a warning, it gets impossible to take them back. Users will say
"Even though we got a warning, it used to correctly filter; now Git
is broken and my setup does not work."

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 8ad29e6..f990017 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -384,6 +384,10 @@ full pathname may have special meaning:
>  +
>  Glob magic is incompatible with literal magic.
>  
> +label:<white space separated list>;;
> +	Additionally to matching the pathspec, the path must habe a 'label'
> +	attribute having set all labels listed here.

s/habe/have/

> +	if (ATTR_TRUE(check.value))
> +		ret = 1; /* has all the labels */

So this is "pretend that I have all the labels under the sun".

> +	else if (ATTR_FALSE(check.value))
> +		ret = 0; /* has no labels */

I do not see a value in this.  What difference does it have compared
to having a "label=" that explicitly says "I do not have one"?  What
is your answer to an end-user question "When should I say 'label='
and when should I say '!label'?"

Just forbid it for now; we may find a better use for it later.

> +	else if (ATTR_UNSET(check.value))
> +		/*
> +		 * If no label was specified this matches, otherwise
> +		 * there is a missing label.
> +		 */
> +		ret = (required_labels->nr > 0) ? 0 : 1;

Hmm, I can see that this is making things more complicated to
explain and understand, but I cannot see what the expected use case
is.

Unless there is any compelling use case, I'd say we should forbid it
for now.

> +	else {
> +		struct string_list_item *si;
> +		struct string_list attr_labels = STRING_LIST_INIT_DUP;
> +		string_list_split(&attr_labels, check.value, ',', -1);
> +		string_list_sort(&attr_labels);

Filter out a non-compliant label values here, so that they are
ignored from day one.  That way you would not have to deal with "I
know I got the warning, but it used to work and you broke it" later.

> +		ret = 1;
> +		for_each_string_list_item(si, required_labels) {
> +			if (!string_list_has_string(&attr_labels, si->string)) {
> +				ret = 0;
> +				break;
> +			}
> +		}
> +		string_list_clear(&attr_labels, 0);
> +	}
> +
> +	return ret;
> +}

> +static void validate_label_name(const char *label)
> +{
> +	if (check_valid_label_name(label))
> +		warning(_("Label '%s' discouraged. Recommended label names start "
> +			"with an alphabetic character and use only alphanumeric "
> +			"characters, dashes and underscores."), label);
> +}

Instead of returning void, parrot the return value from
check_valid_label_name().

> +		/* The label token may have no argument, so no trailing ':' */

Why close the door for future pathspec magic "labelfoo" by being
unnecessarily[*1*] lenient?

    [*1*] Does ":(label)" mean anything useful, and is there a good
          reason why it should behave differently from ":(label:)"?

Unless there is a good reason why users would want ":(label)", I'd
say we should make it a syntax error.

> +		if (skip_prefix(copyfrom, "label", &body)) {
> +			struct strbuf sb = STRBUF_INIT;
> +			skip_prefix(body, ":", &body);
> +			strbuf_add(&sb, body, nextat - body);
> +			if (!item->labels) {
> +				item->labels = xmalloc(sizeof(*item->labels));
> +				string_list_init(item->labels, 1);
> +			} else
> +				die(_("multiple labels not supported in pathspec magic"));

I am NOT suggesting to make this enhancement in the prototype to
allow us experiment with submodule selection use case, but this is
an obvious place to allow

	:(label=A B):(label=C D)

to mean ((A & B) | (C & D)) by making item->labels an array of set
of labels.

And no, I do not think arbitrary boolean expression is too complex
to understand to the end-users, especially if we have to stay within
the pathspec magic syntax.  And my gut feeling is that it is not
worth it to support anything more complex than "OR of these ANDed
ones".

> +			string_list_split(item->labels, sb.buf, ' ', -1);
> +			string_list_remove_empty_items(item->labels, 0);
> +			strbuf_release(&sb);
> +			continue;

The data structure to record the "required labels" is shared
knowledge between this function and the has_all_labels() and nobody
else knows it is done with string_list, so I think this is a good
balance between expediency and future optimization possibilities (I
am anticipating that linear search of string list would be found as
performance bottleneck).

> @@ -447,6 +490,12 @@ void parse_pathspec(struct pathspec *pathspec,
>  		if (item[i].nowildcard_len < item[i].len)
>  			pathspec->has_wildcard = 1;
>  		pathspec->magic |= item[i].magic;
> +
> +		if (item[i].labels) {
> +			struct string_list_item *si;
> +			for_each_string_list_item(si, item[i].labels)
> +				validate_label_name(si->string);

Reject a request to use a label that does not validate here.

The series is surprisingly simple and was a pleasant read (I no
longer recall how this compares with the earlier change to do this
as [submodule "x"] label=X).  Especially, given that the first two
patches are unrelated clean-ups that can be split out, this now
consists of merely 3 patches, each of which is an easily digestable
size.
