From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: read and write a repository specific configuration
 file
Date: Sun, 09 Dec 2012 01:18:08 -0800
Message-ID: <7vd2yjeg8f.fsf@alter.siamese.dyndns.org>
References: <50BF6629.8050806@xiplink.com>
 <1354966067-2865-1-git-send-email-stlman@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mbranchaud@xiplink.com, paulus@samba.org
To: =?utf-8?Q?=C5=81ukasz?= Stelmach <stlman@poczta.fm>
X-From: git-owner@vger.kernel.org Sun Dec 09 10:18:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Thd1y-0004JM-SJ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 10:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910Ab2LIJSN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2012 04:18:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36416 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756617Ab2LIJSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Dec 2012 04:18:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A4649D3B;
	Sun,  9 Dec 2012 04:18:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oOAKO2w+8ASR
	5hbpd2ZA23QdHOA=; b=ZPjrjxDbny1jwiaSMrGfQBGsRGw1IBkI0jkJtuaEKj/v
	hcy2xBkcGTp+/IjuCSp3ZaFj+V+cd5OiXiFcp698s1v16W+rerwEFghKi+WS/n2l
	/s0g2Y+p7qHXQ9rrxE7jTE6vX+tuC/J6vh7EI4hXQ2xUxy9/xzeye8QHnflTSiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K+N0BL
	T5hsWCKDYO8WJ13tsCTLk4myqdfZBJ2tmKF5v4zyY4YUmoHJMUy1iLp7JIPkP5ED
	LmHW+MbBeoO4NBlr0HF2gd26X8SipvXA+XIodT4o4W2WJiCHg99IkpY01K5AWFX6
	l13j4ehP9jfDzTJwn1gsKdbYhTkrNVcK9WQnE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36AAA9D3A;
	Sun,  9 Dec 2012 04:18:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90D7D9D39; Sun,  9 Dec 2012
 04:18:09 -0500 (EST)
In-Reply-To: <1354966067-2865-1-git-send-email-stlman@poczta.fm>
 (=?utf-8?Q?=22=C5=81ukasz?= Stelmach"'s message of "Sat, 8 Dec 2012 12:27:47
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 594A2FD0-41E1-11E2-AB2C-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211229>

=C5=81ukasz Stelmach <stlman@poczta.fm> writes:

> Enable gitk read and write repository specific configuration
> file: ".git/k" if the file exists. To make gitk use the local
> file simply create one, e.g. with the touch(1) command.
>
> This is very useful if one uses different views for different
> repositories. Now there is no need to store all of them in
> ~/.gitk and make the views list needlessly long.

I do not use gitk heavily myself, but I have a mixed feeling about
this patch.

=46orking the configuration from the one true ~/.gitk is easy; it is
just the matter of copying it to repository specific location.  Once
forked, however, it is very hard to merge these configuration files
sprinkled across repositories back, or more importantly, change the
settings globally.  Imagine you just got a new monitor that is a lot
finer grained than the one you have been usingq, and your choice of
font size has been specified in terms of pixels; you would want to
show all gitk windows in larger font now, regardless of the
repository, but you now have to go to 47 different configuration
files and update them.

So I suspect that this may introduce more trouble than it is worth
for users and should not be sold with a "This is very useful" label.
At best, it is "This may be useful"; otherwise the feature may end
up harming our users.  I'd phrase it without judging if it is good
or bad for the users, perhaps like this:

    This allows one to specify different views for different
    repositories.

In any case, the filename .git/k may be _cute_, but I do not think
we would want to see:

    $ ls .git
    branches        config       HEAD   index  k     objects
    COMMIT_EDITMSG  description  hooks  info   logs  refs

It is too cryptic, unless the user _knows_ 'k' is for gitk.  I'd
call it $GIT_DIR/gitkconfig or something, if I were supportive for
this feature (which I am not enthusiastic, yet).

Thanks.
