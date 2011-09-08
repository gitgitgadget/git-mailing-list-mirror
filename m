From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Thu, 08 Sep 2011 15:19:54 -0700
Message-ID: <7v7h5iwub9.fsf@alter.siamese.dyndns.org>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <20110908193555.GC16064@sigill.intra.peff.net>
 <7vy5xywyk8.fsf@alter.siamese.dyndns.org>
 <20110908210217.GA32522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 00:56:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nWd-0004sj-48
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab1IHW4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:56:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731Ab1IHW4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:56:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15FCB41E6;
	Thu,  8 Sep 2011 18:19:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=By0+9Wql9dyVSFvi92y1cGJF2Y0=; b=gmrSUg
	rcUgeCs7SDjI50p0DgsmdIf5gYQPMx6D/8eRDFABtcPWaTKdet4F7/0LP7nUgixH
	ymcZEDUo240QM6PdbLnNHhj3zP8BlJxEv0ZWsA/1VgEuin0EGG1WvNNOu7OdlVCP
	xtkZqRs2HK45Ffn6g/TpoZ8JmFFfPNDKo7MIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j3pk/JHiIY4GB0nqz1htaA80BrN03Md8
	I5o+liwR94eiSRjbi7KjU5zY84IdzmbLztjoFKvXcw9pumGd9aCe/maizLnw0vD+
	zDy4ieaXPEZdxK5/vbFR2QP5Sy7UlTX0DFTRryN+VNSURVyMUyUqEwXxzdSntgSm
	VoOPTYraIrg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1E341E5;
	Thu,  8 Sep 2011 18:19:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EE6D41E4; Thu,  8 Sep 2011
 18:19:56 -0400 (EDT)
In-Reply-To: <20110908210217.GA32522@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 8 Sep 2011 17:02:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEC412DC-DA68-11E0-8A9E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180980>

Jeff King <peff@peff.net> writes:

> Yeah, it is a potential problem, but it just seems wrong to put too much
> policy work onto the server.

My take on it is somewhat different. The only thing in the end result we
want to see is that the pushed commits are annotated with GPG signatures
in the notes tree, and there is no reason for us to cast in stone that
there has to be any significance in the commit history of the notes tree.

In a busy hosting site that has many branches being pushed simultaneously,
it is entirely plausible that the server side may just want to store each
received push certificate in a new flat file in a filesystem, and have
asynchronous process sweep the new certificates to update the notes tree,
possibly creating a single notes tree commit that records updates by
multiple pushes, for performance purposes, in its implementation of
record_signed_push() in receive-pack.

If you forced the clients to also prepare notes and push the notes tree to
the server, you are forcing the ordering in the history of the notes, and
closing the door for such a server implementation. I would consider it an
unnecessary and/or premature policy decision.
