From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow generating a non-default set of documentation
Date: Sun, 07 Oct 2012 15:40:19 -0700
Message-ID: <7vwqz1oqi4.fsf@alter.siamese.dyndns.org>
References: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
 <20121007214855.GB1743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:40:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKzWS-0001SJ-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 00:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab2JGWkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 18:40:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab2JGWkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 18:40:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E5798EB7;
	Sun,  7 Oct 2012 18:40:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zn3zQZY7c7fTQtHe/rjG9G1e1mc=; b=bmQfie
	CNUvZKq0qx0FB8Rfg5Mf2hCQs+jqCKn7vWqtO+2qJhQcvAwPrvKZSPBqySTQZZRN
	YJwWjAtz5w8W8BK3znAMwjIdoyoE9EcmuHp4geZL0L8sUo1JMKdfvTbanGDMoDa/
	m4iXE+XYGfA095J+snCsYycdhQEadyUfoLs/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z+UQAhKUUagToO//uIdXGhRsCDXD2aVV
	oihB2Aivt1O8vIAMvMYopUf2gdK4cGbYyTNkae8khRY4PMSuy+2ZX5PRlc2C4E4E
	mJ/Az+GbqYQeszB47z2hTuCHrxkhs6vPURjfQ59cc6hP7HUyhv4kow3APbob9HQY
	yLMn5GEKXzI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D39D8EB6;
	Sun,  7 Oct 2012 18:40:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC5128EB4; Sun,  7 Oct 2012
 18:40:20 -0400 (EDT)
In-Reply-To: <20121007214855.GB1743@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 7 Oct 2012 17:48:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9AE99C2-10CF-11E2-BB4E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207209>

Jeff King <peff@peff.net> writes:

> On Sun, Oct 07, 2012 at 01:39:32PM -0700, Junio C Hamano wrote:
> ...
>> but it is not so far-fetched to imagine that Windows users may want to
>> omit manpages with
>> 
>>     $ DEFAULT_DOC_TARGET=html make doc
>
> That use case makes a lot more sense to me (or more likely setting it in
> config.mak).

I actually had "ifeq ($(uname_S),Windows)" at the top-level in mind,
not config.mak.  I think that is far more important use case than
going down to Documentation yourself and run make there (which is
not a workflow I deeply care about in the first place).

>>  Makefile | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> No change to Documentation/Makefile? So this will work:
>
>   $ echo DEFAULT_DOC_TARGET=html >config.mak
>   $ make doc
>
> but this will not:
>
>   $ cd Documentation
>   $ make
>
> Why not do it like this:
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 267dfe1..ca10313 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -152,7 +152,8 @@ endif
>  endif
>  endif
>  
> -all: html man
> +DEFAULT_DOC_TARGET ?= html man
> +all: $(DEFAULT_DOC_TARGET)
>  
>  html: $(DOC_HTML)
>  
>
> which covers both cases? That is also how we handle DEFAULT_TEST_TARGET.
>
> -Peff
