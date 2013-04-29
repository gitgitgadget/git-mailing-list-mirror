From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git.pm with recent File::Temp fail
Date: Sun, 28 Apr 2013 22:53:04 -0700
Message-ID: <7vy5c1narj.fsf@alter.siamese.dyndns.org>
References: <20130322205758.09ca9107@pc09.procura.nl>
	<CAP30j14=_U8iEZAodnfACnBHgF0+j0_OK7n7PvsUnwSDj_Y40A@mail.gmail.com>
	<20130428110933.436786bd@pc09.procura.nl>
	<20130429021651.GA2751@sigill.intra.peff.net>
	<7vr4hung17.fsf@alter.siamese.dyndns.org>
	<20130429074620.17fbf129@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Ben Walton <bdwalton@gmail.com>,
	git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Apr 29 07:53:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWh1g-0003HG-9e
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab3D2FxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 01:53:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab3D2FxH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 01:53:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B11C713D65;
	Mon, 29 Apr 2013 05:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FsiXLMiivjw6He9dQxZxVF4yx9c=; b=he6N6a
	tNNAJUOQzaUfege3pTywY0mYv898yOfmUElIwWTxy+xv7QeCTTsb6F0xfKDWPkzW
	NClrTw3YSPmlOTT1NagRpB2teP3OAO2ns5BDjUSvLBFI0g8+8U1XkV5ovOoq+Xgb
	yqy2LS6vfW484RpNJc6Vqadr63KQsP8EWQgOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kKYY2B/Yeque7QkXZjO+SPtJvmDzSFP2
	QyC5WJ+V/ImjqYj043nU19r6XGW36B0g7JNAj2dTkSIFyqHUDKJb/RRiukJOey88
	bD3kBzvGLhEoBGG5c2+8J6nQZuoqnTFO6x7FvUCOzYhRR7aHg8EcOjXk4Z81rESB
	0QOYm4e48gc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A773013D64;
	Mon, 29 Apr 2013 05:53:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1136013D60;
	Mon, 29 Apr 2013 05:53:05 +0000 (UTC)
In-Reply-To: <20130429074620.17fbf129@pc09.procura.nl> (H. Merijn Brand's
	message of "Mon, 29 Apr 2013 07:46:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10109BAA-B091-11E2-ABD7-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222777>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> I don't need any credits. I just want git to work from scratch :)

The sign-off procedure is not about giving credits to you.  It is to
protect us from others (e.g. your employer) by having a record that
you claimed that you had the authority to give us the change.

For a single-liner change like this, this often does not matter in
practice, but we try to be consistent as it makes everybody's life
simpler to have a single procedure for all the patches.

Thanks

>
>> > ...
>> > So I think the right commit message is something like:
>> >
>> >   We call File::Temp's "tempfile" function as a class method, but it was
>> >   never designed to be called this way. Older versions seemed to
>> >   tolerate it, but as of File::Temp 0.23, it blows up like this:
>> >
>> >     $ git svn fetch
>> >     'tempfile' can't be called as a method at .../Git.pm line 1117.
>> >
>> >   Fix it by calling it as a regular function, just inside the File::Temp
>> >   namespace.
>
> Sounds about right.
>
>> > -Peff
>> 
>> Thanks.
