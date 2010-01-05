From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Add support for the google-chrome web browser
Date: Mon, 04 Jan 2010 21:40:07 -0800
Message-ID: <7vr5q56rew.fsf@alter.siamese.dyndns.org>
References: <20100105051906.GA22799@efarrerlx.appsig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Evan Farrer <evan.farrer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 06:40:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS29Z-0006hp-5s
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 06:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab0AEFkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 00:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888Ab0AEFkU
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 00:40:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab0AEFkT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 00:40:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 54C86AD7F3;
	Tue,  5 Jan 2010 00:40:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LtSHFPmjuh7q3itFtRlat9lDTYk=; b=Yly859
	QfVcpNLNYHyM1jewC5bl8Wpzh2Ej7YC9iUumYwEAPSp5mmlZZlJqqk/44IqXRAIq
	AfVyeiCY2ih5OznDIeNSEhkLM9+BsXBBgr2o3TbiJdMImT0PTtMnkXcmCZrEML0L
	tb1WjIN9fy2W1JW1fNAkTtsmRiZDjvKdst5Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s2uoG3C+8179TMKDAN35DTMtgWcFczPO
	y3ZXgpPRSe4/yvptb5JT+ewVuKMUutTDNoEApuFkOUHUvtKkLTTEIgkVUbLxegW3
	bqBVlPpUDQ5nkRRDEyJKpGpTvw3TzZYLLNbVPbEBNeGYfMU6ZQII9+nzbE3dn4qp
	lkCHqGw0ouc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 267C8AD7F2;
	Tue,  5 Jan 2010 00:40:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DE146AD7F0; Tue,  5 Jan 2010
 00:40:08 -0500 (EST)
In-Reply-To: <20100105051906.GA22799@efarrerlx.appsig.com> (Evan Farrer's
 message of "Mon\, 4 Jan 2010 22\:19\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB81CBA0-F9BC-11DE-8723-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136164>

Evan Farrer <evan.farrer@gmail.com> writes:

> Signed-off-by: Evan Farrer <Evan.Farrer@gmail.com>
> ---
>  Documentation/git-web--browse.txt |    1 +
>  git-web--browse.sh                |    6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
> index 278cf73..0994139 100644
> --- a/Documentation/git-web--browse.txt
> +++ b/Documentation/git-web--browse.txt
> @@ -25,6 +25,7 @@ The following browsers (or commands) are currently supported:
>  * links
>  * lynx
>  * dillo
> +* google-chrome

Hmmm, the support added by this patch for the chrome is, together with
w3m, links, and open, to simply run the command with given arguments
without any other magic.

Perhaps valid_custom_tool() function should be changed to simply return $1
if $browser_cmd is not found, like this:

	valid_custom_tool ()
        {
        	browser_cmd=$(git config "browser.$1.cmd")
                : ${browser_cmdn:=$1}
	}

Then we don't even have to add any specific support for "google-chrome" or
anything that takes "$command $path..." and opens the documents.

Is there a downside in this approach?
