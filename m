From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 23 Sep 2011 12:40:51 -0700
Message-ID: <7vobybt5bw.fsf@alter.siamese.dyndns.org>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4E7AF1AE.5030005@alum.mit.edu>
 <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
 <20110922171340.GA2934@sigill.intra.peff.net>
 <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
 <20110922205856.GA8563@sigill.intra.peff.net> <4E7C5A3B.10703@alum.mit.edu>
 <20110923193341.GA26820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jay Soffian <jaysoffian@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 23 21:41:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7BcK-0007UP-2w
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 21:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab1IWTky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 15:40:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897Ab1IWTky (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 15:40:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBA4D4AA6;
	Fri, 23 Sep 2011 15:40:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QkkjF/5jhVfgkmgwXsJkdMqfBtM=; b=Uvd5KW
	b0nJCzEZWFfGrj8mvNf1mg2dScv3YwHLhjJxU4eai7xjJbKdj9vL00YG33NVmibs
	8Q1T+1Igi3/eBnt1J5EOw36i8HFkXvuu00zG9yAavop6s1PjJXPaqm5Y0wQWVwea
	dGQFsChVbCblE/Y6b1YBHwh52lUbyW6d0QeVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZmgpXvuPIpxAXZHaSgGb3yzXfKx8zEmL
	FYgkUl9bvWp2jrWHmAdLeRpiNg9sGtxMASMHKmz8k4N0Sa0vG2+87ZXz5s2Q1ePH
	+ZP50BtDGHdbLAkt/iQe1zgp/xcMA2zykSa9qM9mfsNzMsU7PG8FbEkR839cYnnP
	Z5ttSYMqyQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3ED14AA5;
	Fri, 23 Sep 2011 15:40:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56BC24AA4; Fri, 23 Sep 2011
 15:40:53 -0400 (EDT)
In-Reply-To: <20110923193341.GA26820@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 23 Sep 2011 15:33:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2D51174-E61B-11E0-ABED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181996>

Jeff King <peff@peff.net> writes:

> We do some of this already. For example, textconv will look up each side
> based on its individual filename. But the funcname code, for example
> does this ("one" is the "from" side of the diff, "two" is the "to"
> side):
>
>   pe = diff_funcname_pattern(one);
>   if (!pe)
>           pe = diff_funcname_pattern(two);

What text would we see on the actual hunk header line? I had an impression
that we always take from the preimage. I might be wrong, but if that is
indeed the case, shouldn't we be ignoring the attribute tacked on to the
postimage side altogether?
