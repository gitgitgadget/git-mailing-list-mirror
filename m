From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for
 .gitattributes
Date: Thu, 11 Oct 2012 08:51:20 -0700
Message-ID: <7vpq4p80sn.fsf@alter.siamese.dyndns.org>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-3-git-send-email-pclouds@gmail.com>
 <50758477.3030304@viscovery.net> <7vtxu2ayov.fsf@alter.siamese.dyndns.org>
 <50765CDC.8020509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 17:51:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TML2s-0003dD-Sa
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 17:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757151Ab2JKPvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 11:51:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597Ab2JKPvX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 11:51:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0C1F9F4A;
	Thu, 11 Oct 2012 11:51:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RzrJQP3E0Ncpfv99QvPWEVy1/Ns=; b=HSIE1N
	PTNAdDmHMPNEdVDEJwxiLK74MObm1xTaQb0YbYngO2BDLKqQp18jgQKnr7/K06Px
	hVFWBxHqFkbGdQ4xS3DfPO0u4qOVpBGv7xKS7lfAxT8rs6hujFuwNClzAYGxUOAE
	++A43wNYj7fCusW0Q0ossRnQgswU6dKgTIbIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rr7dMPR3JGes7ON0vFaydXubAOmJfI/N
	ykZzMJJMY13CGIZ0id6sX2YFT/rGES712X9SV/LfY3dK0Kkk+OYrL7AEDq2NMe3w
	IDY2AQJgeqK0uJWHfANMgpYljQYFrHQEVSZHFYw9E2bx5g9t2c0mnkfJTMMiELL9
	LMVW1XZ74Zk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A605B9F49;
	Thu, 11 Oct 2012 11:51:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B2AB9F46; Thu, 11 Oct 2012
 11:51:22 -0400 (EDT)
In-Reply-To: <50765CDC.8020509@viscovery.net> (Johannes Sixt's message of
 "Thu, 11 Oct 2012 07:45:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 812783E4-13BB-11E2-9D9F-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207481>

Johannes Sixt <j.sixt@viscovery.net> writes:

> I saw EINVAL errors when 'git grep pattern rev' was run on Windows. The
> reason is that the code attempted to access "rev:dir/.gitattributes" in
> the worktree, which is an invalid path on Windows due to the colon. The
> lack of this warning indicates that the attempts to access these files are
> eliminated.

It means that whenever we ask for attributes for a tracked file that
is inside a directory whose name contains a colon, we would get the
same error on Windows, no?  Perhaps Windows may not let you create
such a directory in the first place, but you may still get a
repository of a cross platform project that contains such a path.

What I am wondering is if we should do something similar to 8e950da
(attr: failure to open a .gitattributes file is OK with ENOTDIR,
2012-09-13), at least on Windows, for EINVAL.
