From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/21] bisect: use commit instead of commit list as arguments when appropriate
Date: Fri, 15 Apr 2016 15:08:10 -0700
Message-ID: <xmqqk2jy8r05.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-14-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:08:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBuU-0001wb-BD
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbcDOWIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:08:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752421AbcDOWIN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:08:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B37E13F89;
	Fri, 15 Apr 2016 18:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6GicjDlbPNc0u03hrbddWv5GA0M=; b=k5Nagf
	7R0ORdbE05nrRyY3T09Wxn635qUkHa/ZHKuLOoOeB4ipTQRL1bSB9kULdjrKtITB
	KdHsxkWZbPFqA+LepDEbcCiUXor33PhO2owIcy2Ckuh4e9bLmEahuf8lxKs3NTMT
	g1fFf1Z7ZcIJZKFiUXCnZBGaQDgD9OL6YhAto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QvPMdN4H9e1dN49PFRgVmmDvxFxeHAJv
	HbsYxad9KezP4K8oD744NXvPR3jrkoYAtDEsZa0ci2LQlXdnco0WQUMSJDcRWmYB
	Agb5/K5nitBnsZ2bmNp986v+I1I+jk4gqXXxXGngTO1l4/Zkey0PfCQGdKDQUplH
	o3WrgoLb2JU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5371C13F88;
	Fri, 15 Apr 2016 18:08:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF24413F87;
	Fri, 15 Apr 2016 18:08:11 -0400 (EDT)
In-Reply-To: <1460294354-7031-14-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B25D984-0356-11E6-9C74-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291677>

Stephan Beyer <s-beyer@gmx.net> writes:

> It makes no sense that the argument for count_distance() and
> halfway() is a commit list when only its first commit is relevant.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---

Makes sense (modulo perhaps s/elem/commit/).

>  bisect.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 4209c75..2c1102f 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -38,11 +38,11 @@ static inline struct node_data *node_data(struct commit *elem)
>  	return (struct node_data *)elem->util;
>  }
>  
> -static int count_distance(struct commit_list *entry)
> +static int count_distance(struct commit *elem)
>  {
>  	int nr = 0;
>  	struct commit_list *todo = NULL;
> -	commit_list_append(entry->item, &todo);
> +	commit_list_append(elem, &todo);
