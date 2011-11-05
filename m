From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] fsck improvements
Date: Fri, 04 Nov 2011 22:26:04 -0700
Message-ID: <7vehxn9m37.fsf@alter.siamese.dyndns.org>
References: <1320421670-518-1-git-send-email-pclouds@gmail.com>
 <7v1utnd8yf.fsf@alter.siamese.dyndns.org>
 <CACsJy8Ch0m5KQ--VWzsmyNq2R-uHsvSYofHP8L+qcvhRrqgoKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 06:26:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMYm7-0005Kd-8e
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 06:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841Ab1KEF0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 01:26:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740Ab1KEF0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 01:26:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E159834A4;
	Sat,  5 Nov 2011 01:26:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=31fBFgK8228isQaa1w6J8+QEk+s=; b=SNPl7t
	SowUSCNdtAFQZOsLXpVPh9yKTuNijl851Lm4y/06eiSh4ZA6tM4R5H4GeRXO/djM
	kj6m6QwHG0AGeLT5CGaKKFLNSpzAz+Q8oIN9wixqr7zyuj0bum3cKjcNhuJfq+jd
	f8WwABieiexeZ9BtZLTNMJrNhKJ0hzco+utLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BMRWhHCmPPbaqqGIZqLKkDOKskIRK462
	6SfUuHLBVnYY5cZ1PSBYSICWiFFRPdBwKZCOZmRXYqv2w27F5Qwy41Dgbp2nmPN+
	EkLYAlEfIcJ3Bm2T96BxYKiOX14nktrVC2Yp3d/ah5lOKTawXl99fUn3uej7ApSl
	VteSN3KL2aw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF91D3493;
	Sat,  5 Nov 2011 01:26:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 073F63492; Sat,  5 Nov 2011
 01:26:05 -0400 (EDT)
In-Reply-To: <CACsJy8Ch0m5KQ--VWzsmyNq2R-uHsvSYofHP8L+qcvhRrqgoKQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 5 Nov 2011 10:18:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8F757AA-076E-11E1-927D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184819>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2011/11/5 Junio C Hamano <gitster@pobox.com>:
>> I am not sure what purpose patch 2 serves, though. When we find a checksum
>> mismatch for an object in a packstream due to a single-bit error, we would
>> still be able to salvage other objects in other parts of the pack as long
>> as we have a good .idx file, and in such a case, wouldn't it be better if
>> we attempted to find as many corrupt objects that we know we cannot
>> recover as possible and tell the user about them, so that they can be
>> skipped during the recovery process?
>
> It's the inconsistency in that for(;;) loop. If we are going to
> salvage as many objects as we could, should we do "continue;" instead
> of "break;" when unpack_entry() or check_sha1_signature() fails?

I do not think making things worse for the sake of "consistency" is a good
sell ;-). How hard would it be to make it also continue when these report
a corruption?
