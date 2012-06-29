From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Apostrophe at the end of author name
Date: Fri, 29 Jun 2012 12:04:18 -0700
Message-ID: <7vd34i3pot.fsf@alter.siamese.dyndns.org>
References: <20120629124122.GG1258@camk.edu.pl>
 <robbat2-20120629T170457-788694600Z@orbis-terrarum.net>
 <20120629174358.GB3804@sigill.intra.peff.net>
 <20120629181701.GB6533@camk.edu.pl>
 <20120629182944.GA20346@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 29 21:04:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkgUW-000471-6z
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 21:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416Ab2F2TEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 15:04:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755856Ab2F2TEX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 15:04:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 858C28AED;
	Fri, 29 Jun 2012 15:04:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2fjjNKhraVJHMjZl7crpxLG/2Q4=; b=HI6CJ5
	dEXkJOzUb1miyfBey2dLU5HEc3JmZ6ZT786MhsaCQnIc7ZLC76ZziJ7RukH46CO3
	tLRasjG8ud7TK0hFPVTvz87VJ3POFfoZKu6QAik0YwdUPNnYaCNfedKV5ssewf67
	fwa57puaC+bg6+ni7xqK/wxnjUG37zh2dAEI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WoGWRUBdhYR49ItTnCQqnmimJLZ7LV2g
	jcytbt9bFavaouWB8acWMXzz6y/mEgE1FXsWiUDH9oQH01F+Pt/n5bMxd2wvua2K
	ru3q2tMSGn8AnQUVoB75blGHI0txM/iFsUfwmWPKBi/pm7BUJSJBfE/Vz2sRNrZf
	rIYGy8if0H4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BB928AEC;
	Fri, 29 Jun 2012 15:04:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F23B18AE8; Fri, 29 Jun 2012
 15:04:21 -0400 (EDT)
In-Reply-To: <20120629182944.GA20346@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 29 Jun 2012 14:29:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C5787F4-C21D-11E1-A120-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200824>

Jeff King <peff@peff.net> writes:

> I'm tempting by the patch below, which would remove only the
> syntactically significant meta-characters ("\n", "<", and ">"), as well
> as trimming any stray whitespace at the edges. The problem is that we
> don't really have a clue how many people were relying on this trimming
> to clean up their names or emails, so there may be regressions for other
> people.

What do you exactly mean by "syntactically significant"?  In other
words, "whose syntax"?

The code with the patch will leave "." out of the crud, so with

	spearce:*:1000:1000:Shawn O. Pearce:/home/spearce:/bin/sh

we would get:

	From: Shawn O. Pearce <spearce@spearce.org>

without dropping the "." in the name.  Your MTA would likely to
reject it.

I think that quoting "syntactically significant meta-characters" in
the context of e-mail headers is a job for the MSA, and the human
readable names in GIT_AUTHOR_NAME should allow any reasonable
character.  And I agree that it is a sane definition of "reasonable"
to exclude "\n", "<", and ">" (and nothing else), as they are the
only "syntactically significant" in the context of commit object
header.

The patch goes in the right direction in that sense, but you need to
make sure that git-send-email and git-imap-send (the only two MSA we
ship) do the right thing when fed names with ".", dq, etc. first.

> diff --git a/ident.c b/ident.c
> index 443c075..4552f8d 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -127,15 +127,8 @@ const char *ident_default_date(void)
>  static int crud(unsigned char c)
>  {
>  	return  c <= 32  ||
> -		c == '.' ||
> -		c == ',' ||
> -		c == ':' ||
> -		c == ';' ||
>  		c == '<' ||
> -		c == '>' ||
> -		c == '"' ||
> -		c == '\\' ||
> -		c == '\'';
> +		c == '>';
>  }
>  
>  /*
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
