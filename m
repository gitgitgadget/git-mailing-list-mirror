From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Tue, 11 Dec 2012 10:15:23 -0800
Message-ID: <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiUMr-000639-7I
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 19:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab2LKSP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 13:15:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753587Ab2LKSP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 13:15:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62272A879;
	Tue, 11 Dec 2012 13:15:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BvkFET1GheOozvl3yiz32JvhOis=; b=dptQPq
	lNcFtGL5Kqx7ZSjBFDOk1dPE3/D0L9NsyMqe8694MT6TbZmzL3auhKE+4zw/siQZ
	yITMFsifP35gEh/J9fCIwkssTf4WKfauLN1ZI4cxa445xcm9Qk+iYrmGbIX2v5Vg
	iqjE8QGr4PoEC2uR1HsA30q1juX/r5RulhYGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Us7/lJw6+JRfFaRgvXxSEZXpox7IYBRF
	M8DH9nho7ghp6SISQQHoXYDLJYmmU3hKCrakI3q0aya+nSO2cAL6Rol1+fq8N0xY
	uuOstNZ/pwsHqgp57XZn075iCONlmNt42l+EnicFJwcew82gOpq2L0oVYXWgMQsm
	0YrOJvhljjU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50AE3A878;
	Tue, 11 Dec 2012 13:15:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0A8EA877; Tue, 11 Dec 2012
 13:15:25 -0500 (EST)
In-Reply-To: <20121211153903.7522d6b0@chalon.bertin.fr> (Yann Dirson's
 message of "Tue, 11 Dec 2012 15:39:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC588E9E-43BE-11E2-92DE-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211292>

Yann Dirson <dirson@bertin.fr> writes:

> There seems to be some bad interactions between git-push and grafts.
> The problem seems to occur when a commit that exists in the remote
> repo is subject to a graft in the local repo, and we try to push one
> of the fake parents.

History tweaking by grafts is only visible inside your local
repository and objects are not rewritten, and grafts are not
transferred across repositories.  They were invented to be used as a
stop-gap measure until you filter-branch the history before
publishing (or if you do not publish, then you can keep using your
local grafts).

Isn't this well known?  Perhaps we would need to document it better.

What you can do is to use "replace" instead and publish the replace
refs, I think.  Object transfer will then follow the true parenthood
connectivity and people who choose to use the same replacement as
you do can fetch the replace ref from you (this will grab objects
necessary to complete the alternative history) and install it.
