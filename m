From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after non-dumb push
Date: Sat, 24 Aug 2013 20:50:20 -0700
Message-ID: <xmqq61uumnsz.fsf@gitster.dls.corp.google.com>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
	<CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
	<vpqbo4o3jba.fsf@anie.imag.fr>
	<CAMP44s281qkdMXUM-2P6T+emFajASX6Jyj4nk8_cU5xYJYvdLA@mail.gmail.com>
	<vpq8uzr5y4v.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:50:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDRLg-0006lB-Vk
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574Ab3HYDu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:50:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab3HYDu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:50:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 474772C3D2;
	Sun, 25 Aug 2013 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PEsVZdZhg/YevAN9Df08zdjn4OM=; b=yMfBaC
	kFJK0GO5aLR0d0TINzRLnci/7XA5sI8LTGGqrZjnshd3R35L1sqTxuuCpGFXcB65
	aG5qCkV4sjoJrkItCdFmwdQS1sJiwAhf0C6iDsIW7a4YXnlm2PsJKxbWGOy3bDMQ
	kqIaZuxE0MPGTHEuqFv9PyDgVHKSO2R2p8nYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HzgncFltxbjaNoviMFe/f/pQWEVbXXME
	bfJatgAFG7/54adtxk/OqhmyFM+uawQ/AdKzhbu3jmVmmuck+2Q0tN8d0oCipM8v
	HyInH82C6LuBSUHm5XTab4sbXIb8kCdf5bW/pld3ySF192kW4cvL6NUm1ep3C+qg
	PFAkpAfDVqo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF402C3CF;
	Sun, 25 Aug 2013 03:50:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97EEE2C3CE;
	Sun, 25 Aug 2013 03:50:22 +0000 (UTC)
In-Reply-To: <vpq8uzr5y4v.fsf@anie.imag.fr> (Matthieu Moy's message of "Sat,
	24 Aug 2013 09:46:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 77DA0320-0D39-11E3-AA00-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232905>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> How would I do that? The update to the remote namespace is done by Git,
> not by the remote-helper.
>
> OK, I'm now convinced that my solution is the right one. The
> alternatives are far more complex and I still fail to see the benefits.

Sounds like a plan, even though it smells like the "update is done
by Git" that does not have any way to opt-out may be the real design
mistake and your "solution" is a work-around to that.

Would it be a possibility to make it tunable, perhaps by introducing
a capability on the remote-interface side that allows you to tell it
not to mess with the remote namespace?  If we were doing this from
scratch, I would suspect that we would have made the capability work
the other way around (Git does not do the update by default, but
helpers c an ask Git to do so).
