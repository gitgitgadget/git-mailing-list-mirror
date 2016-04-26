From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/83] builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
Date: Tue, 26 Apr 2016 13:27:35 -0700
Message-ID: <xmqq37q8f748.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-23-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:28:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9aO-0004rj-SM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbcDZU1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:27:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754012AbcDZU1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:27:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B8AC816026;
	Tue, 26 Apr 2016 16:27:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oFrqkRNcMhyrL/xTWV4Dts0bOpk=; b=jNTh5k
	zyIuxcMw6oZRlN4O3TpYpIwegwNKIUJ0zNWreJ0SGy/uITWnCvA6dqmN2YIwcVxE
	X0o/ZcR5pjGpqfvUuyChLcuC6S/TjLAJKnbqKDLVJ1IAzZ67TXoznDcuG3+wOKB2
	dnETDN3WgXRkGhhmh4IgDAV3KlF/sby78MBKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hw2Gd7Fx1kvJPlH3q+NVD5C/RvNlrv/P
	goLDvF3Ywggh6wjL09sc6Wqk5aWzwn/BL5Zo0GVz9HDJR6PNXUQ7cpnR1GPmbZ0G
	2dttUFgKiXLsd9Bo2GYEZPquc8oIHG7vsN4bEy2dEvs7HxmfVLrde4EHwxEWQ/D9
	ReiMXSIKZPM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE2E216025;
	Tue, 26 Apr 2016 16:27:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1515116024;
	Tue, 26 Apr 2016 16:27:37 -0400 (EDT)
In-Reply-To: <1461504863-15946-23-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 24 Apr 2016 15:33:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 50C56594-0BED-11E6-A577-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292661>

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 506357c..c45e481 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -57,6 +57,8 @@ struct apply_state {
>  	int unidiff_zero;
>  
>  	int update_index;
> +
> +	int unsafe_paths;
>  };

Having said 

    I like the way this series moves only a few variables at a time to
    limit the scope of each step.

it gets irritating to see all these unnecessary blank lines in the
structure definition added by each step, which would mean all of
these patches need to fix them in the next reroll.
