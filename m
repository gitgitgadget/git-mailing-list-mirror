From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/ciabot: git-describe commit instead of HEAD
Date: Mon, 04 Oct 2010 10:47:24 -0700
Message-ID: <7vd3rp97f7.fsf@alter.siamese.dyndns.org>
References: <1286179362-23597-1-git-send-email-sven.eckelmann@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Eckelmann <sven.eckelmann@gmx.de>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Oct 04 19:47:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2p8X-0007KH-RG
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 19:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921Ab0JDRrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 13:47:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189Ab0JDRre (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 13:47:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 19DCEDBE02;
	Mon,  4 Oct 2010 13:47:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fCl99Kt3mTgKv04x3jqGtRL0Pr8=; b=qaXck1
	Yvui+/4hGxwJNXtQB4H5IjdIc78c9PyPiuFh3Q77SY5gBdhUvPTZpROpopNkFKgY
	yr9Ly9Va+CFEZ5rl5PTUK0EjEgEc8EDKUrErOSORok6wfE38+S/yvWmdk5UU3AdK
	7HRAi3/gTGWEIQCizh/oc2pa+WvD94pMe7aL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KuZjaF9XY66LZH8MptsgMmOaXwxEziSf
	Zk88SKwoeMieVbNpbZNqeZ/w9iigm2t0sF3hMYL6nFaQWAmler5LUqFbrqWCd1BS
	akXfcnnUOUaTjpwU+O/zs7FswAxoZOWdbSMEKT0+AwxAvYKsXrqNw0smXm+3ebC9
	7dSvDFdthEE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB3F0DBDFF;
	Mon,  4 Oct 2010 13:47:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDEB5DBDFC; Mon,  4 Oct
 2010 13:47:25 -0400 (EDT)
In-Reply-To: <1286179362-23597-1-git-send-email-sven.eckelmann@gmx.de> (Sven
 Eckelmann's message of "Mon\,  4 Oct 2010 10\:02\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75666BAA-CFDF-11DF-841F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158073>

Sven Eckelmann <sven.eckelmann@gmx.de> writes:

> For each commit a shorter version of the name will be generated. This is
> either the truncated hash or the output of git-describe. The
> call to git-describe was only made with an empty shell variable instead
> of an actual commit hash. Thus it only described the current HEAD and
> not each commit we want to submit to cia.vc.
>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
> I send this patch already two and four weeks ago and got no reaction.
> This is a resent in case it was forgotton.

Although the computation of "rev" indeed looks wrong, I do not see it used
anywhere, so it might be a better patch to remove it ... wait, the code
does something funny to slurp everything into xml via ... 

	context = locals()
        context.update(globals())
        out = xml % context

Yuck.

Even though it has been my policy not to complain too loudly on stuff in
contrib/ part of the tree, I have to say that this is a bit too _cute_ for
my taste.

Anyway, Ok, so it _is_ used.  And it needs to be fixed.

I was hoping that Eric who took over the maintainership of contrib/ciabot/
directory in April would give his blessing sooner, without me having to
look at the script.

Ack?

>  contrib/ciabot/ciabot.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
> index d0627e0..9775dff 100755
> --- a/contrib/ciabot/ciabot.py
> +++ b/contrib/ciabot/ciabot.py
> @@ -122,7 +122,7 @@ def report(refname, merged):
>      branch = os.path.basename(refname)
>  
>      # Compute a shortnane for the revision
> -    rev = do("git describe ${merged} 2>/dev/null") or merged[:12]
> +    rev = do("git describe '"+ merged +"' 2>/dev/null") or merged[:12]
>  
>      # Extract the neta-information for the commit
>      rawcommit = do("git cat-file commit " + merged)
> -- 
> 1.7.2.3
