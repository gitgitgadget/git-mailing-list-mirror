From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Hold an 'unsigned long' chunk of the sha1 in obj_hash
Date: Thu, 25 Apr 2013 13:13:07 -0700
Message-ID: <7vobd22wto.fsf@alter.siamese.dyndns.org>
References: <6c2b67a2f0b67ee796c7676e3febe4c61ab85d4a.1366912627.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 25 22:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSXd-0001Jr-Mr
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759201Ab3DYUNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:13:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759186Ab3DYUNK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:13:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89BE519870;
	Thu, 25 Apr 2013 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ueVl87fC6g5HdE7RLQYoMMQdQuE=; b=OtTq+U
	PmPKai9q/I4mfXUA4C/EymdCH2f+Sd94yFK6U70Gkzo8GPw1H+lRutc3PFLx/vH2
	bRYwpDyEQ/k08ICTH2l0Q1cyqYip/5vMV3jlG3NVJqRJ1At1NTx/HoOwJpxuMElV
	//X32Yk+iZZbrfG3lBhDRNWebQgoS+nJ4CAcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sRi9ed4Ldb+fHvJmgBHWb43zpH5D8MRO
	Z674yzkGjwnindXyrpkixuclK3RsVUqR2AACswPCMBKNFeHC8DMeuulFazfCWQhn
	LeL1hET44Mkmhq36Wq4sif0rQS/oezPK67HGKxinUyhwj//kDzd+dcAGSSIUR1C8
	A8RbFt1Ca2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 818A91986F;
	Thu, 25 Apr 2013 20:13:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0F361986D;
	Thu, 25 Apr 2013 20:13:08 +0000 (UTC)
In-Reply-To: <6c2b67a2f0b67ee796c7676e3febe4c61ab85d4a.1366912627.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Thu, 25 Apr 2013 20:04:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C1C4956-ADE4-11E2-A71D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222441>

Thomas Rast <trast@inf.ethz.ch> writes:

> So we take a slightly different approach, and trade some memory for
> better cache locality.

Interesting.  It feels somewhat bait-and-switch to reveal that the
above "some" turns out to be "double" later, but the resulting code
does not look too bad, and the numbers do not look insignificant.
