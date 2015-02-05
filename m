From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Makefile: Use the same source directory for "ln -s" as for "ln" / "cp"
Date: Thu, 05 Feb 2015 11:23:24 -0800
Message-ID: <xmqqmw4skvrn.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com>
	<D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:23:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJS1Y-0002sA-Rl
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbbBETXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:23:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752500AbbBETXb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:23:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFDD5358B5;
	Thu,  5 Feb 2015 14:23:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f9o9CwThBlBzDgkgstWZNkA4mcg=; b=amnJTR
	jxHwsfKJ8/OwZcfSLCCxdJIQYuhQhlNp03vdzQwL/AsUET6NGqm5GUJQXk/qnAAr
	GWl4o+JRtONLl22IbHW8Ssn6dn7CcBBNRNdTShJgGnXW0OL7S2LlTOwEQhQ3qKib
	aWfGe3y7YOalZxcCs+a74NI+MF2R8bZ+AeVus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SktfZHaEMfTk3Klfy1RinWgBV9pTzum7
	9WUTRoP7YPCJ/FHzgngMeRSWaEaRy+q4l2EVGRL9RijIxQtxSgMKOUNqC8UG56LS
	zuwGfhX0uuljquG4nqSoi6WhT5HyuW3eut/imm5Dh/4QeQfEkYQLD2mL8EELjmNz
	KoKfHpkP5sg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E77B2358B4;
	Thu,  5 Feb 2015 14:23:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71393358AE;
	Thu,  5 Feb 2015 14:23:25 -0500 (EST)
In-Reply-To: <D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com> (Kyle J. McKay's
	message of "Thu, 5 Feb 2015 09:48:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77BCE78E-AD6C-11E4-B33E-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263389>

"Kyle J. McKay" <mackyle@gmail.com> writes:

>> -        ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
>> +        ln -s "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
>
> This is wrong.
>
> Currently with symlinks you will get installed into bindir something
> like this:
>
>   git
>   git-tag -> git
>   git-show -> git
>
> etc.
>
> With your change you would have
>
>   git
>   git-tag -> /usr/local/libexec/git-core/git
>   git-show -> /usr/local/libexec/git-core/git
>
> And I don't think we want that.  While those absolute path symlinks
> are technically correct,...

It is not even correct, is it?

When DESTDIR is set to allow you to install into a temporary place
only so that you can "tar" up the resulting filesystem tree, bindir
points at the location we need to "cp" the built programs into, i.e.
inside DESTDIR.
