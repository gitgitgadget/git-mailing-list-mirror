From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] add a Makefile switch to avoid gettext translation in
 shell scripts
Date: Tue, 24 Jan 2012 01:39:26 +0100
Message-ID: <CACBZZX66-JsS4zZXwv2squcjYUS8v+9cN0hv23t5nMHA+1k9XQ@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz> <7v1uqq84es.fsf@alter.siamese.dyndns.org>
 <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org> <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
 <20120123221256.GG20833@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 01:39:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpUQW-00054N-C0
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 01:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab2AXAjv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 19:39:51 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42024 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752731Ab2AXAjt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 19:39:49 -0500
Received: by lahc1 with SMTP id c1so1996713lah.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 16:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dF5Qn+vOkOhqW7Mf8CvB3MG4kn2AH3bCbgNBW4OwmyM=;
        b=YlYmfEycJ6NnR+4I4qVFfV+2KVic9P+oZP5nleM9e5b70iDEeX7HWBex+HY23vWRgG
         BTOYChrEEYJfGFIbUjhMF9vb6n50rwOikG0HuIbwUfTM084jvUKSnnnUBXTPBo0QhlR3
         na4KUegQYX/T3qbC/DZsuDYAivy80kRTNZbzk=
Received: by 10.152.144.133 with SMTP id sm5mr5387719lab.38.1327365587120;
 Mon, 23 Jan 2012 16:39:47 -0800 (PST)
Received: by 10.112.48.9 with HTTP; Mon, 23 Jan 2012 16:39:26 -0800 (PST)
In-Reply-To: <20120123221256.GG20833@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189029>

On Mon, Jan 23, 2012 at 23:12, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Junio C Hamano wrote:
>
>> =C2=A0 =C2=A0 make USE_GETTEXT_SCHEME=3Dfallthrough
>>
>> This will replace the translation routines with fallthrough versions=
,
>> that does not use gettext from the platform.
>
> Nice implementation. =C2=A0I still don't understand why NO_GETTEXT=3D=
YesPlease
> should not imply this. =C2=A0Is it to ensure the GETTEXT_SCHEME=3Dgnu=
 mode
> gets more testing?

I was the only one with an objection to doing that. The main (and I
admit, at least slightly irrational) reason being that I simply don't
like using fallback functions when the system supplies us with
perfectly good functions we can use instead.

It means we're less likely to share code / fixes / eyeballs / cache
with other programs. I.e. by using envsubst(1) instead of
git-sh-i18n--envsubst--variables(1).

Ironically this is all my fault by naming the option for turning off
translations NO_GETTEXT. What it should be called is
DO_NOT_TRANSLATE_OUTPUT, but since we *need* shell functions to output
anything it might have used a system gettext library to do that,
NO_GETTEXT should have been "I don't have any gettext library, please
supply some fallbacks".

Which would have meant that for people who simply don't want
translated output we'd be using the maintained by upstream envsubst(1)
instead of the doomed to bitrot forever hack I ripped out of some old
GPL2 version of GNU gettext.

Anyway in the grand scheme of things none of this really matters,
these patches can all go in as far as I'm concerned. I can submit
patches to improve it once the dust has settled if I still care
enough.

Aside from this I think not having the ability to run a pre-processor
on the shellscripts results in some really ugly workarounds. This
stuff would be much nicer if we could just generate git-sh-i18n.sh at
compile time depending on some autoconf tests or Makefile options.

And by hacking up a pre-processor that just searches/replaces all the
gettext/eval_gettext calls out of the shell code we could sidestep
this whole issue and there wouldn't be any need for fallback
functions, ever. This would also result in a real improvement on
Windows where exec overhead is much larger.

Like this hack, which doesn't even work, but gives you some idea of
what we could do:

    #!/usr/bin/env perl
    BEGIN { $^I =3D ""; }

    sub unescape {
    	my $str =3D shift;
    	$str =3D~ s/\\\$/\$/gs;
    	$str;
    }

    LINE: while (defined($_ =3D <ARGV>)) {
    	s["\$\(gettext "([^"]+?)"\)"]["$1"]g;
    	s["\$\(eval_gettext "([^"]+?)"\)"]['"' . unescape($1) . '"']eg;
    	s[eval_gettextln "([^"]+?)"]['echo "' . unescape($1) . '"']eg;
    	s[gettext "([^"]+?)"][printf "%s" "$1"]g;
    	s[gettextln "([^"]+?)"][echo "$1"]g;
    #	s[gettextln "([^"]+?)"][echo "$1"]g;
    #	s/foo/bar/;
    	print;

    }


When run:

    for f in $(git grep -l gettext -- *.sh); do perl replace-gettext.pl=
 $f; done

Produces output like:

    @@ -351 +351 @@ split_patches () {
    -                       clean_abort "$(eval_gettext "Patch format
\$patch_format is not supported.")"
    +                       clean_abort "Patch format $patch_format is
not supported."
    @@ -353 +353 @@ split_patches () {
    -                       clean_abort "$(gettext "Patch format
detection failed.")"
    +                       clean_abort "Patch format detection failed.=
"
    @@ -403 +403 @@ do
    -               die "$(gettext "-d option is no longer supported.
Do not use.")"
    +               die "-d option is no longer supported.  Do not use.=
"
    @@ -466 +466 @@ then
    -       die "$(eval_gettext "previous rebase directory \$dotest
still exists but mbox given.")"
    +       die "previous rebase directory $dotest still exists but mbo=
x given."

It would be relatively easy to hack up a basic POSIX shell
pre-processor like this that would work on our *.sh files, thus
eliminating the need for all of this fallback business.
