From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: Make merge strategy message follow the diffstat
Date: Fri, 13 Jan 2012 11:12:22 -0800
Message-ID: <7vaa5rzaax.fsf_-_@alter.siamese.dyndns.org>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com>
 <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com>
 <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <20120111184026.GA23952@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 13 20:12:37 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RlmYG-0000iM-VR
	for glk-linux-kernel-3@lo.gmane.org; Fri, 13 Jan 2012 20:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758880Ab2AMTM2 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 Jan 2012 14:12:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60997 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753649Ab2AMTMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2012 14:12:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C82A5544F;
	Fri, 13 Jan 2012 14:12:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3mDHtXsxeIj/H57T8psb1nR5gHg=; b=uDR+xe
	hjDAM7Z74/iQNghljeU9+TzgZpow4ALyPJlxarfconv8nZE5ghyPsjB70ZpkKwo7
	hwFdUkvTeQ1W3fOW8Q/zmmekm1QLPXxIE3DzgJ1ZO5aTWg10dthgl+bxo5jaJjUV
	eF0+XNuwHldlSXDIzNWlKCFirYvpcHx7KIo0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O2YoUm9EmwTR3gRZSX4UfbgVjo0lQRKY
	m/BTQ5vUfyOoC/pU1DevlxuAdlZ/GS5mZwDKY6XJknMrFlfmM2TICZeU+4XYjM9c
	EnwJhH71/lfH8ekAhbcTobCxNS6fQcKQfuN3LZw6VBYaK8Bz2U8XANeyJbw0FVRA
	/YaVKx+4pCM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEED95448;
	Fri, 13 Jan 2012 14:12:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FE185446; Fri, 13 Jan 2012
 14:12:24 -0500 (EST)
In-Reply-To: <20120111184026.GA23952@windriver.com> (Paul Gortmaker's message
 of "Wed, 11 Jan 2012 13:40:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 865735AC-3E1A-11E1-9DDB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188529>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> By moving the message after the diffstat, there is a better chance that
> people will be aware they've done a pointless merge commit.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

I think the goal of the change may be worthy, but a few points:

 - What does "automsg" mean? Is "auto" in contrast to "manual"? Even
   better, wouldn't it be far simpler to just use

	if (msg && verbosity >= 0)
		printf("%s\n", msg);

   and get rid of this mysteriously named variable altogether?

 - Wouldn't it make more sense to move "No merge message -- not updating
   HEAD" also to the end?

 - After applying this patch, does the tests still pass?

Thanks.
