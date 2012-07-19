From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Thu, 19 Jul 2012 15:36:09 -0700
Message-ID: <7vy5mftm3q.fsf@alter.siamese.dyndns.org>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 00:36:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrzKV-0005mb-7n
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 00:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab2GSWgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 18:36:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab2GSWgM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 18:36:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9105A881A;
	Thu, 19 Jul 2012 18:36:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7/sUWU4UMkrS4+Pwz8sNxQHeRFc=; b=Bl8ptO
	hRSlIAhdgxa46/lIC3ZanxsdHLBiPgKa9KEh0Gf2vOKklvClT7eB3yUAE6920CbY
	gCdyJ55t6iaOFi/gaLFP10VYblmcVVHooWUUM3t2IHDfPItE9sqxn4r1NFVzXFjy
	oQIscksOeUun1CksXzHHqEt9qHkR2jZdF6Qt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K/klIDd+ZgxVcqFVN8vuyv96UZDnlVu/
	StPyucBOr1ceF4K8h+P3oOBDhT/Kf/+cB8D89IE5oB7SGp/M8kiK64b2EkpoXIP9
	cOHp0yh35xPg0V7kTM7tMkelH7RZSRyytNLTKA76wNw2nLAgw5G2q/qBlikeRQ44
	PxMO+W/da18=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E60B8818;
	Thu, 19 Jul 2012 18:36:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F16EE8817; Thu, 19 Jul 2012
 18:36:10 -0400 (EDT)
In-Reply-To: <20120719213311.GA20385@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 19 Jul 2012 17:33:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23C102A8-D1F2-11E1-ABDA-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201758>

Jeff King <peff@peff.net> writes:

> Only one test needed to be updated; t7701 tries to create
> unreachable objects by deleting branches. Of course that no
> longer works, which is the intent of this patch. The test
> now works around it by removing the graveyard logs.

I think the work-around indicates the need for regular users to be
able to also discover, prune and delete these logs.  Do we have
"prune reflog for _this_ ref (or these refs), removing entries that
are older than this threshold"?  If so the codepath would need to
know about the graveyard and the implementation detail of the tilde
suffix so that the end users do not need to know about them.

I like the general direction.  Perhaps a long distant future
direction could be to also use the same trick in the ref namespace
so that we can have 'next' branch itself, and 'next/foo', 'next/bar'
forks that are based on the 'next' branch at the same time (it
obviously is a totally unrelated topic)?
