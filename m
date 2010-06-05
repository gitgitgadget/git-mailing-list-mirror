From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with 
	gettext
Date: Sat, 5 Jun 2010 16:19:33 +0000
Message-ID: <AANLkTilYD_NyIZMyj9dHtVk-ylVBfvyxpCC7982LWnVd@mail.gmail.com>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
	<1275704035-6552-2-git-send-email-avarab@gmail.com>
	<m3zkz9pols.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 18:19:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKw62-0002id-Ez
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 18:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933640Ab0FEQTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 12:19:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47909 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933617Ab0FEQTe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 12:19:34 -0400
Received: by iwn37 with SMTP id 37so2051495iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LK9PpRbXwF3T+BsI9EcRE2Ek5KEuAkV+mXCNmBn/7T8=;
        b=M4OK3PgtN/h/JiUqih+PUce6410cRCU+Nq+XQICSmRWpWi9bdcyZxom/JH9Wa1afAF
         kYoTxTFc8CY8mUrCMQjeXWzZkenzhcvVv6xKkNT28cL5x2eZMt+llubnfpZwIIe7zyKe
         4A+h7hgTzjseBMEKlNYXKVXvwi1owfBBhlLbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hC8+4ddZJiMpdEKVO6SF+K3rntDISIqmv8da6a9g0f0gY+FZ9/fjeDcBqNVcqhSjXQ
         2/Sxs7nkH/Mfcn25N5tzOWS3syIrDhftCI3gUIGjzA+koASSy74LC0RjRzpHe51Dbe/O
         /dhF4iBCDPcVkNglBO2nx0YoNfsVnWLsBJFfg=
Received: by 10.231.79.4 with SMTP id n4mr6925061ibk.16.1275754773469; Sat, 05 
	Jun 2010 09:19:33 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 5 Jun 2010 09:19:33 -0700 (PDT)
In-Reply-To: <m3zkz9pols.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148478>

On Sat, Jun 5, 2010 at 13:57, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> All of the interface messages in Git core are currently hardcoded in
>> English. Change that by optionally enabling translation of the core =
C,
>> Shell and Perl programs via GNU gettext. If you set the appropriate
>> LC_* variables Git will speak your language, provided that someone h=
as
>> submitted a translation.
> [...]
>
>> Implementation and usage notes:
> [...]
>> =C2=A0* Perl:
>>
>> =C2=A0 =C2=A0Perl code that wants to be localized should use the new=
 Git::I18n
>> =C2=A0 =C2=A0module. It imports a __ function into the caller's pack=
age by
>> =C2=A0 =C2=A0default.
>>
>> =C2=A0 =C2=A0Instead of using the high level Locale::TextDomain inte=
rface I've
>> =C2=A0 =C2=A0opted to use the low-level (equivalent to the C interfa=
ce)
>> =C2=A0 =C2=A0Locale::Messages module, which Locale::TextDomain itsel=
f uses.
>>
>> =C2=A0 =C2=A0Locale::TextDomain does a lot of redundant work we don'=
t need, and
>> =C2=A0 =C2=A0some of it would potentially introduce bugs. It tries t=
o set the
>> =C2=A0 =C2=A0$TEXTDOMAIN based on package of the caller, and has its=
 own
>> =C2=A0 =C2=A0hardcoded paths where it'll search for messages.
>
> Actually both of those can be set using Locale::TextDomain->import()
> call. =C2=A0See e.g. this answer on StackOverflow:
> =C2=A0http://stackoverflow.com/questions/2965626/examples-of-localiza=
tion-in-perl-using-gettext-and-localetextdomain-with-fallb/2967872#2967=
872
>
>> =C2=A0 =C2=A0[...] In any case, this is an issue wholly internal
>> =C2=A0 =C2=A0Git::I18N. Its guts can be changed later if that's deem=
ed
>> =C2=A0 =C2=A0necessary.
>
> Right.

Locale::TextDomain's interface simply does more than
Locale::Messages. And since I'm trying to present exactly the same
interface to C, Shell and Perl any code that uses it has to spend
effort on disabling its features.

