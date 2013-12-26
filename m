From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] Support multiple worktrees
Date: Thu, 26 Dec 2013 09:12:43 -0800
Message-ID: <7vy537k038.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BV6uerMyHNHviL0Jy8s+_jca8NM-hVfnM=u4cr-=JX1Q@mail.gmail.com>
	<xmqq7gaze00k.fsf@gitster.dls.corp.google.com>
	<CACsJy8DuXbCTjcVJNH=w6h3zgo0sxRgMfSQXZFtngYy2FLJTDg@mail.gmail.com>
	<7vvbyhjsp4.fsf@alter.siamese.dyndns.org>
	<CACsJy8DL5=B=jch6j6g_3xj3KRsLXxwMChVHF9MUFvafhWhYag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 26 18:13:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwEUY-0001xc-UU
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 18:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab3LZRMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 12:12:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505Ab3LZRMk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 12:12:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 955E55AEA8;
	Thu, 26 Dec 2013 12:12:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Izxy5qpkV94JgpThWvH6EbC66tY=; b=okKRHI
	vMKzXn9bm0XdQm1xchrpC/WNKzcaKM8fRcdvL6C/2sbJQ+7IZGzGkEgUZyqeXfOE
	Zbob+F8WkdX1RrhICLT0Mn0vS6vtRxb9vJBdgar2i6AwesH35jJB5+TukwvOZ3gI
	K3oTETKwxEwvsX0TGZAa+ziqXg+LwPAqKtoSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KEtzHtkuOSVjd89Hsxqq3/Y3eDl3/NlX
	NYRUAv0+8kYgjuJdFVWNe2NrXFTt+09AIH713WM1iNtrNOV2sgotW3HgjhI9fsfw
	C9tgPXnobnepitZDJulNxd5pG7CDJ599BkDGKl9q3yL8kcpNC72vLYPCOt0Ll9kd
	7L3OzpPKwb8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82DC85AEA6;
	Thu, 26 Dec 2013 12:12:39 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A210A5AEA5;
	Thu, 26 Dec 2013 12:12:38 -0500 (EST)
In-Reply-To: <CACsJy8DL5=B=jch6j6g_3xj3KRsLXxwMChVHF9MUFvafhWhYag@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 22 Dec 2013 15:44:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: EBFA4E0E-6E50-11E3-9585-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239703>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Dec 22, 2013 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Do we even need to expose them as ref-like things as a part of the
>> external API/UI in the first place?  For end-user scripts that want
>> to operate in a real or borrowing worktree, there should be no
>> reason to touch this "other" repository directly.  Things like "if
>> one of the wortrees tries to check out a branch that is already
>> checked out elsewhere, error out" policy may need to consult the
>> other worktrees via $GIT_COMMON_DIR mechanism but at that level we
>> have all the control without contaminating end-user facing ref
>> namespace in a way main/FETCH_HEAD... do.
>
> No, external API/UI is just extra bonus. We need to (or should) do so
> in order to handle $GIT_COMMON_DIR/HEAD exactly like how we do normal
> refs.

And that is what I consider a confusion-trigger, not a nice bonus.

I do not think it is particularly a good idea to contaminate
end-user namespace for this kind of "peek another repository"
special operation.

In order to handle your "multiple worktrees manipulating the same
branch" case sanely, you need to be aware of not just the real
repository your worktree is borrowing from, but also _all_ the other
worktrees that borrow from that same real repository, so a single
"main" virtual namespace will not cut it. You will be dealing with
an unbounded set of HEADs, one for each such worktree.

Can't we do this by adding a "with this real repository" layer,
e.g. "resolve HEAD wrt that repository", somewhat similar to how we
peek into submodule namespaces?
