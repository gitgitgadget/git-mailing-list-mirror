From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] git: simplify environment save/restore logic
Date: Wed, 27 Jan 2016 15:47:26 -0800
Message-ID: <xmqqk2mu60vl.fsf@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<xmqq37tja50t.fsf_-_@gitster.mtv.corp.google.com>
	<xmqqoac6621o.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 00:47:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOZoD-0000Bx-CK
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 00:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934772AbcA0Xra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 18:47:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933492AbcA0Xr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 18:47:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4DEED3F790;
	Wed, 27 Jan 2016 18:47:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/d0sxtR7eLiUrZ+6RHgeN4oiSZo=; b=XeMfO7
	nwZmeK5r+EONyoXdthRwxeFv4E6pd96GzVDo90B1mQHML9tM+XwW8Ke7OnfTJgw2
	CHs3UxzWOvpTh4XxoSi8JKouEmmw9Fsi4VdZ3vJBrMzq9fzvnwgvnfKGILBJT4gj
	CppYVYRZMzsZxV/fY7Z/ZTSPd7iUkIcEkfALQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JaM7B9tQBAaXkZhST1DwSYp4E3eyCZJu
	hr+NhgMTDyK58CmgxHd8e9Ep3a0Vp9RzWpOy2SprjF5AMeMLKmMcaMPm8Mnw6Mgz
	M3atm25J0GF26yxTgiviEtdA0hPM0ZvAmPKCOgED58Tzk2+vP72q5nm9g51ee/64
	KUsJ4XBy7Vc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 347D13F78F;
	Wed, 27 Jan 2016 18:47:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 974EB3F78D;
	Wed, 27 Jan 2016 18:47:27 -0500 (EST)
In-Reply-To: <xmqqoac6621o.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Wed, 27 Jan 2016 15:22:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 527878D8-C550-11E5-9A44-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> @@ -598,9 +597,9 @@ static int run_argv(int *argcp, const char ***argv)
>  		 */
>  		if (done_alias)
>  			break;
> +		done_alias = 1;
>  		if (!handle_alias(argcp, argv))
>  			break;
> -		done_alias = 1;
>  	}
>  
>  	return done_alias;

This hunk shouldn't be there; it changes the return value from this
function and breaks the whole thing.

What I will push out as part of 'pu' will have this fixed.
