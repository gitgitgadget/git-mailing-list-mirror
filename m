From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/14] remote: remove dead code in read_branches_file()
Date: Sun, 23 Jun 2013 00:19:17 -0700
Message-ID: <7v38s9i9ai.fsf@alter.siamese.dyndns.org>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
	<1371887901-5659-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 09:19:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqeaJ-0003GW-LM
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 09:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791Ab3FWHTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 03:19:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab3FWHTU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 03:19:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1072A26153;
	Sun, 23 Jun 2013 07:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7gUPlSWLXKKMFGLSks2zjKU4JJc=; b=k1HGeJ
	RTi+c0twMmF9eWGOcVQJgaFXOpFVcqOLMB6UR+RARnUJILIwzDzH9HSNoEJH75UD
	wh6IMcV1bTVlvi8qFLcyLh2fyQ4x+SZhzz5a+A6xiuM8zICNn5uRASEXzvcYTJ81
	bXcxZV5GAdUzUhbu01NK+CqUqRt6S74ruCAMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lj6yZ0cIDTNiXcpQoABpzZ9Udrt4HVYi
	2+Iskww24oJ4Xze7KLH77KIMyNa6tOEtyq1T6YGlnZeyvn69d11T2WlXR0A++6Z0
	oqtLCDjWDAXatGcg3ouAPulSEHUng72easILWWwG9kK4UIAiAfwj+G2mEmbNfYsK
	xaZUOXOrzVU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0034B26152;
	Sun, 23 Jun 2013 07:19:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67C5526151;
	Sun, 23 Jun 2013 07:19:19 +0000 (UTC)
In-Reply-To: <1371887901-5659-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 22 Jun 2013 13:28:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38584C10-DBD5-11E2-90B9-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228722>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> -	/*
> -	 * With "slash", e.g. "git fetch jgarzik/netdev-2.6" when
> -	 * reading from $GIT_DIR/branches/jgarzik fetches "HEAD" from
> -	 * the partial URL obtained from the branches file plus
> -	 * "/netdev-2.6" and does not store it in any tracking ref.
> -	 * #branch specifier in the file is ignored.
> -	 *
> -	 * Otherwise, the branches file would have URL and optionally
> -	 * #branch specified.  The "master" (or specified) branch is
> -	 * fetched and stored in the local branch of the same name.
> -	 */

Removal of the second paratraph is wrong, isn't it?

>  	frag = strchr(p, '#');
>  	if (frag) {
>  		*(frag++) = '\0';
>  		strbuf_addf(&branch, "refs/heads/%s", frag);
>  	} else
>  		strbuf_addstr(&branch, "refs/heads/master");
> -	if (!slash) {
> -		strbuf_addf(&branch, ":refs/heads/%s", remote->name);
> -	} else {
> -		strbuf_reset(&branch);
> -		strbuf_addstr(&branch, "HEAD:");
> -	}
> +
> +	strbuf_addf(&branch, ":refs/heads/%s", remote->name);
>  	add_url_alias(remote, p);
>  	add_fetch_refspec(remote, strbuf_detach(&branch, NULL));
>  	/*
