From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3]
Date: Fri, 17 Feb 2012 23:27:26 -0800
Message-ID: <7v8vk0r481.fsf@alter.siamese.dyndns.org>
References: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
 <cover.1329472405.git.trast@student.ethz.ch>
 <7v62f5v1d1.fsf@alter.siamese.dyndns.org>
 <7vk43lqbt8.fsf@alter.siamese.dyndns.org>
 <20120218005148.GA1940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jehan Bing <jehan@orb.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 18 08:28:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryei9-0004NX-O8
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 08:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab2BRH1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 02:27:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab2BRH13 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 02:27:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2FEC7EA5;
	Sat, 18 Feb 2012 02:27:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GAjBmINqvNEX+BIcce+cuBPw844=; b=pd1Ta2
	CRDJSp3bE88V06WVPfbZLlHflNpvM5LWbxYp4LkYTwGLX5jyxrrukcqvL3wsU3fk
	pqN7gGtMTgaZD4yItjn135/WnK8fSjblsjzcV6xwDPEbdUqzkVCElrV59gm0HSmp
	LIjZ11xmDE/4pCbujBAGsKyhT2CMBW6FfQ5sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jj1VubPqvX2Q+vQU/q7joR3nONiwDLVa
	5gNEa/uFLrgYPc6Iqi04cRr4daL73XVY2zv0018uQmq9hJ8aNeBTYWqEmcs8eB3i
	aNPq8mi6hMAnDBGTTS8+qBCnk9qUJrsjxWhJ+lMJLhS+9spLaO6Biwhyq4U5OXB1
	GXe/l5PDpCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 996227EA4;
	Sat, 18 Feb 2012 02:27:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30C707EA3; Sat, 18 Feb 2012
 02:27:28 -0500 (EST)
In-Reply-To: <20120218005148.GA1940@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 17 Feb 2012 19:51:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 02DA2582-5A02-11E1-955A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190997>

Jeff King <peff@peff.net> writes:

> I'd be happy if we just ignored SIGPIPE everywhere, but turned it on for
> the log family.

Hmmmm, now you confused me...  What is special about the log family?  Do
you mean "when we use pager"?  But then we are writing into the pager,
which the user can make it exit, which in turn causes us to write into the
pipe, so I would expect that we would want to ignore SIGPIPE --- ah, then
we explicitly catch error in xwrite() and say die() which we do not want.

So you want to let SIGPIPE silently kill us when the pager is in use; is
that it?
