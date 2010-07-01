From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Thu, 01 Jul 2010 09:27:18 -0700
Message-ID: <7v1vbn417d.fsf@alter.siamese.dyndns.org>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de>
 <7vy6dx90uk.fsf@alter.siamese.dyndns.org> <4C2AE04E.9090901@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 18:27:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUMbt-0005c2-A2
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 18:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199Ab0GAQ12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 12:27:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab0GAQ11 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 12:27:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09D47C04DA;
	Thu,  1 Jul 2010 12:27:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BymmiD+2O/MXzQAEp4BU1hb6sfc=; b=vsqNay
	hTu9UNlRVJD2mVkaiV3gckEuzwrPY5V0bkG9zuNNlIfPpJB2zRTivfssd475qdgF
	QZsNe6hpABKH7FGHQNQBsylbRX2BCU8eiEQHAvGFC5kEWC6Ccv5M2QPr/V6uou8T
	foHR2qXAMWqsRw5tRVSwKRockN36Yk2OuuueI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eMqKuBZa4TR4pJSJgYQiP1xxdyZjrrGy
	NWeDqJKJE21dLZymgEGPo596jdLQBB2QtJzbxLBzce74WxStE6UvjI0HMCp6vNW1
	BAOMMR+CopNWnje/ymJVQKW01NChLcSwnEZ6ZrJvufQhcwJmJdA4tkp4VQ/YwyHN
	iONPEM9YeGE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C754EC04D5;
	Thu,  1 Jul 2010 12:27:23 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D648FC04D1; Thu,  1 Jul
 2010 12:27:19 -0400 (EDT)
In-Reply-To: <4C2AE04E.9090901@viscovery.net> (Johannes Sixt's message of
 "Wed\, 30 Jun 2010 08\:12\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 87809D94-852D-11DF-95CF-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150054>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Would it be possible to update the timestamp of preimage every time it is
> used (e.g., in rerere.c:merge()), and check for that?

It would be _possible_, but we are _not_ modifying the file at that point,
so somehow that solution feels very wrong, no?
