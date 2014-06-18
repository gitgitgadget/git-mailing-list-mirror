From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/14] refs.c: add a new update_type field to ref_update
Date: Wed, 18 Jun 2014 13:36:11 -0700
Message-ID: <xmqqfvj2hs5g.fsf@gitster.dls.corp.google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
	<1403111346-18466-5-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 22:36:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMau-0006pD-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbaFRUgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:36:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50491 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993AbaFRUgS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:36:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E9321E695;
	Wed, 18 Jun 2014 16:36:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yeXqyi21VgxoeoEG+M4H1IsORF0=; b=XTLEA1
	1PZ+LkD089gnmNKGdIP+YKgwZXrnmkrKk+kcW4R3kB3pZx9ONol+NLglufe/I2lL
	tVpPP08C27nKFWef3KkwB9HWvNb7X0GrUeW08RzkRnXbFV4YmSFJo1FqnvpFvOBd
	fWM7o1oYSq6Y8zoPNk8SDwSn5zAclaRi5EjI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gcFTEQne6DEFWi6v6FVDCotPXY8gfEHE
	F6Ms3Shegm2thfFXfnn/ERrANjeKaVRWExl9xKpqXMvkkVPswPTDZ5c+h4B1JqjY
	pUH9aBMWpn016TGaOZCutgInfolqt56Uq/zX46s2KXqtHSbfmS+zgOJ5zFsUPiu0
	HImLx+CMX2g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 545211E694;
	Wed, 18 Jun 2014 16:36:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EBE801E693;
	Wed, 18 Jun 2014 16:36:10 -0400 (EDT)
In-Reply-To: <1403111346-18466-5-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 18 Jun 2014 10:08:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2EF43B2E-F728-11E3-AA45-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252065>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Add a field that describes what type of update this refers to. For now
> the only type is UPDATE_SHA1 but we will soon add more types.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 4e3d4c3..4129de6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3374,6 +3374,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
>  	return retval;
>  }
>  
> +enum transaction_update_type {
> +       UPDATE_SHA1 = 0,

indent with SP?

Unlike an array initialisation, e.g.

	int foo[] = { 1,2,3,4,5, };

some compilers we support complain if enum definition ends with a
trailing comma.
