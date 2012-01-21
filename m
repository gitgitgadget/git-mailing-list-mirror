From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sat, 21 Jan 2012 14:56:22 -0800
Message-ID: <7vsjj8acmh.fsf@alter.siamese.dyndns.org>
References: <201201212036.57632.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 21 23:56:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RojrL-00082z-0i
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 23:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab2AUW40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Jan 2012 17:56:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab2AUW4Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2012 17:56:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60EC57877;
	Sat, 21 Jan 2012 17:56:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=InEdOAYB5Lb8
	fLaL/FrzWob1hUk=; b=JsM3R6q2OWyujCcshtaVPEuT87qncXFM5mDGrjWhvZA+
	EnOBWKsUtDDQiJZEXH4gxxddf1ww5hD7vEzidC14OUbGdmH4IcBqcxi4d6ltU3k4
	i0NRITF1I7ntT9166H0qvudsJ5WLs0NYAvJricD5CWK+TFJ83YIa31e0CH4FZlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EmoXWm
	ks0T/jfz2cv5l1s5p8OyepSl7noxRqNcD/b3E+cb/CGrL3NS8nmN/xeL3RNosKYw
	XnB5pRBpr3VsxlyjHU8wp+QJPsZEuJT7SwlencR/HBTNUWyqiQDkjywt0ewQzU3h
	kkffTuRGc+NSxv4E4w7yXBmoC9RPIa2yVEsOQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57D5D7876;
	Sat, 21 Jan 2012 17:56:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF7BD7875; Sat, 21 Jan 2012
 17:56:23 -0500 (EST)
In-Reply-To: <201201212036.57632.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sat, 21 Jan 2012 20:36:56
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 244848BE-4483-11E1-86F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188940>

[Pinging Nguyen who has worked rather extensively on the start-up seque=
nce
for ideas.]

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

I'll try to reword the log message a bit below.

> When a file called "LATIN CAPITAL LETTER A WITH DIAERESIS" (in utf-8
> encoded as 0xc3 0x84) is created, the Mac OS filesystem converts
> "precomposed unicode" into "decomposed unicode". readdir() will retur=
n
> 0x41 0xcc 0x88 for such a file, that does not match what the caller
> thought it created.
>
> To work around this braindamage, allow git on Mac OS to optionally us=
e a
> wrapper for readdir() that converts decomposed unicode back into the
> precomposed form, which most other platforms use natively. This makes=
 it
> easier for Mac OS users to work together on the same project with peo=
ple
> on other platforms (Note that not all Windows versions support UTF-8
> yet. Msysgit needs the unicode branch, cygwin supports UTF-8 since
> 1.7). This allows sharing git repositories stored on a VFAT file syst=
em
> (e.g. a USB stick), and mounted network share using samba.
>
> This new feature is controlled by setting a new configuration variabl=
e
> "core.precomposedunicode" to "true". Unless the variable is set to "t=
rue",
> Git on Mac OS behaves exactly as before, for backward compatiblity.
>
> The code in compat/precomposed_utf8.c implements basically 4 new
> functions: precomposed_utf8_opendir(), precomposed_utf8_readdir(),
> precomposed_utf8_closedir() precompose_argv()
>
> In order to prevent that ever a file name in decomposed unicode is
> entering the index, a "brute force" attempt is taken: all arguments i=
nto
> git (argv[1]..argv[n]) are converted into precomposed unicode.  This =
is
> done in git.c by calling precompose_argv().  This function is actuall=
y a
> #define, and it is only defined under Mac OS.  Nothing is converted o=
n
> any other platforms.

It may be just me, but the above looks more in line with the usual styl=
e
of writing in our existing log messages.

Is this UTF-8 decomposition only an issue on HFS+, or does it happen on
any filesystem mounted on a MacOS box? If the former, then the second l=
ine
of the first paragraph needs further rephrasing, e.g. "... is created,
HFS+, the primary filesystem on the Mac OS, converts ...".

> Auto sensing:
> When creating a new git repository with "git init" or "git clone",
> "core.precomposedunicode" will be set "false".
>
> The user needs to activate this feature manually.
> She typically sets core.precomposedunicode to "true" on HFS and VFAT,
> or file systems mounted via SAMBA onto a Linux box.

I am not sure about this design decision.

I agree that it is prudent to introduce a new feature disabled by defau=
lt,
and I can understand that you tried to make the feature more discoverab=
le
by setting it explicitly to "false".

But I do not think it is a good idea. If a user is on MacOS and has onl=
y
HFS+, then it would be more convenient to have the configuration set to
true in $HOME/.gitconfig once and for all, to affect all repositories o=
n
the box. "git init" dropping the explicit "false" to any new repositori=
es
defeats that.

Wouldn't it make more sense if your "git init" did it this way?

    * Do not do anything, if you know core.precomposedunicode is alread=
y
      set (in /etc/gitconfig or $HOME/.gitconfig);

    * Otherwise, if the "probe" says "yes, we are on HFS+", issue an
      advice message to suggest the user to set it either in the
      repository specific .git/config or in $HOME/.gitconfig file.

> +core.precomposedunicode::
> +	This option is only used by Mac OS implementation of git.
> +	When core.precomposedunicode=3Dtrue,
> +	git reverts the unicode decomposition of filenames done by Mac OS.
> +	This is useful when pulling/pushing from repositories containing ut=
f-8
> +	encoded filenames using precomposed unicode (like Linux).

I would imagine that if the caller of creat(2) named the path in the
decomposed form, Mac OS would store it unaltered; strictly speaking, we
shouldn't say "reverts". How about:

    When set to true, pathnames in decomposed UTF-8 read from the
    filesystem are converted to precomposed UTF-8 before they are used =
by
    Git, to improve interoperability with other platforms.

> +void precompose_argv(int argc, const char **argv)
> +{
> +	int i =3D 0;
> +	const char *oldarg;
> +	char *newarg;
> +	iconv_t ic_precompose;
> +
> +	git_config(precomposed_unicode_config, NULL);

As the first thing called after main(), I still doubt this is a safe th=
ing
to do (Pinging Nguyen who has worked rather extensively on the start-up
sequence for ideas). This is ifdefed away and will not break things on
other platforms, which may make it even harder to diagnose breakages.
