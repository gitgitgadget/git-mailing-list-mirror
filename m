From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH RFC] git remote: Separate usage strings for subcommands
Date: Mon, 16 Nov 2009 20:39:09 -0500
Message-ID: <32c343770911161739g203a32d4p2b9f8ea6b39d900@mail.gmail.com>
References: <32c343770911151343y1ed0aak83b43a4ab57eb6ab@mail.gmail.com>
	 <7vocn2klp8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 02:39:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAD2N-00035c-9r
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 02:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbZKQBjH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2009 20:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755286AbZKQBjG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 20:39:06 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50434 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbZKQBjE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 20:39:04 -0500
Received: by bwz27 with SMTP id 27so6351203bwz.21
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 17:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SNd/GM4g/pOuOuB2WYjKTfEuVbNWs3Kkq5eJ7h7D/NU=;
        b=jrUSrfE87QjWHahreg+5ljxpfGAE5O43TVBP8vwr2gipxDBq5RFeQUHXfW+WkC9xEX
         GhSD8Kd18R0Dd6tVBXFvQjw7WwJwy14MWTvWh/0srrsyR6oXVhu2Ww47AzrOwvt+oICA
         2TQpuebAsuVXkkoCXgmjJRiwp2SDXOXleOgdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LO+LW8zCejik8Jn4Tzr086X0tY+eHbEyDfkgUaUaaGZJQvhzXrRGdbZRPSl/WlwNyA
         +7g232bmTAyWDgXvsgeXMkRD4ZUuYkjIJJkYotP23gjkMFYYVZ0NjNuy35eQayWreKG4
         UbOhbwx6PyYdF1I3t1bugYLepnJF3bYFbQS2c=
Received: by 10.216.86.204 with SMTP id w54mr633593wee.54.1258421949725; Mon, 
	16 Nov 2009 17:39:09 -0800 (PST)
In-Reply-To: <7vocn2klp8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133050>

On Mon, Nov 16, 2009 at 8:02 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> ...
>> +static const char * const builtin_remote_add_usage[] =3D {
>> REMOTE_ADD_USAGE, NULL };
>> ...
>
> I am not sure about the value of reusing option string like this, and=
 for
> all other subcommands the same comment applies. =C2=A0For example, in=
 the case
> of "remote add -h", you would use
>
> "git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <u=
rl>"
> from REMOTE_ADD_USAGE, but ...

Do you object to the new #defines for the strings?  I added them since =
we now
really need to construct the usage string for 2 separate uses:
  (1) When 'git remote -h' is invoked, we need to return the usage
string showing
       all subcommands.
  (2) When 'git remote <subcommand> -h' is invoked, we need to return t=
he
      usage for just that command.

It doesn't make sense to me to maintain separate strings for the two us=
e cases.


>> @@ -70,7 +87,6 @@ static int add(int argc, const char **argv)
>> =C2=A0 =C2=A0 =C2=A0 int i;
>>
>> =C2=A0 =C2=A0 =C2=A0 struct option options[] =3D {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_GROUP("add specific =
options"),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN('f', "f=
etch", &fetch, "fetch the remote branches"),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_CALLBACK('t', "=
track", &track, "branch",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "branch(es) to track", opt_parse_track),
>> @@ -79,11 +95,11 @@ static int add(int argc, const char **argv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_END()
>> =C2=A0 =C2=A0 =C2=A0 };
>>
>> - =C2=A0 =C2=A0 argc =3D parse_options(argc, argv, NULL, options, bu=
iltin_remote_usage,
>> + =C2=A0 =C2=A0 argc =3D parse_options(argc, argv, NULL, options, bu=
iltin_remote_add_usage,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00);
>
> ... the options list is used to reproduce the information in a major =
part
> of that string already. =C2=A0So I would prefer builtin_remote_add_us=
age[] to
> be something like:
>
> =C2=A0 =C2=A0"git remote add [<options>...] <name> <url>"
>
> It is in line with a discussion we had earlier:
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/129906/f=
ocus=3D130646

I planned to make this change in a separate (or maybe just a later
version) patch,
but first I wanted to be sure my other changes were sound.  I will send=
 a new
version that includes this change.

Should this change be made to the man page as well?


>> @@ -1334,7 +1348,6 @@ static int show_all(void)
>>  int cmd_remote(int argc, const char **argv, const char *prefix)
>>  {
>>  	struct option options[] =3D {
>> -		OPT__VERBOSE(&verbose),
>>  		OPT_END()
>>  	};
>>  	int result;

I did find one problem with the above portion of the patch.  With this =
change
'-v' was no longer recognized as an option.  I will remove this change =
in the
next version.  Keeping it means that '-v' will still be reported in the
'git remote -h' usage string, but I don't see an easy way to remove the=
 string
without removing the feature.
