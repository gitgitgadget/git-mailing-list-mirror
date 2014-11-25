From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] string_list: Remove string_list_insert_at_index from its API
Date: Mon, 24 Nov 2014 16:25:59 -0800
Message-ID: <xmqq7fykunvs.fsf@gitster.dls.corp.google.com>
References: <1416864124-15231-1-git-send-email-sbeller@google.com>
	<1416864124-15231-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: marius@trolltech.com, julian@quantumfyre.co.uk, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 01:26:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt3xJ-00029Z-UA
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 01:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbaKYA0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 19:26:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750891AbaKYA0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 19:26:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96C3F211A2;
	Mon, 24 Nov 2014 19:26:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oXLFR0WWGcE/Icnp5wSlAwX0BNc=; b=ee2aAv
	cg+BUrc52YFI+nqTQR4JYIhpRFAtLCEbhwtbwff+kHXeCB5tfd3XS3DJKuBHYsEG
	Hrov0VBSdCJREgnIrmh+YP9RwbHkXsCpNPY/SyUOO2iQh9v8wRNKst8zOkHL3gwZ
	vilu7EQmO0n9MD65tKf+9tGe3lZoHrceDpteo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GJYnmlBzZSF2Nwl7eiS5OLvkK6bW7/uN
	PCQ+Jt/s2mwtxrEXFjDr11lPNQHkHgmRw/okdWGPKOCiiKV/MIX6FbM+1KKv7I2c
	szHiUBrhyMxjKdGYQtHJhg9PXpmD4CKnFKuhDF97SK5HVkV4iOf5lINpwqz2fP+T
	fI9Mll5ZIl8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C2A0211A1;
	Mon, 24 Nov 2014 19:26:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9CDB211A0;
	Mon, 24 Nov 2014 19:26:01 -0500 (EST)
In-Reply-To: <1416864124-15231-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 24 Nov 2014 13:22:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2B66094-7439-11E4-B741-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260174>

Stefan Beller <sbeller@google.com> writes:

> This function behaves the same as string_list_insert, just the
> starting indexes for searching, where to insert into the list is also
> a parameter. So if you have knowledge on where to search for the string
> to be inserted, you may have a speed up version of string_list_insert.

The last half-sentence I am having trouble parsing.  If you have
that knowledge where the item should go, you can insert it at the
right location faster than calling string_list_insert()?

That sounds like a useful feature to me.

But if nobody uses that feature, there is no point keeping it, no
matter how useful it may sound.  So,... I am not sure.

The function would be error prone if used on a string-list that is
accessed via string_list_insert() API, which makes it only useful if
the user of the API is in full control of the sort order, so I do
not mind removing it and won't be saying "that is useful, we should
keep it and use it more."

But your log message confuses me....

>
> As we're not using this function throughout the codebase, get rid of it.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  string-list.c | 8 +-------
>  string-list.h | 2 --
>  2 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/string-list.c b/string-list.c
> index c5aa076..9584fa6 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -59,13 +59,7 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
>  
>  struct string_list_item *string_list_insert(struct string_list *list, const char *string)
>  {
> -	return string_list_insert_at_index(list, -1, string);
> -}
> -
> -struct string_list_item *string_list_insert_at_index(struct string_list *list,
> -						     int insert_at, const char *string)
> -{
> -	int index = add_entry(insert_at, list, string);
> +	int index = add_entry(-1, list, string);
>  
>  	if (index < 0)
>  		index = -1 - index;
> diff --git a/string-list.h b/string-list.h
> index 40ffe0c..ee9b100 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -61,8 +61,6 @@ int string_list_find_insert_index(const struct string_list *list, const char *st
>   * Returns the string_list_item, the string is part of.
>   */
>  struct string_list_item *string_list_insert(struct string_list *list, const char *string);
> -struct string_list_item *string_list_insert_at_index(struct string_list *list,
> -						     int insert_at, const char *string);
>  
>  /*
>   * Checks if the given string is part of a sorted list. If it is part of the list,
