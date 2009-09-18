From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add compiled date to git --version output?
Date: Thu, 17 Sep 2009 22:07:47 -0700
Message-ID: <7v8wgchmcc.fsf@alter.siamese.dyndns.org>
References: <544dda350909172117r44761577m11e7d30a1a5d0c91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 07:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoVhR-0007vp-JR
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 07:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbZIRFHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 01:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbZIRFHw
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 01:07:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbZIRFHw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 01:07:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13B9D3782E;
	Fri, 18 Sep 2009 01:07:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=roq1yGRlSToC4M8l14OerRYflbk=; b=vHStqv
	275GcFyOwsdOzFc0Ti8EDGknlTvGAcxXAgMo8bWwnQryDvO/ms+bB9IrI0ybUEL9
	pC8Ws/GUBBFalFRO+qZPtMd9oKerDxYcnaetf0uSGv32NyAV7dx0ZWAmd9L05ngD
	hgxzXwXwwx6IYV+NyDnnU2WaaI/iYzRBLrNis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gZHsdJLYEMIUZ1YVAq0VUCmP79+bcurq
	Ck4xKiSrBytILWQnUmdFZXmnsUqpYayio3NdiI7sacGtgpeBgIvv4NF90pMgmvtk
	8E33JDxLO/4KtBOY9ll+K1CyWAYNfOQhoenkz8ouHU34yWXxtM28dIBnXiTDW9N/
	IRbp850Zo8A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB68F3782D;
	Fri, 18 Sep 2009 01:07:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5368A3782C; Fri, 18 Sep
 2009 01:07:49 -0400 (EDT)
In-Reply-To: <544dda350909172117r44761577m11e7d30a1a5d0c91@mail.gmail.com>
 (Nazri Ramliy's message of "Fri\, 18 Sep 2009 12\:17\:48 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37731546-A411-11DE-B522-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128784>

Nazri Ramliy <ayiehere@gmail.com> writes:

> Sometimes I wanted to know how outdated git is on my system.
>
> Coming up with a script to parse "git --version" output to get the SHA1,
> and compare that to master's SHA1 seemed a little overkill compared to
> this:
>
> diff --git a/help.c b/help.c
> index 294337e..bc83491 100644
> --- a/help.c
> +++ b/help.c
> @@ -361,6 +361,9 @@ const char *help_unknown_cmd(const char *cmd)
>
>  int cmd_version(int argc, const char **argv, const char *prefix)
>  {
> -       printf("git version %s\n", git_version_string);
> +       printf("git version %s compiled %s %s\n",
> +                       git_version_string,
> +                       __DATE__,
> +                       __TIME__);
>         return 0;
>  }
>
> With this, git --version gives:
>
>         git version 1.6.5.rc1.19.g8426.dirty compiled Sep 18 2009 12:03:29
>
> Thoughts?

It's open source, so you are welcome to do that to your binary.

Personally, I do not want it.  My build scripts depend on the version
string at the end if the output to omit re-building what is already
installed.

Seriously, the version number is useful to track down the bug, and perhaps
your compiler and library versions might be useful to help diagnose build
related errors, but when would that __DATE__/__TIME__ be useful more than
what "ls -l /usr/bin/git" would give you?
