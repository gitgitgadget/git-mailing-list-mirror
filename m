From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: allow {--amend|-c foo} when {HEAD|foo} has empty
 message
Date: Tue, 28 Feb 2012 09:21:09 -0800
Message-ID: <7vr4xe27sq.fsf@alter.siamese.dyndns.org>
References: <8529824c8569a8a0b4c4caf3a562750925758e74.1330419275.git.trast@student.ethz.ch> <20120228090540.GB5757@sigill.intra.peff.net> <20120228091422.GC5757@sigill.intra.peff.net> <87haybco1j.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 28 18:21:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Qjo-0004Lb-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 18:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203Ab2B1RVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 12:21:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59055 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964949Ab2B1RVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 12:21:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B07F36333;
	Tue, 28 Feb 2012 12:21:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hc2v9VzLpoai1qIg9X3lya/wdNM=; b=mZiuWz
	6FS0+98m3fd461gFi0cYwrq7moRT4J7KZ4HBB+S/2ihn7elXVVJl/ah8rFGy6XHr
	0/+4Ii2/5Fy3JZmRI1aTQFMWhua4xIWcSBmaUvI26QfURqEaABgiDtCAl0pkwC0G
	/wdsj1qqTN0E3jFxxxTgfRwXi/MCgsfEF9SN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r1wKlBOABFxNL2Uem15Rmb5E4pHQCpA9
	PCBuC+dQ6rIRAu8eBp31UtXGbKqpJFmsQotjI3fMvfOzZlsSwJjVOJsOK0bMOInD
	/AMkM3GorFVzYc/lxLpcUTCQuOsDW0on2Dc6gw9FKGeTwkHN+6QiEfYFjEUU8FQO
	JiRqVUMqn2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A77ED6332;
	Tue, 28 Feb 2012 12:21:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 884226330; Tue, 28 Feb 2012
 12:21:11 -0500 (EST)
In-Reply-To: <87haybco1j.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 28 Feb 2012 10:20:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C28C5C8-6230-11E1-97DD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191745>

Thomas Rast <trast@inf.ethz.ch> writes:

> So either there's a lot to be fixed, or fsck needs to catch this.

Your experiment with hash-object aside (that is like saying "I can write
garbage with a disk editor, and now OS cannot read from that directory"),
if somebody manages to create a commit without any body, it is clear that
the user wanted to record no body.  I think all code that tries to run
strstr("\n\n") and increment the resulting pointer by two to find the
beginning of the body should behave as if it found one and the result
pointed at a NUL.  Rejecting with fsck does not help anybody, as it
happens after the fact.
