From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/10] teach replace objects to sha1_object_info_extended()
Date: Thu, 12 Dec 2013 12:05:46 -0800
Message-ID: <xmqq1u1hu95x.fsf@gitster.dls.corp.google.com>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Dec 12 21:05:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrCWB-0005zW-TH
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 21:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab3LLUFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 15:05:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab3LLUFv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 15:05:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF3C659AC0;
	Thu, 12 Dec 2013 15:05:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KjDPOaWgKgx4Zysz5QGbnwxxpns=; b=iGqIQU
	/8qJ1PUIDKw5bDvZRHMCIPU3tNXssihB4uCQjtRSZmLkVpP4QBtZXK7HI2EEYssF
	tYA9b2MJj9GE+w2F385WjMqjzuCRy0isyn8i4a4GFPHg0oaBXmYYX6y0QabD+4B5
	soiKpyHEAiWhZDw6a0ZOG+9ZpfEfHkqM0YsnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OyozWTg98EEIjfYJouH50WJclvJepVLk
	5XqCMVcqg9lswF5KECvtfz6IBRP8x2TJRV21mJoPNJ9aWenJbCDO5sPl/2oaYeEp
	XVYassPpjZiSM3DcYZmg4okzfOmX5Oj5xu8DwlTSKYlH5rvDXD08K/7iIUirqTK9
	lo+jLsc+nMM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D3159ABF;
	Thu, 12 Dec 2013 15:05:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8E9159ABE;
	Thu, 12 Dec 2013 15:05:49 -0500 (EST)
In-Reply-To: <20131211074147.11117.1155.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 Dec 2013 08:46:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CBBB58B0-6368-11E3-AE16-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239243>

Christian Couder <chriscool@tuxfamily.org> writes:

> Here is version 3 of a patch series to improve the way
> sha1_object_info_extended() behaves when it is passed a
> replaced object. The idea is to add a flags argument to it
> in the same way as what has been done to read_sha1_file().

Thanks.

Will take a look again (in the meantime, will queue on 'pu').

I do not think the new name for the bit is necessary nor it is a
good change, though.  Given an object name, reading the data and
inspecting the metadata (i.e. type and size) should yield consistent
results, so the original name is a perfectly appropriate name that
means "use the replacement object when using read-sha1-file and
friends to ask about an object".  The use of the replacement object
happens to be implmented via lookup-replace-object helper, but that
is an implementation detail of _how_ it is done, not the high level
descroption of _what_ the callers want to see done.

But that is just a minor nit.
