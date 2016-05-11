From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] submodule--helper: add valid-label-name
Date: Tue, 10 May 2016 18:11:19 -0700
Message-ID: <xmqqr3d9l7pk.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<1462928397-1708-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 11 03:11:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IgU-0006RJ-EJ
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbcEKBLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:11:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751063AbcEKBLW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:11:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 461871B9C1;
	Tue, 10 May 2016 21:11:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bibjJkbJA/8GvVRuK63dlMyS3f8=; b=SbZHOk
	I182k1ERyTKuO7RBs0Ljg9NSsDF4PD8BPTUH/xG2dKihXte0kccIDhCmKGcBMQMr
	UPZywR4VXFKDfVg+9l2mk9J6SqKtE0oN3rJP1GEcqGs2kvozSsgrGB76bkKpmnFI
	Eyee91IhrZnolV7b7LwqzoLyLOhb8WFBJEISc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rkbfI+btKNowJPbAU3nhXEMMR6wWYfuv
	yhq/abxX6DxP/H/4/T0296vDB6k2GBqoyvNfkjZmODTBckVoXSVT6an9patZE4VZ
	dfuMNPHUQQ/mWl6ma/wGYCeCm+Yb3AteJ+Qw3tUbXRSXcaRRatH1XYxU0uK6SxN9
	xXtStxrCrME=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CD741B9C0;
	Tue, 10 May 2016 21:11:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE14A1B9BF;
	Tue, 10 May 2016 21:11:20 -0400 (EDT)
In-Reply-To: <1462928397-1708-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 10 May 2016 17:59:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 456DEA44-1715-11E6-8C6F-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294218>

Stefan Beller <sbeller@google.com> writes:

> +static int submodule_valid_label_name(const char *label)
> +{
> +	if (!label || !strlen(label))
> +		return 0;
> +
> +	if (!isalnum(*label))
> +		return 0;

I'd limit this one to isalpha() if I were doing this to make the
restriction similar to identifiers in traditional programming
language.

> +	while (*label) {
> +		if (!(isalnum(*label) ||
> +			*label == '-'))

And throw in '_' to the mix while at it.

> +			return 0;
> +		label++;
> +	}
> +
> +	return 1;
> +}

If the convention is "0 is good", then please signal "bad" with a
negative value, not just "non-zero".
