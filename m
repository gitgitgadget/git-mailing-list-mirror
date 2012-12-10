From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Use of a mailmap file with git-log
Date: Mon, 10 Dec 2012 12:05:47 -0800
Message-ID: <7vk3spad0k.fsf@alter.siamese.dyndns.org>
References: <CALKB1SXdNVsQop5VYmShOMx93+j5SPdkGF9yNU5k7nXg87TwMw@mail.gmail.com>
 <7v38zdbv6d.fsf@alter.siamese.dyndns.org>
 <CALWbr2ydMkR_O-Gev7k-HjGadRJMv0UH3XdqtM0Jt=vC82GwJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rich Midwinter <rich.midwinter@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 21:06:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti9c7-0004y5-CY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 21:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab2LJUFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 15:05:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39217 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab2LJUFt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 15:05:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5121CACD4;
	Mon, 10 Dec 2012 15:05:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O8om9dR2odASPGSMnnNlV9LX4wg=; b=Z+ttkG
	41qZYQ7a+Xo70wwAjJQOeW6njRInt0X3bKez4Bcqvuj94FueMQ2ihcElu7ncCn+b
	uyUGEJwnGJ0wxaMJjCaPjuu2J1yPNOiLN6iQGbYLdXKTumfeIUMCL+is3I/YKLv0
	dl1yiGmK4uovQMlsbDwo/Pg3b7eZK0kFCBkoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bW21eJgm8TJM6IXYDJQuyTdFkGg2XA6m
	FlCqENRH+9YTDziGnH/RnDamzO77/7WSP07VyTQnPh/CEBeLSR/nxAApNaeepS4F
	NNvUu2LAobE4r91FsK4V4Jv7bC1+EhfvTMZEpJzQYHDI2D2wutgWOu3wAoRHEZ1i
	w8jaoFqy7Nk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E008ACD2;
	Mon, 10 Dec 2012 15:05:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1EA1ACD0; Mon, 10 Dec 2012
 15:05:48 -0500 (EST)
In-Reply-To: <CALWbr2ydMkR_O-Gev7k-HjGadRJMv0UH3XdqtM0Jt=vC82GwJw@mail.gmail.com> (Antoine
 Pelisse's message of "Mon, 10 Dec 2012 20:47:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD8D76BE-4304-11E2-8FE5-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211272>

Antoine Pelisse <apelisse@gmail.com> writes:

> Yet I'm afraid it could be:
> 1. expensive to rewrite all commit log (reallocating the buffer)
> 2. Inappropriate to change the value in function that is supposed to
> read

In my suggestion I avoided rewriting the log buffer, primarily
because of #2 (in addition to "read" cleanliness, such a change may
break the gpg signature checking for merges).

We do reencode the contents before we write it out when "encoding"
is present, so logically such a rewrite of authors and committers
belongs to where that happens, in pretty_print_commit().  Note that
this existing rewrite is not done to the commit log buffer but is to
a separate buffer meant to be used only for output.
