From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 5/9] builtin/notes: Simplify early exit code in add()
Date: Tue, 11 Nov 2014 07:53:02 -0800
Message-ID: <xmqqvbml7mzl.fsf@gitster.dls.corp.google.com>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
	<1415536255-19961-6-git-send-email-johan@herland.net>
	<xmqqmw7y94jm.fsf@gitster.dls.corp.google.com>
	<CALKQrgdBhm91tipHRQ3sF_DacSh5nRJmS7eP4S5Z4vB8R8O4_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 16:53:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoDkm-0005Xg-OX
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 16:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbaKKPxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 10:53:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752307AbaKKPxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 10:53:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C4FF1B2CE;
	Tue, 11 Nov 2014 10:53:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EXSHm6kiRIu7W7UJMeUpShzRNiY=; b=bm4Md4
	nFC3R+dIoR3bE7k3YW0TInxX/YbGGWud1T9EOM6ZN9MC4eVuBY+2HxPtI6zuT2Tj
	9UiL68BtoiFI12+WCWaaazU0iAcmJNtp9eo0uFftZFdVCtSJe9AfVT030a43c26H
	31vleJWggpwuJ8chEIMaMOqca5u2oiy60M6e0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DKBd1mGQOnc0cUl2Yma11S11q8PIEPAJ
	ttP6FO3Qn36m+P6p5nbUY8cRT6qdQkNOWn4wwnK/lbMWQ/HHrHFHuxezoN2D2+Iz
	cdoH0l8nI0mqF//rTzdMvLY+Me5UFcJgx7t32/CfiZOgl7wXatzpQdm1qVAp+BIS
	jn3vDAsLJvk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 627461B2CC;
	Tue, 11 Nov 2014 10:53:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D84EC1B2CB;
	Tue, 11 Nov 2014 10:53:03 -0500 (EST)
In-Reply-To: <CALKQrgdBhm91tipHRQ3sF_DacSh5nRJmS7eP4S5Z4vB8R8O4_w@mail.gmail.com>
	(Johan Herland's message of "Tue, 11 Nov 2014 01:49:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D237512C-69BA-11E4-AAF7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> On Mon, Nov 10, 2014 at 9:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>
>>> Signed-off-by: Johan Herland <johan@herland.net>
>>> ---
>>>  builtin/notes.c | 12 +++++-------
>>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/builtin/notes.c b/builtin/notes.c
>>> index 1017472..f1480cf 100644
>>> --- a/builtin/notes.c
>>> +++ b/builtin/notes.c
>>> @@ -399,7 +399,7 @@ static int append_edit(int argc, const char **argv, const char *prefix);
>>>
>>>  static int add(int argc, const char **argv, const char *prefix)
>>>  {
>>> -     int retval = 0, force = 0;
>>> +     int force = 0;
>>>       const char *object_ref;
>>>       struct notes_tree *t;
>>>       unsigned char object[20], new_note[20];
>>> @@ -441,6 +441,8 @@ static int add(int argc, const char **argv, const char *prefix)
>>>
>>>       if (note) {
>>>               if (!force) {
>>> +                     free_note_data(&d);
>>> +                     free_notes(t);
>>>                       if (!d.given) {
>>
>> It looks a bit strange to refer to d.given after calling a function
>> that sounds as if it is meant to clear what is recorded in and to
>> invalidate &d; yes, I can read the implementation to see that
>> d.given keeps its stale value, but that is something other people
>> may want to "clean up" later and this reference to d.given will get
>> in the way when that happens.
>
> Yes, that was obviously an oversight on my part.
>
>> At this point of the code, it makes sense to free t in preparation
>> to either switching to append codepath or erroring out, but does &d
>> have anything in it already to necessitate its freeing?
>
> Actually, no, although verifying that required double-checking that
> each of the -m/-F/-c/-C parsers which store data into &d, do in fact
> set d.given.
>
> I suggest to either move the free_note_data(&d) call below the "if
> (!d.given)" block, or reorganize into this (which at the moment reads
> better to me):
>
>     if (note) {
>         if (!force) {
>             free_notes(t);
>             if (d.given) {
>                 free_note_data(&d);
>                 return error(_("Cannot add notes. "
>                     "Found existing notes for object %s. "
>                     "Use '-f' to overwrite existing notes"),
>                     sha1_to_hex(object));
>             }
>             /*
>              * Redirect to "edit" subcommand.
>              *
>              * We only end up here if none of -m/-F/-c/-C or -f are
>              * given. The original args are therefore still in
>              * argv[0-1].
>              */
>             argv[0] = "edit";
>             return append_edit(argc, argv, prefix);
>         }
>         fprintf(stderr, _("Overwriting existing notes for object %s\n"),
>             sha1_to_hex(object));
>     }
>
> This keeps the two free_* calls close together, only separated by if
> (d.given), which nicely indicates whether we need to call
> free_notes_data(&d) at all.
>
> If that looks good to you, do you want a re-roll, or is it easier to
> fix up yourself?

I strongly prefer reroll for anything bigger than single-line tweaks
to avoid mistakes.

Thans.
