From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Patch v3] string-list: Document STRING_LIST_INIT_* macros.
Date: Sun, 5 Sep 2010 19:22:49 -0500
Message-ID: <20100906002249.GB18060@burratino>
References: <1283731991-15080-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 02:24:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsPVy-0001HT-LC
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 02:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab0IFAYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 20:24:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63321 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab0IFAYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 20:24:45 -0400
Received: by iwn5 with SMTP id 5so3675969iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 17:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=50ZsTnOm4euMYT+q0ChT+0NKhEvvhzdEHXTdnSEucas=;
        b=cNF91RvBXWq8MTCmPcriP+Avbn5OZZQL2vBjbr2hXjnoeO1PBjvmRDqsOvgUeGxw0V
         QWxty3jS6NgmnGJG2KJAuCl050UYmh0+T3L79KfL/CDCJwoXFeVGiH63xVG1fmQFXg8O
         PMmcxubbDCYjpd18bWtyPUcnLOQmEk1rztzsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OlAxzOiO+2O03bMVh6cXrphgPSw1lO6BJAlLmr7tBVtZApnSnFdndlISuf+Bhn6bac
         xOwzRSpXNa4lvXdQNrgWK87Nr3Oc8TAA2f05moi14NO/1YsBDoT+i9v8bWbnG/Sy01Cs
         T3VenOod5FAWxeRuZ0aDiyRSyCerwkBqQBnt8=
Received: by 10.231.11.72 with SMTP id s8mr5243583ibs.110.1283732683889;
        Sun, 05 Sep 2010 17:24:43 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm5149398ibk.15.2010.09.05.17.24.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 17:24:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283731991-15080-1-git-send-email-tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155507>

Thiago Farina wrote:

> +++ b/Documentation/technical/api-string-list.txt
> @@ -11,10 +11,15 @@ The caller:
>  
>  . Allocates and clears a `struct string_list` variable.
>  
> -. Initializes the members. You might want to set the flag `strdup_strings`
> -  if the strings should be strdup()ed. For example, this is necessary
> -  when you add something like git_path("..."), since that function returns
> -  a static buffer that will change with the next call to git_path().
> +. Initializes the members. A string_list might be initialize by

s/initialize/initalized/, I think.

> +  `= STRING_LIST_INT_NODUP` or `= STRING_LIST_INIT_DUP` before it can be used.
> +
> +  Strings in lists initialized with the _DUP variant will be
> +  automatically strdup()ed on insertion and free()ed on removal.
> +  For example, this is necessary when you add something like
> +  git_path("..."), since that function returns a static buffer
> +  that will change with the next call to git_path().

If we do not have a string_list_init() function, maybe it is worth
mentioning how a person can use

 memset(&list, 0, sizeof(struct string_list));
 list.strdup_strings = 1 or 0;

too?

The previous text tried (too subtly, perhaps) to imply that with the
"clears" (for memset) and "might want to set the flag `strdup_strings`"
phrases.

> @@ -34,10 +39,9 @@ member (you need this if you add things later) and you should set the
>  Example:
>  
>  ----
> -struct string_list list;
> +struct string_list list = STRING_LIST_DUP;
>  int i;
>  
> -memset(&list, 0, sizeof(struct string_list));
>  string_list_append(&list, "foo");
>  string_list_append(&list, "bar");
>  for (i = 0; i < list.nr; i++)

Probably worth copying and pasting this code to another file and
trying it to make sure it works for the final draft.

Also, I am afraid I will not be able to send detailed reviews on
uncomplicated patches like this one in the future.  It simply does not
scale (though I like for people to learn, at a certain point it
becomes faster to do things myself).

So if you can, it is best to find ways to motivate other people to
help with your work, by conveying what problems it will solve (in this
case: people might be confused about the initialization sequence; as
part of patch 3 demonstrated, the invariants regarding strdup_strings
are not being described clearly enough) and finding ways to minimize
the time other people have to spend to get it done.

Regards,
Jonathan
