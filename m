From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug?  git format-patch -M -D then git am fails
Date: Tue, 13 Nov 2012 15:22:08 -0800
Message-ID: <7vfw4dccm7.fsf@alter.siamese.dyndns.org>
References: <1352846721.17444.24.camel@joe-AO722>
 <7vsj8dcdv6.fsf@alter.siamese.dyndns.org>
 <1352847962.17444.27.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, David Miller <davem@davemloft.net>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:22:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYPoH-00072J-GO
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 00:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673Ab2KMXWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 18:22:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45581 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338Ab2KMXWL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 18:22:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAEC6AA4E;
	Tue, 13 Nov 2012 18:22:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qv5L9f+4v1EEl+cu0M32+3EvkO4=; b=wiqekl
	pyUHPOpe5chq5OKY0uqsBylEBJge8Z8CxRnS2Boky6LEupXC047ZTUbmdlQTpgA1
	xOYJnkKmeG1FvXFarVWzrKe1hbJMz281fHZnIPKg+Psjdd0xXKegfAdPY5qhiPee
	jnOADe1/bAzeJIPzTiESlHBjU4utEltsoBhng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mkhTVKR6j6FlXKCunpUl8Yw6XDMDxxI/
	CCzuhZhgocxK6EailiIy11eZJmy3SiCrfdypX0elfPbBOre1nEWThs6QYk/ihOuf
	aTC2mUQEA5PSKqi2E79O2CzUmlPASqzSE9xPSWhtDpIW4Hwt+RLvUF0NZoyEk2eF
	zvx90PP6MLo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A72DFAA4D;
	Tue, 13 Nov 2012 18:22:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25B70AA4A; Tue, 13 Nov 2012
 18:22:10 -0500 (EST)
In-Reply-To: <1352847962.17444.27.camel@joe-AO722> (Joe Perches's message of
 "Tue, 13 Nov 2012 15:06:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2AD2266-2DE8-11E2-A03D-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209684>

Joe Perches <joe@perches.com> writes:

> I don't believe that reversibility
> is a really useful aspect of deletion patches
> when there are known git repositories involved.

You can read "reversibility" as "safety" if you want.  We would want
to make sure we know what we are deleting before deleting a path.

The history that the receiver of such a patch has may have further
changes that are relevant that the sender of the deletion patch did
not know about, and removing the path in such a case would make the
result inconsistent.  If the sender did his work on top of the newer
version with the change in the path, the sender's patch may still
have deleted the path but would have had changes to other paths to
compensate for the loss of that change.
