From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Add a new function, string_list_remove_duplicates()
Date: Sun, 09 Sep 2012 02:45:23 -0700
Message-ID: <7vfw6rsf64.fsf@alter.siamese.dyndns.org>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
 <1347169990-9279-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 09 11:46:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAe5o-0004SJ-Mj
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 11:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab2IIJp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 05:45:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab2IIJpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 05:45:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D02B7751;
	Sun,  9 Sep 2012 05:45:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fLSd9GZh2k6Rgfmdxu5HdMMh80s=; b=TDutdF
	nJPtUlHOAu2daa13k17EUA4OLXkggFH9YZbnn2KNTJqhK6IxGmtt8YX53RcJk9Y0
	x07vJqT8NFptITPAuqS3gW3ZT2+GiWGWMBuRK8lhcaoXFaGhljjXr6i+hpkZJF6c
	xjQhDZpH6esq/Qjw6YBSFe9uTnjnxGwuR+byc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yTBLG7lxTXz7IRRbXeg61QJsK/kOPDo/
	yzCWeLtNmPvaoeLFJt3a8j0uzp7xnqDc5kJiw29U940BCV5r9a7dpsO6AK7hh7GM
	7Wwl70LLAXUbyQWIU0L9v5sNzrW53uy2J9AjmoEpfCWosw8Rf7EqnC1HMN1hShYz
	x2pD708MgcA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73BB47750;
	Sun,  9 Sep 2012 05:45:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A2F1774F; Sun,  9 Sep 2012
 05:45:24 -0400 (EDT)
In-Reply-To: <1347169990-9279-4-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Sun, 9 Sep 2012 07:53:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1441ECC2-FA63-11E1-AA9D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205072>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/technical/api-string-list.txt |  4 ++++
>  string-list.c                               | 17 +++++++++++++++++
>  string-list.h                               |  5 +++++
>  3 files changed, 26 insertions(+)
>
> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
> index 15b8072..9206f8f 100644
> --- a/Documentation/technical/api-string-list.txt
> +++ b/Documentation/technical/api-string-list.txt
> @@ -104,6 +104,10 @@ write `string_list_insert(...)->util = ...;`.
>  	Look up a given string in the string_list, returning the containing
>  	string_list_item. If the string is not found, NULL is returned.
>  
> +`string_list_remove_duplicates`::
> +
> +	Remove all but the first entry that has a given string value.

Unlike the previous patch, free_util is not documented?

It is kind of shame that the string list must be sorted for this
function to work, but I guess you do not have a need for a version
that works on both sorted and unsorted (yet).  We can introduce a
variant with "unsorted_" prefix later when it becomes necessary, so
OK.

>  * Functions for unsorted lists only
>  
>  `string_list_append`::
> diff --git a/string-list.c b/string-list.c
> index 72610ce..bfef6cf 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -92,6 +92,23 @@ struct string_list_item *string_list_lookup(struct string_list *list, const char
>  	return list->items + i;
>  }
>  
> +void string_list_remove_duplicates(struct string_list *list, int free_util)
> +{
> +	if (list->nr > 1) {
> +		int src, dst;
> +		for (src = dst = 1; src < list->nr; src++) {
> +			if (!strcmp(list->items[dst - 1].string, list->items[src].string)) {
> +				if (list->strdup_strings)
> +					free(list->items[src].string);
> +				if (free_util)
> +					free(list->items[src].util);
> +			} else
> +				list->items[dst++] = list->items[src];
> +		}
> +		list->nr = dst;
> +	}
> +}
> +
>  int for_each_string_list(struct string_list *list,
>  			 string_list_each_func_t fn, void *cb_data)
>  {
> diff --git a/string-list.h b/string-list.h
> index 84996aa..c4dc659 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -38,6 +38,7 @@ int for_each_string_list(struct string_list *list,
>  void filter_string_list(struct string_list *list, int free_util,
>  			string_list_each_func_t fn, void *cb_data);
>  
> +
>  /* Use these functions only on sorted lists: */
>  int string_list_has_string(const struct string_list *list, const char *string);
>  int string_list_find_insert_index(const struct string_list *list, const char *string,
> @@ -47,6 +48,10 @@ struct string_list_item *string_list_insert_at_index(struct string_list *list,
>  						     int insert_at, const char *string);
>  struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
>  
> +/* Remove all but the first entry that has a given string value. */
> +void string_list_remove_duplicates(struct string_list *list, int free_util);
> +
> +
>  /* Use these functions only on unsorted lists: */
>  struct string_list_item *string_list_append(struct string_list *list, const char *string);
>  void sort_string_list(struct string_list *list);
