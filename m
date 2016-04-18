From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/6] verify-tag: add sha1 argument to verify_tag()
Date: Mon, 18 Apr 2016 13:28:38 -0700
Message-ID: <xmqqoa964q6h.fsf@gitster.mtv.corp.google.com>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
	<1460932021-27633-5-git-send-email-santiago@nyu.edu>
	<CAPig+cSGR-AZPzPRenm8RkOa7XpUOqMAgUw_8p-OUL=qP0Hy6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Santiago Torres <santiago@nyu.edu>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 22:28:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asFmp-00055N-U6
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 22:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbcDRU2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 16:28:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751342AbcDRU2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 16:28:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5A4714D9B;
	Mon, 18 Apr 2016 16:28:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=00WfVATmcBzbWJ0B59DAYYPy7Dk=; b=SdvPcz
	TLKW3U1JLeq8IQn8D0ZPrl/XPoDvV97LwYuFWcrPj/y6Wv+So/3XO/mpcfOA7iEj
	wBKbTNtqGbM/aYC/VLp04iKCzwYZYqbLajh1GvKgiUPAU05GYwuG4Q7JCxdf7tYx
	2aAo5Ar+pRL7PyWMf6JK5l3p/PiUrncsbUX1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PiOsHqTxdBXjQKJ3RojlUP8/WpHJQ/+Q
	3ZHFb2wbSHySU6826pt+lVe9NUHFFj746qRZ3kAd08xPrcWiA9tZunwQvy2yhX0/
	+wN5NXx3tgpBLiz7rPYWSMwSPOawBV0VGP0PoN+biC3PPU/NqQ+fVd7AQP9pBCjr
	kap/GrQwa2Y=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABD2E14D9A;
	Mon, 18 Apr 2016 16:28:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E52E114D99;
	Mon, 18 Apr 2016 16:28:40 -0400 (EDT)
In-Reply-To: <CAPig+cSGR-AZPzPRenm8RkOa7XpUOqMAgUw_8p-OUL=qP0Hy6w@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 18 Apr 2016 13:41:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 237CFEB6-05A4-11E6-9071-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291824>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Apr 17, 2016 at 6:26 PM,  <santiago@nyu.edu> wrote:
>> verify-tag: add sha1 argument to verify_tag()
>
> Mentioned previously[1]: This subject is talking about low level
> details of the change rather than giving a high-level overview. A
> suggested replacement[1] would be:
>
>     verify-tag: prepare verify_tag() for libification
>
>> The current interface of verify_tag() resolves reference names to SHA1,
>> which might be redundant as future callers may resolve the refname to
>> SHA1 beforehand.
>
> There is no mention here that the plan is to libify verify_tag() and
> "might be redundant" is a somewhat weak way to argue in favor of this
> change. The commit messages proposed in the previous review[1] was
> more explicit:
>
>     verify_tag() accepts a tag name which it resolves to a SHA1
>     before verification, however, the plan is to make this
>     functionality public and it is possible that future callers will
>     already have a SHA1 in hand. Since it would be wasteful for them
>     to supply a tag name only to have it resolved again, change
>     verify_tag() to accept a tag SHA1 rather than a name.

Phrased that way, it is not "might be redundant" that this change is
fixing, and "It is possible ... will already have" is still weak.  I
think the real reason for this change is that some future callers
may only have object name without the end-user supplied textual
input, and the current interface that takes strings is cumbersome
for them to use--they have to use sha1_to_hex() only so that the
callee can do get_sha1() on it.

I guess with 's/already/only/', your version is good.

By the way, it can also be read in a negative way: "Some current
callers may let this function resolve tagname, but they no longer
can rely on it, as we force them to resolve before we allow them to
call this function."

>> Add a SHA1 parameter to use instead of the name parameter. We also
>> replace the name argument to report_name and use it for error reporting
>> only.

I know I am to blame, but perhaps "reported_name" or
"name_to_report"?  "report_name" sounds as if it is a boolean that
tells the function to report the name of the tag (as opposed to stay
silent).

I agree all the clean-up points in the code part of your review.

Thanks.

> The patch itself looks okay, though see a few nits below (which may
> not be worth a re-roll).
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/290829
>
>> Signed-off-by: Santiago Torres <santiago@nyu.edu>
>> ---
>> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
>> @@ -80,6 +79,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>>  {
>>         int i = 1, verbose = 0, had_error = 0;
>>         unsigned flags = 0;
>> +       unsigned char sha1[20];
>> +       const char *name;
>
> Nit: These could have been declared in the scope of the while-loop
> (below) since you've added braces to it.
>
>> @@ -96,8 +97,14 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>> -       while (i < argc)
>> -               if (verify_tag(argv[i++], flags))
>> +       while (i < argc) {
>> +               name = argv[i++];
>> +               if (get_sha1(name, sha1)) {
>> +                       error("tag '%s' not found.", name);
>>                         had_error = 1;
>
> These lines could be combined:
>
>     had_error = !!error("tag '%s' not found.", name);
>
> which would allow you to drop the braces.
>
>> +               }
>> +               else if (verify_tag(sha1, name, flags))
>> +                       had_error = 1;
>
> Style: cuddle '}' and else:
>
>     } else
>
>> +       }
>>         return had_error;
>>  }
