From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: [PATCH 0/2] submodules: Use relative paths to
 gitdir and work tree
Date: Tue, 28 Feb 2012 11:14:21 -0800
Message-ID: <7vehtezs6q.fsf@alter.siamese.dyndns.org>
References: <4F32F252.7050105@web.de> <4F4A6DFA.5080709@kdbg.org>
 <4F4A8EF2.3020901@web.de> <4F4BF357.8020407@kdbg.org>
 <4F4D23D8.1050208@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:14:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2SVI-00036M-QT
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039Ab2B1TOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:14:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468Ab2B1TOX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:14:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2032D7F79;
	Tue, 28 Feb 2012 14:14:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q+qifdw7l6ZfIwRoBxarLc5g89c=; b=WlO4cX
	KW0OGxdirn2+hElYiuQcASh2yJGkPLGKK5Qc5S99GQmdw7D2s0N6sB7B4A4tKo+h
	fllExslmfRu5LtryO0uPnr0eiep/NxvJsGCcyj+az0/rzPSkOVzKIb3OI6HlCdcp
	lkghVjhVQfOySdUHzf6DTypOcJFB1iec46lOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nnZxS8ppTbTDDIIs7jAaZP2Qlw0NUm77
	3F9rrbtTiT+7iprZwYvypiCqISjODURgvbP22kGyuFYAJURmoEFg0kufBo8OHWz4
	nLCuqLbiQsdN8d06eRDj8z6O3PRr8uvwkiL8nJkwKJqQ9usTLmZzq3tW05kaNsVH
	bGON7f0Wjfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 169AE7F78;
	Tue, 28 Feb 2012 14:14:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88F3E7F77; Tue, 28 Feb 2012
 14:14:22 -0500 (EST)
In-Reply-To: <4F4D23D8.1050208@kdbg.org> (Johannes Sixt's message of "Tue, 28
 Feb 2012 19:58:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BEE0D72-6240-11E1-85D9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191766>

Johannes Sixt <j6t@kdbg.org> writes:

> With the following patch on top of your always-use-relative-gitdir branch
> from https://github.com/jlehmann/git-submod-enhancements the tests pass
> on Windows.
>
> Thanks, Dscho, for pointing out the obvious.

The patch looks unintrusive and sane.

Thanks all three of you for looking into this.  Should I wait for a patch
with nice write-up from one of you, or should I just come up with a random
message and apply it locally avoiding roundtrip cost?

> diff --git a/git-submodule.sh b/git-submodule.sh
> index e1984e0..953ca5e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -151,6 +151,9 @@ module_clone()
>  
>  	a=$(cd "$gitdir" && pwd)
>  	b=$(cd "$path" && pwd)
> +	# normalize Windows-style absolute paths to POSIX-style absolute paths
> +	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} esac
> +	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} esac
>  	# Remove all common leading directories
>  	while test -n "$a" && test -n "$b" && test "${a%%/*}" = "${b%%/*}"
>  	do
