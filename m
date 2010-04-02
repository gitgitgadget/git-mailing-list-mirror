From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] diff: avoid useless filespec population
Date: Fri, 02 Apr 2010 00:12:22 -0700
Message-ID: <7vvdcal44p.fsf@alter.siamese.dyndns.org>
References: <20100402000159.GA15101@coredump.intra.peff.net>
 <20100402001424.GG16462@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 02 09:12:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxb3U-0003CD-V4
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 09:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759259Ab0DBHMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 03:12:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759233Ab0DBHMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 03:12:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9127AA7AD7;
	Fri,  2 Apr 2010 03:12:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=q5tA9kl6hvTVBAzyGzLleUWRzxg=; b=tpBKp8WNZfiT23d1UdjZQAG
	it+gIgyr9ZZOM8E/18txGB85VaAfH5AbHvXhs7KExA7W4jgtA/7xZssn8zQscYpn
	KNMSxBOor2hTV0Z9lSelVWdMDApC75y8q2sWC5U8oBXfcR3mjkuIOn4vrvyLKyer
	HCVK7XBWsqmelnNUIb0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OJYtPdGaH830QMTTBGYWYh6V9HjyxlU86Gj+TpYkIV0qdYuRI
	bZjqytLG+zJjghz7k4+/bBAZYuR09jTTE6+mrUNVrw/+PL9OzoC7sLr+LYHTpfBv
	CHhxwPIGl6++0e3QUamioPtATM7SPfSdKmL3yijefEqwLU/FoFuiKZ0nz0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E003A7AD6;
	Fri,  2 Apr 2010 03:12:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D756AA7AD5; Fri,  2 Apr
 2010 03:12:23 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 178DB960-3E27-11DF-BD8F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143783>

Jeff King <peff@peff.net> writes:

> This patch just pushes the fill_mmfile call a bit later, so we can avoid
> populating the filespec in some cases.  There is one thing to note that
> looks like a bug but isn't. We push the fill_mmfile down into the first
> branch of a conditional. It seems like we would need it on the other
> branch, too, but we don't; fill_textconv does it for us (in fact, before
> this, we were just writing over the results of the fill_mmfile on that
> branch).

... and leaking the memory in the "cached" codepath, perhaps?

> I remember when I first started using git having it go so fast that I
> had to double-check that it had actually worked correctly. I had another
> of those moments when I ran this. But it correctly processed everything
> I threw at it. More stress-testing appreciated. :)

Heh.  Will queue.

Thanks.
