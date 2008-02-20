From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 11:15:27 -0800
Message-ID: <7vzltv4ey8.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802201337060.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 20:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRuQa-0006sN-9Q
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 20:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbYBTTPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 14:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbYBTTPt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 14:15:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbYBTTPr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 14:15:47 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BDFFD4E7E;
	Wed, 20 Feb 2008 14:15:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 D19784E7B; Wed, 20 Feb 2008 14:15:41 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802201337060.19024@iabervon.org> (Daniel
 Barkalow's message of "Wed, 20 Feb 2008 13:43:53 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74536>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This allows users with different preferences for access methods to the
> same remote repositories to rewrite each other's URLs by pattern
> matching across a large set of similiarly set up repositories to each
> get the desired access.
>
> For example, if you don't have a kernel.org account, you might want
> settings like:
>
> [url "git://git.kernel.org/pub/"]
>       aka = master.kernel.org:/pub
>
> Then, if you give git a URL like:
>
>   master.kernel.org:/pub/scm/linux/kernel/git/linville/wireless-2.6.git
>
> it will act like you gave it:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
>
> and you can cut-and-paste pull requests in email without fixing them
> by hand, for example.

To me, "url.$this_is_what_I_use.aka = $how_they_might_call_it"
initially felt backwards, but the point of the facility is to
allow mapping many ways other people might call it to how you
would (and the other way would not make sense as allowing to map
one thing to multiple is only to introduce unnecessary
ambiguity), so it makes perfect sense.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f2f6a77..44f4c4b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -646,6 +646,11 @@ help.format::
>  	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
>  	the default. 'web' and 'html' are the same.
>  
> +host.<name>.rewritebase::
> +	Additional base URLs which refer to this host. If a URL
> +	matches this, any access to it will use the URL formed with
> +	the corresponding base URL instead of the given URL.
> +

This still stands???

> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index 81ac17f..0115af7 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -44,3 +44,26 @@ endif::git-clone[]
> ...
> +If you have a section:
> +
> +------------
> +	[host "git://git.host.xz/"]
> +		aka = host.xz:/path/to/
> +		aka = work:
> +------------
> +
> +a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
> +rewritten in any context that takes a URL to be
> +"git://git.host.xz/repo.git".

This still stands???
