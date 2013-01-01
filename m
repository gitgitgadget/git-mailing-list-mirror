From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/19] Improve documentation and comments regarding
 directory traversal API
Date: Tue, 01 Jan 2013 12:52:23 -0800
Message-ID: <7vobh8aans.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-3-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 21:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq8pS-0002cd-Cl
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 21:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab3AAUw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 15:52:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab3AAUwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 15:52:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C925BCD3;
	Tue,  1 Jan 2013 15:52:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=s0S0iyLowdWV07d3nGGXCjSZjpE=; b=PQt+fUK2SYNuQC3obGar
	4WJItAQzpJi6b+t6q8bs4iNuuRYSOMLMFAD1IoqMx4T5p/hOleGyx+6l8YZTUiwz
	b79gQ+teN3LfUfkY6nqMR8uBk8Qw508ZmmL7KTXnTIwpTNi3nRXqZuBexBxFOdRu
	hId2T7QBtj5jIwfVQv4fTsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=v7moCD90alyN/XVupfd7/z2JI/XfkvrU514B+Jd0SSAsbq
	6LfGOrgBNC/11Ip9sC/H8SLWRkf0xsgabQXBOUqQVoxKYJB/K7PVGwN5dZ0XOOCe
	2E4WVC0AEJz6gHZCWWer+s4CGVGZtBUN6zEGdMonh0vRXHjPI3c3AMTopkj4g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F6ABBCD2;
	Tue,  1 Jan 2013 15:52:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B28ADBCD1; Tue,  1 Jan 2013
 15:52:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 252FE6B4-5455-11E2-8F5D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212439>

Adam Spiers <git@adamspiers.org> writes:

> diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
> index 0356d25..944fc39 100644
> --- a/Documentation/technical/api-directory-listing.txt
> +++ b/Documentation/technical/api-directory-listing.txt
> @@ -9,8 +9,11 @@ Data structure
>  --------------
>  
>  `struct dir_struct` structure is used to pass directory traversal
> -options to the library and to record the paths discovered.  The notable
> -options are:
> +options to the library and to record the paths discovered.  A single
> +`struct dir_struct` is used regardless of whether or not the traversal
> +recursively descends into subdirectories.

I am somewhat lukewarm on this part of the change.

The added "regardless of..." does not seem to add as much value as
the two extra lines the patch spends.  If we say something like:

	A `struct dir_struct` structure is used to pass options to
        traverse directories recursively, and to record all the
        paths discovered by the traversal.

it might be much more direct and informative, I suspect, though.

After all, the word "traversal" pretty much implies that the library
goes in and out of the directories recursively.

> @@ -39,7 +42,7 @@ options are:
>  	If set, recurse into a directory that looks like a git
>  	directory.  Otherwise it is shown as a directory.
>  
> -The result of the enumeration is left in these fields::
> +The result of the enumeration is left in these fields:

Good eyes.

> diff --git a/dir.c b/dir.c
> index ee8e711..89e27a6 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2,6 +2,8 @@
>   * This handles recursive filename detection with exclude
>   * files, index knowledge etc..
>   *
> + * See Documentation/technical/api-directory-listing.txt
> + *
>   * Copyright (C) Linus Torvalds, 2005-2006
>   *		 Junio Hamano, 2005-2006
>   */
> @@ -476,6 +478,10 @@ void add_excludes_from_file(struct dir_struct *dir, const char *fname)
>  		die("cannot use %s as an exclude file", fname);
>  }
>  
> +/*
> + * Loads the per-directory exclude list for the substring of base
> + * which has a char length of baselen.
> + */
>  static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>  {
>  	struct exclude_list *el;
> @@ -486,7 +492,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>  	    (baselen + strlen(dir->exclude_per_dir) >= PATH_MAX))
>  		return; /* too long a path -- ignore */
>  
> -	/* Pop the ones that are not the prefix of the path being checked. */
> +	/* Pop the directories that are not the prefix of the path being checked. */

The "one" does not refer to a "directory", but to an "exclude-list".

	Pop the ones that are not for parent directories of the path
	being checked

perhaps?
