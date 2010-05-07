From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Fri, 7 May 2010 22:15:18 +0000
Message-ID: <AANLkTinCaPrThtuQd7tUFxNNn9KUx9v3_PXnH_6C8yco@mail.gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
	 <1273180440-8641-1-git-send-email-avarab@gmail.com>
	 <m3k4rfe90n.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 00:15:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAVpN-00055Z-Bp
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 00:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab0EGWPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 18:15:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48821 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab0EGWPT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 18:15:19 -0400
Received: by gwj19 with SMTP id 19so941134gwj.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 15:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uYYsrHZhB90CrvqZa7/5OqJ0qynGp3b61J/U6ToOoLY=;
        b=AuugKMnAlfcgDDXCJiI9UUWhcskm3J6RKSXDUlYcm9y4bhqbPBjlk/IbAAKVcOI6LV
         cKP/cR7Z27URY7HpmbS3FQefjCnGNUIONXhb5xoRRlJZ51T2XyhHd51hPxqJxr16i33U
         BC+NT0LVERFYBiSfhKXzT9P++MjG6Q4oc7QUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F/VcZj7uOJf5gza7LP/rYqpEs8ZOViv91tJa8mg442PyrRNqvuCpwTj/w8Oh0rsqrN
         VIs+roMxTjYxWWYJKnqERe+IqfR5XQ9T1xi337Ak1NRb/Jt0SwjFDG49nYpepIZXyH5j
         2Rlk+hDfDYRyE12dYUEc/KwYFobNoWrGJ4ukI=
Received: by 10.231.166.8 with SMTP id k8mr172016iby.93.1273270518584; Fri, 07 
	May 2010 15:15:18 -0700 (PDT)
Received: by 10.231.160.11 with HTTP; Fri, 7 May 2010 15:15:18 -0700 (PDT)
In-Reply-To: <m3k4rfe90n.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146610>

On Fri, May 7, 2010 at 20:46, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> This is not ready for inclusion in anything. Commiting for RFC on
>> whether this way of doing it is sane in theory.
>
> I think this is a good idea at least in theory.

Thanks, and thanks for all your comments below. They were very useful.

>> Known bugs:
>>
>> =C2=A0 * Breaks the model of being able to *set* config values. That
>> =C2=A0 =C2=A0 doesn't work for the included files. Maybe not a bug.
>
> Errr... do I understand correctly that it simply means that you are
> not able to set config values that came from included files, in
> included files?
>
> This is quite serious limitation.

It is. And recap, you can now you can set Git's config in either
places .git/config, ~/.gitconfig and $prefix/etc/gitconfig.

With inclusion this is a bit more complex. If my ~/.gitconfig includes
a seekrt.key=3Dfoobar via an include in ~/.gitconfig/seekrt, what shoul=
d
`git config --global seekrt.key newkey` do? How about `git config
--global seekrt.some_new_value blah`?

I think it's best to not try to get into that mess and just let the
user manage included files manually, or with `git config --file`.

>> =C2=A0 * Errors in the git_config_from_file() call in glob_include_c=
onfig()
>> =C2=A0 =C2=A0 aren't passed upwards.
>
> Hmmm...
>
>>
>> =C2=A0 * It relies on the GNU GLOB_TILDE extension with no
>> =C2=A0 =C2=A0 alternative. That can be done by calling getenv("HOME"=
) and
>> =C2=A0 =C2=A0 s/~/$home/.
>
> "git config --path <variable>" expands leading '~' to $HOME, and ~use=
r
> to home directory of given user. =C2=A0Why not use this?

I didn't spot it. expand_user_path() does do everything I need,
yippie! I'll use that then.

>> =C2=A0 * The whole bit with saving/restoring global state for config
>> =C2=A0 =C2=A0 inclusion is evil, but then again so is the global sta=
te.
>
> Why not encapsulate those global variables in a struct, passed to
> appropriate functions, with a global variable holding an instance of
> such struct (IIRC similarly to what is done for "the_index").

That's indeed the sane way to go. I'll do that (and look at
the_index).

