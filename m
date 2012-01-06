From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_object: try internal cache before reading object
 db
Date: Fri, 06 Jan 2012 13:27:40 -0800
Message-ID: <7v8vlkjzcj.fsf@alter.siamese.dyndns.org>
References: <20120105210001.GA30549@sigill.intra.peff.net>
 <7vipkpn87d.fsf@alter.siamese.dyndns.org>
 <20120106191654.GA11022@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 06 22:27:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjHKH-0006Zt-Nw
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 22:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464Ab2AFV1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 16:27:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928Ab2AFV1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 16:27:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7DA37C37;
	Fri,  6 Jan 2012 16:27:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PC3sbEeQpcF4Dko3bvLy/ljqZTc=; b=GzIONI
	tAc0B+nGPRGJvz+AhThXj4D4JD2igg1Gy42bSRPHa0XiaKEUXumCOY0rKtPApnTk
	moYE4XbO22KEPL9OhjTiJ5JZ3U3q/Zt3Zi2Qhp81rHDZoCUW+0//t5VDMES0K9up
	HbTXOdFCd/5Jn4irBWaL5vG5nIL7KNxVkzPEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SkwYmJBmJOhdCgkPcJvlG0XSDjHe2e1C
	mCjd60uR9bioEuDem7o6u3ubGvai8CzYWDyaQ6Us1hp9IeQtFNTt2b6zOkv4atxM
	5Nv0i/CTXIXkvwiN5BpVFjrBh3xhbwqyGgb3BrTHIEWz1i5V6d7jGw1KoMoya3DQ
	P7EuhfNYUQ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9D4C7C35;
	Fri,  6 Jan 2012 16:27:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D40D7C31; Fri,  6 Jan 2012
 16:27:42 -0500 (EST)
In-Reply-To: <20120106191654.GA11022@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 Jan 2012 14:16:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4448A3D4-38AD-11E1-B2BF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188047>

Jeff King <peff@peff.net> writes:

> Actually, we can do much better than that. Here are a few patches that
> avoid parsing objects when possible. They drop the 3.4s to 2.0s. If you
> combine them with the parse_object optimization, my 120K case drops to
> around 0.68s.
>
> I don't know if it is really that worth it on top of the parse_object
> optimization. It's almost negligible for the normal case...
> ... OTOH, if you had some totally insane ref
> structure, like 120K _unique_ refs (which would probably imply that
> you're making one ref per commit or something silly like that. But hey,
> people have suggested it in the past), then it could be a big
> improvement.

Even though it is a bit scary kind of loosening of sanity checks that I
hesitate to take at this late in the cycle, I think it makes sense. Let's
queue them on 'pu' and aim for the next cycle.
