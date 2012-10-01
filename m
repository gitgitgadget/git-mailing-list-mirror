From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] submodule add: Fail when .git/modules/<name>
 already exists unless forced
Date: Sun, 30 Sep 2012 17:06:58 -0700
Message-ID: <7v7grbf42l.fsf@alter.siamese.dyndns.org>
References: <BC634E06939C44239106E7A8DD229130@gmail.com>
 <50636C00.6080906@web.de> <50677E76.1050204@web.de>
 <7vtxugglqy.fsf@alter.siamese.dyndns.org> <50689B5F.3060308@web.de>
 <5068B329.7040302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Johnson <me@jondavidjohn.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 02:07:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TITYC-0000z9-7e
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 02:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab2JAAHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 20:07:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56340 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425Ab2JAAHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 20:07:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D463B9E3E;
	Sun, 30 Sep 2012 20:07:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=raOrKqdgVrBWSQ1LFbaGUzPyjcc=; b=e5aDSE
	W7/PnQ1jvNdY5k4BPc8I/vNcPd5glr2V1g0kqfLiHHuapjU6397PDn7pI6T1q5/p
	DmoHhe+PdsOgy2dBkb7rOZrwR41HUmWGjJwyMGxUsltN2fubQOTy23vQmqrsS/KM
	lSTUI0SIBr4CGVxgG4F0jqFI0lGx0KJnbNpvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mBvjrSK8xtPA6zgSideQIXuG4QrKLLlb
	0pD/R7smQyipDskKDkSY3yX4SORMl7Dy/459RXTQ0yQOzCMD4u0uuoMxVIVOMz3Q
	cZZG1opZZH/aChQHXZmRuljE9GDaq3kjkDJhXcaaBAFNrUOQuLLOoo36eckmu8uR
	iklI7Jip2PU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9D6F9E3D;
	Sun, 30 Sep 2012 20:07:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96C979E3C; Sun, 30 Sep 2012
 20:07:03 -0400 (EDT)
In-Reply-To: <5068B329.7040302@web.de> (Jens Lehmann's message of "Sun, 30
 Sep 2012 23:01:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDEDF89A-0B5B-11E2-94FF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206700>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> Good point! I will add a more detailed error message (including
>> the url of the default remote which is configured for the already
>> present submodule repo) and teach --force to skip the test and
>> resurrect that submodule repo.
>
> The message when "git submodule add" finds .git/modules/<name> is:
>
> A git directory for '<name>' is found locally with remote(s):
>   origin	<url(s) from .git/modules/<name>>
> If you want to reuse this local git directory instead of cloning again from
>   <url given on command line>
> use the '--force' option. If the local git directory is not the correct repo
> or you are unsure what this means choose another name with the '--name' option.
>
> When run with the --force option the following message is printed:
>
> Reactivating local git directory for submodule '<name>'.

Thanks, will re-queue.

The approach "submodule rm" takes when removing a project is to
treat the removed submodule as not necessary for the current commit
in the superproject, but it is considered necessary elsewhere in the
history of the superproject, and that is why we stash away the
repository in $GIT_DIR/modules of the superproject.

We may however want to think about another mode of user error where
the user runs "submodule add $path" for a wrong repository, realizes
the mistake _before_ making any commit and try to repoint the $path
to a correct repository.  The behaviour of "submodule add" in this
patch, and the behaviour of existing "submodule rm", assumes that
the user is not stupid and won't make such a mistake, but to recover,
the user may need a way to really nuke the submodule repository that
was added by the earlier misteake (which is not needed anywhere in
the history of the superproject) and $GIT_DIR/module/$name really
replaced with the updated one.

I don't know how important to support a recovery procedure from such
mistakes, though.
