From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Borrowing objects from nearby repositories
Date: Tue, 25 Mar 2014 10:02:23 -0700
Message-ID: <xmqqtxammctc.fsf@gitster.dls.corp.google.com>
References: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com>
	<CACBZZX5teZuqtNkPT4PdXJn=g34cOhRH2oNehROT8kJ_M2cgfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Keller <andrew@kellerfarm.com>,
	Git List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:02:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSUkD-0006Mn-Mi
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 18:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbaCYRC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 13:02:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753948AbaCYRC1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2014 13:02:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 426517740B;
	Tue, 25 Mar 2014 13:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dzYhJInQaNpt
	MGdPwNXwJFZjkAo=; b=DOlBQZJUTNtPyYWnTEwIB3YxhvgRIxG5P9kZTQYv5QQZ
	Ikre+2RKaHDM+x1eGNan0JLMTtSKzOe0KTthbLQkp4/U4sTl9qMIo7Y/3bwee5if
	bJTydl3oU5iyRW3y7ZFRlEHRlhWq4PkKmvbgrnyQfLexkbmGYPL7plVVJjg58jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CIg9DY
	tAw/Sgyg5atLLk5lM47kZXGN5Y9y6OXWMCgVMw0DxgTbMOY1nQmbuLLfhpyURRXQ
	rTpRTgLAQ1em4wJb73v7fnt8IQ0sPh/B8NPYGHli4ORf+BFAistCVIDxFmMVdBfN
	c6iIlqRCq75DUVhmsEsYZv2CkleKdD1KqPb9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E06977409;
	Tue, 25 Mar 2014 13:02:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 703AB77407;
	Tue, 25 Mar 2014 13:02:26 -0400 (EDT)
In-Reply-To: <CACBZZX5teZuqtNkPT4PdXJn=g34cOhRH2oNehROT8kJ_M2cgfg@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 24 Mar
 2014 22:21:03
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3DD6E9F6-B43F-11E3-B983-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245044>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> 1) Introduce '--borrow' to `git-fetch`.  This would behave similarly
> to '--reference', except that it operates on a temporary basis, and
> does not assume that the reference repository will exist after the
> operation completes, so any used objects are copied into the local
> objects database.  In theory, this mechanism would be distinct from
> --reference', so if both are used, some objects would be copied, and
> some objects would be accessible via a reference repository reference=
d
> by the alternates file.
>
> Isn't this the same as git clone --reference <path> --no-hardlinks
> <url> ?
>
> Also without --no-hardlinks we're not assuming that the other repo
> doesn't go away (you could rm-rf it), just that the files won't be
> *modified*, which Git won't do, but you could manually do with other
> tools, so the default is to hardlink.

I think that the standard practice with the existing toolset is to
clone with reference and then repack.  That is:

    $ git clone --reference <borrowee> git://over/there mine
    $ cd mine
    $ git repack -a -d

And then you can try this:

    $ mv .git/objects/info/alternates .git/objects/info/alternates.disa=
bled
    $ git fsck

to make sure that you are no longer borrowing anything from the
borrowee.  Once you are satisfied, you can remove the saved-away
alternates.disabled file.
