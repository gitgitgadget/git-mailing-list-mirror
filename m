From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] mergetools: use the correct tool for Beyond Compare
 3 on Windows
Date: Fri, 14 Oct 2011 22:50:31 -0700
Message-ID: <7vobxix0pk.fsf@alter.siamese.dyndns.org>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
 <1318632815-29945-8-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 15 07:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REx8p-0000I0-3v
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 07:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab1JOFue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 01:50:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800Ab1JOFud (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 01:50:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0099D35D2;
	Sat, 15 Oct 2011 01:50:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mjFlPeg7/SpkWQDM5upd5qEe3NQ=; b=OORkyL
	5Oo48vWvs+5tZVq8jLj8ZhWCDCQIKwBSKG8/ItTh6R8XvtSOknvuiFyY71d+YSMO
	Lc+wfwd6fUy4XIj/39NJRBIX54cbrxpkjSalWIEg6C+oasJvFo8WyM+SX9P1nylh
	Tfebjg9YoeuxpFroqx6QzVtgc4AYz8nTZA/HY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sSX4DD6p64sW1Ah8/nmKNTuG5Bh3tN4P
	/YQNpyPpL/DTphp72vtzDL0T9tcoxRDTPwViekbTtS5ebo9GEz9xXn+0/O/A9ewF
	PqKf7GTQG33J2RgcG5gAgy1pxEGEclkJwUfKrO/6uRH9eBGPmCfzl5YIh+vTkEDT
	7kb0d5+TZeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED11E35D1;
	Sat, 15 Oct 2011 01:50:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 753A635D0; Sat, 15 Oct 2011
 01:50:32 -0400 (EDT)
In-Reply-To: <1318632815-29945-8-git-send-email-patthoyts@users.sourceforge.net> (Pat
 Thoyts's message of "Fri, 14 Oct 2011 23:53:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 985D6A34-F6F1-11E0-BE39-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183643>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> On Windows the bcompare tool launches a graphical program and does
> not wait for it to terminate. A separate 'bcomp' tool is provided which
> will wait for the view to exit so we use this instead.

Hmm, does this only apply to Windows, or are there other platforms on
which BC3 supplies bcomp for the exact same reason? What I am trying to
get at is that it might be nicer if we do not have to check uname, e.g.

	if type bcomp >/dev/null 2>/dev/null
        then
        	echo bcomp
	else
        	echo bcompare
	fi

> Reported-by: Werner BEROUX <werner@beroux.com>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
>  mergetools/bc3 |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/mergetools/bc3 b/mergetools/bc3
> index 27b3dd4..b642bf2 100644
> --- a/mergetools/bc3
> +++ b/mergetools/bc3
> @@ -16,5 +16,12 @@ merge_cmd () {
>  }
>  
>  translate_merge_tool_path() {
> -	echo bcompare
> +	case $(uname -s) in
> +	*MINGW*)
> +		echo bcomp
> +		;;
> +	*)
> +		echo bcompare
> +		;;
> +	esac
>  }
