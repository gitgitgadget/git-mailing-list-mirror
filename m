From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --src/dst-prefix to git-formt-patch in git-rebase.sh
Date: Thu, 09 Sep 2010 11:35:19 -0700
Message-ID: <7vbp86n4t4.fsf@alter.siamese.dyndns.org>
References: <1283954045-8326-1-git-send-email-ods15@ods15.dyndns.org>
 <1284019625-14096-1-git-send-email-ods15@ods15.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Oded Shimon <ods15@ods15.dyndns.org>
X-From: git-owner@vger.kernel.org Thu Sep 09 20:35:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtlyP-0004Sm-5S
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 20:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab0IISf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 14:35:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab0IISf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 14:35:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE576D41F6;
	Thu,  9 Sep 2010 14:35:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fHrHkzub0GbcTRM7NX7qLlxs0pQ=; b=d9Db7W
	CQwVP/KArplo0KTdDeA/Z1FkGZ2k2zduqhkOGYKrREHbBLbGp832sOonxxK7CBHz
	x9G17fPDRr0C1RErXQ6NBbN0DA9iI9khGPltUtfPwukLTs7nte+nrLyQCN/Xpn7n
	z7Ipv7e9CMkPUl8tgc50DQ0MO/6jI1SxEczmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z5HFxgnketXRArbjCD8aSnHPTM8qZyrz
	dZkDm4Efy00BLRwsg5z8z3YLvQfrvHuEZ0cwNVayFT9WkCxI5zpoc1X/sEnMkN3d
	4hu5OM7OKn+IhUcuw+ykhAO4F1DeJBFMa07SK5ZsEQx1I7+o+i36xYr5WQMHB6D5
	LQ/QF9aM8IQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B209D41F4;
	Thu,  9 Sep 2010 14:35:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB2D9D41F3; Thu,  9 Sep
 2010 14:35:20 -0400 (EDT)
In-Reply-To: <1284019625-14096-1-git-send-email-ods15@ods15.dyndns.org> (Oded
 Shimon's message of "Thu\,  9 Sep 2010 11\:07\:05 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01EA2E70-BC41-11DF-BB68-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155873>

Oded Shimon <ods15@ods15.dyndns.org> writes:

> For the case of "diff.noprefix" in git-config, git-format-patch should
> still output diff with standard prefixes for git-am
>
> Signed-off-by: Oded Shimon <ods15@ods15.dyndns.org>

Hmm.

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 7508463..e83a0cf 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -565,7 +565,7 @@ fi
>  
>  if test -z "$do_merge"
>  then
> -	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> +	git format-patch -k --stdout --full-index --ignore-if-in-upstream --src-prefix=a/ --dst-prefix=b/ \
>  		--no-renames $root_flag "$revisions" |
>  	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&

As the format-patch invocation is already multi-line, you probably would
want to use a continuation line with "\" to keep the line length shorter.

We need to protect ourselves from crazy people, so regrettably something
like this patch is unavoidable, albeit unsightly.

Thanks.
