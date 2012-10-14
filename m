From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A design for subrepositories
Date: Sun, 14 Oct 2012 11:04:05 -0700
Message-ID: <7v4nlxylpm.fsf@alter.siamese.dyndns.org>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
 <7vd30m2sbr.fsf@alter.siamese.dyndns.org>
 <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi>
 <7vzk3p1xh3.fsf@alter.siamese.dyndns.org>
 <20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi>
 <507ABDF3.4040106@web.de>
 <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi>
 <507AE773.1010301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lauri Alanko <la@iki.fi>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:04:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNSY1-0002Cg-T8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 20:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab2JNSEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 14:04:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab2JNSEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 14:04:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A9ED91D0;
	Sun, 14 Oct 2012 14:04:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UiL7MX4H4c9sfuQrxtYLAmD63dM=; b=OifHvq
	fJWuBpt8/PUNFvwS2L5owGF4Vq2L+YP/YvMwsc/3raRK1B8EUHzvEQi66olBXDfL
	pNcLs/G2IlyYr22n4T5D1VlBy4MZVsaXm/1o7CAr/Dv/YTh7ZkKyVTObEEWbbqew
	fp8C27riXUwEnZqXwxtCHflwSheeAbfegzqVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ECeu8I93tkvyiSgL15jb2EL3Uzz69TVO
	t8bTFhvWMrOERtHDhtjYT8tzxti8I1sPRqimsYb0gu3bGcpd+PU2VRod34TlA4PW
	Ix2dWZJppgbfX7Z+r+eu9pUUeReJZbNmWiFsl72i1dKyfFQHjfLdnGyKmCp8rWRO
	8hfp57Ze86M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17D2391CF;
	Sun, 14 Oct 2012 14:04:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6664291CD; Sun, 14 Oct 2012
 14:04:07 -0400 (EDT)
In-Reply-To: <507AE773.1010301@web.de> (Jens Lehmann's message of "Sun, 14
 Oct 2012 18:25:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C163910-1629-11E2-BDF7-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207679>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Again, the user experience is currently suboptimal.

You mentioned multiple things in your responses that you are
planning to address, but I am wondering if the first step before
doing anything else is to have a list of known-to-be-suboptimal
things and publish it somewhere other people can find it.  Then
Lauri or others may able to help code the design of the approach to
address them for items you already have designs for, and they may
even be able to help designing the approach for the ones you don't.

More importantly, they do not have to waste time coming up with
incompatible tools.  Adding "works in this scenario that is
different from those other slightly different tools" to the mix of
third-party tool set would fragment and confuse the user base
("which one of 47 different tools, all of which are incomplete,
should I use?") and dilute developer attention.  They all at some
point want to interact with the core side, and without an overall
consistent design and coordination, some of their demand on the core
side would end up being imcompatible.

The "just let .gitmodules record which branch is of interest,
without checking out a specific commit bound to the superproject
tree and using as a base for diff" (aka floating submodule) could be
one of the items on the list, for example; to support it, we should
not have to throw the entire "git submodule" with the bathwater.

Thanks.
