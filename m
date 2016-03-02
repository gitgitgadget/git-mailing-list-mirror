From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable git clone?
Date: Wed, 02 Mar 2016 00:41:20 -0800
Message-ID: <xmqqziuh46hb.fsf@gitster.mtv.corp.google.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sarah@thesharps.us, viro@zeniv.linux.org.uk
To: Josh Triplett <josh@joshtriplett.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:41:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2LX-0002zR-PW
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 09:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbcCBIlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 03:41:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751167AbcCBIlX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 03:41:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AB8E40A9C;
	Wed,  2 Mar 2016 03:41:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xpg4Iedl5AOS0JCgjXMIU+2fTn8=; b=iBLEN3
	glMePxTDVqICyr6MEVycn4zFJZP5PrR09jdVVnr9KbqDnT/bUX2fivkYRHFHFivQ
	WMuDVuPup9qaR3xpnpeodgR4HHeLV4tsOChUgMQHyjeyWncEcf65neVxruplSUW5
	v4HUPgUQ7W+YJfODJvXfTkOu7yI+CbCyqv9BU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C5pJmEQZPjjF3P9Yl4G5rrE7N/7idlU6
	UhIn555m0o1wq7bSX0hI0hLlWrU9HxNZVniNc8h4CCzIQ+cW66Tg+AQdMH04XZbw
	+w5Js0Zwba8e6lVnvHcP5EiSeUctQIW3RfhiGcVxGNcNINzyEFcOKP6T6VbZhZmr
	p/OdMfMnEsQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FF2B40A9B;
	Wed,  2 Mar 2016 03:41:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B05CA40A99;
	Wed,  2 Mar 2016 03:41:21 -0500 (EST)
In-Reply-To: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com> (Josh
	Triplett's message of "Tue, 1 Mar 2016 17:30:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A53E752-E052-11E5-A082-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288108>

Josh Triplett <josh@joshtriplett.org> writes:

> If you clone a repository, and the connection drops, the next attempt
> will have to start from scratch.  This can add significant time and
> expense if you're on a low-bandwidth or metered connection trying to
> clone something like Linux.

For this particular issue, your friendly k.org administrator already
has a solution.  Torvalds/linux.git is made into a bundle weekly
with

    $ git bundle create clone.bundle --all

and the result placed on k.org CDN.  So low-bandwidth cloners can
grab it over resumable http, clone from the bundle, and then fill
the most recent part by fetching from k.org already.

The tooling to allow this kind of "bundle" (and possibly other forms
of "CDN offload" material) transparently used by "git clone" was the
proposal by Shawn Pearce mentioned elsewhere in this thread.
