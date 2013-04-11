From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] Teach mv to move submodules using a gitfile
Date: Thu, 11 Apr 2013 11:43:10 -0700
Message-ID: <7vmwt4j4ch.fsf@alter.siamese.dyndns.org>
References: <515C88FE.9020203@web.de> <515C8987.2060804@web.de>
 <7vwqsbnvxz.fsf@alter.siamese.dyndns.org> <51659A8A.80605@web.de>
 <5165D469.2020603@web.de>
 <CALkWK0kUdKfAp36HSdoTOK_Wt-Rs_4f3HKHLbLi8e3pzx0iEGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMSx-0006rO-21
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763029Ab3DKSnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 14:43:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44121 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759700Ab3DKSnO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:43:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5BC915D7F;
	Thu, 11 Apr 2013 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NHQH+ACFfcgn3F0UIee1oK6nra0=; b=rNZQPP
	ZSayi5MSTJ7Omz7aKCNUTent15EjLCleBbFPrtKDc0WfVc69yUxrzbhgRyb3QYR1
	h7DQX1B8OXni6zZlQwJveNDR/Fdw2XvDaNiF2tOlwSM/BSy8y9DLC/pu1aVf4PgT
	NQ3hLHR6q3pjiwS9vYqHJCo/3biQp1k4mrZ4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nrS9Z7+slOx7fnjjsNzQS0WPQk/VNzjB
	6Z4IDDdpDcYeqAfb8Qbox1RHRkTyZn/JbzFBJTUDfFS0IAKghKC+uL/yrvv4PIsQ
	TQgmluKCrzJ+0ypZKcwlIcoZS/Y9z7kcZCdFC5d90+y2YeM4+zktbJ5DnmyZS+aY
	GCBhdwaGf0o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A05715D7E;
	Thu, 11 Apr 2013 18:43:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E11D415D7A; Thu, 11 Apr
 2013 18:43:12 +0000 (UTC)
In-Reply-To: <CALkWK0kUdKfAp36HSdoTOK_Wt-Rs_4f3HKHLbLi8e3pzx0iEGw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu, 11 Apr 2013 14:07:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA0FA8D0-A2D7-11E2-A4A7-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220910>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Jens Lehmann wrote:
>> When moving a submodule which uses a gitfile to point to the git directory
>> stored in .git/modules/<name> of the superproject two changes must be made
>> to make the submodule work: the .git file and the core.worktree setting
>> must be adjusted to point from work tree to git directory and back.
>
> Isn't it untrue that the git directory is stored in
> .git/modules/<name>: it is stored in .git/modules/path/to/module.
>
> I thought the whole point of this complex scheme was to avoid name
> conflicts with submodules with the same name in other directories.

I think Jens is right on this one.  There are three things the code needs
to know about a submodule: its name, path and URL.

A canonical use case to think about is a project that builds an
appliance:

 * Its zero-th version only has the sources to the userspace for the
   appliance.

 * The first version adds the Linux kernel as a submodule bound at
   kernel/, taking it from git://k.org/linux-2.6.git/.

 * The second version adds a choice to build the appliance with the
   BSD kernel, and the project reorganizes the source tree to have
   Linux kernel at path linux/ and adds the bsd kernel at path bsd/.

 * By the time the third version is released, the URL to the Linux
   has migrated to git://k.org/linux.git/; it is still logically
   the same (i.e. continuation of) the old 2.6.git repository [*1*].

We would want to make it possible to "git checkout" smoothly between
these four versions.  Switching from v1 to v0 would have to remove
the submodule working tree at kernel/ but the user may want to
switch back to v1 without having to re-download the kernel
submodule, so the kernel/.git repository needs to be stashed away
somewhere.  Somewhere in $GIT_DIR of the superproject, but where?
Switching from v1 to v2 would need to move kernel/ to linux/ and
move kernel/.git to linux/.git.  The design choice made long time
ago (if you recall the collection of old threads I gave you some
time ago, this is what was called "Steven's three-level thing") was
to give a stable "logical" name for the Linux kernel component, so
that no matter where in the working tree the version that happens to
be at the tip of the current branch has it, we know where in the
superproject's .git/modules it is found.

So at the second version when we move the submodule that used to be
at kernel/ to linux/, we move the working tree of it, adjust the
"path" of the submodule, but keep the name.  And that name gives an
identity to the submodule, and that is what is used as a key inside
$GIT_DIR of the superproject to decide where the repository
(together with its object store) of the submodule is stashed away.


[Footnote]

*1* I mentioned the URL thing only for completeness; it does not
come into play in the "checkout" scenario, but when you start
thinking about remote interactions, you need to be aware of how that
value and the one copied to the configuration upon "submodule init"
need to be managed. Which is a separate topic but is an integral
part of the canonical example.

Ideally, a user who has followed along the life of this project
should:

 * first encounter git://k.org/linux-2.6.git/ in v1; "git submodule
   init" would copy it to her .git/config in the superproject.

 * later notice that .gitmodules has git://k.org/linux.git/ location
   that she hasn't seen for the submodule, and is given a chance to
   have the URL entry updated in her .git/config.

This is becuase even when she checks out an older branch that has
2.6 in .gitmodules, "git submodule update" _should_ go to the new
URL, not to the defunct 2.6 URL.  We do the "copy initially", but do
not do the latter "offer a chance to update when seeing a new one"
(at least, not yet).
