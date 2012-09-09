From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Add a function string_list_longest_prefix()
Date: Sun, 09 Sep 2012 02:54:23 -0700
Message-ID: <7vbohfser4.fsf@alter.siamese.dyndns.org>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
 <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 09 11:55:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAeEc-00045M-NR
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 11:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab2IIJy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 05:54:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148Ab2IIJy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 05:54:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D5C878D8;
	Sun,  9 Sep 2012 05:54:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xheYkvuBZQlcb8eoDR6PxYMxJcs=; b=fNG0oy
	iBOp5b3gqXHmwXMRt+M8bpVrFiyV5OXylU6o2mA4AtIPZww5YDIGy3hWo2EThakM
	9Y2r0S3GPcb06PcI8UHAztzCCvrgLztO//xnskls3Yu5m2Nw409HD5Pffa4+VTRj
	ptFi++JNHDWfS8f7c/rtByTP10rHL+34x841U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nLZv6lZ6pO6fJMPuyJyc9XodkymPRNiY
	ATVrBLApgfwyYyv0xb1+KAXP43C/NnK67BuSsdiJYQjgk5ZuBGfPHeYnJ1qDeTl8
	e7UAuf+DNMpliCQE/QWH7VjShHHeWLvL2Plo7Ej6tUO6EGnBLmn5q5qLFzvEYizl
	8GT96HKkmfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BB6678D7;
	Sun,  9 Sep 2012 05:54:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1917F78D6; Sun,  9 Sep 2012
 05:54:25 -0400 (EDT)
In-Reply-To: <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Sun, 9 Sep 2012 07:53:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56672A3A-FA64-11E1-9E4E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205073>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/technical/api-string-list.txt |  8 ++++++++
>  string-list.c                               | 20 +++++++++++++++++++
>  string-list.h                               |  8 ++++++++
>  t/t0063-string-list.sh                      | 30 +++++++++++++++++++++++++++++
>  test-string-list.c                          | 22 +++++++++++++++++++++
>  5 files changed, 88 insertions(+)
>
> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
> index 9206f8f..291ac4c 100644
> --- a/Documentation/technical/api-string-list.txt
> +++ b/Documentation/technical/api-string-list.txt
> @@ -68,6 +68,14 @@ Functions
>  	to be deleted.  Preserve the order of the items that are
>  	retained.
>  
> +`string_list_longest_prefix`::
> +
> +	Return the longest string within a string_list that is a
> +	prefix (in the sense of prefixcmp()) of the specified string,
> +	or NULL if no such prefix exists.  This function does not
> +	require the string_list to be sorted (it does a linear
> +	search).
> +
>  `print_string_list`::

This may feel like outside the scope of this series, but since this
series will be the main culprit for adding many new functions to
this API in the recent history...

 - We may want to name things a bit more consistently so that people
   can tell which ones can be called on any string list, which ones
   are sorted list only, and which ones are unsorted one only.

   In addition, the last category _may_ need a bit more thought.
   Calling unsorted_string_list_lookup() on an already sorted list
   is not a crime---it is just a stupid thing to do.

 - Why are these new functions described at the top, not appended at
   the bottom?  I would have expected either an alphabetical, or a
   more generic ones first (i.e. print and clear are a lot "easier"
   ones compared to filter and prefix that are very much more
   specialized).

