From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GSoC2014 microprojects #6 Change bundle.c:add_to_ref_list() to use ALLOC_GROW()
Date: Thu, 27 Feb 2014 11:44:41 -0800
Message-ID: <xmqqzjlcxrva.fsf@gitster.dls.corp.google.com>
References: <1393517894-670-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 20:44:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ6sz-00067B-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 20:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbaB0Top (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 14:44:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbaB0Too (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 14:44:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 409A97098E;
	Thu, 27 Feb 2014 14:44:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WLkZcBLZgTo0ev/Fza4jHC1LXWU=; b=rohrfu
	2CJFMEDHxvasP3S28rBhtbJ3rXrkUoeP4y1+WV+Y0RoyyJ052qNoKyc4xA/wY/8q
	wRCCixB7fQK7zml+/Nc0qIozqRZdbwLY6OAoAz4aQxsZCH2PhDB/tyjIq+sWW76J
	mwaO9kLhwgixCKU68FTkYP3gfMhshnUR7WxAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fZDvPEPlnccpKDhhSibZGCrDwditVcLL
	6AkDbufcxPXC2xok1R7FmamGHgI4QQGHcrXrOXLmeLcurc9JpQUU04cRMR2dbDUG
	3c8rSJUnq1QPLalEYytRn8yfCAg0bxMhCW/xQ9oXbjGUAwlCMkTEWtSBS5lQ7ODn
	DvL7IhIsi34=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28EB97098D;
	Thu, 27 Feb 2014 14:44:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A4787098A;
	Thu, 27 Feb 2014 14:44:43 -0500 (EST)
In-Reply-To: <1393517894-670-1-git-send-email-sunheehnus@gmail.com> (Sun He's
	message of "Fri, 28 Feb 2014 00:18:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9ACA4B06-9FE7-11E3-8472-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242845>

Sun He <sunheehnus@gmail.com> writes:

> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---

The subject reads:

>> Subject: [PATCH] GSoC2014 microprojects #6 Change bundle.c:add_to_ref_list() to use ALLOC_GROW()

I do not think we want to see the leading part of it in our "git
shortlog" output.

	Subject: [PATCH] bundle.c:add_to_ref_list(): use ALLOC_GROW()

or something, perhaps.

>  bundle.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 7809fbb..1a7b7eb 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -14,11 +14,7 @@ static const char bundle_signature[] = "# v2 git bundle\n";
>  static void add_to_ref_list(const unsigned char *sha1, const char *name,
>  		struct ref_list *list)
>  {
> -	if (list->nr + 1 >= list->alloc) {
> -		list->alloc = alloc_nr(list->nr + 1);
> -		list->list = xrealloc(list->list,
> -				list->alloc * sizeof(list->list[0]));
> -	}
> +    ALLOC_GROW(list->list,list->nr,list->alloc);
>  	hashcpy(list->list[list->nr].sha1, sha1);
>  	list->list[list->nr].name = xstrdup(name);
>  	list->nr++;
