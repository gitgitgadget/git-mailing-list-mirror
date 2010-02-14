From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 03:46:51 -0800
Message-ID: <7vsk94niok.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100214021847.GA9704@dpotapov.dyndns.org>
 <7v8wawy0ee.fsf@alter.siamese.dyndns.org>
 <201002141214.15025.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 14 12:47:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgcwX-0001w2-Gk
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 12:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab0BNLrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 06:47:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab0BNLrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 06:47:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A0FF99123;
	Sun, 14 Feb 2010 06:47:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Mo82/Gs6EI00n5LnJxixjoFElU=; b=TnogJy
	tuTd8nm1J/BS5Kjx7SDSgh/u87djn/fH7EP6BnTUICxdj9hybwdCfN04iJ0Ecd5U
	ztF5hZoec3GIU9R7Ae6rvND6zjJF/iJE2X//382thwfq5mzKfeZUbP9rT3dtA/pi
	tdCdiVWLIR3ysDHypzNNBNBAKxuhmG2YA7Y/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QQqE31AjSLcsI6U/ov3zjqxJ5CXuT0hs
	HO6zPlQGeOtskJEBbRe/X+derRrQYh4EBVKbVPYkWYW4eU0bTCNBwkeHvwDFl2zE
	tLahV6n2Dh9pvJPfHdTzvsVb8qms2TDYN059ZLgGtdI9fNe1xCbVUIuenWS/Y3CP
	2ML9SaDisv0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DA8499122;
	Sun, 14 Feb 2010 06:47:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7BEA99120; Sun, 14 Feb
 2010 06:46:52 -0500 (EST)
In-Reply-To: <201002141214.15025.trast@student.ethz.ch> (Thomas Rast's
 message of "Sun\, 14 Feb 2010 12\:14\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A92A7F40-195E-11DF-B71F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139898>

Thomas Rast <trast@student.ethz.ch> writes:

> * Give up and stick with Dmitry's patch :-)

You obviously didn't read the last line of my message before responding.

In any case, I have a suspicion that streaming to a single loose object
file would not buy us much (that is the only case the "cross directory
rename" could matter), exactly because we wouldn't want to leave an object
in loose form if it is so big that we do not want to slurp it in full into
memory anyway.  If we stream such a huge object directly to a new pack, on
the other hand, there won't be any cross directory rename issues.
