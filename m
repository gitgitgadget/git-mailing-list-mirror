From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Fri, 07 Dec 2012 12:23:41 -0800
Message-ID: <7vsj7hfw6q.fsf@alter.siamese.dyndns.org>
References: <50C22B15.1030607@xiplink.com>
 <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com>
 <7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 21:24:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th4Sm-0006Vl-Ti
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 21:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424169Ab2LGUXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 15:23:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047Ab2LGUXo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 15:23:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44AF7965A;
	Fri,  7 Dec 2012 15:23:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nu0nwZh5xmYASMpQQweMRhxmABQ=; b=Kg1c7A
	g6mbjk28eqV6srMbVU6Tgv+NnKO7NnrM2U7abRyYtmsPexGOFN9EweB7EAvLR5eW
	6u0TeMshStyPxT7Noim5n2X8eMwAzlKv1ryPqpYoFhBiSQAl2XAm+9qM1uIF6OdE
	rvqihxWibo6MbFHgQKZc4YsM5IjXIhNif9JBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dt//YwObuiySVSSkbw/TXWnJjVTWO6oX
	1NpwWGRO7IgafJsF9Xa4aCqyXr0ROfQtbOweyBEfxZ4B6Lt8HG2jcgUeuyznFnOj
	WbORogJoo/sWXN5eXSbMCRL1tODYcS2ucTRTtpCeCNUUm9WlGby7CK2DXTbtfkSp
	dtDUKO7oHK4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FA1B9659;
	Fri,  7 Dec 2012 15:23:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0F349658; Fri,  7 Dec 2012
 15:23:42 -0500 (EST)
In-Reply-To: <50C24ED7.90000@xiplink.com> (Marc Branchaud's message of "Fri,
 07 Dec 2012 15:17:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE6CE660-40AB-11E2-8407-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211190>

Marc Branchaud <marcnarc@xiplink.com> writes:

>     sh-setup: protect from exported IFS
>
>     Many scripted Porcelains rely on being able to split words at the
>     default $IFS characters, i.e. SP, HT and LF.  If the user exports a
>     non-default IFS to the environment, what they read from plumbing
>     commands such as ls-files that use HT to delimit fields may not be
>     split in the way we expect.
>
>     Protect ourselves by resetting it, just like we do so against CDPATH
>     exported to the environment.
>
>     Noticed by Andrew Dranse <adranse@oanda.com>.
>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Perhaps IFS should be set to " \t\n" (which I believe is sh's default)
> instead of just unsetting it altogether?

POSIX.1 says this:

    IFS - A string treated as a list of characters that is used for
    field splitting and to split lines into fields with the read
    command.  If IFS is not set, it shall behave as normal for an
    unset variable, except that field splitting by the shell and
    line splitting by the read command shall be performed as if the
    value of IFS is <space> <tab> <newline>; see Field Splitting.

    Implementations may ignore the value of IFS in the environment, or
    the absence of IFS from the environment, at the time the shell is
    invoked, in which case the shell shall set IFS to <space> <tab>
    <newline> when it is invoked.

So setting it to SP HT LF should not make a difference, or your
shell is buggy.

This is exactly why I asked you about the /bin/sh on your
problematic box.
