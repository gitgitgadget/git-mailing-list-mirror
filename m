From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disallow refs containing successive slashes
Date: Sun, 11 Oct 2009 11:52:45 -0700
Message-ID: <7vbpkdwyo2.fsf@alter.siamese.dyndns.org>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org> <4AD1B6A4.8060405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 11 20:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx3cq-0003e8-HP
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 20:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbZJKSxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 14:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbZJKSxd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 14:53:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbZJKSxc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 14:53:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63C1E551AE;
	Sun, 11 Oct 2009 14:52:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=RUfNqJh9TAWmuqTnF7b0rNrz8kg=; b=FzJEvnkNBH8oylZmhD/M7sx
	xvVZ2St/nl+K1oG+cL8Aqe99ZTVMVb/x/gOuK1hBjW56/W9KCfJ3GUaHmiJEumlh
	+rHxszkOp2RY6M17ahtRWNHJPO39Zi8PlbgfdWZUbYIxN43Xp8/M72e6yANbDcxr
	jRcmJ5ABqA3i8WQBPDlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gJuZaRfSHkVhmmVLLlNhsr4NHf0Xt5tmcq/zv0sceLC54ql66
	I9U/kmWMk5kGykWPonOLZN4RSdNfiFE22meaycCB/lMb6MXucgQDKG31ga+jcF9m
	Yv8Sh4LPfKgarv+8bRRGfNvrkDK2e8JJa/5DNXW6EjLKcSOAf4EFTK9FiA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 189CC551AD;
	Sun, 11 Oct 2009 14:52:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75AB3551AC; Sun, 11 Oct
 2009 14:52:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 458965FC-B697-11DE-96B2-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129944>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>>> I became aware of this issue while looking into problems occuring
>>> when a user created a branch starting with a '/' in git gui (e.g.
>>> "/foo"). Strange things happen, while git gui shows the current
>>> branch as "/foo" under the hood a branch "foo" (without the slash)
>>> had been created. But then you can't delete "/foo" from git gui,
>>> because a branch of that name doesn't exist.
>> 
>> Perhaps an interface to give a cleaned-up version, e.g.
>> 
>>     $ git check-ref-format --print refs/heads//foo/bar
>>     refs/heads/foo/bar
>> 
>> is what you want in order to fix git-gui?  I dunno.
>
> Yes, one solution could be to fix every application handling branch, tag
> or repo names to mimic the namechange done in the bowels of git. But i
> think it is not worth the hassle.

That cuts both ways.

When the users make typoes (e.g. /foo//bar) you can accept the only sane
correction (e.g. foo/bar) instead of rejecting, since the only thing the
user can do after getting such a rejection is to correct it to that
corrected name (e.g. foo/bar) himself and re-issue the command anyway.
You can push the "hassle" down to the user, or you can fix the tool to
remove the hassle from the user.

Besides, by rejecting what we used to accept you are breaking people's
expectations.  So I am moderately negative, unless you can say your "every
application" is literally _tons_.
