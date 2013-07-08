From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] commit: reject invalid UTF-8 codepoints
Date: Mon, 08 Jul 2013 12:36:07 -0700
Message-ID: <7vfvvozvx4.fsf@alter.siamese.dyndns.org>
References: <cover.1372957719.git.sandals@crustytoothpaste.net>
	<20130704171943.GA267700@vauxhall.crustytoothpaste.net>
	<alpine.DEB.2.00.1307051345260.11814@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Jul 08 21:36:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwHEO-0004oC-SX
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 21:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab3GHTgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 15:36:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159Ab3GHTgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 15:36:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E93D32EDF3;
	Mon,  8 Jul 2013 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uXYT+rUshjeiix6Kg7sJlz2bL7c=; b=Sbby+g
	Z9ddOrLy0UKGcbZ+cWnI66hJdyFZa2yfmGLH5deNMwugdSlg0XkAXClG12XVtc6g
	itO6Fe14jBV7vjPLVobvGemHi+jmh4TbWSisNaW1AE6nEBmICk4hOUulIDNm53/X
	qeN2aL0SLtmufU7d+wfDwCmAfdkRs8uA2MXvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SBkwEYzedAEC32pwaGle1tT/KNfJxyOu
	YbzWHPvWAR0q/nwPIqxvTkns6cB+UUxTNzqzI/Lc78CNHRYqQPbuH13hD8v9/f4M
	ywhc46oGJ9mc87v9Inau3pRBaieMeKbKXLNVXe9RSu7bOR8xvmD/PqO0OkmK3/Fp
	eghBpySirTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98BE92EDF2;
	Mon,  8 Jul 2013 19:36:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A045A2EDEE;
	Mon,  8 Jul 2013 19:36:09 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1307051345260.11814@ds9.cixit.se> (Peter
	Krefting's message of "Fri, 5 Jul 2013 13:51:03 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3ED7478-E805-11E2-9D5A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229888>

Peter Krefting <peter@softwolves.pp.se> writes:

> brian m. carlson:
>
>> +		/* U+FFFE and U+FFFF are guaranteed non-characters. */
>> +		if ((codepoint & 0x1ffffe) == 0xfffe)
>> +			return bad_offset;
>
> I missed this the first time around: All Unicode characters whose
> lower 16-bits are FFFE or FFFF are non-characters, so you can re-write
> that to:
>
>   /* U+xxFFFE and U+xxFFFF are guaranteed non-characters. */
>   if ((codepoint & 0xfffe) == 0xfffe)
>    return bad_offset;
>
> Also, the range U+FDD0--U+FDEF are also non-characters, if you wish to
> be really pedantic.

Yeah, while we are at it, doing this may not hurt.  I think Brian's
two patches are in fairly good shape otherwise, so perhaps you can
do this as a follow-up patch on top of the tip of the topic,
e82bd6cc (commit: reject overlong UTF-8 sequences, 2013-07-04)?
