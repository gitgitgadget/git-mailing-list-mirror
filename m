From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH 2/2] check-ignore.c: fix segfault with '.' argument
 from repo root
Date: Tue, 19 Feb 2013 18:53:07 -0800
Message-ID: <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
 <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 03:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7zoO-0004Xr-0Q
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 03:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933914Ab3BTCxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 21:53:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933341Ab3BTCxL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 21:53:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80E6AB62B;
	Tue, 19 Feb 2013 21:53:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8/cvQrbHteRKC6GnB6omk2r9lT0=; b=Rt35PP
	+fU0NozMxrHr3eehxDDrNpbuXx+kxpC0shT0vuXAUnSnxytpsCZWFtjfRIRvo47V
	pqzhayWAYzoML2iKWLv7GGdCCYfyVhUvX03kA/oZ/+eyLJPOOt9li2gz9qoEPvDY
	d6xPJyE9ii7VLjI99bXaFkrER3iDFnQCqRjyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ij2h2AGpwx7sKfz23GbEENonTQAUwCjB
	4hnLrDcaT0jHJBAP3NZMMXaLHrQByNMjni81fZmAU/x12JxSUsdENirKwD3lWhlt
	v2eRmW/NuGtWIgFp/7EzRt6lrmdQ4gOPlnsbynX2m6afZ+Rzjn3DYZxMsbznpCKI
	/pUotGNRQ/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 517EEB62A;
	Tue, 19 Feb 2013 21:53:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9635BB622; Tue, 19 Feb 2013
 21:53:09 -0500 (EST)
In-Reply-To: <20130220020046.GC7860@pacific.linksys.moosehall> (Adam Spiers's
 message of "Wed, 20 Feb 2013 02:00:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8C9565C-7B08-11E2-B2CD-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216675>

Adam Spiers <git@adamspiers.org> writes:

> OK, thanks for the information.  IMHO it would be nice if 'git
> format-patch' and 'git am' supported this style of inline patch
> inclusion, but maybe there are good reasons to discourage it?

"git am --scissors" is a way to process such e-mail where the patch
submitter continues discussion in the top part of a message,
concludes the message with:

	A patch to do so is attached.
	-- >8 --

and then tells the MUA to read in an output from format-patch into
the e-mail buffer.  You still need to strip out unneeded headers
like the "From ", "From: " and "Date: " lines when you add the
scissors anyway, and this is applicable only for a single-patch
series, so the "feature" does not fit well as a format-patch option.
