From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -A fails in empty repository since 1.8.5
Date: Wed, 18 Dec 2013 10:54:50 -0800
Message-ID: <xmqqioumhtvp.fsf@gitster.dls.corp.google.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
	<CALWbr2wXxSU4qD_Gj5P7aYxB39tEVBa-TDALVepuwZLh+RNU1Q@mail.gmail.com>
	<CACsJy8DY7eZm7-P=azJF-jEiBKM_QPf_GXG3uzbuw5C1vq1Q5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 19:55:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtMGr-0003UA-Ro
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 19:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051Ab3LRSy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 13:54:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab3LRSyz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 13:54:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C6715AFD7;
	Wed, 18 Dec 2013 13:54:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XQVKdTGgflkDj89641VwXqZRai4=; b=sY5Ieq
	M7+0OALGhc+Cl4bis0+WrG8RkxT5s5Id0N6kyrHMapFPVnzF6uge0qku8kO4rjkl
	4D0KGkad62GaxbD75IeJ+CSM4uXHOfLcMlyMRcxgZsS3RTu/BQn+PODHy5e70bVV
	QP+8GEPZ/FVLOkOqVmOV1mJCDvvXKuymAw8p0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=opZR/23npY/aN4Om/Hzrw4/0G2KMyxJ/
	jxhPZWT56Swu4l6yKpOwjPQfDhBnfC/YAb5oOT+39UWpilxV0inmqu5vz/skGtGg
	KkNVfNqSCjyc5PfRoInQMkp+3SCjhfx+4mkfZail+gEp8RCybbX6RgaP4xvbHlMH
	7wMHTIz0Bsw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 316025AFD6;
	Wed, 18 Dec 2013 13:54:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32DA55AFD4;
	Wed, 18 Dec 2013 13:54:52 -0500 (EST)
In-Reply-To: <CACsJy8DY7eZm7-P=azJF-jEiBKM_QPf_GXG3uzbuw5C1vq1Q5A@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 18 Dec 2013 18:59:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E08CEFC2-6815-11E3-BA23-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239468>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Dec 18, 2013 at 3:44 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> FWIW, git-bisect points to 84b8b5d (that is $gmane/230349).
>>
>> On Wed, Dec 18, 2013 at 9:06 AM, Thomas Ferris Nicolaisen
>> <tfnico@gmail.com> wrote:
>>> This was discussed on the Git user list recently [1].
>>>
>>> #in a repo with no files
>>>> git add -A
>>> fatal: pathspec '.' did not match any files
>>>
>>> The same goes for git add . (and -u).
>>>
>>> Whereas I think some warning feedback is useful, we are curious
>>> whether this is an intentional change or not.

The logic to produce that error message is primarily to catch a typo
like:

	$ git add Nakefile

when the user meant to say Makefile.

It could be argued that a "git add [<any option>] .", with an
explicit "." given by the end-user, that is run in an empty
directory may be an error worth reporting.  Just like it is likely
for the user to have wanted to add some other file when he typed
Nakefile and it is not good to silently decide "ah, nothing matches
the pathspec, so not adding anything is the right thing to do" in
such a case, it is plausible that the user thought that he was in
some other directory he wanted to add its contents to the index when
he gave us the explicit ".", while he was in fact in a wrong
directory, and it is not good to silently decide "nothing there to
add so I won't do anything" without any indication of an error.

We should *not* error out "git add [<any option>]" without any
end-user pathspecs, especially with that error message, on the other
hand.

> I was not aware of this case when I made the change. It's caused by
> this change that removes pathspec.raw[i][0] check in builtin/add.c in
> 84b8b5d .
>
> -               for (i = 0; pathspec.raw[i]; i++) {
> -                       if (!seen[i] && pathspec.raw[i][0]
> -                           && !file_exists(pathspec.raw[i])) {
> +               for (i = 0; i < pathspec.nr; i++) {
> +                       const char *path = pathspec.items[i].match;
> +                       if (!seen[i] && !file_exists(path)) {
>
> Adding it back requires some thinking because "path" in the new code
> could be something magic.. and the new behavior makes sense, so I'm
> inclined to keep it as is, unless people have other opinions.
>
>>>
>>> [1] https://groups.google.com/d/topic/git-users/Qs4YSPhTsqE/discussion
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
