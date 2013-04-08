From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rev-parse: add --filename-prefix option
Date: Mon, 08 Apr 2013 08:07:32 -0700
Message-ID: <7vmwt9ysaz.fsf@alter.siamese.dyndns.org>
References: <cover.1365364193.git.john@keeping.me.uk>
 <ba2c7aa9eaa982306f1d5ad5ff2d26a6e2b8df85.1365364193.git.john@keeping.me.uk>
 <20130407221458.GE19857@elie.Belkin> <20130408083123.GN2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:34:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPF0V-0003oz-1j
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095Ab3DHPHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 11:07:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965063Ab3DHPHf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 11:07:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6D4114612;
	Mon,  8 Apr 2013 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=XL4Jq1JLkjnot/gdoRBG6Vr2TRU=; b=F9SREFB8gAMnVUtce3R3
	iGoB+WaBh0wAs9tsOKijgKrzTU1/JOGnGun0Xu2yzFTHXUZls7D2T2GQfxdZSrKv
	2JkkbVJ+Ktnft5gEXXVrjoX6DIX9vyJL4nJLo6sr9M6CKlPgYT2ifm9cOijBWcCk
	Sa26yQapWa+tU/7AWFumHXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=f9Xs6rVwFbDybJfDkd/Sbq1vnpzczdVl96mYPX6lcUuLeg
	u7vQxFAzolGap35OXftQpaXjC2qNocktEsrcUkj7aFYCCK7PFjQW9HZXsNJMkRh5
	MqRT+7b1hAis4VcFi/ecNw44Ho+nbzVV38xR3WXm0kbVboQEx+Q2dcRLZnvQw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CB4E14611;
	Mon,  8 Apr 2013 15:07:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7C8A14609; Mon,  8 Apr
 2013 15:07:33 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A8D554E-A05E-11E2-846C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220431>

John Keeping <john@keeping.me.uk> writes:

> Yes (ish), the intended usage is something like this:
>
>     prefix=$(git rev-parse --show-prefix)
>     cd_to_toplevel
>     ... parse options here ...
>     # Convert remaining arguments (filenames) into top-level paths:
>     eval "set $(git rev-parse --prefix "$prefix" --sq -- "$@")"
>
> The "ish" is that my current implementation introduced a new variable
> instead of simply resetting the existing "prefix" variable, which I
> assume is what you mean.

This is very sensible.

> That is probably simpler than my
> implementation, but loses the ability to be at an intermediate level,
> for example:
>
>     cd Documentation/
>     eval "set $(git rev-parse --prefix technical/ --sq -- api-strbuf.txt)"

I am not sure in what situation it makes sense to do this.  Where
does "technical/" come from?  For a script that wants to work from a
subdirectory, end-user input would come in the form relative to the
current directory, i.e. "Documentation/" from the top-level, so...
