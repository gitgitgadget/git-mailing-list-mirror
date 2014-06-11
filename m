From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: Do not abuse 'break' inside a shell 'case'
Date: Wed, 11 Jun 2014 13:13:30 -0700
Message-ID: <xmqqvbs76w7p.fsf@gitster.dls.corp.google.com>
References: <1402476465-27177-1-git-send-email-jajcus@jajcus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Jacek Konieczny <jajcus@jajcus.net>
X-From: git-owner@vger.kernel.org Wed Jun 11 22:13:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wuou3-0007t7-FB
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 22:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbaFKUNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 16:13:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52029 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbaFKUNh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 16:13:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 61EF71F8FA;
	Wed, 11 Jun 2014 16:13:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gfob3Hl++Wxht4LiyVdTbzVCpRs=; b=qkjIfd
	cS+YXsfv+VVAXH4YivlJpbZDWODSpCfAFPAhzvNn691c+XtzqJEl2DnUPV5fXffv
	f4v5hteAHMPbFcNXOwY4WuIfMuZM9S78Vl3PLodWueYBqPSxjIZLIfcaFWKy7YN7
	pOymqVHqjbx8RyNItQKwwANrlqOZrGBm10jRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qQkSMhIVV4sKfP3RWhp2TK5E5Sb2Fuxy
	+gduAm6C8Q8dZhXgERXhGfeGDT8Wmjcf4L31NvXFCTKIl7ouc6sYOA9GCvG5XiXM
	BXz4KqkrDNufIqwKMXN/BLrhZiXc8qZb+J7fDYJLMoQz6+jgmFf/x5goiSPh+VRJ
	L1EuQaamo/k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 578641F8F9;
	Wed, 11 Jun 2014 16:13:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5D0CC1F8F2;
	Wed, 11 Jun 2014 16:13:32 -0400 (EDT)
In-Reply-To: <1402476465-27177-1-git-send-email-jajcus@jajcus.net> (Jacek
	Konieczny's message of "Wed, 11 Jun 2014 10:47:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC48E060-F1A4-11E3-86B8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251384>

Jacek Konieczny <jajcus@jajcus.net> writes:

> It is not C. The code would break under mksh when 'pull.ff' is set:
>
>   $ git pull
>   /usr/lib/git-core/git-pull[67]: break: can't break
>   Already up-to-date.
>
> Signed-off-by: Jacek Konieczny <jajcus@jajcus.net>
> ---

Thanks for spotting; I cannot believe this somehow got through
unnoticed.

As this fixes b814da89 (pull: add pull.ff configuration,
2014-01-15), it will eventually have to go to both master for 2.1
and maint for 2.0.1.




>  git-pull.sh | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 6cd8ebc..7358fac 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -58,11 +58,9 @@ pull_ff=$(git config pull.ff)
>  case "$pull_ff" in
>  false)
>  	no_ff=--no-ff
> -	break
>  	;;
>  only)
>  	ff_only=--ff-only
> -	break
>  	;;
>  esac
