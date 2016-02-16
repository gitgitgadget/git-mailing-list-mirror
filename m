From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/15] branch: report errors in tracking branch setup
Date: Tue, 16 Feb 2016 15:07:55 -0800
Message-ID: <xmqq1t8cmeyc.fsf@gitster.mtv.corp.google.com>
References: <1455627402-752-1-git-send-email-ps@pks.im>
	<1455627402-752-3-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:08:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVoiw-0005kl-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380AbcBPXH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:07:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756335AbcBPXH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:07:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB07D453E3;
	Tue, 16 Feb 2016 18:07:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fsf8i/ufoN+1lB6bKo9fuhPMW4E=; b=IOaGEm
	yE1XEWPajLPS6HKO5laXxeAd+fVCQg51f2ZFXrweVke0uDr5SAD9XeQdZJ/pfirS
	92T146wtFiEwpEd8MpwKFIFBJX9zqbcFgVakBhNhEEqYmwuiY09UtNtYs/Yt2tNL
	81Kl804McskZzmO/XB+Lx25h/Oyj5HzVVOjJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WH1wf9y5C4BRS2e00wWRDS6q75jEHPHz
	JKs1eRlBpdip6a8IaM2k3IrQA/iWO2PqZu8e5wFy/1HIUV61iSEwg+ao1rfrp1a/
	ZXmVcKfNlWt+QmJzbH61gVf4kuDV6PrnyPjptiWixNWg/3GXPJ9hnSPH6Wjm32+6
	e2a7GCa6XHY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2DE5453E2;
	Tue, 16 Feb 2016 18:07:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 293C6453E1;
	Tue, 16 Feb 2016 18:07:57 -0500 (EST)
In-Reply-To: <1455627402-752-3-git-send-email-ps@pks.im> (Patrick Steinhardt's
	message of "Tue, 16 Feb 2016 13:56:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DD5C470-D502-11E5-AE41-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286452>

Patrick Steinhardt <ps@pks.im> writes:

>  	if (rebasing) {
>  		strbuf_reset(&key);
>  		strbuf_addf(&key, "branch.%s.rebase", local);
> -		git_config_set(key.buf, "true");
> +		if (git_config_set(key.buf, "true") < 0)
> +		    goto out_err;

The indentation here is suspect.
