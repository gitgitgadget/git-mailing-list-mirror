From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Fri, 20 Sep 2013 15:54:44 -0700
Message-ID: <xmqq8uyrp0i3.fsf@gitster.dls.corp.google.com>
References: <20130917201259.GB16860@sigill.intra.peff.net>
	<xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
	<20130917202917.GA20020@sigill.intra.peff.net>
	<xmqq1u4nxjv2.fsf@gitster.dls.corp.google.com>
	<20130917212106.GB20178@sigill.intra.peff.net>
	<xmqqk3ifw1km.fsf@gitster.dls.corp.google.com>
	<20130917220345.GA22914@sigill.intra.peff.net>
	<xmqqd2o7w0xc.fsf@gitster.dls.corp.google.com>
	<20130919074616.GA29773@sigill.intra.peff.net>
	<xmqqbo3ou1ue.fsf@gitster.dls.corp.google.com>
	<20130919221323.GA18085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 00:54:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN9b8-0001Mr-Uo
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 00:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab3ITWyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 18:54:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab3ITWyq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 18:54:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D97F437C8;
	Fri, 20 Sep 2013 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p3qUTyQ/wAwRQVmuZYKEE2Ztd6w=; b=e5rCdL
	06QSj/FqivNyTnPwu1U1t8oxwkuD6TGwX0c9brtej5O6xok+UeKLDGKlfiwghNvd
	9NHdg4qWEFpISPxRpGzdEf/+mVmhXNJq6csDlN9zReD5+W1gQ71TEnYsWM81Q3iz
	GSZTb2QthSm/oCLIu/R8ct2jutnG9jWfg14M0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j8TMqlgMmapeCFrB/HhOlFmUu6bMlDRF
	XbEeQfQJZ32AdA8xGH21exBx5kj0JW6t0b//5dgTUPtk26MIpmDzprYIAgF8sslq
	z9lDHR4/SlTbrvkKJnfDobYrV8aH1VBOVLk3BLxFMfzd/fjwKbcHdk/TXIpFW8vD
	nYm9XBc5vv8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BE5C437C6;
	Fri, 20 Sep 2013 22:54:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2FA8437C4;
	Fri, 20 Sep 2013 22:54:45 +0000 (UTC)
In-Reply-To: <20130919221323.GA18085@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 19 Sep 2013 18:13:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A4FED24A-2247-11E3-BA03-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235087>

Jeff King <peff@peff.net> writes:

>      But I think that points to a larger problem, which is that we do
>      not want to just look at the entries that are different between the
>      tree and the index.

True.  The unpack-trees API knows how to walk the index and trees in
parallel, and I tend to agree that it may be a more suitable vehicle
for this purpose.
