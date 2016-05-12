From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 22/94] builtin/apply: move 'threeway' global into 'struct apply_state'
Date: Thu, 12 May 2016 12:41:05 -0700
Message-ID: <xmqqoa8bdpym.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-23-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 21:41:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wU2-0007pP-HW
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbcELTlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:41:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753127AbcELTlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:41:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 645AE1A9D7;
	Thu, 12 May 2016 15:41:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AR9HXpQ1RP38hvgbWh/201nwpqk=; b=swIYtJ
	46NTQGKl4cJofb1cKB7zUSUOxeE5hmNhLEUR377mm9y45H2N3kCs49Uc2Lk4wGXc
	xBD4b9dbtI2D4VQ7zQfrXjhb5usqUh196PLAiYFtxGp/AYFbdIJUFn5gOlR3+bco
	PucV25nCbEApOEixeZUjHRatXb1klbXiF1q08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ROukuuYtZpT/g7Nx0kiXw1AoNCxAev7D
	XgoTCfA+CPqFb1gG1MbO8iJ9m2vJH0CqyBm683DpbFKXORlm3D2a9lkG5zydaG3O
	gbuGfpEIhkvYg0bXGxk/Tg87TUosITbqWwnOx2p7+1vLYqPb+t47e6Kc/CWB9lFu
	ZN0UgQH0hjQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A1E41A9D6;
	Thu, 12 May 2016 15:41:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C30351A9D3;
	Thu, 12 May 2016 15:41:07 -0400 (EDT)
In-Reply-To: <20160511131745.2914-23-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78D6CA4E-1879-11E6-8D96-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294436>

Christian Couder <christian.couder@gmail.com> writes:

> To libify the apply functionality the 'threeway' variable should
> not be static and global to the file. Let's move it into
> 'struct apply_state'.
>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 6216723..3650922 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -40,6 +40,7 @@ struct apply_state {
>  	int numstat;
>  
>  	int summary;
> +	int threeway;

This makes threeway look as if it is one of the cosmetic options
like stat/numstat/summary, doesn't it?  If anything, the blank
between numstat and summary should be moved below summary.  I'd
group knobs that affect "what is affected (check, check_index,
cached, etc.)", "how the application is done (allow-overlap,
threeway, in-reverse, etc.)" and "cosmetics" and place the ones in
the same group next to each other.
