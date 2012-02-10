From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Move git_version_string to help.c before diff
 changes
Date: Fri, 10 Feb 2012 09:58:08 -0800
Message-ID: <7vty2yr2of.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com>
 <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl>
 <1328891972-23695-2-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Feb 10 18:58:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvujg-0003lS-0E
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 18:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab2BJR6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 12:58:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177Ab2BJR6K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 12:58:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27C765FB7;
	Fri, 10 Feb 2012 12:58:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0+nOnfMcDZrC
	bEN0oTKd7MUvupM=; b=P926xiBMbnSKYT19mFdthVN4BXe0fCV4Snt5cK6dU6OV
	Zrz0ymlnxue9vuWvFs6lE0n6ksEp4LRRp1EYkzYSZeNn8wKduwXEoeHRrpJl6NU4
	VonqSQYwOlty2fXi7ZA3J2RbTASnimfxqt7UEdIIRoY9ymDWUEzDEAV9vP6OoMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=x0LtIf
	ukuqXkgQWIw+HtIi9edbCKFgJS/3/pxh9wFAvAl+LHTUvrN18dY2ylqLYOihDORC
	x9bBpllBGsEmX1cUB+/8+gu/J0Xwq/27asxtcC+lKfsjvdf7v++dQ0opYVc4hVK5
	xDYDj6XriCVLx/BNwYMEaGV3+sGZqXlIzbX00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C80E5FB6;
	Fri, 10 Feb 2012 12:58:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A04E25FB4; Fri, 10 Feb 2012
 12:58:09 -0500 (EST)
In-Reply-To: <1328891972-23695-2-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Fri, 10 Feb 2012
 17:39:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAD04E1A-5410-11E1-8802-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190427>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> git_version_string lives in git.c. When diff.c starts to use function=
s
> from help.c, which in turn use git_version_string, linking against
> libgit.a will fail. This is because git_version_string is physically
> located in git.o, and this object file is not part of libgit.a.

But what is wrong about that?

If you are making the termio related code reusable and sharable by turn=
ing
the static "term_columns()" in help.o into an external symbol, there is=
 no
reason that termio related function, which is now useful outside the
context of giving help, must stay in help.c where its life happened to
have started.  In fact, "tell me how wide the terminal is" does not bel=
ong
to something called "help subsystem", no?

Wouldn't a new file, term.c or something, be a lot more suitable home f=
or
the function you will be reusing from diff and other parts of the syste=
m?
