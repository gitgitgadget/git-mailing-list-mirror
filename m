From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Sun, 15 Nov 2009 13:03:52 -0800
Message-ID: <7vskcffqkn.fsf@alter.siamese.dyndns.org>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Sylvain Rabot <sylvain@abstraction.fr>
To: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Luben Tuikov <ltuikov@yahoo.com>, "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 22:04:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9mGo-0003uR-Jj
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 22:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbZKOVEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 16:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbZKOVEF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 16:04:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbZKOVEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 16:04:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B46719E125;
	Sun, 15 Nov 2009 16:04:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rDFGkU2kb1qI+XH74AMXzXFUVJw=; b=U2l3MwYJ2K3FBUDpYzSSX10
	+n61y49sIrcCBmcg2NufLDzUsIq85yNk7MQUn/S4EUOkJ1qKkcdYkssk5ohC00w7
	1Al7uzTZTnZO8yHSS35aOSB7E3cy0Ic+hVQYC6D9kuN25D4hYOjpz+r93nxSix1g
	f6FUJxEPWe0lp7b2uGOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xK/s6qxwKDO2hN0hv/XrLZ5Xt76W7VZnRaFCCqcqSm0OA0X1q
	L60JQome5EaZRc+vZ73jBeYI9jwkfTH7FveBCrLwWyH2XZrb0nZV1QXs8kBJv4q5
	fspmtIVn9EJJEESAQqIX/mQlgPDqoEfJNFFr1KctL+mlNsZGeBqwoFWXNM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 597519E124;
	Sun, 15 Nov 2009 16:04:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3BEE79E120; Sun, 15 Nov 2009
 16:03:53 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 66BFF08E-D22A-11DE-B5AF-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132962>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> I made gitweb behave a bit like UserDir module will in apache.
> In fact it's only configuration but I think it could be useful to others.

Thanks.  Any comment from gitweb gangs?

> Basicly it allows users of your server who use git to be able to use
> gitweb to browse their own root project. E.G. :
>
> Alice's private repos :
>
> /home/alice/git/product_a.git (cloned from /var/git/product_a.git)
> /home/alice/git/product_b.git (cloned from /var/git/product_b.git)
> /home/alice/git/product_c.git (cloned from /var/git/product_c.git)
>
> Alice's links to her repos which she wants to be able to browse with gitweb :
>
> /home/alice/gitweb/product_a -> /home/alice/git/product_a.git/.git
> /home/alice/gitweb/product_c -> /home/alice/git/product_c.git/.git
>
> Bare repos :
>
> /var/git/product_a.git
> /var/git/product_b.git
> /var/git/product_c.git
> /var/git/product_d.git
>
> /etc/gitweb.conf :
>
> $projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/var/git/";
>
> Apache configuration :
>
> RewriteRule ^/~([^\/]+)/?$ /cgi-bin/gitweb.cgi
> [QSA,E=GITWEB_PROJECTROOT:/home/$1/gitweb/,L,PT]
>
> So now all users with a gitweb folder in their home will be able to
> browse all git repos in it through http://<host>/~<user>.
>
> You will find a patch enclosed which try to describe best what I did
> and why in the gitweb/README.