>> =C2=A0 * We don't check for recursion. But Git gives up eventually a=
fter
>> =C2=A0 =C2=A0 after spewing a *lot* of duplicate entry errors. Not s=
ure how to
>> =C2=A0 =C2=A0 do this sanely w/symlinks.
>
> The alternates mechanism has some depth limit; why not use it also fo=
r
> config file inclusion? =C2=A0The machanism is quite similar...

Yet another example of prior art in git itself I have to check out,
thanks.

>> Not-signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
> You can simply do not add Signed-off-by for an RFC patch...
>
>> ---
>>
>> > On Sun, Apr 4, 2010 at 07:50, Eli Barzilay <eli@barzilay.org> wrot=
e:
>> > > Isn't it better to have a way to include files instead?
>> >
>> > Probably yes. Programs like Apache HTTPD, rsyslog and others just =
use
>> > ${foo}conf.d by convention by supporting config inclusion.
>>
>> Here's an evil implementation of this. I know the code is horrid &
>> buggy (see above). But is the general idea sane. I thought it would =
be
>> better to submit this for comments before I went further with it.
>>
>> =C2=A0config.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 55 +++++++++++++++++++++++++++++++++++++++++++++++-
>> =C2=A0t/t1300-repo-config.sh | =C2=A0 43 +++++++++++++++++++++++++++=
++++++++++
>> =C2=A02 files changed, 97 insertions(+), 1 deletions(-)
>
> No documentation.

A final patch will have that. Since some of the semantics are "munges
your .gitconfig" (a bug). I'll write dosc for it once it's behaving.

> [...]
>> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
>> index f11f98c..4df6658 100755
>> --- a/t/t1300-repo-config.sh
>> +++ b/t/t1300-repo-config.sh
>> @@ -824,4 +824,47 @@ test_expect_success 'check split_cmdline return=
' "
>> =C2=A0 =C2=A0 =C2=A0 test_must_fail git merge master
>> =C2=A0 =C2=A0 =C2=A0 "
>>
>> +cat > .git/config << EOF
>> +[some]
>> + =C2=A0 =C2=A0 variable =3D blah
>> +[voodoo]
>> + =C2=A0 =C2=A0 include =3D .git/more_config_*
>> +EOF
>
> I don't like this syntax.

Me neither.

> First, it forces git-config to hide all 'include' keys. =C2=A0I think=
 there
> might be some legitimate <section>.include config variables (perhaps
> outside git-core); with this patch they are impossible.

It's only hiding the full 'voodoo.include' key currently, you can
still have e.g. 'bleh.include'.

> Second, I guess that the section name has absolutely no meaning here.
> If included config file has section.key config variable, i.e.:
>
> =C2=A0[section]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0key =3D value
>
> the variable in master config file (visible by git-config) would not
> be voodoo.section.key.

No. All includes are done at the top level. The end result should be
equivalent to having used cat(1) to stitch a bunch of config files
together.

> Third, what happens with the sections in master config file? =C2=A0If=
 I
> have the following in .git/config
>
> =C2=A0[voodoo]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0var1 =3D val1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0include =3D .git/more_config
> =C2=A0 =C2=A0 =C2=A0 =C2=A0var2 =3D val2
>
> and the .git/more_config has
>
> =C2=A0[foo]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bar =3D baz
>
> would "git config --list" see 'voodoo.var2' (i.e. sections in include=
d
> file does not change parsing of master file), or would it see
> 'foo.var2'?

Only voodoo.include should be hidden, nothing else. But let's move on
to..

> I would propose
>
> =C2=A0include .git/more_config_*
>
> if not for the fast that it would trip older git. =C2=A0Perhaps

> =C2=A0## include ".git/more_config_*"

Probably not a good idea to mix up comments & configuration like
that. Some (semi-broken) parsers of .gitconfig also use INI parsers to
parse it, which breaks on # comments. Those are already broken, but it
would be nice if a feature didn't require them.

> =C2=A0[include .git/more_config_*]

Syntax error on older Gits.

> =C2=A0[include ".git/more_config_*"]

I like this one the best. It's also easy to modify the parser (so it
doesn't think it's a section) to handle it. And it doesn't incur the
confusion of looking like a normal configuration variable.
