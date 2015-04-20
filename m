From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] "git pull" will regress between 'master' and 'pu'
Date: Mon, 20 Apr 2015 11:59:04 -0700
Message-ID: <xmqqmw22lj7r.fsf@gitster.dls.corp.google.com>
References: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com>
	<20150419130745.GA20476@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:59:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkGuY-0003nu-Kj
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 20:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbbDTS7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 14:59:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754401AbbDTS7I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 14:59:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA35848248;
	Mon, 20 Apr 2015 14:59:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5CSqBPyS/c5rm8zIQQchw8jxfuo=; b=p5WjZc
	dd0l6nbNZg5bAYs1XDDBvBsYOSug7ffSbHBeA6crepU+TEI7FLpM81CIbgB5A2dC
	tanyMpvZz5RC7glAngjH87IY1XidjvKXg+0WqCexlrV0ceJ+gQOzBt3Vj7vtunKf
	pTQU+SWkBKiqFkHUxVhTmTeWBG5OAg/sxQBfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xvjVweELXluExb9P/0s64D3VE7jyHcMF
	OZw2UQd9hfnqW/xy7CgTOax5BxyI3KX/e4/rNIqdzv7Zvu0C1Lz0WlTTalIzcgUU
	SMl4+qbVTeXs1GVcsYjBWBxvIq48RqULyCTUpkeqI5d/L0BW4noecS1E1vVg6ILr
	Q3ZmL498s9Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B273048247;
	Mon, 20 Apr 2015 14:59:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BE0548246;
	Mon, 20 Apr 2015 14:59:07 -0400 (EDT)
In-Reply-To: <20150419130745.GA20476@peff.net> (Jeff King's message of "Sun,
	19 Apr 2015 09:07:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 522737EC-E78F-11E4-B920-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267487>

Jeff King <peff@peff.net> writes:

> @@ -334,7 +333,7 @@ true)
>  	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
>  	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
>  	eval="$eval $gpg_sign_args"
> -	eval="$eval -m \"\$merge_name\" $merge_head"
> +	eval="$eval FETCH_HEAD"
>  	;;
>  esac
>  eval "exec $eval"
>
> as we seem to special-case the name FETCH_HEAD. It assumes that
> git-merge's parsing of FETCH_HEAD is the same as what we do in git-pull,
> but that seems safe.

Unfortunately, "git merge"'s parsing of FETCH_HEAD forgets that we
may be creating an Octopus.  Otherwise the above should work well.

> Unfortunately we still have to compute $merge_head ourselves here
> for the "git pull --rebase" case.

That is not that unfortunate, I would say.
