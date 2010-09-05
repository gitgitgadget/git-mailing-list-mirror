From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] string-list: Document STRING_LIST_INIT_* macros.
Date: Sun, 5 Sep 2010 18:57:52 -0500
Message-ID: <20100905235752.GA18060@burratino>
References: <1283730055-14477-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 02:00:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsP8J-0002J9-3F
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 02:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab0IEX75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 19:59:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34553 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828Ab0IEX74 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 19:59:56 -0400
Received: by gxk23 with SMTP id 23so1440884gxk.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 16:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6l2ZiTBd0lofajIYM30g6n2/KpImRHI7mgFx4fzjOMI=;
        b=Fl/AGPRxWTNlOmgAxm+GsWgMX9lYV5fnLmndw3EUXFuuxx3aWZNf4IkphR2YTtUAuG
         pfRq7hze3vJg4q4vOF2/4wn9+LvH4OZcv36lnSn9BQTeHgLqXn0Dw6+XE0c2jWcXgezv
         xNAw66G3id4TvIYK6nRos8M5N3M5NGVnc+eaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c7GUf9R6cKktwydM+hqdyLdCByzMY47k3MMMcpi4c3rkSYmNL48TNrB7zeHPFDg1fq
         9jpvueObk6BHQrfgsdgz9yeWCEqDDgz9PtMT1KotHq8p5FV5O/n/7Xg7nIzYZSXIzlA2
         AktIvKgbY8KUP/Px6mTNspXpxt5niXJRInf6Y=
Received: by 10.151.150.18 with SMTP id c18mr603056ybo.358.1283731195667;
        Sun, 05 Sep 2010 16:59:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm5225791ybk.1.2010.09.05.16.59.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 16:59:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283730055-14477-1-git-send-email-tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155501>

Thiago Farina wrote:

> +++ b/Documentation/technical/api-string-list.txt
> @@ -11,7 +11,14 @@ The caller:
>  
>  . Allocates and clears a `struct string_list` variable.
>  
> -. Initializes the members. You might want to set the flag `strdup_strings`
> +. Initializes the members. A string_list has to by `= STRING_LIST_INT_NODUP` or
> +  `= STRING_LIST_INIT_DUP` before it can be used.
> +  Strings in lists initialized with the _DUP variant will be
> +  automatically strdup()ed on insertion and free()ed on removal.
> +  For example, this is necessary when you add something like
> +  git_path("..."), since that function returns a static buffer
> +  that will change with the next call to git_path().
> +
>    if the strings should be strdup()ed. For example, this is necessary
>    when you add something like git_path("...")

Hmm, something seems to have go wrong here.  Did you intend to
insert that line break and duplicate the text below it?

We cannot really say "a string_list has to be initialized with
STRING_LIST_INIT_NODUP or STRING_LIST_INIT_DUP before it is
used" because not all string_lists are statically allocated.
Some (many) are allocated on the heap, which is part of why I
introduced a string_list_init() function in the rfc series.

> @@ -52,6 +58,18 @@ However, if you use the list to check if a certain string was added
>  already, you should not do that (using unsorted_string_list_has_string()),
>  because the complexity would be quadratic again (but with a worse factor).
>  
> +Macros
> +------
> +
> +`STRING_LIST_INIT_NODUP`::
> +
> +	Initialize the members and set the `strdup_strings` member to 0.

I think this section is not very useful.  I think what is intended is
something like

`STRING_LIST_INIT_NODUP`::

	initializer for a string_list with 0 items and the `strdup_strings`
	member equal to 0

but string-list.h says that already:

 struct string_list
 {
	struct string_list_item *items;
	unsigned int nr, alloc;
	unsigned int strdup_strings:1;
 };

 #define STRING_LIST_INIT_NODUP	{ NULL, 0, 0, 0 }

In generally it is not always a good idea to immediately document
every identifier in a project like this one: writing good
documentation takes some time, and maintaining it takes even more, so
when the code already explains something, it tends to be more useful
to document from another angle.

Hope that helps,
Jonathan
