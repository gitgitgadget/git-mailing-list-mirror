From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] writing out a huge blob to working tree
Date: Wed, 18 May 2011 08:12:20 -0700
Message-ID: <7vzkmkcaaz.fsf@alter.siamese.dyndns.org>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <20110518064158.GB27482@sigill.intra.peff.net>
 <20110518070837.GC27482@sigill.intra.peff.net>
 <20110518075023.GD27482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 18 17:12:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMiQM-0000Oc-Pb
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 17:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149Ab1ERPM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 11:12:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933040Ab1ERPM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 11:12:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BBDB94426;
	Wed, 18 May 2011 11:14:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lHlueHjeQ5B92rutD9Cca5Bjp3E=; b=qlLonp
	bbXANPLWYCpevpcK6LDzaOJZZ3VCacumFtXOmIBIesb0006oOKFqHUQe+LIoeWjX
	lWB71wLIbbe9LcuWJ4aHiynMxeXP4052VYSUvU0y0rz+0ys4v1BpM3daqNfkQSQL
	W7q+IF6P4h4fUc4v4srtpXC+KpkKmIDdt8dPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B7uBFRLFe0v5zZ1gRqY3WX1aav/MS33K
	X186rdNmX39RW1BmgwHkXNpTNpticl7GI02NgJVfkwEpdRWBw8DnP6CU+TtC2RHd
	t8S9PRqOaQpt5NsA3wsoVl1v0VAUBpVKHG499k9tF3xO1vnk3dW+FAeiJT1u+xWW
	u4jpc3a0ueo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 993A44422;
	Wed, 18 May 2011 11:14:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BEADD4421; Wed, 18 May 2011
 11:14:28 -0400 (EDT)
In-Reply-To: <20110518075023.GD27482@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 18 May 2011 03:50:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 880A7286-8161-11E0-AE3D-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173883>

Jeff King <peff@peff.net> writes:

> (I still think the concept of avoiding the revindex should
> still work in principle, though).

Yes, absolutely. The streaming code cares only about non-delta, and in
general applying delta without holding the base image entirely in core
would be horribly complex unless the delta only runs forwards over the
delta-base image. The true general case is not something this topic is
interested in (it is primarily about the large objects), and limiting
ourselves to non-delta case is just as fine.
