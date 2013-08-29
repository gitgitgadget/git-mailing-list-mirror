From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/7] refs: report ref type from lock_any_ref_for_update
Date: Thu, 29 Aug 2013 10:22:19 -0700
Message-ID: <xmqqtxi85s50.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<80d72f6f4bf04a8fef8ebfcc02a463e769cea3d4.1377784597.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 19:22:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF5vP-0006W3-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 19:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab3H2RWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 13:22:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094Ab3H2RWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 13:22:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 343F43D7A7;
	Thu, 29 Aug 2013 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gp6GFYh/AqjyyAOcfdV8FJ/W9M8=; b=sWRPb+
	ci9HxNTYGvnXw+TEc3SoxoG3JY78HdZ3zW8Sz3yauRYI6xgi8xCuk9rkGNaiM+i4
	Q8TM7i24mSu/arLHPnTmbNJI15pjSu3RifhOXgbvI37LzRON3r6k8nC9FBUdszmC
	+vLEM/OZmB46qGvSvPTBF03fRqUiMzFijlv5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZFxINnM09RyokGv/3TL+M3AnTt276yM+
	e+nsrbwcmAQQP34mzafICMuVh2YU1QjxzIO04g7uXIcl1X0UmSOElu+e+aqoWMb7
	BTebvn973hxDTEA97ojbZy+m7PzPvG11umM/ckWPO8YCh7dy4ebARBxS3O7tzSJB
	i5a/hbDck/E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 263A83D7A4;
	Thu, 29 Aug 2013 17:22:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A2D13D7A3;
	Thu, 29 Aug 2013 17:22:21 +0000 (UTC)
In-Reply-To: <80d72f6f4bf04a8fef8ebfcc02a463e769cea3d4.1377784597.git.brad.king@kitware.com>
	(Brad King's message of "Thu, 29 Aug 2013 10:11:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9019C774-10CF-11E3-ABE3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233289>

Brad King <brad.king@kitware.com> writes:

> Expose lock_ref_sha1_basic's type_p argument to callers of
> lock_any_ref_for_update.  Update all call sites to ignore it; we will
> use it later.
> ...
> diff --git a/branch.c b/branch.c
> index c5c6984..c244483 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -291,7 +291,7 @@ void create_branch(const char *head,
>  	hashcpy(sha1, commit->object.sha1);
>  
>  	if (!dont_change_ref) {
> -		lock = lock_any_ref_for_update(ref.buf, NULL, 0);
> +		lock = lock_any_ref_for_update(ref.buf, NULL, 0, 0);

If you are passing an NULL as a new parameter, please spell it
"NULL", not "0".
