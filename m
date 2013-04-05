From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug: Git submodules can get into broken state
Date: Fri, 05 Apr 2013 09:51:31 -0700
Message-ID: <7vmwtcdip8.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1304041758140.965@lap-x201.fen.aptivate.org>
 <7vmwtei1wu.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.02.1304042138100.965@lap-x201.fen.aptivate.org>
 <7vr4iqgg2w.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.02.1304042302550.965@lap-x201.fen.aptivate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Wilson <chris+gitscm@aptivate.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:06:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWKY-0002u6-Jp
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162112Ab3DEQve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 12:51:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162066Ab3DEQvd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 12:51:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3537414186;
	Fri,  5 Apr 2013 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zIwTSSZAbhlr/RmcgWg3zfe46DM=; b=Qh+yPu
	r9h2vkx8y7rySmXN5xUQPO+Z7ysn+2m3EyjKBodpB9YszNkrBpuZAB8Zls20XL62
	9ZwnavqAohW1ixg3GkhxaKoHmmDn1jsp8snS/vgAux2ae/vtZz4YldhzyiAFNyMp
	VPsn/dSk7X6u3UQw+p+u99aGeXRLqOwJEdiJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p5WXUHIYqeI646khoHdRUNpmeG7oM5sw
	kx8faLNkJz8aydG+HR7h4QYBao2QIrxgIanB1nm6yE6TfBYD4dC2E1id4ff88/VN
	xMLUJyya8iyqvdc+PRU4IYc/Q7Jl1AuNqAZ+ZGCI+XNncAk/CJc03fvV9UZL/tJb
	6jpx3SheL7g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 293BB14185;
	Fri,  5 Apr 2013 16:51:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B1EC14184; Fri,  5 Apr
 2013 16:51:32 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.02.1304042302550.965@lap-x201.fen.aptivate.org>
 (Chris Wilson's message of "Thu, 4 Apr 2013 23:07:19 +0100 (BST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11DC0164-9E11-11E2-8FE9-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220186>

Chris Wilson <chris+gitscm@aptivate.org> writes:

> They fixed it by checking in a rectified .gitmodules file.
>
> In the mean time, I ran git submodule init, and now I've ended up in a
> situation where git submodule update doesn't work, and there's no
> submodule command to fix it, so I have to remove the broken submodules
> from .git/config.
>
>> and the configuration mechanism is the way to use custom URL in
>> place of it.
>
> I don't want to use a custom URL, I want to use the URL which is now
> in .gitmodules.

Then don't call it a "custom URL" ;-).

Isn't your problem that the old, broken one is now in your config,
and you want to update that with a corrected one?  How you learned
which one is correct does not really matter---you may learned it out
of band by looking at upstream's gitweb, or by running "git fetch"
in the superproject again and looking at the updated .gitmodules
file.  The configuration mechanism has a way to update that entry.

> Could submodule init at least change the URLs of submodules which are
> not checked out? (e.g. because they couldn't be)?

Perhaps "submodule deinit" might be what you are looking for, but I
dunno.
