From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-options: fix the description of defval
Date: Sun, 29 Mar 2015 10:39:10 -0700
Message-ID: <xmqqsicnya81.fsf@gitster.dls.corp.google.com>
References: <E8C3474A-5A3A-4A51-A798-84FB9AD46A9F@gmail.com>
	<CACRoPnTjAu_pyPp2TXZGou=H8mkXBmQqgxGNusjW6u8peEfw6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivan Ukhov <ivan.ukhov@gmail.com>, Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 19:40:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcHBF-0000Ri-0U
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 19:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbbC2RjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 13:39:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752213AbbC2RjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2015 13:39:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D81874242B;
	Sun, 29 Mar 2015 13:39:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=klbxn7aIk/vL4Df3ZmsIZ3mzhOs=; b=VysAIC
	a+dQcsxPo15G4YbRErlzDTRplV8N43rJnDiluiH/VxK2rYVFrsPygcz5faRiddLz
	BnJQmQ5zS0Id1M2WWJnzwPRQbwBjiKz8xcX0GHe8BzCrsfEfD0mXOVsPsRVZaaek
	uyMjQQ+fCUxr136bMtx5L7UWu3NihT/aJ5Q+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RjJQFaXXrqeSvJZsXKOxBF5Y/9ZnhPJT
	i2onw5l5eK7Ej+PfYwqCQMLojWmuLFXY7xMfRTxx9t+bavE1kVzxxrVblSJv6/1K
	a0NVaz7cgbqEnh9mre1BRWm6E1Scc0/TwDSm7zVqRU2XFaKrldcxrAY2+HTw81dM
	GPBHv1Kefo4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D00654242A;
	Sun, 29 Mar 2015 13:39:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4FFF342429;
	Sun, 29 Mar 2015 13:39:11 -0400 (EDT)
In-Reply-To: <CACRoPnTjAu_pyPp2TXZGou=H8mkXBmQqgxGNusjW6u8peEfw6Q@mail.gmail.com>
	(Paul Tan's message of "Sun, 29 Mar 2015 17:08:54 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 82799108-D63A-11E4-BAA3-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266441>

Paul Tan <pyokagan@gmail.com> writes:

> On Sun, Mar 29, 2015 at 4:32 PM, Ivan Ukhov <ivan.ukhov@gmail.com> wrote:
>> Since the deletion of OPT_SET_PTR, defval can no longer contain a pointer.
>>
>
> Actually, it can contain a pointer for OPTION_CMDMODE, OPTION_STRING
> and OPTION_FILENAME. Since we are on the topic of updating the
> documentation, I think it would be great if the documentation
> mentioned these option types as well.

Actually, both of you are correct ;-)

The patch text you are responding to is not saying anything wrong.
The only thing Ivan stated incorrectly is the log message.

    parse-options.h: OPTION_{BIT,SET_INT} do not store pointer to defval

    When 20d1c652 (parse-options: remove unused OPT_SET_PTR,
    2014-03-30) removed OPT_SET_PTR, the comment in the header that
    describes what the option did to defval field was left behind by
    mistake.  Remove it.

or something, perhaps?

It is a different issue if we want to describe uses of `defval` by
all other macros like OPTION_STRING.  We should make it easier for
our contributors (me included) to find how each option macros can be
used, and how OPTION_XYZ uses defval must be described somewhere,
but I personally think bloating the description of `defval` is not a
good way to do so.  Description of OPTION_XYZ may be the first place
for programmers to go to find how it should be used, so perhaps it
is a better idea to enrich descriptions there instead of here.

In other words, it may be an improvement to say only the general
principle shared across all uses e.g. "default value to fill .value
with", without mentioning specifics of exceptions (e.g. "for
OPTION_BIT it is not even a default, it is _the_ value") in this
section.  Instead, comment OPTION_BIT with "the defval field is used
to store the bitmask used to set/clear/flip" or something.

But as I said, that is a different issue.

> diff --git a/parse-options.h b/parse-options.h
> index 7940bc7..c71e9da 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -95,8 +95,7 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
>   *
>   * `defval`::
>   *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
> - *   OPTION_{BIT,SET_INT} store the {mask,integer,pointer} to put in
> - *   the value when met.
> + *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the value when met.
>   *   CALLBACKS can use it like they want.
>   */
