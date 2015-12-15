From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/10] dir: free untracked cache when removing it
Date: Tue, 15 Dec 2015 11:05:44 -0800
Message-ID: <xmqqlh8vfs6v.fsf@gitster.mtv.corp.google.com>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
	<1450196907-17805-8-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 20:06:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8uvC-0004L1-NH
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 20:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478AbbLOTF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 14:05:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932190AbbLOTF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 14:05:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E01D631065;
	Tue, 15 Dec 2015 14:05:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LQC03zLvOs3CAYNPln3TDFEIIzk=; b=dHxqjf
	8k9uscW3jFJgkawS92pKJRMXitPK6lz0TS1Fb4/PXz5EVrZymObKH445OjC3rrC5
	1ujjivsf/vk1wGvUu6Q6BHvgTkQeEr8HStxdh3LhGm7ajrYRYXwfkdRTH0yOfKjs
	G0NFHVbvJ9tu4TOyTh2yQ0CNZrUP2iCBLf9Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AxNlcKx9ldsZMu2IEIpGj8r6tx6ZJmrs
	ZB0q31Hz5SUlfMoHNmlPHcTV6AQQBYIqG8OZNyUh+CfgNI4kNOPlRogW439q0ceE
	UI8UahzTevWo5MvfPe0Q9Uygt2jsJd9gzPMZ1kscTVob+Qhw2rx6pbMWur/+hIAj
	pDi4ptHLPNw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D470A31064;
	Tue, 15 Dec 2015 14:05:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C18B31062;
	Tue, 15 Dec 2015 14:05:46 -0500 (EST)
In-Reply-To: <1450196907-17805-8-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 15 Dec 2015 17:28:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8A4F26A-A35E-11E5-9A11-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282494>

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  dir.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/dir.c b/dir.c
> index ffc0286..3b83cc0 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1954,6 +1954,7 @@ void add_untracked_cache(void)
>  
>  void remove_untracked_cache(void)
>  {
> +	free_untracked_cache(the_index.untracked);
>  	the_index.untracked = NULL;
>  	the_index.cache_changed |= UNTRACKED_CHANGED;
>  }

Up to this point the series makes sense (again, I am not saying the
remainder does not ;-)).  But shouldn't this step, as a bugfix,
appear a lot earlier in the series?
