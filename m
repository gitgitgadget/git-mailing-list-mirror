From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Question about .git/objects/info/alternates
Date: Wed, 24 Mar 2010 13:35:25 -0700
Message-ID: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com>
References: <a038bef51003221026i379ee16ej6e0e6defcf0048dd@mail.gmail.com>
	 <20100323024223.GA12257@progeny.tock>
	 <a038bef51003241153g33445607qb3ab750e08b0584@mail.gmail.com>
	 <7vljdhh4po.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 21:35:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuXIg-0007XO-55
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821Ab0CXUf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 16:35:28 -0400
Received: from mail-qy0-f188.google.com ([209.85.221.188]:44544 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457Ab0CXUf0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 16:35:26 -0400
Received: by qyk26 with SMTP id 26so4973312qyk.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Snq2BMBTTjAmPZrIfX15wpeHnAF3gC2h7Osl06Q+Mnc=;
        b=IATSGou0WX4XsFYx5Kv5qJvepvrnQfyZ7Dte+cBPF7YvPQsiKku6mRvGX0otXP92CT
         cO1tEVxR3yzkFWC0NrjqrsLmZA2fSZ0RLwhBjMT3aBcZUpPX0ZDra0OFyaFy45QBCrX0
         3+vJswh8PPf5eMgwvIfw+teAbzR1zhwswfNLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pau/JbOXfquKAbnrm+P3m3vvM4hsMlyG2ek14RSG+4ziKjBBE2sgp9sWjeUo8aLZNq
         DkVxfFo2TWcgnYrn8P7dcfB+fLID2gu2TTEMhCPZ5zkJsvC6Rr6sI+HERBMMrg5s3Mgi
         AeuZXSM8nk0nmyj/gTOVR6LjOoG8L97RcF0C4=
Received: by 10.229.14.157 with SMTP id g29mr2297941qca.57.1269462925419; Wed, 
	24 Mar 2010 13:35:25 -0700 (PDT)
In-Reply-To: <7vljdhh4po.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143121>

On Wed, Mar 24, 2010 at 12:58 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Chris Packham <judge.packham@gmail.com> writes:
>
>> git repack -a did the correct thing.
>>
>> It occurs to me that the UI around alternates is a bit lacking i.e.
>> there isn't a git command to display the alternates in use or to add
>> them to an existing repository (or at least I couldn't find one
>> skimming the docs or googling).
>
> That's an understatement. =C2=A0Thanks for starting the effort.

Thanks for the comments (and lessons in portable shell scripting).
I'll re-roll shortly. Some responses to specific questions below.

> I will likely to have quite a few style issues with the script
> implementation, and am undecided if this should be a new command
> or an option to some existing command, but it's time we have a
> management facility for alternates.

=46air enough about style issues, I tend to code everything like its C =
I
guess some habits are hard to break. I was wondering about the
justification for having a separate command but I couldn't think of
anywhere else it'd fit. Also calling the command alternates when we
create them with git clone --reference seems a bit funny.

>> diff --git a/Makefile b/Makefile
>> index 3a6c6ea..1a7b084 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -334,6 +334,7 @@ TEST_PROGRAMS_NEED_X =3D
>> =C2=A0unexport CDPATH
>>
>> =C2=A0SCRIPT_SH +=3D git-am.sh
>> +SCRIPT_SH +=3D git-alternates.sh
>> =C2=A0SCRIPT_SH +=3D git-bisect.sh
>> =C2=A0SCRIPT_SH +=3D git-difftool--helper.sh
>> =C2=A0SCRIPT_SH +=3D git-filter-branch.sh
>
> You probably need one entry in the command-list.txt to classify where=
 in
> the main manual page git(1) for this command to appear. =C2=A0I would=
 suggest
> imitating "git config".

Yes will do when I write the documentation

>> diff --git a/git-alternates.sh b/git-alternates.sh
>> new file mode 100755
>> index 0000000..74ec707
>> --- /dev/null
>> +++ b/git-alternates.sh
>> @@ -0,0 +1,159 @@
>> +#!/bin/sh
>> ...
>> +#
>> +# Runs through the alternates file calling the callback function $1
>> +# with the name of the alternate as the first argument to the callb=
ack
>> +# any additional arguments are passed to the callback function.
>> +#
>> +walk_alternates()
>> +{
>> + =C2=A0 =C2=A0local alternates=3D$GIT_DIR/objects/info/alternates
>> + =C2=A0 =C2=A0local callback=3D$1
>
> We want to use this on platforms with ksh and dash, so please refrain=
 from
> bash-ism features. =C2=A0"local" does not mix well with "#!/bin/sh".
>
>> + =C2=A0 =C2=A0shift
>> +
>> + =C2=A0 =C2=A0if [ -e $alternates ]; then
>
> We tend to avoid '[' and write it like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -f "$alternates"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...

I think there were a few of these I missed before submitting. Easy to f=
ix.

> Also notice that an indent is one tab and one tabstop is 8 places, an=
d
> alternates need to be quoted in case $GIT_DIR has IFS whitespace in i=
t.

I must have used the wrong thing as an example. I actually started
with tabs and converted it to spaces after looking at
git-mergetool.sh.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0while read line
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$callback $line $*
>
> As the path to an alternate object store can contain IFS whitespace, =
line
> needs to be quoted. =C2=A0Also you call walk_alternates with things l=
ike "$dir"
> that could also be a path with IFS whitespace, it needs to be quoted
> properly. =C2=A0I suspect callback is only your own shell function, s=
o it does
> not have to be quoted, but it is Ok to quote it for consistency. =C2=A0=
I.e.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"$callback" "$line" "$@"
>
> You are loooooose in quoting throughout your script, so I won't bothe=
r to
> point all of them out in the rest of the message. =C2=A0You also are =
loose in
> checking error returns (what you failed to write $newalternates file,=
 for
> example), which needs to be fixed before the final version.

I'll fix these.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0done < $alternates
>
> This is correct per POSIX even if $alternates itself has IFS whitespa=
ce in
> it, but newer bash on some platforms have an obnoxious "safety featur=
e"
> (see 3fa7c3d work around an obnoxious bash "safety feature" on OpenBS=
D,
> 2010-01-26) that can cause it to barf on this. =C2=A0It is unfortunat=
e but we
> need to quote it like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0done <"$alternates"
>
> Also notice that there is no SP after < or > redirection (it is just =
a
> style thing).
>
>> +# Walk function to display one alternate object store and, if the u=
ser
>> +# has specified -r, recursively call show_alternates on the git
>> +# repository that the object store belongs to.
>> +#
>> +show_alternates_walk()
>> +{
>> + =C2=A0 =C2=A0say "Object store $1"
>> + =C2=A0 =C2=A0say " =C2=A0 =C2=A0referenced via $GIT_DIR"
>> +
>> + =C2=A0 =C2=A0local new_git_dir=3D${line%%/objects}
>> + =C2=A0 =C2=A0if [ "$recursive" =3D=3D "true" -a "$GIT_DIR" !=3D "$=
new_git_dir" ]
>> + =C2=A0 =C2=A0then
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test "$recursive" =3D true && test "$GI=
T_DIR" !=3D "$new_git_dir"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_DIR=3D$new_git_dir show_alternates
>
> This is probably depending on a bug in bash and is not portable. =C2=A0=
See
> 76c9c0d (rebase -i: Export GIT_AUTHOR_* variables explicitly, 2010-01=
-22)

OK I thought that was a standard thing. Exporting could play havoc
with recursion, will have to look for a solution for that.

>> +add_alternate()
>> +{
>> + =C2=A0 =C2=A0if test ! -d $dir; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0die "fatal: $dir is not a directory"
>> + =C2=A0 =C2=A0fi
>
> This will not work with relative alternates. =C2=A0In two repositorie=
s A and B,
> where B borrows from A:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A/.git/objects/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0B/.git/objects/info/alternates
>
> the alternates file in B can point at A's .git/objects, relative to i=
ts
> own .git/objects/.

So would the best approach be not to validate the input or to validate
it relative to $PWD and .git/objects/. I think the answer ties into my
use of readlink.

>> + =C2=A0 =C2=A0walk_alternates check_current_alternate_walk $dir
>> +
>> + =C2=A0 =C2=A0# At this point we know that $dir is a directory that=
 exists
>> + =C2=A0 =C2=A0# and that its not already being used as an alternate=
=2E We could
>> + =C2=A0 =C2=A0# go further and verify that $dir has valid objects.
>> +
>> + =C2=A0 =C2=A0# if we're still going we can safely add the alternat=
e
>> + =C2=A0 =C2=A0touch $GIT_DIR/objects/info/alternates
>> + =C2=A0 =C2=A0echo "$(readlink -f $dir)" >> $GIT_DIR/objects/info/a=
lternates
>
> What is this touch for?

I wasn't 100% sure >> would work if the file didn't exist. I just
tried on a bash shell and it works. Does anyone know of any supported
shells that behave differently w.r.t the >> operator?

> Is readlink(1) portable enough across platforms? =C2=A0A more fundame=
ntal
> question is if resolving symbolic link like this behind user is a sen=
sible
> thing to do, especially as you are ...
>
>> + =C2=A0 =C2=A0say "$dir added as an alternate"
>
> ... lying to the user here, if $dir indeed is a symbolic link.

Using readlink was my hack around converting a user specified relative
path to an absolute one. I actually would prefer it if it didn't
interpret a symlink. I also had my doubts about portability its
probably not going to exist on platforms that don't have real symlinks
(windows). What I really wanted to do was something like "abspath
$dir" but I was bitterly disappointed to find that was a gnu make-ism.
Any suggestions?

>> +rewrite_alternates()
>> +{
>> + =C2=A0 =C2=A0if test "$1" !=3D "$2"; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $2 >> $3
>> + =C2=A0 =C2=A0fi
>> +}
>
> That's a misleading name for this helper function.

I think this is made redundant by your grep suggestion below.

>> +del_alternate()
>> +{
>> + =C2=A0 =C2=A0if test ! $force =3D "true"; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0say "Not forced, use"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0say " =C2=A0 'git repack -a' to fetch m=
issing objects, then "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0say " =C2=A0 '$dashless -f -d $dir' to =
remove the alternate"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0die
>> + =C2=A0 =C2=A0fi
>> +
>> + =C2=A0 =C2=A0local alternates=3D$GIT_DIR/objects/info/alternates
>> +
>> + =C2=A0 =C2=A0new_alts_file=3D$(mktemp $alternates-XXXXXX)
>> + =C2=A0 =C2=A0touch $new_alts_file
>> +
>> + =C2=A0 =C2=A0walk_alternates rewrite_alternates $dir $new_alts_fil=
e
>
> I think this is a more expensive way to say:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep -v -F "$dir" <"$alternates" >"$new_al=
ternates"
>

Much easier. I'll do that.

>> + =C2=A0 =C2=A0mv $new_alts_file $alternates
>> +
>> + =C2=A0 =C2=A0# save the git from repeatedly reading a 0 length fil=
e
>> + =C2=A0 =C2=A0if test $(stat -c "%s" $alternates) -eq 0; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rm $alternates
>> + =C2=A0 =C2=A0fi
>
> Good point, but it would be better to do something like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep -v -F "$dir" <"$alternates" >"$new_al=
ternates"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -s "$new_alternates"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mv "$new_alter=
nates" "$alternates"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f "$altern=
ates"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> without making it less portable by using "stat".
>
Yes. Will change.
