From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rejecting patches that have an offset
Date: Tue, 16 Aug 2011 16:22:42 -0700
Message-ID: <7vobzpeybh.fsf@alter.siamese.dyndns.org>
References: <4E49A8EA.5020507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bug-patch@gnu.org, Git Mailing List <git@vger.kernel.org>
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 01:22:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtSyB-0006ns-HJ
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 01:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab1HPXWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 19:22:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431Ab1HPXWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 19:22:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D13A65AF0;
	Tue, 16 Aug 2011 19:22:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cIINGkc34dBsyDR6OauY2aelkzo=; b=ahSNX5
	ccCsdVUF96iaYFSdGiTOKeIW05ZauDTJ9oOKS48g7USMIx9hFwR7cYRpBQaLrl7W
	vNLwiVTSPq9/VxrihUd49gqzYEfaHVpM3z1A6bERhVRcXDmaI/WYA4jZx1ISNqNB
	ebeF4QD3cJA+GTNlXaSx8mJxW94QUdzF3PSmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sEd9jotkFfILucvz0scV85BgWC4uGNq9
	4oPJOq4OLGLpHUeCmpG7XB1pVxcMPt0C9ErSDqxEwWpJkn8usjQe9kEFsFiYLBG0
	Uabi2BCkbY+Op0zGHo/eR6/8A4FCDR5HrCK+WbFNkMJ1RaaEkAvolkDX+qhyFpFm
	HwvyJqP1HZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6E0D5AEF;
	Tue, 16 Aug 2011 19:22:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 596335AEE; Tue, 16 Aug 2011
 19:22:44 -0400 (EDT)
In-Reply-To: <4E49A8EA.5020507@redhat.com> (Eric Blake's message of "Mon, 15
 Aug 2011 17:16:58 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A51E9F52-C85E-11E0-A6AD-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179487>

Eric Blake <eblake@redhat.com> writes:

> It would have saved me a lot of time if both 'patch' and 'git apply'
> could be taught a mode of operation where they explicitly reject a
> patch that cannot be applied without relying on an offset.

I am not sure about this. I somehow doubt you would want to make sure that
the preimage your patch is to be applied must be bit-for-bit identical to
what you prepared your patch for, IOW, you are using a patchfile merely as
a mean to "compress" the replacement file. You would want your RPM change
to tolerate some changes in the upstream and keep your patch applicable to
the next version of the upstream, no?

Given a patch that is not precise and can apply to multiple places,
"patch" and/or "git apply" can apply it to a place you may not have
intended. It may feel like a bug if that happens to a preimage that is
bit-for-bit identical to the version you prepared your patch is against,
but I would rather think, instead of blaming "patch" and/or "git apply",
it would be more productive to prepare a patch with larger context when
you know that the preimage file you are patching has many similar looking
lines, to make it _impossible_ for it to apply to places different from
what you intended.
