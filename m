From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule should honor "-c credential.helper" command line argument
Date: Fri, 19 Feb 2016 09:33:56 -0800
Message-ID: <xmqqr3g8d2pn.fsf@gitster.mtv.corp.google.com>
References: <56B0E3AA.30804@syntevo.com>
	<20160203042554.GA21179@sigill.intra.peff.net>
	<CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
	<CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com>
	<56B74B17.4040304@syntevo.com>
	<CA+P7+xpFmZBUwq1h9Xhi7xKYfAyvcouBiV5ujHxuGJQJTMHXZw@mail.gmail.com>
	<CA+P7+xpHNHVSJnVg3HwiBjWxRdSpLXCsm3GpWst=BNyhLMVd5A@mail.gmail.com>
	<20160219043019.GA14764@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:34:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWowh-000504-DS
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 18:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993117AbcBSReN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 12:34:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2993094AbcBSReA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 12:34:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCFB843678;
	Fri, 19 Feb 2016 12:33:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KsjyRObQM9p0wHaiMocy8BjU5Ko=; b=lHye7W
	wzDIYj2xqChVqYcsV+4c3UNRv+HjMAY6SpV1tNHUt1LCk0qJ1KrgMSjVNGGTKYZk
	4OAmb91JDdmwNxPa+qzitHrvhklAaCMbCCS0FxbtSNT7V4B+mI0ogFmxjNFk9bXW
	J9o4HEUt7/H4SerjXRg7LU+Eua5FSQBrpfomU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cq8B46jUvuvMfojlvuGhAG6jpBQYvrSA
	5eBiT9lH0AMU103ZykC8AcrlmsoMO+DD9b3qcseGtuJaSdXOr51C+zZTUet/hyLZ
	tSHNGZrcGVb1B8IRbwOol06WwrRVb85RludKpwdOtTXFeRFrdeVhGFja505yLluf
	uLE2+4y1IHg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C392C43676;
	Fri, 19 Feb 2016 12:33:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4868C43675;
	Fri, 19 Feb 2016 12:33:57 -0500 (EST)
In-Reply-To: <20160219043019.GA14764@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 18 Feb 2016 23:30:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F46AD5F6-D72E-11E5-9A88-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286722>

Jeff King <peff@peff.net> writes:

> That being said, I am not sure this is the right solution. In the thread
> I linked earlier[1], Jens indicated he would prefer not to blindly share
> config with the submodules, and I think I agree. Or are you proposing to
> pick and choose the keys in GIT_CONFIG_PARAMETERS, and whitelist
> credential.*?

Yes, I think it is sensible not to propagate by default, and pass
ones that are absolutely safe, sane and necessary by whitelisting.
