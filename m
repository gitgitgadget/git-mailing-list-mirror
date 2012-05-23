From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cherry-pick dangles and forgets helpful advice in next
Date: Wed, 23 May 2012 14:20:00 -0700
Message-ID: <7vr4uazjb3.fsf@alter.siamese.dyndns.org>
References: <4FBD4904.9090000@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed May 23 23:20:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXIyn-0003qR-Of
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 23:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318Ab2EWVUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 17:20:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933260Ab2EWVUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 17:20:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB7A48D75;
	Wed, 23 May 2012 17:20:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z9g+6pTrijSV/2UCF5KX6pJezF0=; b=sfH5L9
	tQSqLAAX35WIyrB7IBGqDKg5YwOe21ghm7twW/pKnrCzdz/cZTw6L7RGzH64L7+y
	nrJcwsSCKFgMjBMQj411HithNcHW2M2pyIVSqbObMeCTRT0KCy6A16c0fvthfua9
	2IXpANxu7LVVHs0SvAnYS9UsZIF/p16Yma7dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dlzgRUYKxKTHNV4qutuUcWCi01fqu71F
	pu/ueOQyZMcrC/QW+IdQERxFx4kVS/yNrsk3XhjsvYZj/IDVgo9NL5/VCYXe+cie
	lm6mY7wjXODYcUZdFfAASvYf+BJKDE7WSNsnxly4FoSd4zGEkd2i43tkbpVo7uJI
	Xq9TvyJvAmo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D06FF8D73;
	Wed, 23 May 2012 17:20:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 788C08D68; Wed, 23 May 2012
 17:20:02 -0400 (EDT)
In-Reply-To: <4FBD4904.9090000@cisco.com> (Phil Hord's message of "Wed, 23
 May 2012 16:31:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F2CC2A2-A51D-11E1-884E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198325>

Phil Hord <hordp@cisco.com> writes:

> In git.git 'master' when I cherry-pick a commit which is eventually
> empty, git gives me a friendly description of my supposed error, leaves
> my cherry-pick "pending" and exits with an error code.
>
>
> $ git cherry-pick a0aff2d                          
> # On branch master
> nothing to commit (working directory clean)
> The previous cherry-pick is now empty, possibly due to conflict resolution.
> If you wish to commit it anyway, use:
>
>     git commit --allow-empty
>
> Otherwise, please use 'git reset'
>
>
> In 'next' this is broken.  Now git does not tell me anything and it does
> not exit with an error code.  It does still leave the cherry-pick
> pending, though.
>
>
> $ git cherry-pick a0aff2d
> $ cat /tmp/repo/.git/CHERRY_PICK_HEAD
> a0aff2da3d12a9a097c02e39570611f359433c23
>
> It bisects to this commit:
>
> commit b27cfb0d8d4cbb6d079c70ffeadac9c0dcfff250
> Author: Neil Horman <nhorman@tuxdriver.com>
> Date:   Fri Apr 20 10:36:15 2012 -0400
>
>     git-cherry-pick: Add keep-redundant-commits option
> ...
> I don't have time to chase it any further today.  Hopefully someone can
> see the flub and straighten it out before I get a chance to look again. 
> If not, I'll probably forget anyway.

Given that I am currently very deep in today's integration round, I
wouldn't have a chance to look into this.  I am OK with reverting the
whole topic (and I am also very much tempted to do so), as nobody other
than Neil seemed to have wanted this "feature". and even though it is
"optional", I doubt it encourages a good workflow.

Let's see if somebody comes up with a fix quickly enough before the -rc1
is tagged.

Thanks for a report.
