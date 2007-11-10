From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make builtin-tag.c use parse_options.
Date: Sat, 10 Nov 2007 13:25:44 +0100
Message-ID: <1b46aba20711100425o2f351ac5o81537adc6f09dc80@mail.gmail.com>
References: <473463E0.7000406@gmail.com>
	 <7vabpmpr9y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Pierre Habouzit" <madcoder@debian.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 13:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqpPW-0007Jj-3M
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 13:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbXKJMZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 07:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbXKJMZq
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 07:25:46 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:14605 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbXKJMZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 07:25:45 -0500
Received: by rv-out-0910.google.com with SMTP id k20so723803rvb
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 04:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JJBtz1jL0JyX97vyt9weOUFFSrfIqSIChhjcdgiwJP4=;
        b=XWL4XBe/RIlaKy6xjAiLeaLX37Sn2abdw6GGxCUs8H1W9HwoUvGXSyPocEvldT0BV8trWbfwnYcDFgT2a/12edtxXGIiBgY0YWfokPD5rI0hEYVMm1bta7zSOahHM+AjuiC+YzgeJt0iG7iLd6ICLHQkJshV1HoHG7hskReFt80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mbl2suxAh2fCyp7JaRtUDu3fZspROoDvvUqvEiAFS4JC+KhedbFX5U/klFwhQLs+vVvuw3GLGUoLzpxeGFDpQ8tfzWk6y6KYaIUQdgSrK1XZ0xrsYgHAwEO3tVhkgGReRUq2sQuFtPSiT9TjBJkmk0WSQmEQe7K+9ZJ0qiONSJk=
Received: by 10.142.131.18 with SMTP id e18mr532952wfd.1194697544953;
        Sat, 10 Nov 2007 04:25:44 -0800 (PST)
Received: by 10.142.88.7 with HTTP; Sat, 10 Nov 2007 04:25:44 -0800 (PST)
In-Reply-To: <7vabpmpr9y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64338>

2007/11/10, Junio C Hamano <gitster@pobox.com>:
> Carlos Rica <jasampler@gmail.com> writes:
>
> > Also, this removes those tests ensuring that repeated
> > -m options don't allocate memory more than once, because now
> > this is done after parsing options, using the last one
> > when more are given. The same for -F.
>
> The reason for this change is...?  Is this because it is
> cumbersome to detect and refuse multiple -m options using the
> parseopt API?  If so, the API may be what needs to be fixed.
> Taking the last one and discarding earlier ones feels to me an
> arbitrary choice.
>
> While I freely admit that I do not particularly find the "One -m
> introduces one new line, concatenated to form the final
> paragraph" handling of multiple -m options done by git-commit
> nice nor useful, I suspect that it would make more sense to make
> git-tag and git-commit handle multiple -m option consistently,
> if you are going to change the existing semantics.  Since some
> people really seem to like multiple -m handling of git-commit,
> the avenue of the least resistance for better consistency would
> be to accept and concatenate (with LF in between) multiple -m
> options.
>
> With multiple -F, I think erroring out would be the sensible
> thing to do, but some people might prefer concatenation.  I do
> not care either way as long as commit and tag behave
> consistently.

A solution not needing memory allocation into the option parser
could be setting a callback running over the repeated option
arguments, passing them to the function one per each call.
Then, the user will be able to decide if he wants the arguments
concatenated or only need one of them and prefers erroring out.

Is this already possible with the current parser or the callback
mode only calls using the last option?
