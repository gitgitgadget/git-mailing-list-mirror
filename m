From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2][GSoC] diff-no-index: rename read_directory()
Date: Wed, 19 Mar 2014 11:31:13 -0700
Message-ID: <xmqqd2hi3ury.fsf@gitster.dls.corp.google.com>
References: <1395244702-659-1-git-send-email-ba.bourn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Brian Bourn <ba.bourn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 19:31:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQLGr-0006yE-TB
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 19:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbaCSSbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 14:31:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbaCSSbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 14:31:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CE2F74247;
	Wed, 19 Mar 2014 14:31:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=scR5cufoAsjnFQkDwtKZ5DJEeB4=; b=cjEyFG
	aEDdHgISO2dHyPlE3mMjR96outsd02Wo0djv3UmMiMhpAg/3649b/IMChxHEARWK
	SMzouR5VN+95u18I4R20fdXuOJOBDF0QyALjXqTmkrCU9wHsuFiHQJxFXdzv8tq/
	dm1mnTzSPGPdu5XdV0QDvh/jXv2QOKK+Tt3zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mfK5ZN6nswBHnWZNpWf3x2PORJQirmFw
	3pNnBGs+otDidWAPoT6kUEv32mQM/bEKSjXsG/a1lTpQpfRHPwLikdyogAec4EfQ
	HiFDFob4dbBj0GLzIJB6Bi4k1mHJ0gOpoeeJtvhJTyx7RUq6NG0/7tbwsPXug5IS
	C7rHURKr3Tg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FDB574246;
	Wed, 19 Mar 2014 14:31:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A029674243;
	Wed, 19 Mar 2014 14:31:14 -0400 (EDT)
In-Reply-To: <1395244702-659-1-git-send-email-ba.bourn@gmail.com> (Brian
	Bourn's message of "Wed, 19 Mar 2014 11:58:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A736DA46-AF94-11E3-AAF2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244474>

Brian Bourn <ba.bourn@gmail.com> writes:

> It would be desirable to replace manual checking of "." or ".."
> in diff-no-index.c with is_dot_or_dotdot(), which is defined
> in dir.h, however, dir.h declares a read_directory() which conflicts
> with a (different) static read_directory() defined
> in diff-no-index.c. As a preparatory step, rename the local
> read_directory() to avoid the collision.
>
> Signed-off-by: Brian Bourn <ba.bourn@gmail.com>
> ---
> Part 1 of my submission for GSoC
>  diff-no-index.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looks good to me.  Doesn't Eric deserve a "Helped-by:" above?

Thanks.

> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..ec51106 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -16,7 +16,7 @@
>  #include "builtin.h"
>  #include "string-list.h"
>  
> -static int read_directory(const char *path, struct string_list *list)
> +static int read_directory_contents(const char *path, struct string_list *list)
>  {
>  	DIR *dir;
>  	struct dirent *e;
> @@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
>  		int i1, i2, ret = 0;
>  		size_t len1 = 0, len2 = 0;
>  
> -		if (name1 && read_directory(name1, &p1))
> +		if (name1 && read_directory_contents(name1, &p1))
>  			return -1;
> -		if (name2 && read_directory(name2, &p2)) {
> +		if (name2 && read_directory_contents(name2, &p2)) {
>  			string_list_clear(&p1, 0);
>  			return -1;
>  		}
