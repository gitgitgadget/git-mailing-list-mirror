From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/rev-parse: --verify does not check
 existence
Date: Tue, 11 Jan 2011 13:00:28 -0800
Message-ID: <7v39oz40lv.fsf@alter.siamese.dyndns.org>
References: <2441701cf9c9cc09d86f52b093bfa896479daad8.1294771717.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Zachery Hostens <zacheryph@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 11 22:00:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PclKf-0007ok-Kk
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 22:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604Ab1AKVAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 16:00:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110Ab1AKVAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 16:00:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 563853F17;
	Tue, 11 Jan 2011 16:01:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LvaSV32BfUSMdAMk8Vk6JKukmkE=; b=GxWFFm
	KXHNg790VQNTfNWnJTjF/yawcVehllIKY+lK7pTWxf7NvXdGX22KjonuEKi4zMQ8
	S1DWytV0OpKWC67gYwq8qiyq6fnG3w4H1ZLD9L2Xnezp8YFh3zkEcxG8WUdPvfzW
	NeFsXuHYOHPfy027OZ2PJomOgkrUPbIUjbuCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p+VjkyDV0sXLPwaI0EoHzdYw1x8K2m+E
	rI5Y62FAKNJ/m3s8l4Tj06LAo+hrf2LzygW4v2cCuKCS7+tzRfw8oRdNPgD/Fi3u
	kdJEH5HRbw+TdSaLlUbmjvbedORMS414eNsKzHzi/Jk/qWjBKR6GyBGHrWdtXqhq
	3Wtf/HaX6TM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25CDA3F16;
	Tue, 11 Jan 2011 16:01:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CC36A3F15; Tue, 11 Jan 2011
 16:01:11 -0500 (EST)
In-Reply-To: <2441701cf9c9cc09d86f52b093bfa896479daad8.1294771717.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue\, 11 Jan 2011 19\:51\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE11D8D0-1DC5-11E0-A572-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164991>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index ff23cb0..779fa87 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -59,8 +59,9 @@ OPTIONS
>  	instead.
>  
>  --verify::
> -	The parameter given must be usable as a single, valid
> -	object name.  Otherwise barf and abort.
> +	The parameter must either be formed like an object name, or
> +	dereference to an object name.  This does 'not' verify that
> +	the object actually exists!  See EXAMPLES below.

To paraphrase what this text says, if you do

	echo >.git/refs/tags/next e17aa8a9dca972ca278dd91a097873101066e963

where that hexstring does not name any existing object [*1*], you can
successfully verify "tags/next" (i.e. "git rev-parse --verify tags/next"),
but not "tags/next^0", because "tags/next^0" does not "dereference" to a
40-hex string, while "tags/next" does.

That's all good, but as I said, the hexstring is _not_ an object name.  So
"dereference to an object name" is actively a wrong thing to say here.

You meant "40-hex string" with "formed _like_ an object name" in the
above, and the "like" is an attempt to say "could be usable to name an
object, but does not mean that the object has to exist".

But "dereferencing" a 40-hex string yields itself, so what you wrote can
be simplified to something like this, without using a wrong term "object
name":

        Makes sure that the parameter dereferences to a string of 40
        hexadecimal characters.  Otherwise barf and abort.

But then, if you read the original carefully, it already says "must be
usable as a single valid object name", and "be usable as" does not
necessarily mean "named object must exist".  So I agree you identified
something that needs to be clarified, but I do not think your rewrite
clarified things very much.

How about this?

	The parameter given must be usable as a string to name a single
        object (note that the named object does not have to exist).
        Otherwise barf and abort.

Unfortunately, this does not clarify if it satisfies the above condition
to say "refs/heads/nosuch" in a repository without "nosuch" branch---the
ref expression is usable as a string to name a single object, so it should
verify Ok, but the reason it doesn't name a single object is not because
it yields a 40-hex string that no object with that name exists, but
because it doesn't dereference to a 40-hex string to begin with.  So it
actually should _not_ verify well.

To fully clarify this, I think the first step we need is to add a better
definition of "to dereference" (or whatever word we would end up using to
call the act of passing a string through get_sha1()) to the glossary.
Then we can use the "string of 40 hexadecimal" rewrite I gave earlier.

[Footnote]

*1* These days, "git tag" and even "git update-ref" seems to verify that
the given name actually refers to an existing object, so this experiment
has to be done by manually futzing with the repository.  Joy of safety ;-)