E.g.

  * No I don't want a tied hash (yes, I know I don't have to export it
    in turn):

        BEGIN {
            # Tie the hash to gettext().
            tie %__, '__TiedTextDomain', \&__tied_gettext;
            $__ =3D \%__;

  * I *only* want our TEXTDOMAINDIR, not this. And there's no way to
    turn it off:

    	# Add default search directories, but only if they exist.
    	for my $dir (qw (/usr/share/locale /usr/local/share/locale)) {
            if (-d $dir) {
                @default_dirs =3D ($dir);

  * I also don't want to search for locale files in Perl's @INC, or
    $textdomaindir/LocaleData:

        unless (exists $bound_dirs{$textdomain}) {
    		@search_dirs =3D map $_ . '/LocaleData', @INC, @default_dirs
    			unless @search_dirs;
    		$bound_dirs{$textdomain} =3D [@search_dirs];

  * Here's what the normal functions look like. Since caller() will be
    the top-level caller and not Git::I18N (unless I define a wrapper
    function, which Git::I18N doesn't do) I'd have to take measures to
    set the textdomain for the importer's package as well as my own:

        # Normal gettext.
        sub __ ($)
        {
            my $msgid =3D shift;
            my $package =3D caller;

     And that sub does this:

        __find_domain $textdomain if
    		defined $textdomain && defined $bound_dirs{$textdomain};

  * Which again bypasses what I just want to do with bindtextdomain():

        sub __find_domain ($)
        {
        	my $domain =3D shift;
        =09
        	my $try_dirs =3D $bound_dirs{$domain};
        =09
        	if (defined $try_dirs) {
        		my $found_dir =3D '';
        	=09
        		TRYDIR: foreach my $dir (map { abs_path $_ } grep { -d $_ }
@$try_dirs) {
        			# Is there a message catalog?  We have to search recursively
        			# for it.  Since globbing is reported to be buggy under
        			# MS-DOS, we roll our own version.
        			local *DIR;
        			if (opendir DIR, $dir) {
        				my @files =3D map { "$dir/$_/LC_MESSAGES/$domain.mo" }
        					grep { ! /^\.\.?$/ } readdir DIR;

        				foreach my $file (@files) {
        					if (-f $file || -l $file) {
        						# If we find a non-readable file on our way,
        						# we access has been disabled on purpose.
        						# Therefore no -r check here.
        						$found_dir =3D $dir;
        						last TRYDIR;
        					}
        				}
        			}
        		}
        	=09
        		# If there was no success, this will fall back to the default=
 search
        		# directories.
        		bindtextdomain $domain =3D> $found_dir;

  * That'll only happen on the first invocation though, later it'll
    just skip that and do:

        dgettext $textdomain =3D> $msgid;

None of this is a showstopper. It's just more code to test, override
and stuff that can go wrong.

It doesn't make any sense to use it when all I want is simply
bindtextdomain(git =3D> $dir) && gettext($msgid).

>> --- a/INSTALL
>> +++ b/INSTALL
>> @@ -93,6 +93,14 @@ Issues of note:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 history graphically, and in git-gui. =C2=
=A0If you don't want gitk or
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 git-gui, you can use NO_TCLTK.
>>
>> + =C2=A0 =C2=A0 - The GNU "libintl" library is used by default for l=
ocalizing
>> + =C2=A0 =C2=A0 =C2=A0 Git. It needs a gettext.h on the system for C=
 code, gettext.sh
>> + =C2=A0 =C2=A0 =C2=A0 for shell scripts, and libintl-perl for Perl =
programs.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 Set NO_GETTEXT to disable localization suppor=
t and make Git only
>> + =C2=A0 =C2=A0 =C2=A0 use English. Under autoconf the configure scr=
ipt will do this
>> + =C2=A0 =C2=A0 =C2=A0 automatically if it can't find libintl on the=
 system.
>> +
>
> Shouldn't you also add here that you need also "libintl-perl" to have
> those commands that are written in Perl localized?

I pondered it, it's it's documented in the INSTALL file, but all the
comments in the Makefile are pertinent only to compiling the C code.

Since libintl-perl isn't a compilation requirement, or anything you
need to worry about when running make I didn't add it in the Makefile
comments.

>> diff --git a/Makefile b/Makefile
>> index d5d6565..3040000 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -28,6 +28,15 @@ all::
>> =C2=A0# Define NO_EXPAT if you do not have expat installed. =C2=A0gi=
t-http-push is
>> =C2=A0# not built, and you cannot push using http:// and https:// tr=
ansports.
>> =C2=A0#
>> +# Define NO_GETTEXT if you don't want to build with Git with gettex=
t
>> +# support. Building it requires GNU libintl, and additionally
>> +# libintl-perl at runtime.
>> +#
>> +# Define NEEDS_LIBINTL if you haven't set NO_GETTEXT and your syste=
m
>> +# needs to be explicitly linked to -lintl. It's defined automatical=
ly
>> +# on platforms where we don't expect glibc (Linux, Hurd,
>> +# GNU/kFreeBSD), which includes libintl.
> [...]
>
>> diff --git a/config.mak.in b/config.mak.in
>> index 0d4b64d..a15f3c1 100644
>> --- a/config.mak.in
>> +++ b/config.mak.in
>> @@ -32,6 +32,7 @@ NO_CURL=3D@NO_CURL@
>> =C2=A0NO_EXPAT=3D@NO_EXPAT@
>> =C2=A0NO_LIBGEN_H=3D@NO_LIBGEN_H@
>> =C2=A0HAVE_PATHS_H=3D@HAVE_PATHS_H@
>> +NO_GETTEXT=3D@NO_GETTEXT@
>
> No
>
> =C2=A0+NEEDS_LIBINTL=3D@NEEDS_LIBINTL@
>
> (see also below)?
>
>> diff --git a/configure.ac b/configure.ac
>> index 71038fc..7bebfd8 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -730,6 +730,12 @@ AC_CHECK_HEADER([paths.h],
>> =C2=A0[HAVE_PATHS_H=3D])
>> =C2=A0AC_SUBST(HAVE_PATHS_H)
>> =C2=A0#
>> +# Define NO_GETTEXT if you don't have libintl.h
>> +AC_CHECK_HEADER([libintl.h],
>> +[NO_GETTEXT=3D],
>> +[NO_GETTEXT=3DYesPlease])
>> +AC_SUBST(NO_GETTEXT)
>> +#
>
> No check for NEEDS_LIBINTL? [..]
>
> =C2=A0+# Define NEEDS_LIBINTL if you haven't set NO_GETTEXT and your =
system
> =C2=A0+# needs to be explicitly linked to -lintl. It's defined automa=
tically
> =C2=A0+# on platforms where we don't expect glibc (Linux, Hurd,
> =C2=A0+# GNU/kFreeBSD), which includes libintl.
> =C2=A0+AC_CHECK_LIB([c], [gettext],
> =C2=A0+[NEEDS_LIBINTL=3D],
> =C2=A0+[NEEDS_LIBINTL=3DYesPlease])
> =C2=A0+AC_SUBST(NEEDS_LIBINTL)
> =C2=A0+test -n "$NEEDS_LIBINTL" && LIBS=3D"$LIBS -lintl"
>
> Or something like that (following examples for NEEDS_SOCKET and
> NEEDS_RESOLV in configure.ac).

(I added a NEEDS_RESOLV check in another patch that's exactly like
this, thanks).

> No check that gettext is properly set up with AM_GNU_GETTEXT
> (protected with m4_ifdef)?

Since it was noted before and Ben Walton and David M. Syzdek were CC'd
I thought I'd wait for what they have to say about it:

    http://www.spinics.net/lists/git/msg132431.html

I'm not familiar enough with autoconf to know which'd be better, and I
don't see how to use the AM_GNU_GETTEXT() macro to set and substitute
the NO_GETTEXT variable like the AC_CHECK_HEADER check does now.

Help from someone familiar with autoconf's m4 library would be
appreciated.

>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 454880a..ae63316 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -37,6 +37,7 @@ ORIGINAL_TERM=3D$TERM
>> =C2=A0# For repeatability, reset the environment to known value.
>> =C2=A0LANG=3DC
>> =C2=A0LC_ALL=3DC
>> +LANGUAGE=3DC
>> =C2=A0PAGER=3Dcat
>> =C2=A0TZ=3DUTC
>> =C2=A0TERM=3Ddumb
>
> This ensures that testsuite is run without translation. =C2=A0It is
> required because tests often include checking output of git commands
> against expected output.

Right, but I found that it didn't work as intended unless LANGUAGE=3D
was also set, so I added it.

> But perhaps, in later commit, we should mark those test that check
> porcelain output format with NO_GETTEXT or LANG_C, and add --gettext
> or --intl or --localized to run (parts of) testsuite with localized
> strings, checking if localization didn't broke some scripted command
> (somewhere command parses output of other git command).
>
> What do you think?

Yeah, optionally overriding the test suite to not set the LC variables
to test whether something breaks with localized output would be useful
later. It could be done just as:

    if test -z "$GIT_TEST_SET_C_LOCALE"
    then
         LC_ALL=3DC
         ...
    fi
