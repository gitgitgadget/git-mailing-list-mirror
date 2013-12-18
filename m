From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -A fails in empty repository since 1.8.5
Date: Wed, 18 Dec 2013 12:57:06 -0800
Message-ID: <xmqqhaa5ho7x.fsf@gitster.dls.corp.google.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
	<CALWbr2wXxSU4qD_Gj5P7aYxB39tEVBa-TDALVepuwZLh+RNU1Q@mail.gmail.com>
	<CACsJy8DY7eZm7-P=azJF-jEiBKM_QPf_GXG3uzbuw5C1vq1Q5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 21:57:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtOBI-00032H-LT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 21:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab3LRU5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 15:57:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988Ab3LRU5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 15:57:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BA7458873;
	Wed, 18 Dec 2013 15:57:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XswlpAQ509HZmxkUGN9+n+/NfLo=; b=aSPRG0
	HKS2fd+yT9F7tfPoEDTV77uFECjPn61ol/BrKQwaaqTCNPXQ2FyznQg6OSY0X9pd
	6ou2m78YjNea7dwNEikjxPBSRsHuPE6xPKbFbq70lSag5w7L8nORNwCtvuE7y52r
	JddmpVs1S5IS6vzNGWRbxG6GhcDpYMbJInCp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DMOH4F6KNsdZwqbU9eeaxx0AEvsecqj0
	5Red5nX0dAaMwGZ+uikJIY8SqVpzS8fGWUhwai8GH8GHdxXYZ7K4EjBK8sRxWsbk
	7oCJaHMEXK7dbCkUR0V9EW96ae9IvViwh6zstGFlz6zehqsHEb2ctVQwQevR2f/5
	fl3c0NE3XRo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B08D858872;
	Wed, 18 Dec 2013 15:57:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C988F5886F;
	Wed, 18 Dec 2013 15:57:08 -0500 (EST)
In-Reply-To: <CACsJy8DY7eZm7-P=azJF-jEiBKM_QPf_GXG3uzbuw5C1vq1Q5A@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 18 Dec 2013 18:59:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F583C82C-6826-11E3-99CF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239485>

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
>
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

Isn't that pathspec.raw[i][0] check merely an attempt to work around
the combination of

 (1) "the current directory" pathspec "." is sanitized down to an
     empty string by the pathspec code; and

 (2) even though file_exists() is willing to say "yes" to a non-file
     (namely, a directory), it is not prepared to take an empty
     string resulting from (1) to mean "the directory .".

> Adding it back requires some thinking because "path" in the new code
> could be something magic..

Ehh, why?  Shouldn't "something magic" that did _not_ match
(i.e. not in seen[]) diagnosed as such?

I am wondering why we even need !file_exists(path) check there in
the first place.  We run fill_directory() and then let
prune_directory() report which pathspec did not have any match via
the seen[] array.  We also match pathspec against the index to see
if there are pathspec that does not match anything.  So at that
point of the codeflow, we ought to be able to make sure that seen[]
is the _only_ thing we need to consult to see if there are any
pathspec elements that did not match.

Stepping back even further, I wonder if this "yes, I found a
matching entity and know this is not an end-user typo" bit actually
should be _in_ "struct pathspec".  Traditionally we implemented that
bit as a separate seen[] array parallel to "const char **pathspec"
array, but that was merely because we only had the list of strings.
Now we express a pathspec as a list of "struct pathspec" elements,
I think seen[] can and should become part of the pathspec.  Am I
missing something?


> and the new behavior makes sense, so I'm
> inclined to keep it as is, unless people have other opinions.
>
>>>
>>> [1] https://groups.google.com/d/topic/git-users/Qs4YSPhTsqE/discussion
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
