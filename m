From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stop a git commit by a specific author using pre-commit hook
Date: Sun, 11 Mar 2012 04:05:35 -0700
Message-ID: <7v62ebz9c0.fsf@alter.siamese.dyndns.org>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
 <4F5BAE5E.5030407@gmail.com> <7vboo415rn.fsf@alter.siamese.dyndns.org>
 <4F5BDDAC.4050700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Cornish <git@bluedreamer.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 12:05:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6gat-0002b8-T7
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 12:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab2CKLFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 07:05:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab2CKLFi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 07:05:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00C816D96;
	Sun, 11 Mar 2012 07:05:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u+0XomkxcZ/9sOyaNPAuH2MuJuE=; b=c1eGKl
	p0i3inOobdp6QHMRhPmCaGK/H2/K+V/YueZIO49E1k2K/7MFs4Jbk32Zm14lacuq
	1Cs3qNQMaOcN7Pg7cTQEu+lTMtu5QIvyzvMSUmptVAGrwRLrp6UyCtopklX8S+ZD
	ZrS1uDxq2N1WkJ37ZI1dUjhtdbIRiRCSTudDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EWfQJlqi4qgeXOQ4hk7IjO+/rOQgHRCn
	Hx4uRqbs1ZOvEVLLJOdOun+6GlAb6rLu7reHEpNmLM23qtEqX8ELJEDgcB29Q23a
	kl+cXaXMUHpC8ZsVOIrRLPvjvyDTap9pta2CvwSFIoM9Piq7VlcN87rHAyhphR5X
	EsdOWAqwOck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB3426D95;
	Sun, 11 Mar 2012 07:05:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 775296D94; Sun, 11 Mar 2012
 07:05:36 -0400 (EDT)
In-Reply-To: <4F5BDDAC.4050700@gmail.com> (Neal Kreitzinger's message of
 "Sat, 10 Mar 2012 17:03:08 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 212B10E0-6B6A-11E1-8F9D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192802>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> ... at the point pre-commit is run git has not
> overriden GIT_AUTHOR_IDENT with your --author value, yet.  I don't
> know if that is a bug or not.  The prepare-commit-msg hook is the same
> way.

I'd call it a bug, as the command line --author should have the same
effect as GIT_AUTHOR_NAME and friends observable by the outside
world.

There are two slightly different approaches to solve this, that
share the first two preparatory commits.  I'll send out the
preparatory ones first and then show both of these approaches.
