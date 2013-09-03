From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 03 Sep 2013 10:12:18 -0700
Message-ID: <xmqqioyhu8wd.fsf@gitster.dls.corp.google.com>
References: <20130831194425.GA14706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:12:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGu9R-0007i3-AF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab3ICRMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:12:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab3ICRMV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:12:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DA743FD79;
	Tue,  3 Sep 2013 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pJYhZKsBP7p6wBP7PB3lV3O1g3Q=; b=vS9cuo
	iP/tD0458LuwRcy+rEgU+ChmZ8uFx1GwZoRrscyizbPqAROol0gG1YZhWMUWK3y5
	13Xbc5kfbjQGV5QqIrXuEwOyjyrccZRmNjudsHzGbbjYnCfo1b3NlsOuaindjyk6
	fqJ5bLZrVEVWBc8Z0UC/Dl45cFKRQF46pFVWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GGwshAN9JcHyVN51rxxtded3zDBLVajL
	s7Md7ohCYXCR00dyOGGYGtErL2W11lckgwVnH4BX8xEAAYwvwLE1LGb9PRO7B7e4
	gLAWNt/3r8T9Rhm4pbZvLVK25XNSD+GCuya1JY+yPgw5RjMjyyWGTe9ZONEW1cKR
	7e2CBD54FW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92EC63FD78;
	Tue,  3 Sep 2013 17:12:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFD143FD72;
	Tue,  3 Sep 2013 17:12:19 +0000 (UTC)
In-Reply-To: <20130831194425.GA14706@redhat.com> (Michael S. Tsirkin's message
	of "Sat, 31 Aug 2013 22:44:25 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FDC023F0-14BB-11E3-910D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233742>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> I always want my diffs to show header files first,
> then .c files, then the rest. Make it possible to
> set orderfile though a config option to achieve this.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

I admit that I was the guilty one who introduced the orderfile, but
I think the feature was misguided (for one thing, it breaks the
patch-id, I think).  So I am moderately hesitant to promote its use
with an addition like this.

>  diff.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index 208094f..cca0767 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -264,6 +264,9 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +        if (!strcmp(var, "diff.orderfile"))
> +                return git_config_string(&default_diff_options.orderfile, var, value);
> +
>  	if (!prefixcmp(var, "submodule."))
>  		return parse_submodule_config_option(var, value);
