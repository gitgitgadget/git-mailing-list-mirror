From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 10:50:37 -0700
Message-ID: <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
 <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <516C21CF.5080705@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Apr 15 19:50:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnYC-0004zR-EL
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab3DORuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:50:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39806 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755734Ab3DORuj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:50:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BF3D16257;
	Mon, 15 Apr 2013 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IQFmS+gihhLS4hLpDFiMGJ4VSkI=; b=xYgNYN
	T4qIym/M5lwKdJBm0Qkhe4Bn2ZYfkDoT0cxG/3zB8aj/UKf7tDzp6UkX//z903Pn
	4gaf4d5MerqSOCgmEpND0bReTZKv9SPAGIkfwjBmFl1M2YEIvBTasz0XDG1KuVLM
	XMWhOw2PHrzcn34wfTojF7T2NxnMRYnV9yQl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZDXgI70HEGJbg0escVmvpXNu3uplH21O
	Vf7/lXoOF8+JhbTkJKi23zLvBU5Dswju9hvhu07GB1l80K2WwP9yN1b6QzS+tOpJ
	P5L4biVVWxf1y561/nQusfk7mRrS5d1II71lY7BYok0n4YxtTAjS8Fh630s296ew
	yTuMSmKlaRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F54816255;
	Mon, 15 Apr 2013 17:50:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 806B916251; Mon, 15 Apr
 2013 17:50:38 +0000 (UTC)
In-Reply-To: <516C21CF.5080705@xiplink.com> (Marc Branchaud's message of
 "Mon, 15 Apr 2013 11:50:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB8B1954-A5F4-11E2-878F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221273>

Marc Branchaud <mbranchaud@xiplink.com> writes:

> In general I think it is a mistake to overload "git clone" with the notion of
> adding a submodule.

I agree with that principle, but my understanding is that this
effort is not about teaching "git clone" to create a submodule.

Both "git clone" and "git init" already know how to use a directory
that is outside the working tree of the newly created repository to
store its $GIT_DIR and point at it with .git in the working tree
using the gitfile mechanism (their --separate-git-dir option).  My
understanding is that this "config" is about making that option
easier to use when you _know_ any new repository you create with
"git clone" or "git init" inside your (toplevel super)project's
working tree will become its submodule, as it is more convenient to
have their $GIT_DIR inside the .git/modules/$name of the
superproject.

After that "clone" or "init" creates a repository, you still have to
"add" if you want to make it a submodule to the toplevel.

> If I want to *add* something to a repository, I'll use
> some kind of "add" command.  To me "git clone" is not the kind of verb I
> would expect to add something to some distant-parent .git directory.
>
> Instead of mucking around with"git clone" I would much rather see "git add"
> autodetect URLs and do the submodule thing:
>
> 	git add ssh://host/blammo.git
>
> would clone blammo.git into ./blammo/ and set it up as a submodule inside
> $PWD's git repo.

I do not think the addition Ram is envisioning in the patch will
prevent you from teaching "add" to do that.  An implemention of such
an addition indeed would most likely use the same --separate-git-dir
mechanism anyway.
