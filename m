From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Tue, 26 Jun 2012 15:53:15 -0700
Message-ID: <7vzk7p8z38.fsf@alter.siamese.dyndns.org>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
 <7vobo6cazk.fsf@alter.siamese.dyndns.org> <4FE9FF0C.8050409@web.de>
 <7vobo5c0n0.fsf@alter.siamese.dyndns.org> <4FEA380D.8070001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:53:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjedY-0000lq-EC
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab2FZWx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 18:53:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab2FZWx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 18:53:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9DA28977;
	Tue, 26 Jun 2012 18:53:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6gdGYad7cm6P/N9Fu+GnOKDoU3w=; b=ow2F/X
	vjAcAv5QQB+ITa3JkgpKhroiTJ1b3CRr7JF6Ch1tTn+t0zeqJvIpbqee0vgdjyhL
	+Fe8vmONXEWD3dP+EY8MN1GPiC4tPfAzDV9qUldM9HI0Nebeh4WJeX7hx/I3hWU+
	QIoJqseJY76BtV88uqVushhn61Z8wpcArS0yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uNZh1WtOcA68aXJlAhM0XLhmfJrB0HFy
	x/SHKgnqasAuOOmWRnsBBIii7L+tiwxzVgkhOJPT7FG+Ci93FOhsPqpARRvD49+G
	QWCOAMdbIFbI7apRJYiVHoVrKB9CcXK3BoSz3sxwFWcStZzCYdelKbInh68GJgGI
	cdGtKwO2PYM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0CD08976;
	Tue, 26 Jun 2012 18:53:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A19DE8975; Tue, 26 Jun 2012
 18:53:22 -0400 (EDT)
In-Reply-To: <4FEA380D.8070001@web.de> (Jens Lehmann's message of "Wed, 27
 Jun 2012 00:30:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB2E0906-BFE1-11E1-9843-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200698>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 26.06.2012 21:51, schrieb Junio C Hamano:
> ...
>> If the user has to use GIT_WORK_TREE to mark the root level of the
>> superproject working tree as such, it is very likely that the
>> controlling repository of the superproject does not live in the
>> $GIT_WORK_TREE/.git directory (in other words, $GIT_DIR points at
>> somewhere else).  Exporting GIT_WORK_TREE/submodule as the new value
>> of GIT_WORK_TREE is sensible, but I do not see a reasonable way to
>> deduce the value of GIT_DIR for the submodule in such a case.  The
>> controlling repository of the superproject is located somewhere
>> random; there is no reason to assume the repository for the
>> submodule is somewhere at fixed relation to it.
>> 
>> Does it mean the short answer to Richard's situation is "Don't do
>> it"?  I am not sure, but it is starting to sound like it.
>
> Not at all, I was just trying to reach consensus on what the user
> can reasonably expect when setting GIT_WORK_TREE in the presence of
> submodules. I will look into it to see how we can handle the cases
> where GIT_WORK_TREE and/or GIT_DIR are set.

Thanks, then I'll let you look into it.  I do not see how you could
determine GIT_DIR for the submodule sensibly if the superproject's
working tree does not have its GIT_DIR as ".git" at the top-level,
though.

Declaring that a checked out submodule _must_ have its controlling
repository as ".git" at its root level, i.e. it should be accessible
without using GIT_WORK_TREE/GIT_DIR at all just like a normal Git
repository is, would be a clean way to avoid the issue altogether
and it still will allow the top-level superproject to be structured
in a funny way to require GIT_WORK_TREE/GIT_DIR to access it, but I
am not sure if that is too restrictive for people who for some
unknown reason want to use these environment variables to create
repositories with a strange layout.
