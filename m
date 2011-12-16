From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Branch names with slashes
Date: Thu, 15 Dec 2011 16:10:37 -0800
Message-ID: <7vhb11l6ki.fsf@alter.siamese.dyndns.org>
References: <CAGcUY13TOodu1BO3DCoNnVvNZ9QkWAbD-RmyqQX6P1q6tcO+yg@mail.gmail.com>
 <4EEA5B55.1040405@gmail.com> <4EEA777C.6040607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Leonardo Kim <dalinaum@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 16 01:10:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbLNs-0007Aj-JT
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 01:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759875Ab1LPAKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 19:10:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34950 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756247Ab1LPAKj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 19:10:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 453EE6971;
	Thu, 15 Dec 2011 19:10:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EKjnTExJiH0NGPlzfiQpwJ4sGyo=; b=oSlaHh
	RiJ1xYarPIDq/JiPUmFyMz8koBcIQJXgffCXi08LXXGTPEAl9LQAt4NiLu4p6BNe
	sU3DI11O/UxA1K9Rcj4wPDO0Gr+pGJ/SLDpJREXVKs4CgbupePquhDX1QLDjcXek
	vKLL0sBpX60kc+SYBuZvm+ZGRge/oa7wQY5sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YbbOTWd74mnXeXoSKlQ4Ey2xWuDP41KO
	UUJmQcJR41Z/KOrci/5fMZ/V7lDGyENyulsZTQG8B6t7HULp9R1nJUO7Wf8pzFeT
	DvPdLbZx6uw9w2qxSKjaZeNcXo06qg4pfkeD0RVvWr8/0u9zs9d725XmKtinle5x
	JiZEJUsYVd8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D0CF6970;
	Thu, 15 Dec 2011 19:10:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6CA9696F; Thu, 15 Dec 2011
 19:10:38 -0500 (EST)
In-Reply-To: <4EEA777C.6040607@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 15 Dec 2011 23:41:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6267494A-277A-11E1-B4B7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187258>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I don't believe that it would be possible to relax this limitations
> without at least a little breakage of backwards compatibility.

I do not think it is worth it, but you _could_ update your git to use a
file whose name is "refs/heads/.foo/bar" as the representation of foo/bar
branch and refs.c API, especially the ones close to resolve_ref(), should
be the only ones that need to know about this.  While walking the filesystem
in refs/ hierarchy, any directory you see whose name do not begin with dot
you would treat it as a legacy one and perhaps rename it to match the new
convention on the fly.

> What is the bottom line?  Feel free to submit patches to improve the
> documentation or error reporting.  But I doubt that the underlying
> limitation will be removed.

I do not think so either. It is not even a limitation but is a basic
nature of "hierarchical names".
