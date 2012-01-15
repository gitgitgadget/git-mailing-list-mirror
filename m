From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep doesn't follow symbolic link
Date: Sat, 14 Jan 2012 18:07:32 -0800
Message-ID: <7v1ur1yazf.fsf@alter.siamese.dyndns.org>
References: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
 <CALkWK0=-LZH4MYhX50v-RWpGA2r+6q50YxsKaOxc0mJ__yuK7g@mail.gmail.com>
 <877h0zlvwd.fsf@thomas.inf.ethz.ch> <7vwr8za04q.fsf@alter.siamese.dyndns.org>
 <CACsJy8BfvhWxqBOj=+7AiF8dZBVEASAuxiOsjOvpmfE3uPrO3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pang Yan Han <pangyanhan@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 15 03:07:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmFVV-0001v5-RV
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 03:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab2AOCHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 21:07:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947Ab2AOCHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 21:07:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9775B59B2;
	Sat, 14 Jan 2012 21:07:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k2Y3Dp7H/p3ODuy2pwGOwH03NCU=; b=wnNWju
	Xw8aPzf15n9HxqMG3GpkX7lbPK6d9Kp84Y9yN2X5ImhuuOI2Y2JdLLff3xi2b2lG
	jsckIwGp7A4eU+rd+/6I7wjy+RpjBj501+39ZOqrKdpaqktaDuOOpqZR3UZSyVVM
	TqT9R3glxJePqBaxP02PgkPzE0a+9u4ZYmj0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dl8KDzEFBkwgVztY/r2xf5RS5Ev3u5eC
	CA/aXbrKjTHqv64IznZRipUE/Qkq4zG3NkJVO1m1tWyIZEV5vfQ4VBUNKFQxFGLM
	x6r8dPyaahxgoKNrt6Q5TU4dETYku9FI2KCYhJxPvurT3/8IdoKfbRjvfUKeVLTs
	kgdsBS0sduM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E0C359B1;
	Sat, 14 Jan 2012 21:07:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1470E59AE; Sat, 14 Jan 2012
 21:07:34 -0500 (EST)
In-Reply-To: <CACsJy8BfvhWxqBOj=+7AiF8dZBVEASAuxiOsjOvpmfE3uPrO3A@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 14 Jan 2012 16:50:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0393CC2-3F1D-11E1-B922-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188583>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> Even though some platforms may lack symbolic links, where they are
>> supported, they have a clear and defined meaning and that is what Git
>> tracks as contents: where the link points at.
>>
>> So we would want our "git diff" to tell us, even if you moved without
>> content modification the symbolic link target that lives somewhere on your
>> filesystem but is outside the control of Git, and updated a symbolic link
>> that is tracked by Git to point to a new location, that you updated the
>> link. On the other hand, if you did not update a tracked symbolic link,
>> even if the location the link points at that may or may not be under the
>> control of Git, we do not want "git diff" to show anything. As far as that
>> link is concerned, nothing has changed.
>>
>> Changing this would not be a fix; it would be butchering.
>
> That's a good default. But git should allow me to say "diff the files
> that symlinks point to". Link target is content from git perspective,
> not from user perspective.
>
> So instead changing the default behavior specifically for git-grep as
> Pang did, I think adding --follow-symlinks option, that could be
> passed to grep or any of diff family, would be a better approach.

Stop and think what "git diff --follow-symlinks v1.3.0 v1.7.0" should do
when these versions record a symbolic link, "from user perspective", if
the link points outside the tracked contents. Naturally, the users would
expect that the comparison is made between the contents of the file back
when v1.3.0 was tagged and the contents of the file (which may or may not
be the same path depending on the target of that symbolic link) back when
v1.7.0 was tagged.

But that is something that the user is *NOT* tracking with the system, and
hence something we cannot give the right answer. Your "--follow-symlinks"
option only encourages the *wrong* perception on the users' side, without
supporting what it appears to promise to the users. Why could it be an
improvement?

Compared to that, limiting the optional support for following symlinks
only in "--no-index" case, where the user explicitly asks us to look at
the data that is not managed by Git at all, makes more sense.  At the
design level, I wouldn't be fundamentally opposed to a change to add an
optional "follow the symlink" feature only when "--no-index" is asked for.

I didn't look at the posted patch, so I do not know if it adds an optional
following or unconditionally makes us follow symbolic links, or if the
patch sensibly implements the feature, though. That is a separate issue.
