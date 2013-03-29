From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reading remote reflogs
Date: Fri, 29 Mar 2013 15:45:42 -0700
Message-ID: <7vd2uhn7u1.fsf@alter.siamese.dyndns.org>
References: <1364595928.30202.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 23:46:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULi3p-00027M-Gq
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 23:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab3C2Wpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 18:45:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757183Ab3C2Wpo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 18:45:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04874FA35;
	Fri, 29 Mar 2013 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=agbD27wBsFDO24F1L2E3IatZWqM=; b=GLIsUd
	VpLmz9uZ0TQsyL4zXxB5vWQZ/Z8mCXez+81a8CLylo7hxLIIDspiMXitCt1A6qch
	1YbS6zjOG8aMVCPYlXngGwmSrvZfPA25jz2EaAnoWUgHt4L5E3QKKDtRKr2WDn4p
	JbfANGXrzYK1SQaaOAEvoxJ9axnpuQ3hAw/qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tuPN5CosSUq93JkgZQmPBf3jd3thc2Sb
	qDMe1zTjJB7n9twFcO0LWzwp3WcTFZl8Dyw3uW/+Ll5m/+sZt52Qh7eD9hmCoXLo
	mH4dx5QzvUd7kVtq/IbUaGRcy/PbXUVOh/ea+rWthsFxVOi1Xq7WpqLXb+gVya5A
	gbYiw0GAbY0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE09BFA34;
	Fri, 29 Mar 2013 22:45:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7387BFA33; Fri, 29 Mar 2013
 22:45:43 +0000 (UTC)
In-Reply-To: <1364595928.30202.4.camel@localhost> (Dennis Kaarsemaker's
 message of "Fri, 29 Mar 2013 23:25:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 637DB9EE-98C2-11E2-80CE-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219536>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> ... Mirrored repositories don't
> maintain a reflog, even with core.logAllRefUpdates = true,...

Are you sure about this?  When log_all_ref_updates is not set, by
default we do not log for bare repositories, but other than that, we
do not do anything special with respect to reflogs.

	$ (cd .. && git clone --no-local --mirror git.git victim)
        $ git checkout next
        $ EDITOR=: git commit --amend
        $ cd ../victim
	$ git config core.logallrefupdates true
	$ git fetch
        $ find logs
	logs
        logs/HEAD
        logs/refs
        logs/refs/heads
        logs/refs/heads/next

It seems to record how a branch at its origin was updated just fine,
at least to me.
