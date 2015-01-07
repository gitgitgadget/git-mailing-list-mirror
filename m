From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] doc: core.ignoreStat update, and clarify the --assume-unchanged effect
Date: Wed, 07 Jan 2015 10:09:38 -0800
Message-ID: <xmqqbnmajwd9.fsf@gitster.dls.corp.google.com>
References: <1420496573-3260-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 19:15:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8v8W-0004m8-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 19:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbbAGSPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 13:15:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753608AbbAGSPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 13:15:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CAD92B377;
	Wed,  7 Jan 2015 13:15:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=kQrw6f4zTXPJAEVjt1k6oE7jXGM=; b=oHLdCP6sDNO1cv/lqaQg
	nxuThE0iy60pyrts2ZCm10I5fASDMcjDq3ufa1bxClWsH+aIf6UJuIS3nzvb+HmJ
	mpFA2BgxH8xIb8KEb+4TSGbhgBNm3BPY1dqaw1VhOQIOwRRPL3kEgZ/Xbf5hIPJ4
	08H50gBqudSHOM4Pt/ccY1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=eY6kClRVyGXyrTlr+JDKSn8Qhpph5C0h/KIkaHBGjJQFEf
	Td3Dwb8hnrLk8uq9EQgYY5+cWeVbsYJPIEgbvY2biPrLj7ITbdXdZRp654+kpEYO
	5fafDBfYM+d5Oy+ad0oQoUtnxX+ZmYBZs1HCJ8zGUKkEwWkZvowd4kIVVnaCE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 248EC2B376;
	Wed,  7 Jan 2015 13:15:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BEF62B1F7;
	Wed,  7 Jan 2015 13:09:39 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 58C5FD92-9698-11E4-9124-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262139>

Philip Oakley <philipoakley@iee.org> writes:

> The assume-unchanged bit, and consequently core.ignoreStat, can be
> misunderstood. Be assertive about the expectation that file changes should
> notified to Git.
>
> Overhaul the general wording thus:
>     1. direct description of what is ignored given first.
>     2. example instruction of the user manual action required.
>     3. use sideways indirection for assume-unchanged and update-index
>        references.
>     4. add a 'normally' to give leeway for the change detection.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>
> This is the corrected patch which now applies on top of next and has been
> checked on AsciiDoc. (was $gmane/261974/focus=262022)
>
> I have included the previous 'after three-dashes' comment and included
> them in the commit message. I'm happy for it to be tweaked as appropriate.

Thanks.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 52eeadd..fe179d0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -375,15 +375,18 @@ This is useful for excluding servers inside a firewall from
>  proxy use, while defaulting to a common proxy for external domains.
>  
>  core.ignoreStat::
> +	If true, Git will avoid using lstat() calls to detect if files have
> +	changed. Git will set the "assume-unchanged" bit for those tracked files
> +	which it has updated identically in both the index and working tree.

I wonder if this is better stated in two seemingly independent
sentences (like your version), or "... if files have changed by
setting the assume-unchanged bit ...." to clarify where the setting
of the bits to these files come into the big picture, but it is
minor.  Either way, I think it is a lot easier to understand than
what we have in 'master'.

> ++
> +When files are modified outside of Git, the user will need to stage
> +the modified files explicitly (e.g. see 'Examples' section in
> +linkgit:git-update-index[1]).
> +Git will not normally detect changes to those files.
> ++
> +This is useful on systems where lstat() calls are very slow, such as
> +CIFS/Microsoft Windows.
> +False by default.

I think you are trying to make the result more readable by using
separate paragraphs for separate conceptual points, but then isn't
it wrong to have "False by default" as part of stating which
platforms are intended targets?  I wonder if we want to have that
last line as its own paragraph instead.

Thanks.

>  
>  core.preferSymlinkRefs::
>  	Instead of the default "symref" format for HEAD
