From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Sun, 08 Sep 2013 10:35:00 -0700
Message-ID: <xmqqk3ir6wu3.fsf@gitster.dls.corp.google.com>
References: <20130906155204.GE12966@inner.h.apk.li>
	<6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley>
	<xmqqfvthyfui.fsf@gitster.dls.corp.google.com>
	<94A71512041A4F9BB402474DB385E310@PhilipOakley>
	<xmqqwqmsvdfh.fsf@gitster.dls.corp.google.com>
	<531DBE1FF66D4356AEE6AEE5C2FE9389@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andreas Krey" <a.krey@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Sep 08 19:35:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIitE-0000pe-IC
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 19:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758477Ab3IHRfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 13:35:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757493Ab3IHRfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 13:35:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 202573F73F;
	Sun,  8 Sep 2013 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GXdh0vZdHO1MOi5wtgSk7DokjlE=; b=iAfOxD
	N3SJAUN2rd0jgwrbz6EvNXeAp8peRHRFBl5KEfZtMlAZDCoE1oIFO2xPlYEfO/c+
	szdFIt3mXbKBgJ89OVIO3mjaqcZ1t2PqRVziH8v2YfDCuHVzLLD1UXiZw0nYZlsa
	f1azNqwoHe0i0urFuc0g2ouSA7TdguCmkAKVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SJvRFH3cx+aV96NaKqEfNDiT54Iq6ADV
	cpZLZ8mkE8BTazspbfR+bXCUMREU1UIqYwhgIeLaFqKTeHzGZnR3s6u84u6TCdUC
	auJvKY7fAQegdXyg/P3P98HGcpSYRbv80BHNSVaSJ7UWYwl9dIHTnhapn9yTabti
	I4Y6pTyXVm4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15C3A3F73D;
	Sun,  8 Sep 2013 17:35:04 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 823EC3F73B;
	Sun,  8 Sep 2013 17:35:03 +0000 (UTC)
In-Reply-To: <531DBE1FF66D4356AEE6AEE5C2FE9389@PhilipOakley> (Philip Oakley's
	message of "Sat, 7 Sep 2013 20:19:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE8E8994-18AC-11E3-B261-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234256>

"Philip Oakley" <philipoakley@iee.org> writes:

> What I observed was that all the clones had the same HEAD problem,
> which I think comes from clone.c: guess_remote_head().

Yes.  They share "having to guess" property because their data
source does not tell them.

> My quick look at clone.c suggested to me that there would be a lot of
> commonality between the bundle data stream and the transport streams
> (identical?), and it was just a case of adding into the bundle data
> the same HEAD symref indication that would solve the normal clone
> problem (including backward compatibility). Is that a reasonable
> assesssment?

You need to find a hole in the existing readers to stick the new
information in a way that do not break existing readers but allow
updated readers to extract that information.  That is exactly what
we did when we added the protocol capability.  I do not offhand
think an equivalent hole exists in the bundle file format.
