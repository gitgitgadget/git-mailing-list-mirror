From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/22] argv-array.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:53:45 -0800
Message-ID: <xmqqd1s3vuhy.fsf@gitster.mtv.corp.google.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
	<1455194339-859-4-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 21:53:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTyFN-0007NF-Aw
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 21:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbcBKUxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 15:53:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751103AbcBKUxt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 15:53:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42C624249F;
	Thu, 11 Feb 2016 15:53:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J1mOCeaIQiJHztfz98OIN0L7WWY=; b=UhIMnD
	ScIlORh//PDJDAxerKW1jS1iQK+JL3VqkmeF+cZtEZ8w+3iKBKB397AbTR2dyHTz
	5PG/bZ0RcoIxn5O/XtXgxTKHDJNufxfYmgT+9/E++f1KC1fUeoqkQ9GtSOqqT7/i
	5y5ObKRr0f9vbFbkLJyN2ktygVb/zF/naNq+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tqu6136O7aAX0nfAYW7jE2TGEVT+I2dz
	DSa7m8+BnMG9cYVryvGtt8BXRobfDsoXD/p89dagCaEpLGwHi42a1OFgmgnj6Gn5
	834VUGk9qBp2AZAXeMgU7ANMUldeaDR48RzP328cRAkH+yB1uRzgfRidwgkEjhJ9
	qNcQuK5/wtE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29B7C4249D;
	Thu, 11 Feb 2016 15:53:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8510E4249A;
	Thu, 11 Feb 2016 15:53:46 -0500 (EST)
In-Reply-To: <1455194339-859-4-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Thu, 11 Feb 2016 12:38:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B386766-D101-11E5-8939-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285998>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
> attribute 'format printf'
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  argv-array.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/argv-array.h b/argv-array.h
> index a2fa0aa..e303dfd 100644
> --- a/argv-array.h
> +++ b/argv-array.h
> @@ -13,7 +13,7 @@ struct argv_array {
>  
>  void argv_array_init(struct argv_array *);
>  void argv_array_push(struct argv_array *, const char *);
> -__attribute__((format (printf,2,3)))
> +FORMATPRINTF(2,3)
>  void argv_array_pushf(struct argv_array *, const char *fmt, ...);
>  LAST_ARG_MUST_BE_NULL
>  void argv_array_pushl(struct argv_array *, ...);

OK, this may answer my previous question.

It might be pleasing to the eyes when these two macros appearing
together in all CAPS, making them look similar and consistent,
perhaps with two more tweaks:

 - Imitate LAST_ARG_MUST_BE_NULL and spell it FORMAT_PRINTF;

 - Consistently have SP after comma, i.e. FORMAT_PRINTF(2, 3),
   or to make it obvious that this thing is a special magic, drop SP
   (i.e. this patch would stay the same but some other patches left
   a space after comma, which made them look more inconsistent).

Thanks.  I am not 100% sold on this yet, though.



 
