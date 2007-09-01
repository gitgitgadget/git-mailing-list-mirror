From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag: Fix -l option to use better shell style globs.
Date: Fri, 31 Aug 2007 23:16:21 -0700
Message-ID: <7v8x7qvrka.fsf@gitster.siamese.dyndns.org>
References: <46D8F431.70801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 08:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRMHX-0002b2-Ol
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 08:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbXIAGQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 02:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbXIAGQ1
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 02:16:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbXIAGQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 02:16:26 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 88BD612AC64;
	Sat,  1 Sep 2007 02:16:44 -0400 (EDT)
In-Reply-To: <46D8F431.70801@gmail.com> (Carlos Rica's message of "Sat, 01 Sep
	2007 07:10:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57257>

Carlos Rica <jasampler@gmail.com> writes:

>  	if (pattern == NULL)
> -		pattern = "";
> +		pattern = "*";
>
> -	/* prepend/append * to the shell pattern: */
> -	newpattern = xmalloc(strlen(pattern) + 3);
> -	sprintf(newpattern, "*%s*", pattern);
> -
> -	filter.pattern = newpattern;
> +	filter.pattern = pattern;
>  	filter.lines = lines;
>
>  	for_each_tag_ref(show_reference, (void *) &filter);

I think it is conceptually simpler on the show_reference side to
allow (filter.pattern == NULL) and say:

	if (!filter->pattern || !fnmatch(filter->pattern, refname, 0)) {
        	... show that ref ...
	}

It is not such a big deal now you do not do newpattern
allocation anymore, so I'll apply the patch as is.
