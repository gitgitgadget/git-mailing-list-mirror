From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] handle rename of case only, for windows
Date: Fri, 14 Jan 2011 15:22:43 +0100
Message-ID: <AANLkTi=R0bkZgUjn01A0ZLZBad2ERGOfQneqBMEPTa4j@mail.gmail.com>
References: <1295012461.7403.1415291765@webmail.messagingengine.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Tim Abell <tim@timwise.co.uk>
X-From: git-owner@vger.kernel.org Fri Jan 14 15:23:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdkYc-00043d-1u
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 15:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab1ANOXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 09:23:08 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60736 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab1ANOXF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 09:23:05 -0500
Received: by bwz15 with SMTP id 15so2555989bwz.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 06:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Vyzo3B35+gYo8wwIABAz3l4RfiFMH41LolatalXX3bA=;
        b=alHiqi7NahTNtTqvRLOJEiXsuQohXzbR7YKhspljd/kaq30nc3Fa3rrq8+4+P1Ybti
         qTnjRmxzw7G8OLgg6pAXThdOvxu/8wXOG5lTJMKC6gvvG7+sfph87hc5lat36985l4Dy
         XqSCDJ3SM7XtOFF+GUJTE8DdrmgisjzcV3pmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=SMyxB6VuXolLbhntRx78HtxFQ4yBhg0pH+5FP3ty49NsehTv74IoOMMg9nmIJxXn3E
         zIrgaMoCdtkrWoXV4aRMyHYW9UvZbSR6S55S5tKkouWOatGoxDuvnXBl9vaCmbt7U94/
         mLhQMdVxNuKEBG6lQNj3Vtn+HvbCI3BwSbEvY=
Received: by 10.204.101.83 with SMTP id b19mr645010bko.199.1295014984049; Fri,
 14 Jan 2011 06:23:04 -0800 (PST)
Received: by 10.204.51.8 with HTTP; Fri, 14 Jan 2011 06:22:43 -0800 (PST)
In-Reply-To: <1295012461.7403.1415291765@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165103>

On Fri, Jan 14, 2011 at 2:41 PM, Tim Abell <tim@timwise.co.uk> wrote:
> Hi folks,
>
> I've never contributed to git before so be gentle :-)
>
> Would someone have the time to help me get this patch into mailine gi=
t?
>

=46irst of all, welcome!

There are some problems with your patch that aren't directly related
to the code:
- It's become white-space damaged, most likely from when you e-mailed
it. Perhaps you could try again with git-send-email?
- There's no real commit-message. This e-mail description isn't really
suited as a commit message as it is, IMO. It might just be a matter of
snipping away some stuff, though.
- The patch lacks a sign-off
- Since this is a Windows-issue, it would be nice if you CC'ed
msysgit@googlegroups.com as well. I've done that for now.

I suggest you read through Documentation/SubmittingPatches to get to
know the process.

> I tripped over a failure to rename files on windows when only the cas=
e
> has changed. I've created a patch which fixes it for me and doesn't s=
eem
> to break on linux or windows. I also created a test to demonstrate th=
e
> issue (part of this patch). This test passes on linux and fails on
> windows before my patch for mv.c is applied, and passes on both windo=
ws
> and linux for me after my patch is applied.
>
> The problem with changing the case of a file happens because git mv
> checks if the destination filename exists before performing a
> move/rename, and on windows lstat reports that the destination file
> *does* already exist because it ignores case for this check and
> semi-erroneously finds the source file.
>
<snip>
> When using "git mv" it is possible to work around the error by using
> --force.
>

Your reasoning seems to match what we've discussed on the msysGit
mailing list. Good work, and a clear description.

> The way I've attempted to fix it in my patch is by checking if the in=
ode
> of the source and destination are the same before deciding to fail wi=
th
> a "destination exists" error.
>

Hmm, not so good. st_ino is always 0 on Windows, so this would make
false positives, no?

> The fault exists in both the current cygwin git and the current msysg=
it,
> so I figured it would be good to get a patch to upstream (you) so tha=
t
> it could work everywhere.
>

It also affects MacOS X, AFAIK. So yes, it'd be good for upstream.

> ---
> =A0builtin/mv.c =A0| =A0 33 ++++++++++++++++++++++-----------
> =A0t/t7001-mv.sh | =A0 =A09 +++++++++
> =A02 files changed, 31 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 93e8995..6bb262e 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -63,6 +63,7 @@ int cmd_mv(int argc, const char **argv, const char
> *prefix)
> =A0 =A0 =A0 =A0const char **source, **destination, **dest_path;
> =A0 =A0 =A0 =A0enum update_mode { BOTH =3D 0, WORKING_DIRECTORY, INDE=
X } *modes;
> =A0 =A0 =A0 =A0struct stat st;
> + =A0 =A0 =A0 struct stat src_st;

Couldn't this be moved inside the scope around "cache_name_pos"?
That's the only scope it is valid inside anyway...

And if not, perhaps you could piggy-back on the st-definition, like thi=
s:
-=A0 =A0 =A0 =A0struct stat st;
+ =A0 =A0 =A0 struct stat st, src_st;

> =A0 =A0 =A0 =A0struct string_list src_for_dst =3D STRING_LIST_INIT_NO=
DUP;
>
> =A0 =A0 =A0 =A0git_config(git_default_config, NULL);
> @@ -165,17 +166,27 @@ int cmd_mv(int argc, const char **argv, const c=
har
> *prefix)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (cache_name_pos(src, length)=
 < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bad =3D "not under ver=
sion control";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (lstat(dst, &st) =3D=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad =3D "destination ex=
ists";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (force) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* on=
ly files can overwrite each other:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ch=
eck both source and destination
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (S_I=
SREG(st.st_mode) ||
> S_ISLNK(st.st_mode)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 warning("%s; will overwrite!",
> bad);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 bad =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 bad =3D "Cannot overwrite";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If we are on a case =
insensitive files=3D system
> (windows) http://is.gd/kyxgg

Perhaps you could use the full URL (and maybe put it in the commit
message insted)? It'd be nice if we could reach this information even
if is.gd disappears...

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and we are only ch=
anging the case of the file
> then lstat for the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* destination will r=
eturn !=3D 0 because it sees
> the source file.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* To prevent this ca=
using failure, lstat is
> used to get the inode of the src
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and see if it's ac=
tually the same file.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lstat(src, &src_st); //=
get file serial number
> (inode) for source
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #warning("src inode: %s=
, dst inode: %s",
> src_st.st_ino, st.st_ino);

Uhm, is this debug-leftovers? #warning is a preprocessor-construct,
and it can't understand varaibles in c. Especially not formatted as
strings. Can #warning even do varags? :P

Blah, it's too tiresome to review this white-space broken version, and
I seen now that you have re-posted a non-broken version. Thanks!
