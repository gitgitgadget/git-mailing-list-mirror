From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git p4: Use git diff-tree instead of format-patch
Date: Thu, 21 Nov 2013 11:47:57 -0800
Message-ID: <xmqqa9gx4jv6.fsf@gitster.dls.corp.google.com>
References: <528E2467.4030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Crestez Dan Leonard <cdleonard@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 20:48:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjaER-0007Wx-0Y
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 20:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab3KUTsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 14:48:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069Ab3KUTsB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 14:48:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B499545D9;
	Thu, 21 Nov 2013 14:48:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r68rlQ+D+AOOqucoTUU44jWv3uo=; b=L+cK/4
	izLdEdnla2xvadg1Wf9oPFZzsipZN8pJQ0kzmmaUc7k4uxFgTWl5f761ntNs/Zvv
	IF/nKLsF+ICBqwG08NuOfcrgrbkIk7RRe1wdAl0O+PHv5ozhqABjczqpB/m7oeBI
	iNsPdR4LZJIWqx/wmCdcTI324XKlC9CGDAvVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hFltxeTjufXY397GWk61OTeaoXz5sJnI
	obnWc8YiWvkNrrXf7LXiuDHSJmRZQi6lmYioZSlRlX+tNuqJDXJ+5l5inv/l7UYW
	J0DgsQd2yohZ+tX40+roujCriteSmntF7HI5cg5nm8SbA3xb9kFJRQfmICHRuLam
	HjU+519wL4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DE85545D8;
	Thu, 21 Nov 2013 14:47:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02A62545D6;
	Thu, 21 Nov 2013 14:47:58 -0500 (EST)
In-Reply-To: <528E2467.4030900@gmail.com> (Crestez Dan Leonard's message of
	"Thu, 21 Nov 2013 17:19:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D2E1309E-52E5-11E3-96F4-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238137>

Crestez Dan Leonard <cdleonard@gmail.com> writes:

> The output of git format-patch can vary with user preferences. In
> particular setting diff.noprefix will break the "git apply" that
> is done as part of "git p4 submit".
>
> Signed-off-by: Crestez Dan Leonard <cdleonard@gmail.com>
> ---
>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 31e71ff..fe988ce 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1308,7 +1308,7 @@ class P4Submit(Command, P4UserMap):
>              else:
>                  die("unknown modifier %s for %s" % (modifier, path))
>  
> -        diffcmd = "git format-patch -k --stdout \"%s^\"..\"%s\"" % (id, id)
> +        diffcmd = "git diff-tree -p \"%s\"" % (id)
>          patchcmd = diffcmd + " | git apply "
>          tryPatchCmd = patchcmd + "--check -"
>          applyPatchCmd = patchcmd + "--check --apply -"

I do not do p4 myself, but from a cursory reading it looks like the
right thing to do.  Thanks.

The output of "git shortlog --no-merges --since=1.year git-p4.py"
tells me that Pete should be the person much more familiar with the
code than myself, so I'll Cc him just in case...
