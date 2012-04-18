From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/4] git-cherry-pick: Add keep-redundant-commits
 option
Date: Wed, 18 Apr 2012 15:59:33 -0700
Message-ID: <7vfwc0k5nu.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334776680-23460-1-git-send-email-nhorman@tuxdriver.com>
 <1334776680-23460-3-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 00:59:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKdqf-0000x6-4R
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 00:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab2DRW7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 18:59:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345Ab2DRW7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 18:59:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D2DE695E;
	Wed, 18 Apr 2012 18:59:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=7Tj8rjRg0SKslpBq1yU/ahXE9A4=; b=G1f3GmemK8veMhXZuPQH
	o/SJw/u6miFwkSySbmHCznfDwmzvEg/0QPF8GGqc9l2sZbh85puWhLC3oiUCsJAK
	ZgpziTTvUY9gR3rWvYjZZPc1t6U7eJO6vwlTAW3YxmOOedM63k8KZh59Y3yvco0V
	saG4Vd7poSBm2b29qjX3/9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=L9V3v2ruKUFDzrdgm3tggNv36pPAXG+q+7N0wXVd7xmfm0
	N3xXlkzTcGQIHn9+K/ctBRQ3vl2VXgQkkDWgv6VO7ODE7qkVBxvdzIFpsTet4uW1
	6d732uoTBjLm0duBjHGZ4USIj4MD0jBV1ZXdApuxPu06EGUh0zR/RWIPOzgWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A81695D;
	Wed, 18 Apr 2012 18:59:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAFBB695C; Wed, 18 Apr 2012
 18:59:34 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A95C770-89AA-11E1-BC2E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195915>

Neil Horman <nhorman@tuxdriver.com> writes:

> diff --git a/sequencer.c b/sequencer.c
> index 71929ba..e33dfbb 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -13,6 +13,7 @@
>  #include "rerere.h"
>  #include "merge-recursive.h"
>  #include "refs.h"
> +#include "argv-array.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -251,6 +252,30 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	return !clean;
>  }
>  
> +static int is_index_unchanged()
> +{

Hmm... I am reasonably sure I fixed this when I queued the previous one to
'pu'.

	static int is_index_unchanged(void)
        {
