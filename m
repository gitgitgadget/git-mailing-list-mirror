From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 12:11:30 -0800
Message-ID: <xmqq1tmcc9l9.fsf@gitster.dls.corp.google.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
	<xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
	<20150130181153.GA25513@peff.net>
	<xmqq61bocao1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 21:11:43 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHHum-0007Y4-OV
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 21:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763089AbbA3ULg (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 15:11:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753706AbbA3ULe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 15:11:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 884D331CE4;
	Fri, 30 Jan 2015 15:11:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bpp6+iVNOVLxGaIUItLD9J0LkwA=; b=BfpPgq
	mKDr5td8q2u3Vu96feOetMjgBkT6z5XO9qskcbGfZt5PtcbsEFA3hwr7JnQEAaXM
	oZZwTdfNgVcCpc4wcdNmlihq+OHRS9BjgbHJnk9YRFKbYRTHR96wgcMB1wVkg3N8
	JnAAOyQw1lOmEZGjIDtwkz3WBq6AznA4LBZzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NI9W8WpWIGuWaFIIxZpvdCPfcFzXAfZx
	mXkib6Cfq10Hi/4Eid2H4wm5vH6qxNsiX7FhJ0aqrDrG0cR+WQUOlc3Y02Vz2aEd
	jd3LfNnxB6dAIMTqnCBIfL213jHBxRqDPADhoBENsadoZID9UXpNh2DsplrWuKVW
	gjS7YEa7LNY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EF4131CE0;
	Fri, 30 Jan 2015 15:11:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E791C31CDD;
	Fri, 30 Jan 2015 15:11:31 -0500 (EST)
In-Reply-To: <xmqq61bocao1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 30 Jan 2015 11:48:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2ECA46C0-A8BC-11E4-ADBA-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263193>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> +	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
>>> +		return error(_("affected file '%s' is beyond a symbolic link"),
>>> +			     patch->new_name);
>>
>> Why does this not kick in when deleting a file? If it is not OK to
>> add across a symlink, why is it OK to delete?
>
> Hmph, adding
>
> 	if (patch->is_delete &&	path_is_beyond_symlink(patch->old_name))
> 		return error(_("deleted file '%s' is beyond a symlink"),
> 				patch->old_name);
>
> seems to break t4114.11, which wants to apply this patch to a tree
> that does not have a symbolic link but a directory at 'foo/'.
>
> diff --git a/foo b/foo
> new file mode 120000
> index 0000000..ba0e162
> --- /dev/null
> +++ b/foo
> @@ -0,0 +1 @@
> +bar
> \ No newline at end of file
> diff --git a/foo/baz b/foo/baz
> deleted file mode 100644
> index 682c76b..0000000
> --- a/foo/baz
> +++ /dev/null
> @@ -1 +0,0 @@
> -if only I knew


I am not sure how to fix this, without completely ripping out the
misguided "We should be able to concatenate outputs from multiple
invocations of 'git diff' into a single file and apply the result
with a single invocation of 'git apply'" change I grudgingly
accepted long time ago (7a07841c (git-apply: handle a patch that
touches the same path more than once better, 2008-06-27).

"git diff" output is designed each patch to apply independently to
the preimage to produce the postimage, and that allows patches to
two files can be swapped via -Oorderfile mechanism, and also "X was
created by copying from Y and Y is modified in place" will result in
X with the contents of Y in the preimage (i.e. before the in-place
modification of Y in the same patch) regardless of the order of X
and Y in the "git diff" output.  The above input used by t4114.11
expects to remove 'foo/baz' (leaving an empty directory foo as an
result but we do not track directories so it can be nuked to make
room if other patch in the same input wants to put something else,
either a regular file or a symbolic link, there) and create a blob
at 'foo', and such an input should apply regardless of the order of
patches in it.

The in_fn_table[] stuff broke that design completely.
