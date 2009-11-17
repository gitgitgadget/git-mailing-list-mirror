From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 12:15:28 -0800
Message-ID: <7vhbssewm7.fsf@alter.siamese.dyndns.org>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Tue Nov 17 21:15:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAUSt-0005N3-4a
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 21:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbZKQUPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 15:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbZKQUPe
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 15:15:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbZKQUPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 15:15:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 720969FFA4;
	Tue, 17 Nov 2009 15:15:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Xk2XazCQ0LkeyTIItUCbpUn/fE=; b=XODBh/
	hejn5eSxk7ykZ9gW8o9m48MBBzsEnCoUreLleF7Lcvviii28QOKal0yZSIG2Ze+u
	ExXOLYli7HYUUudB2oZsavEC+0HJNXIrXMEenTUxbc0J0ryW2llhouyz1aGZONzL
	W788u1QD1tdgwZLw+jTLxvGV8f5Foqv1CW2xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qqGXCIfGGemGUMQjQLNJppB7NOcFnQaj
	HdTv9PPzIhOS+s88Lzp4DqfKLKIb0UvLCXq00HgCvbMSEeG72Vq1VmI7gJqNojdO
	N6P2KslZOB+KgFSu76PHbRNXxRRBJ9/zfSvRxrOkNzvux1P5mRVEPK2vBnN3JBHJ
	7HVCPj64tiM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 426909FFA0;
	Tue, 17 Nov 2009 15:15:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B93F59FF9F; Tue, 17 Nov 2009
 15:15:30 -0500 (EST)
In-Reply-To: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
 (Sylvain Rabot's message of "Sun\, 15 Nov 2009 11\:04\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F6DF7AE0-D3B5-11DE-A7F0-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133100>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> +If you want gitweb to act a bit like UserDir mod in apache, knowing, http://<host>/~<user> 
> +will list all git repos of <user> located in a special directory in his home (/home/<user>/gitweb/), 
> +do the following steps :
> +
> +Add this to the VirtualHost section of your apache configuration file :
> +
> +   RewriteRule ^/~([^\/]+)/?$  /cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/gitweb/,L,PT]
> +
> +Modify your gitweb.conf file, located at /etc/gitweb.conf in this example, with :
> +
> +   $projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/path/to/the/defaul/project/root"; 
> +
> +Thus, each user with a gitweb folder in his home will be able to browse it with gitweb.
> +/!\ The gitweb folder and user's home folder must be readable by the webserver user.

Wouldn't it be a good idea to somehow make this work well together with
the --user-path feature of git-daemon?

Perhaps the recommended name given in the example shouldn't be ~/gitweb,
but more like ~/public_git, as this is like ~/public_html but for git
repositories.  Then the end users will browse

	http://my.site/~gitster/public_git/git.git

and gitweb can be told to show

	clone URL: git://my.site/~gitster/public_git/git.git

on the page.  If the site administrator runs git-daemon with --user-path
set to public_git, everything will work seamlessly, no?
