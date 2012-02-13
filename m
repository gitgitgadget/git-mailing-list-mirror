From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] submodules: always use a relative path from
 gitdir to work tree
Date: Mon, 13 Feb 2012 11:59:37 -0800
Message-ID: <7vlio6ec7q.fsf@alter.siamese.dyndns.org>
References: <4F32F252.7050105@web.de> <4F32F465.7090401@web.de>
 <4F338156.9090507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 13 20:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx23u-0001H2-GD
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 20:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757758Ab2BMT7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 14:59:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757714Ab2BMT7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 14:59:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D3BE6202;
	Mon, 13 Feb 2012 14:59:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ecJxrimKXJJ5yZ3204qxENTHLTs=; b=UBJv4x
	GV+aSioLg0OJSYmR4Ntyq2B5GpuYneNxJBM6SKxwEQ/TTTUNUcmmo9yPRCzmOYIb
	0/SUtrtIBMrigu8enxMAetynMna2o8xhpVN5YdWBPu0yycYEGbvmUHivtJqgZC0g
	BNfQV9t3mTgwZFSEkxhJ0pY9Fr/AzpJ5QfxFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QoDybasjV2SKETJ0YH62zM+P0C4liAdj
	rqScr4B101cmXngwDH06YOORxJqWFjSmNntwNK13jZPSKl6sqx9lwY4rwY+igOwy
	oxKIX4ca2/6Dl23ldaW3VPELy5soffXBXSisah/0pLMhoMW4Vq1GwDNK0m1JoZC8
	p4I0m0WWz6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23C816201;
	Mon, 13 Feb 2012 14:59:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA01D61FE; Mon, 13 Feb 2012
 14:59:38 -0500 (EST)
In-Reply-To: <4F338156.9090507@web.de> (Jens Lehmann's message of "Thu, 09
 Feb 2012 09:18:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42A8D10A-567D-11E1-8D89-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190656>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> The first version was whitespace damaged, please use this instead.

Thanks.  This one looks somewhat iffy (1/2 looked perfectly fine, though).

> +	a=$(cd "$gitdir" && pwd)
> +	b=$(cd "$path" && pwd)
> +	while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
> +	do
> +		a=${a#*/} b=${b#*/};
> +	done
> +	rel=$(echo $a | sed -e 's|[^/]*|..|g')
> +	(clear_local_git_env; cd "$path" && git config core.worktree "$rel/$b")
>  }


The style ([ "$b" ] vs "test -n "$b") aside, it strikes me odd that you
only check $b; it is unclear what guarantees that "$a" is always longer.
Maybe there is a reason but then a one-line comment here would not hurt?
