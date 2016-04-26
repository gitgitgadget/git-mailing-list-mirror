From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http: support sending custom HTTP headers
Date: Tue, 26 Apr 2016 12:05:03 -0700
Message-ID: <xmqqzisgfaxs.fsf@gitster.mtv.corp.google.com>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
	<921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 26 21:05:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av8IN-0003nf-8M
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 21:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbcDZTFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 15:05:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750843AbcDZTFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 15:05:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B089D15514;
	Tue, 26 Apr 2016 15:05:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eIc2Y4ccs244vwAHnjXDbS6VdRs=; b=Mp1Yn5
	wldkHXBiKiYmc2TnJEYvR4IPzoH9EsC/sdliu+Uxdp+lV+/Kf6k1P9MIhmc0vD4P
	UH3MmELjNqSnkUvI5XN4OhSVyLP4731MBaoyWiHCxCo+Pe0NIbxs+EqcjJQ+WTvl
	SOUjOgoVft77HZywGHHd9+XQLzOBL/eHCdUy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eJ6xDH8Rg3fBjzLk9ZqFA45K13HioLjO
	MlzdtRcNVxxbhQThPS6WDejnKBwnCL8zZxZY1Fr+A0G8xLZ/QC+FiPBIc22/ZVqa
	7FTjdSfpBBR296wA8Cy6rABGYRUtASa9ayK7OZWaa3cO3yIYP2M+86RaOOc0wpqa
	acIWhJzxE/A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F07F15513;
	Tue, 26 Apr 2016 15:05:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4C2015512;
	Tue, 26 Apr 2016 15:05:04 -0400 (EDT)
In-Reply-To: <921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Apr 2016 17:40:30 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C8FB7C3A-0BE1-11E6-A954-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292648>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  diff --git a/Documentation/config.txt b/Documentation/config.txt
>  index 42d2b50..37b9af7 100644
>  --- a/Documentation/config.txt
>  +++ b/Documentation/config.txt
>  @@ -1655,6 +1655,12 @@ http.emptyAuth::
>   	a username in the URL, as libcurl normally requires a username for
>   	authentication.
>   
>  +http.extraHeader::
>  +	Pass an additional HTTP header when communicating with a server.  If
>  +	more than one such entry exists, all of them are added as extra headers.
>  +	This feature is useful e.g. to increase security, or to allow
>  +	time-limited access based on expiring tokens.

I am unsure about the last two lines.  Is it necessary to have them?
