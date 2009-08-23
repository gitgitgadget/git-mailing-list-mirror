From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pulling one commit at a time.
Date: Sun, 23 Aug 2009 15:33:55 -0700
Message-ID: <7vr5v2qhws.fsf@alter.siamese.dyndns.org>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
 <4A9172D0.6030507@microchip.com> <20090824060710.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Sanjiv Gupta <sanjiv.gupta@microchip.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 00:34:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfLdd-0001MQ-Oq
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 00:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbZHWWeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 18:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbZHWWeE
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 18:34:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbZHWWeD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 18:34:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE78C34E2E;
	Sun, 23 Aug 2009 18:34:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=803maxXfRW595t1h/DLz5HXa4A0=; b=xQP0cU/5JieWkvJuiFxpEUS
	mUnasA8+CshSswqnloCAEJZSQO/cDu+eMUaNfPzTEY7tuNgyqU/YKmLWcX4PS+dU
	QiJMMRdlijeukHh7S+3cEmlm3gjYmoeU2I7U4KN0MI8FqTHtsX4Z9GH3EoIdxy/0
	Ob7D8YWTNWRDb5UrYYkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NfKW2js1BfsKISuWBz023RmSMtxcYmuSJmcwgYu5EbhqolH7x
	KNsbEVkfNvUSVGAC4cQLh2aB/4FtC65ZZIFTr+FaDhsZEskYKjkGHqcvqI7e2LLi
	R1RgiVsN2l6kvBVuMjn5dfEr2fZXsRkYKR71dJ+Y93JFHzxL9BC1J5WWSw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F62634E27;
	Sun, 23 Aug 2009 18:34:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3AC7D34E1E; Sun, 23 Aug 2009
 18:33:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E577D72-9035-11DE-91AA-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126892>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> When your histories look like this:
>
>       A                 your 'master'
>      /
>  ---X---U---V---W---Y   public 'master' (your 'origin')
>
> ... you can fetch first.
>
>  git fetch origin
>
> Then look at the history in gitk
>
>  gitk master origin
>
> And find the commit you are interested in merging (U in the above
> picture). And merge it.
>
>  git merge origin~3
>
> Replace "origin~3" in the example above with whatever commit you want to
> merge the entire history leading to it.

A good description.  Thanks, Nana.

Novice readers should notice the careful wording used here.  She says
"merge the entire history leading to it" instead of simply "merge the
commit".  Merging a commit in git always means merging the entire history
leading to that commit, so they mean the same thing to people who know git
well, but it avoids a misunderstanding that, if you did

    $ git merge V

it might apply the effect of only V, ignoring what U did, on top of your
current state A.  It doesn't.

       A-------M         your 'master'
      /       / 
  ---X---U---V---W---Y   public 'master' (your 'origin')

To create a commit that has only the effect of a single commit, you would
need to cherry-pick it.

    $ git cherry-pick V

will give you

       A-------V'        your 'master'
      /
  ---X---U---V---W---Y   public 'master' (your 'origin')

where "git diff A V'" is a moral equivalent of "git diff U V".
