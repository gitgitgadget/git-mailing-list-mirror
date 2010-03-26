From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: readme fixed regarding per user project root
 repository
Date: Fri, 26 Mar 2010 11:52:29 -0700
Message-ID: <7v39zmnceq.fsf@alter.siamese.dyndns.org>
References: <1269296130-2237-1-git-send-email-sylvain@abstraction.fr>
 <1269296130-2237-2-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Fri Mar 26 19:52:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvEeC-0005mD-IH
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 19:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab0CZSwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 14:52:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab0CZSwi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 14:52:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82FC6A5B3E;
	Fri, 26 Mar 2010 14:52:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CMDbhsSgZiZthMzDflI3S8jmbQc=; b=gb2ghE
	Qw/HCTYaqfWcPZe/VlXdfG7amkLV6FOv4uUzNJ0HJ1LG2xRF313E9PqTZwonKgmN
	omkY3DxI/JjnoJoEPNEgjIV+mx5ReVJs6NELQRaANa7UOHqmCIdb0e6YWvuzG56N
	lWldT3x84mq+KFPHHG+yxW51t2oXFcEshxATM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B59LnVz8L7J85VdniJbRZMVgxfdI8Mf+
	sMm1CAipQM7ReJ+Vnrc0xOizmUkjXpIYaeSaEoQ5xtgiXBnOXpzcYXoJgLm+/EEA
	dBVESN4V2/el3TpxtbPWrE62CwGIZuCitONV45afZTOTw5NuTOPhcs8kxwNXD/eb
	oW0qDGfEgi0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EA31A5B23;
	Fri, 26 Mar 2010 14:52:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28995A5B18; Fri, 26 Mar
 2010 14:52:31 -0400 (EDT)
In-Reply-To: <1269296130-2237-2-git-send-email-sylvain@abstraction.fr>
 (Sylvain Rabot's message of "Mon\, 22 Mar 2010 23\:15\:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BD4D2DB4-3908-11DF-8F11-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143264>

I was waiting for gitweb people to respond, but nobody seems to be
interested so here is my take on it.

Sylvain Rabot <sylvain@abstraction.fr> writes:

> + the RewriteRule '/+<user>' is not working as the '+' character is
>   replaced by a space in urls when you click on links. it is replaced by '/u/<user>'

I think the _only_ value of having this example, in addition to the next
one that uses "http://host/user/<me>" notation, was to demonstrate that
you do not necessarily have the actual user name and the magic token (be
it "user" or "u") that introduces the per-user hierarchy as separate path
components delimited with a slash.  Changing "+<me>" to "u/<me>" removes
that only additional value from this example.

Anybody moderately intelligent would be able to guess "u/<me>" if she
finds "user/<me>" too long to her taste, so I would suggest updating the
example to allow "http://host/+<user>/" but spell the rewrite rule in such
a way that actually does work.  An alternative is to just remove it.

By the way, does mod-rewrite configuration allow "~<me>" (home-directory
expansion) when setting the environment?  You currently do:

    E=GITWEB_PROJECTROOT:/home/$1/public_git/

but if we somehow could write it like

    E=GITWEB_PROJECTROOT:~$1/public_git/

it would be more generally useful, no?

> + the RewriteRule '/user/<user>' updated to allow
>   '/user/<user>', '/user/<user>/' and '/user/<user>/gitweb.cgi'

Please describe what you added relative to the original, not just what the
final result looks like.  "updated to allow A B C" doesn't tell the reader
"it used to redirect only A and C to gitweb request, but B wasn't
rewritten.", which seems to be the case if I am reading your regexp
correctly.  Describing why it is better to also rewrite B would be a good
idea, too, if it is not obvious.

> + some typos fixed
>
> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>

> diff --git a/gitweb/README b/gitweb/README
> index ad6a04c..bc90f4d 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -347,18 +347,18 @@ something like the following in your gitweb.conf (or gitweb_config.perl) file:
>    $home_link = "/";
>  
>  
> -Webserver configuration with multiple projects' root
> -----------------------------------------------------
> +Webserver configuration with multiple project roots
> +---------------------------------------------------

Ok.

> -If you want to use gitweb with several project roots you can edit your apache
> -virtual host and gitweb.conf configuration files like this :
> +If you want to use gitweb with several project roots then you can edit your
> +apache virtual host and gitweb.conf configuration files like this :

Ok (you might want to remove SP before colon, though).

>  virtual host configuration :
>  
>  <VirtualHost *:80>
> -    ServerName			git.example.org
> -    DocumentRoot		/pub/git
> -    SetEnv				GITWEB_CONFIG	/etc/gitweb.conf
> +    ServerName		git.example.org
> +    DocumentRoot	/pub/git
> +    SetEnv		GITWEB_CONFIG	/etc/gitweb.conf

What is this reindentation for?  "Just cosmetic" is an acceptable answer
as long as the change resulted in cosmetic improvement, but it doesn't
seem to be cosmetic improvement, either.

Thanks.
