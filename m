From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Mon, 28 Jan 2013 09:45:46 -0800
Message-ID: <7vham1xktx.fsf@alter.siamese.dyndns.org>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
 <1359290777-5483-2-git-send-email-hjemli@gmail.com>
 <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
 <CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
 <20130128081006.GA2434@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 18:46:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzsmf-0001k0-7L
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 18:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591Ab3A1Rpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 12:45:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756576Ab3A1Rpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 12:45:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E4B6C0DB;
	Mon, 28 Jan 2013 12:45:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OKFQCv/egLMq0FqfI7yBqOy1sZc=; b=HOpiTK
	BJPsaaeAzwFftsNWx1QQzfFNfbTGGKDjrA20CihyaMpDSR+3GNMhYzT7UVWmnssh
	V6BZ14OxrV/85frVQA4YKg+2SdbBSDPlTepRz9hVSZOkcsRi6X/esNkSpoxFdFbS
	RdI2ay8bQ23Z3EKNebocAteDvCaetdSMzIT2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bRaXcCpPIradhKoVWMjQGEnom8UhEjvz
	EwUJ1QLg2drW6kxK3BxHQtVOYVHYcUHLAkxTYFrmHmVa48tmeHLoh1TSc+5xEZg6
	Ob96dmHYay2AXoG9+CXwhPgLd7C14doAH6DlaCWGmAT/23DiF8nuf58+SqDrd2yG
	YYpqtJ97UiE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93B03C0DA;
	Mon, 28 Jan 2013 12:45:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C675C0D8; Mon, 28 Jan 2013
 12:45:47 -0500 (EST)
In-Reply-To: <20130128081006.GA2434@elie.Belkin> (Jonathan Nieder's message
 of "Mon, 28 Jan 2013 00:10:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C995FBA-6972-11E2-847A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214841>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Tracing backwards: it would be really nice to be able to do
>
> 	git for-each-repo git grep -e foo -- '*.c'

This is a very good example that shows the command that is run in
the repositories found may want pathspecs passed, but at the same
time, makes me realize that these repositories have to be fairly
uniform for this command to be useful.  For example, 'src/*.c' or
'inc/*.h' pathspecs wouldn't be useful unless majority if not all
projects the loop finds follow that layout convention.  This is not
necessarily limited to pathspecs, of course.  Unless they all have
the 'next' branch "git for-each-repo checkout next" would not work,
etc. etc.

As to the pathspec limiting to affect the loop itself, not the
argument given to the command that is run, I don't think it is
absolutely needed; I am perfectly fine with declaring that
for-each-repo goes to repositories in all subdirectories without
limit, especially if doing so will make the UI issues we have to
deal with simpler.

As to the "option to the command, not to the subcommand, -a option",
I have been assuming that it was a joke patch, but if "git -a grep"
turns out to be really useful, "submodule foreach" that iterates
over the submodules may also want to have such a short and sweet
mechanism.  Between "for-each-repo" and "submodule foreach", I do
not yet have a strong opinion on which one deserves it more.

Come to think of it, is there a reason why "for-each-repo" should
not be an extention to "submodule foreach"?  We can view this as
visiting repositories that _could_ be registered as a submodule, in
addition to iterating over the registered submodules, no?

If these two are unified, then we do not have to even worry about
which one deserves "git -a" more.
