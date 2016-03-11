From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at the same time
Date: Thu, 10 Mar 2016 22:43:27 -0800
Message-ID: <xmqqmvq5bjlc.fsf@gitster.mtv.corp.google.com>
References: <cover.1457609615.git.johannes.schindelin@gmx.de>
	<CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
	<alpine.DEB.2.20.1603101417590.4690@virtualbox>
	<CACsJy8AuBsF_rhuo_a_nqaVH1ApT3iAyozt1w2vkmvHmK17hZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 07:43:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeGnR-0004MC-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 07:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbcCKGnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 01:43:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753394AbcCKGna (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 01:43:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1001A3D2E4;
	Fri, 11 Mar 2016 01:43:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MbaNdsAASLtz9iaYvcfYukEowrY=; b=xVMK4J
	GZYOoSkMVBiQY0NWwiEGmo4X+G29mr5eDAJKvP6KzSRKxonp2qtvG8qgFT1Njkli
	0HzVlUhyIK72qybPw+aH5+hFHHiG8+q61+SZWA87K+blNtmLf89oOQUUfIfI17dR
	VQtA7lvArggJQHtSS7rru4WUN3bSgpLc9+F0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wP3EDi5OxT/eUIE6uCXZswPgNHRpw0Bj
	avgQ0bzDIRbBOSpkfOJ/gG8O9Kwtpt9HHlN9S5FHb63Uww3EvCZn4axMKN4376eW
	IIjGGiJ8Vjii33PbDvVs8uJG3J59JQHCeuwvMzgQ9/e+ZjVvwpJKLwIfi+3vJlxJ
	tzc5QFOYwec=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0725E3D2E2;
	Fri, 11 Mar 2016 01:43:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 814E43D2E1;
	Fri, 11 Mar 2016 01:43:28 -0500 (EST)
In-Reply-To: <CACsJy8AuBsF_rhuo_a_nqaVH1ApT3iAyozt1w2vkmvHmK17hZA@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 11 Mar 2016 07:56:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9017D726-E754-11E5-8416-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288675>

Duy Nguyen <pclouds@gmail.com> writes:

>> Granted, "git worktree remove" should be the work horse. But why not have
>> two ways to skin the same cat? I, again, would prefer the short 'n sweet
>> "git branch -d -w pull-rebase-prefix" invocation.
>
> If you put effort into making it happen, I'm not stopping you :)

I actually would ;-)  If I had to choose between the two, I'd prefer
to see this new feature as part of the "worktree" subcommand, simply
because "branch" is a fairly basic feature that can be used by those
who are new to Git without knowing that the "worktree" feature even
exists (hence not having to have one extra option description in its
documentation that talks about "worktree" is a big plus).

But that is only if I had to choose between the two.

Personally, I think you are better off implementing this set of
features as a set of shell aliases (be it bash or tcsh).  For one
thing, you are likely to want to "chdir" to the newly created
worktree built for the branch (or an existing one for the named
branch) for the "take me to a worktree to work on this branch"
feature.  The last action you would want that command to take is to
take you there, and "git anything" subcommand would not let you do
that (unless you tell your users to run "eval `git something`", a
way similar to "ssh-agent -s", that is).

That approach to implement the UI that directly faces the end users
via scripting would let your users choose layouts more flexibly.
Some people may want a repository and its worktrees next to each
other, some others may want the worktrees embedded inside the main
repository, yet some others may want layouts other than those two.
