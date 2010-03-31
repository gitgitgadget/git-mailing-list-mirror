From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCHv2 1/2] Add git alternate command
Date: Tue, 30 Mar 2010 21:35:16 -0700
Message-ID: <a038bef51003302135k700446n5a5e9d50e35d1ad9@mail.gmail.com>
References: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com>
	 <1269497251-13103-2-git-send-email-judge.packham@gmail.com>
	 <7vr5n37fci.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 06:36:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwpeS-0001c9-Ll
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 06:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab0CaEfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 00:35:19 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:33311 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab0CaEfR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 00:35:17 -0400
Received: by qyk9 with SMTP id 9so3474471qyk.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 21:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PXXXlL6hMuJFlTI92vhBu6UV6RAqc/u3YQr5wdkDNlY=;
        b=kzFoZahzWiSskehDoLDzcDoLW6x9ALfMPcRHR9Jq3Hw/4CFpg9ep3QquZPm92OdmAp
         GvhcMFVqi7uuT5qNIm9SvUjMAlbjJfjgUw95ZAIA0ntt6ZvpDINovRKHC6US946/3FAk
         5jv8eo6V5aZvqfIxrfYgeDQ9T9F/aaTGaU6GI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=og6p0dRlsJIHxykexZ2vFs9RTS2Yy4jESse5h4RhvgSK9mOsVExltY+mganKkry2BZ
         2ARHtnZov8tzms5lwfBDbXcidaC2em9n3wZJTMUY5cq3EuN9P31pVnGEmQqAXMyeacKO
         h8IMJrjI1zX5mujNCjDSMHNuWs287yNanoG9U=
Received: by 10.229.27.141 with HTTP; Tue, 30 Mar 2010 21:35:16 -0700 (PDT)
In-Reply-To: <7vr5n37fci.fsf@alter.siamese.dyndns.org>
Received: by 10.229.212.213 with SMTP id gt21mr443131qcb.2.1270010116312; Tue, 
	30 Mar 2010 21:35:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143646>

Sorry, just realized I missed this email before sending my last update.

On Mon, Mar 29, 2010 at 12:32 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Chris Packham <judge.packham@gmail.com> writes:
>
>> +abspath()
>> +{
>> + =C2=A0 =C2=A0 cd "$1"
>> + =C2=A0 =C2=A0 pwd
>> + =C2=A0 =C2=A0 cd - > /dev/null
>> +}
>
> I do not think "cd -" is all that portable. =C2=A0As you will be alwa=
ys using this in
> this form:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0somevariable=3D$(abspath "$it")
>
> you are in a subshell and won't affect the caller anyway. =C2=A0Why n=
ot drop
> the "go back to where we came from"?

=46air enough. Should be safe.

> Also a shell built-in "pwd" tends to be fooled by $PWD especially sin=
ce
> you are running "cd" without -P.

Are you saying I should switch to "echo $PWD"?

>> +#
>> +# Runs through the alternates file calling the callback function $1
>> +# with the name of the alternate as the first argument to the callb=
ack
>> +# any additional arguments are passed to the callback function.
>> +#
>> +walk_alternates()
>
> This is more like "for_each_alternates"; "walk" can be mistaken as if=
 you
> are recursively looking at alternates defined in alternate repositori=
es
> of the repository you start from.

Easy change.

>> +{
>> + =C2=A0 =C2=A0 alternates=3D$GIT_DIR/objects/info/alternates
>> + =C2=A0 =C2=A0 callback=3D$1
>> + =C2=A0 =C2=A0 shift
>> +
>> + =C2=A0 =C2=A0 if test -f "$alternates"
>> + =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while read line
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 $callback "$line" "$@"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done< "$alternates"
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0done <"$alternates"
>
> How well does this handle relative alternate object stores?

Not well at all.

> Shouldn't it be more like this?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while read altdir
> =C2=A0 =C2=A0 =C2=A0 =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$altdir"=
 in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*) ;; # full =
path
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*) altdir=3D"$=
GIT_DIR/objects/$altdir" ;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$callback "$al=
tdir" "$@"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0done <"$alternates"
>

Thanks, I was wondering how to handle relative paths.

>> +# Walk function to display one alternate object store and, if the u=
ser
>> +# has specified -r, recursively call show_alternates on the git
>> +# repository that the object store belongs to.
>> +#
>> +show_alternates_walk()
>> +{
>> + =C2=A0 =C2=A0 say "Object store $1"
>> + =C2=A0 =C2=A0 say " =C2=A0 =C2=A0referenced via $GIT_DIR"
>> +
>> + =C2=A0 =C2=A0 new_git_dir=3D${line%%/objects}
>
> Do you need double-% here, not a single one?
>

Not if I'm not using a regex. I'll change it.

>> +# Add a new alternate
>> +add_alternate()
>> +{
>> + =C2=A0 =C2=A0 if test ! -d "$dir"; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "fatal: $dir is not =
a directory"
>> + =C2=A0 =C2=A0 fi
>> +
>> + =C2=A0 =C2=A0 abs_dir=3D$(abspath "$dir")
>> + =C2=A0 =C2=A0 walk_alternates check_current_alternate_walk "$abs_d=
ir"
>> +
>> + =C2=A0 =C2=A0 # At this point we know that $dir is a directory tha=
t exists
>> + =C2=A0 =C2=A0 # and that its not already being used as an alternat=
e. We could
>
> s/its/(it's|it is)/;
>
> But I don't think it is true that you have verified that it is not us=
ed.
> You are running abspath on the input from the end user, but you are u=
sing
> existing entries in the alternates file that may not be absolute. =C2=
=A0They
> can be relative to $GIT_DIR/objects/.
>

I'll add some actual verification

>> + =C2=A0 =C2=A0 say " =C2=A0 =C2=A0use 'git repack -adl' to remove d=
uplicate objects"
>
> Good.
>
>> +# Deletes the name alternate from the alternates file.
>> +# If there are no more alternates the alternates file will be remov=
ed
>> +del_alternate()
>> +{
>> + =C2=A0 =C2=A0 if test ! $force =3D "true"; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 say "Not forced, use"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 say " =C2=A0 =C2=A0'git =
repack -a' to fetch missing objects, then "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 say " =C2=A0 =C2=A0'$das=
hless -f -d $dir' to remove the alternate"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die
>
> Hmm, I am afraid that this will end up training users to always say -=
f
> without even thinking. =C2=A0Shouldn't this code be doing whatever ne=
cessary
> steps to make sure this repository has all the necessary objects with=
out
> the named alternates and then removing the file? =C2=A0An easiest mig=
ht be to
> temporarily remove the entry and run fsck, perhaps?
>

Yeah I had the same fear. I was wondering how to proceed with this part=
=2E

I take it your suggestion is to update the alternates file and run git
fsck to see if any objects are missing then, if there are missing
objects, switch to the original alternates file run git repack -a to
fetch the missing objects and finally switch to the new alternates
file. I'll code something up for us to discuss.
