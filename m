From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Running commands in wrong environment
Date: Fri, 04 Dec 2009 09:16:45 -0800
Message-ID: <7vr5raslqa.fsf@alter.siamese.dyndns.org>
References: <D6F784B72498304C93A8A4691967698E8EE2C44FE5@REX2.intranet.epfl.ch>
 <20091204104441.GD27495@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marinescu Paul dan <pauldan.marinescu@epfl.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbmD-0001V5-3C
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757081AbZLDRQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757011AbZLDRQx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:16:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837AbZLDRQw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:16:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1D6D85B66;
	Fri,  4 Dec 2009 12:16:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VBZ955mtrYGE8ej/N3JrbqeJziM=; b=Wlhu0m
	bpfkPnj4yxieGkLoewKWO58OhVXJeVR0m7wH8QSZM1EcCaOPBvDCd/ajZIlenLtP
	tfC9+IDI+ZCsC+WsWfg2jL/NC1FTVUzcTkKkPRjPmDn5k5zm+IxhzFjgu0pAQZzl
	ruXaIvAFlbr7QPF/ncsvmV76m5bwZdTd48iak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uf6AczbooURfMHYThy20ToOfMK9+xVLs
	P3l5yA/yz0wj5ICJh6/84ZQf+6Z/FF4S+IsvAzHLe+oJnq1FnvTye6ZBD/c/wU4u
	Wnu9D91j6M/XrCeC1O7JcIbMeJ+sy2KJTuOlYUfqTMnpx4+1SAF9r9A/NZRTQ2yU
	aPCpNSlMnOY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE9A85B64;
	Fri,  4 Dec 2009 12:16:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08D2A85B5D; Fri,  4 Dec
 2009 12:16:46 -0500 (EST)
In-Reply-To: <20091204104441.GD27495@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 4 Dec 2009 05\:44\:41 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D053A554-E0F8-11DE-8385-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134548>

Jeff King <peff@peff.net> writes:

> But the consequences, as you mention, could include data loss, which
> argues for being on the safe side. In that case, we would probably want
> an "xsetenv" to die() if we fail to avoid cluttering the code
> everywhere.
>
> I dunno. If we're going to do it, it is probably maint-worthy. Junio?

My gut feeling is xsetenv/xputenv would be sufficient.  I do not think we
make any setenv/putenv that we do not care about failing, perhaps other
than the "if LESS is not there set it to this default value, as it would
give users nicer experience if they use 'less'."
