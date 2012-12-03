From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/4] submodule update: add --remote for submodule's
 upstream changes
Date: Mon, 03 Dec 2012 12:29:05 -0800
Message-ID: <7vr4n6q3qm.fsf@alter.siamese.dyndns.org>
References: <20121130032719.GE29257@odin.tremily.us>
 <cover.1354417618.git.wking@tremily.us>
 <ec5d0235322619aff6c1c64b0a346efb0e4d0a32.1354417618.git.wking@tremily.us>
 <7v8v9ft761.fsf@alter.siamese.dyndns.org>
 <20121203181519.GC14981@odin.tremily.us>
 <20121203183802.GD14981@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Dec 03 21:29:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tfcdr-0000dJ-Ic
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 21:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab2LCU3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 15:29:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64300 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab2LCU3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 15:29:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FBE3A487;
	Mon,  3 Dec 2012 15:29:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XYYn5jXmUq4t12rsaYKxuMVRQ7s=; b=GsMzKg
	H2ILKxLnYwBX3w9QACthuJTLudIQgMKT+nax1Q9TltN70272kZNCL0VR+WZXlxtB
	4JowCZCdgXdnYaxnw75ltWEzjZqnPlGjY3WdzEFY7UpJYnUAR71LCGvvPqbFcx/G
	ibWDgyFNHrzarcotxzoF7tRbiQPonTrRqMxWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JXBSJ6I17eXzP64stXy66JeeTub9PEu8
	PUMif7aY9cDGFKMhoF6zO6PnHOX/0K7t3J04n4cqQXwTS8fLtkM9HGU4fTfEabB7
	8Eiw8P7eMGFJ76HerrVUIjww/hyOiQfYHScczQnbLDKvxKXROm40ZXu49lWnO4pA
	5MW/29Osu5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A751A486;
	Mon,  3 Dec 2012 15:29:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FFB5A485; Mon,  3 Dec 2012
 15:29:07 -0500 (EST)
In-Reply-To: <20121203183802.GD14981@odin.tremily.us> (W. Trevor King's
 message of "Mon, 03 Dec 2012 13:38:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1652717C-3D88-11E2-B425-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211058>

"W. Trevor King" <wking@tremily.us> writes:

> As an example to make this clearer:
>
>   $ cat .gitmodules
>   [submodule "sub1"]
>     path = sub1
>     url = git://example.com/sub1.git
>     remote = remote1
>     branch = branch1
>     update-source = submodule-upstream
>     update = rebase
>   [submodule "sub2"]
>   ...

Maybe it is just me but that "remote = remote1" sticks out like a
sore thumb.

If you are showing the .gitmodules file to be shared as hints to
project participants, why does it even need to have both URL and
remote1?  If remote1 points at some other repository, the recipient
of this .gitmodules file would not have any clue where it is.  If
remote1 points at the same repository as the URL, why should it be
there in the first place?  The superproject is in no business to
force what local remote name each participant would call in their
submodule checkout, and more importantly, there is no _need_ to do
so.

We could extend that reasoning to the branch name (which is also a
local matter, at least technically), but this is a lot more
justifiable.  If the upstream of the superproject is the same
organization as the upstream of the submodule project, which is
often the case when a large project is organized as a forest of
submodules bound at the top-level with a superproject, the
superproject commit on a particular superproject branch may want any
update necessary to complete the superproject made to submodules on
specific branches at the central meeting place.  The superproject's
Milestone22 branch may want to bind commits that is on submodule's
Milestone22 branch.

While a participant locally *can* create M22 branch in the submodule
and set it to build upon Milestone22 branch taken from the central
repository, most people don't.  They use the same branch names
between local and remote (i.e. refs/heads/*:refs/remotes/origin/* to
keep the remote-tracking branches under the same name, and the local
branch $any builds upon the corresponding remote-tracking branch
refs/remotes/origin/$any.  Most importantly, the work done on local
branch $any is pushed out to refs/heads/$any at the remote of the
submodule).  Because of how people use "push" to push $any branch to
the branch of the same name $any at the central meeting place, and
because the upstream wants participants to use a particular branch
name in the submodule at the central meeting place, the set-up ends
up dictating what local branch name should be used.

But I do not see any reason to require or even suggest any local
nickname that is to be used to call the remote.  It really is a
local matter.  Why should .gitmodules have "remote = ..." line?

On the other hand, if you meant the above as an excerpt from
$GIT_DIR/config, it also does not make sense.  At that point, the
participant own the file and updating url to point at whatever
different repository without changing the remote name is sufficient.

It looks way over-engineered for unclear/dubious benefit.
