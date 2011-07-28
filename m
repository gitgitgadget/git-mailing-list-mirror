From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] push: Add the --no-recurse-submodules option
Date: Thu, 28 Jul 2011 13:05:45 -0700
Message-ID: <7vy5zikw6e.fsf@alter.siamese.dyndns.org>
References: <1311790250-32454-1-git-send-email-iveqy@iveqy.com>
 <1311790250-32454-4-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 22:05:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmWq9-00059M-BO
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 22:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804Ab1G1UFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 16:05:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62570 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755753Ab1G1UFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 16:05:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86810547C;
	Thu, 28 Jul 2011 16:05:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dJC3PaF//EvqqAhiQmyngJPOlhc=; b=llUuRC
	MUTttjY1TM5YafkvXdQ2SR11gSvkspSnS/6VJLnlFpfKfVkuSoHUBSJjEaXYUlZA
	jVmXGr/iqR7Ys9xD2PiQk8gLtRDUI1Dwy0Z5CdBYUpAV+DcjadTgAn9cOYyNw/sD
	0cz8SE2EzW/t7mZs5fdq4K8bRmORXVV4DdAWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iv2HIZHLHthkYI/oTAsLO4AodzhOg04y
	k5tK/aCNTXGSO/Rkm/HX++6TCkT75EmAAKz5mwWMQdESO6ExmeXRtzIARbRFEwMq
	r4pIh21qJ6Yd9CkqVJrpOVJdNwZwLzqLn3YsRbhhDDTINAA+pxqk6IXnaML3biuj
	uvVavxR+zYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CD2A547B;
	Thu, 28 Jul 2011 16:05:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EB40547A; Thu, 28 Jul 2011
 16:05:46 -0400 (EDT)
In-Reply-To: <1311790250-32454-4-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Wed, 27 Jul 2011 20:10:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB9A943A-B954-11E0-8A7A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178111>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> This adds the option --no-recurse-submodules to push. That is, git

I think this needs to be renamed at least for two reasons.

The name makes it sound as if "push --recurse-submodules" would
recursively visit the submodules and runs "push" there, but I do not think
that is what this flag does.

> diff --git a/transport.h b/transport.h
> index 161d724..c6ccf8c 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -101,6 +101,7 @@ struct transport {
>  #define TRANSPORT_PUSH_MIRROR 8
>  #define TRANSPORT_PUSH_PORCELAIN 16
>  #define TRANSPORT_PUSH_SET_UPSTREAM 32
> +#define TRANSPORT_PUSH_NO_RECURSE_SUBMODULES 64

Also naming the constant with NO will invite an unnecessary double
negation, like this:

	if (!(flags & FROTZ_NO_NITFOL))
        	do_nitfol_to_frotz();

Besides, I would be moderately annoyed if this check were the default.
