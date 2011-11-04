From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] fsck improvements
Date: Fri, 04 Nov 2011 11:43:52 -0700
Message-ID: <7v1utnd8yf.fsf@alter.siamese.dyndns.org>
References: <1320421670-518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 19:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMOkC-0003wo-N3
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 19:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185Ab1KDSn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 14:43:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab1KDSnz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 14:43:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E86B595F;
	Fri,  4 Nov 2011 14:43:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XTrsF9zf/hM8qrNeOCIcv+enKo0=; b=UrMxfG
	RYHCBQfa4j99wyddXsnLqpgqO0sxpcUvmAcS9BTvZa6tFaWXK9f3U12sifczDuIf
	7ZLpryh1BGZagnfZQ1XvxUai5GbbfR0aRNmbGzzM67PsopRFpMOrpIS+ollTyIJ7
	JeOHBmKVDe5DCswojFssNTYuAM1UKqnkdqdk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mEgqv3ypjubTtgwquKKuvly2xdw2yx+D
	Gbry7dDUD+Blz5PFt7lRqtIl0ZwzVY28/Me3Y9ZfQcijPXT5GtoB8SvnjlO1Mu/b
	W3A3zlUzzFsx1c5TyhLQTeJToQouLzDpBMvVpzLbgEcg+dc8w9NgseEoLEYKUNMv
	5x5OvSPKCew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51EE4595E;
	Fri,  4 Nov 2011 14:43:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C95E1595C; Fri,  4 Nov 2011
 14:43:53 -0400 (EDT)
In-Reply-To: <1320421670-518-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Fri, 4 Nov
 2011 22:47:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1FB6608-0714-11E1-B621-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184797>

I think patches 1, 3 and 4 all are good ideas from a cursory look.

I am not sure what purpose patch 2 serves, though. When we find a checksum
mismatch for an object in a packstream due to a single-bit error, we would
still be able to salvage other objects in other parts of the pack as long
as we have a good .idx file, and in such a case, wouldn't it be better if
we attempted to find as many corrupt objects that we know we cannot
recover as possible and tell the user about them, so that they can be
skipped during the recovery process?
