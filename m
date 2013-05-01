From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed, 01 May 2013 10:53:05 -0700
Message-ID: <7vr4hq7fjy.fsf@alter.siamese.dyndns.org>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 19:53:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbDO-0002tM-Vy
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 19:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab3EARxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 13:53:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916Ab3EARxI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 13:53:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC0151A99A;
	Wed,  1 May 2013 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Be0fc9K/kaof7O/reL5AtQH18tk=; b=LXo+J3I2+8q8FQzZA8a4
	lN0kyA/+eieCNBUx7Alll8sElLYzlY3u0t/krY+DhUYOwpnyiQPIxG9MEk8oxYD1
	30UvljTla1Xri78xCtMxVZey9MyNjU076P+fVW1RX4nJ+DVR8j8kkrGGwRE4ku+4
	xy0SYAT+y4xULnPWwwcKErM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=tUvCZxAVR2wxg8d1VLbP4PFkxiXv1PZMBL0+ake0jyGB8c
	4nd3s4+OjHg6aedK1b6hAoviX6WY4Y5VijEibVNGpaM545BQHJo+8ZjfK+MJaDuG
	siv0hw6FcovNluBSDcAJJx1Dy3Q8LIXKg8zqE0UCj4V+wV1Cu3f6kuGHwmpXE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFC291A999;
	Wed,  1 May 2013 17:53:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF4D81A998;
	Wed,  1 May 2013 17:53:06 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAA39030-B287-11E2-BCA4-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223105>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
> can't remove '{0}'?
>
> This patch allows '@' to be the same as 'HEAD'.

While the above reasoning is cute, it is misleading.

If you start from HEAD@{1}~0^0, we can remove '^0', we can remove
'~0', but you cannot remove HEAD from the remaining "HEAD@{1}"
without changing what it means.  @{1} is where the current branch
was, while HEAD@{1} is where you were---they are different when you
have just did "git checkout anotherbranch".  HEAD@{1} is the tip of
your previous branch, @{1} is where anotherbranch was before its tip
became the commit you have checked out.

You have to be specially talking about "HEAD@{0}" as a whole for
that reasoning to hold; it does not work for HEAD@{$n} for an
arbitrary value of $n.

So I'd suggest toning it down, perhaps something like this:

	Even though we often can do without having to type "HEAD",
	e.g. "git log origin.." substitutes missing RHS with "HEAD",
	sometimes we still do need to type "HEAD" (thats six f*cking
	keystrokes "Caps Lock", "H", "E", "A", "D" and finally "Caps
	Lock").

        That is four keystrokes too many to name an often needed
	reference.  Make "@" usable as its synonym.

>
> So now we can use 'git show @~1', and all that goody goodness.
>
> Until now '@' was a valid name, but it conflicts with this idea, so lets
> make it invalid. Probably very few people, if any, used this name.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> diff --git a/sha1_name.c b/sha1_name.c
> index 76e3219..3b06e5e 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -965,6 +965,17 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
>  	return st;
>  }
>  
> +/* parse @something syntax, when 'something' is not {.*} */
> +static int interpret_empty_at(const char *name, int namelen, int len, struct strbuf *buf)
> +{
> +	if (len || name[1] == '{')
> +		return -1;

This function is to handle a string that begins with '@', so by
definition len is zero when anything useful is done by it.  So...

> +	strbuf_reset(buf);
> +	strbuf_add(buf, "HEAD", 4);
> +	return 1;
> +}
> +
>  static int reinterpret(const char *name, int namelen, int len, struct strbuf *buf)
>  {
>  	/* we have extra data, which might need further processing */
> @@ -1025,9 +1036,15 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
>  	cp = strchr(name, '@');
>  	if (!cp)
>  		return -1;
> +
> +	len = interpret_empty_at(name, namelen, cp - name, buf);

... it is suboptimal (from readability point of view) to have the
caller unconditionally call interpret_empty_at() when the function
clearly is marked to handle something that _begins_ with '@'.

I would suggest something like

	if (cp == name)
        	len = interpret_empty_at(name, namelen, buf);

which people may find much easier to follow.

For that matter, it may make even more sense to just remove the
"empty-at" function and inline its body here:

	if (cp == name && name[1] != '{') {
		strbuf_reset(buf);
                strbuf_add(buf, "HEAD", 4);
                len = 1;
        } else {
        	len = -1;
	}

> +	if (len > 0)
> +		return reinterpret(name, namelen, len, buf);
> +
>  	tmp_len = upstream_mark(cp, namelen - (cp - name));
>  	if (!tmp_len)
>  		return -1;
> +
>  	len = cp + tmp_len - name;
>  	cp = xstrndup(name, cp - name);
>  	upstream = branch_get(*cp ? cp : NULL);
> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
> index d5d6244..65584c0 100755
> --- a/t/t1508-at-combinations.sh
> +++ b/t/t1508-at-combinations.sh
> @@ -45,6 +45,9 @@ check "@{u}" upstream-two
>  check "@{u}@{1}" upstream-one
>  check "@{-1}@{u}" master-two
>  check "@{-1}@{u}@{1}" master-one
> +check "@" new-two
> +check "HEAD@{u}" upstream-two
> +check "@@{u}" upstream-two
>  nonsense "@{u}@{-1}"
>  nonsense "@{1}@{u}"