> diff --git a/string-list.c b/string-list.c
> index bfef6cf..043f6c4 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -136,6 +136,26 @@ void filter_string_list(struct string_list *list, int free_util,
>  	list->nr = dst;
>  }
>  
> +char *string_list_longest_prefix(const struct string_list *prefixes,
> +				 const char *string)
> +{
> +	int i, max_len = -1;
> +	char *retval = NULL;
> +
> +	for (i = 0; i < prefixes->nr; i++) {
> +		char *prefix = prefixes->items[i].string;
> +		if (!prefixcmp(string, prefix)) {
> +			int len = strlen(prefix);
> +			if (len > max_len) {
> +				retval = prefix;
> +				max_len = len;
> +			}
> +		}
> +	}
> +
> +	return retval;
> +}
> +
>  void string_list_clear(struct string_list *list, int free_util)
>  {
>  	if (list->items) {
> diff --git a/string-list.h b/string-list.h
> index c4dc659..680916c 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -38,6 +38,14 @@ int for_each_string_list(struct string_list *list,
>  void filter_string_list(struct string_list *list, int free_util,
>  			string_list_each_func_t fn, void *cb_data);
>  
> +/*
> + * Return the longest string in prefixes that is a prefix (in the
> + * sense of prefixcmp()) of string, or NULL if no such prefix exists.
> + * This function does not require the string_list to be sorted (it
> + * does a linear search).
> + */
> +char *string_list_longest_prefix(const struct string_list *prefixes, const char *string);
> +
>  
>  /* Use these functions only on sorted lists: */
>  int string_list_has_string(const struct string_list *list, const char *string);
> diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
> index 0eede83..fa96eba 100755
> --- a/t/t0063-string-list.sh
> +++ b/t/t0063-string-list.sh
> @@ -15,6 +15,14 @@ string_list_split_in_place() {
>  	"
>  }
>  
> +longest_prefix() {
> +	test "$(test-string-list longest_prefix "$1" "$2")" = "$3"
> +}
> +
> +no_longest_prefix() {
> +	test_must_fail test-string-list longest_prefix "$1" "$2"
> +}
> +
>  string_list_split_in_place "foo:bar:baz" ":" "-1" <<EOF
>  3
>  [0]: "foo"
> @@ -60,4 +68,26 @@ string_list_split_in_place ":" ":" "-1" <<EOF
>  [1]: ""
>  EOF
>  
> +test_expect_success "test longest_prefix" '
> +	no_longest_prefix - '' &&
> +	no_longest_prefix - x &&
> +	longest_prefix "" x "" &&
> +	longest_prefix x x x &&
> +	longest_prefix "" foo "" &&
> +	longest_prefix : foo "" &&
> +	longest_prefix f foo f &&
> +	longest_prefix foo foobar foo &&
> +	longest_prefix foo foo foo &&
> +	no_longest_prefix bar foo &&
> +	no_longest_prefix bar:bar foo &&
> +	no_longest_prefix foobar foo &&
> +	longest_prefix foo:bar foo foo &&
> +	longest_prefix foo:bar bar bar &&
> +	longest_prefix foo::bar foo foo &&
> +	longest_prefix foo:foobar foo foo &&
> +	longest_prefix foobar:foo foo foo &&
> +	longest_prefix foo: bar "" &&
> +	longest_prefix :foo bar ""
> +'
> +
>  test_done
> diff --git a/test-string-list.c b/test-string-list.c
> index f08d3cc..c7e71f2 100644
> --- a/test-string-list.c
> +++ b/test-string-list.c
> @@ -19,6 +19,28 @@ int main(int argc, char **argv)
>  		return 0;
>  	}
>  
> +	if (argc == 4 && !strcmp(argv[1], "longest_prefix")) {
> +		/* arguments: <colon-separated-prefixes>|- <string> */
> +		struct string_list prefixes = STRING_LIST_INIT_NODUP;
> +		int retval;
> +		char *prefix_string = xstrdup(argv[2]);
> +		char *string = argv[3];
> +		char *match;
> +
> +		if (strcmp(prefix_string, "-"))
> +			string_list_split_in_place(&prefixes, prefix_string, ':', -1);
> +		match = string_list_longest_prefix(&prefixes, string);
> +		if (match) {
> +			printf("%s\n", match);
> +			retval = 0;
> +		}
> +		else
> +			retval = 1;
> +		string_list_clear(&prefixes, 0);
> +		free(prefix_string);
> +		return retval;
> +	}
> +
>  	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
>  		argv[1] ? argv[1] : "(there was none)");
>  	return 1;
