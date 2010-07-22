From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t7002: test git grep --no-index from a bare repository
Date: Fri, 23 Jul 2010 08:36:29 +1000
Message-ID: <AANLkTik4LvZwHdZ6cFW2EcBXWZ8fOrp5qqIfkepndL3k@mail.gmail.com>
References: <1279715018-24225-1-git-send-email-pclouds@gmail.com>
	<20100722070219.GA6577@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 00:36:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc4Nc-00023G-Uy
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 00:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab0GVWgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 18:36:35 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36370 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0GVWge convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 18:36:34 -0400
Received: by qwh6 with SMTP id 6so3121296qwh.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 15:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=elS3+BYKSltkeLbNwj4pEvcfrvLj3ABDV3D46s/SanE=;
        b=lwBKD7533OYN5yLrDo/m/7GZnbh6LA4J90K6mEb+APNFiVGeFug3xDSg1MH40pVWSF
         GATOpQTzk6OvThcdtgE0+AgSbVXHznI5MVPDLaZmTGPiaXowJYiUD7XsxQ9/x/mHkCvc
         ktmAOIy/jb31n1c6N8/QFnzrnl/G22GWR5p8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tI7ksHuHVS5uY3v6oFkw6fVjxLiiLEk6QUlZUpK78Id3KV/xVwSmW7Y1Gw1ZemhWuE
         AqQZTUG5L/1vBN0h4oIyiPY9uzDwLpPykwW0sbN9PFLTlv7w/X6jhEQQv8bCYCE0X/LI
         pYWC200ipnDzOd3QYja89y22ZzQdNVT92y8hk=
Received: by 10.224.51.15 with SMTP id b15mr1723293qag.394.1279838189953; Thu, 
	22 Jul 2010 15:36:29 -0700 (PDT)
Received: by 10.229.242.8 with HTTP; Thu, 22 Jul 2010 15:36:29 -0700 (PDT)
In-Reply-To: <20100722070219.GA6577@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151490>

2010/7/22 Jonathan Nieder <jrnieder@gmail.com>:
> Hi Duy,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Subject: [PATCH] t7002: test git grep --no-index from a bare reposit=
ory
>
> It=E2=80=99s t7810 now (to keep t7811 company).
>
>> =C2=A0There is an interesting thing about this command. Back in tp/s=
etup
>> =C2=A0series, there is a patch that changes the current behavior,
>> =C2=A0"calculate prefix even if no worktree is found". grep is inter=
esting
>> =C2=A0because it depends on the current behavior, i.e. prefix being =
NULL
>> =C2=A0in bare repo, while it still needs true prefix to do chdir()
>> =C2=A0stuff in run_pager().
>
> Yes, sorry to let this hang for so long. =C2=A0I liked your setup ser=
ies
> for many reasons and am happy to see pieces of it coming back to life=
=2E
>
>> +++ b/Documentation/git-grep.txt
>> @@ -28,8 +28,9 @@ SYNOPSIS
>> =C2=A0DESCRIPTION
>> =C2=A0-----------
>> =C2=A0Look for specified patterns in the tracked files in the work t=
ree, blobs
>> -registered in the index file, or blobs in given tree objects.
>> -
>> +registered in the index file, or blobs in given tree objects. By de=
fault
>> +it will only search tracked files within the current directory (or =
full
>> +tree if in bare repository).
>
> Probably deserves more detail.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Searches for lines matching the specified =
patterns in the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0work tree, the index, or a specified tree.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0By default, 'git grep' only examines track=
ed files in the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0subtree of the work tree rooted at the cur=
rent working
> =C2=A0 =C2=A0 =C2=A0 =C2=A0directory. =C2=A0Output consists of matchi=
ng lines preceded with
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the corresponding filename and a colon.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0With `--cached`, 'git grep' does the same =
search in the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0version scheduled for the next commit in t=
he index.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0With `--no-index`, 'git grep' pays no mind=
 to the index
> =C2=A0 =C2=A0 =C2=A0 =C2=A0file and reports *all* matching files unde=
r the working
> =C2=A0 =C2=A0 =C2=A0 =C2=A0directory.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Given a commit name, 'git grep' does the s=
ame search in that
> =C2=A0 =C2=A0 =C2=A0 =C2=A0historical version. =C2=A0More generally, =
given a tree name, 'git
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep' searches the subtree of that tree ob=
ject corresponding
> =C2=A0 =C2=A0 =C2=A0 =C2=A0to the path to the current directory from =
the root of the work
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tree (or the entire tree if there is no wo=
rk tree, as in a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bare repository).
>

Yeah.. grep looks more complex than I thought :) Documentation patch
should go separately then. Please go ahead and make a patch of this
text. Oh you did.

>>
>> =C2=A0OPTIONS
>> =C2=A0-------
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 597f76b..e8abdc7 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -1109,6 +1109,8 @@ int cmd_grep(int argc, const char **argv, cons=
t char *prefix)
>>
>> =C2=A0 =C2=A0 =C2=A0 if (use_threads)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hit |=3D wait_all()=
;
>> +
>> + =C2=A0 =C2=A0 /* FIXME prefix is NULL in bare repo, no matter wher=
e cwd is */
>> =C2=A0 =C2=A0 =C2=A0 if (hit && show_in_pager)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run_pager(&opt, pre=
fix);
>
> This comment seems kind of unhelpful. =C2=A0Maybe something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * NOTE NOTE NOTE: Even in a bare reposito=
ry, the user
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * probably expected the command specified=
 with -O to run in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the current directory, but when --no-in=
dex is supplied, we
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * are passing it paths relative to the .g=
it directory.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Until that changes, this needs not to c=
hdir() in that case.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>
> Do I understand correctly?

Hmm.. on second thought, the fault is probably not grep's. These
things must be consistent together:

 - new cwd after setup is at worktree top-level directory (or
undefined if no worktree is found?)
 - prefix must be aligned with new cwd. That is, chdir(prefix) must
give the original cwd (**1**)
 - gitdir is relative to new cwd
 - worktree is relative to new cwd

So probably best to adjust cwd in setup_git_directory_gently() in this
case to align with the NULL prefix, not the other way around.
Something like this (still incorrect):

diff --git a/setup.c b/setup.c
index 87c21f0..b67b3aa 100644
--- a/setup.c
+++ b/setup.c
@@ -412,6 +412,15 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
+
+			/*
+			 * The old behavior is return NULL here.
+			 * Follow it and cwd back to because
+			 * NULL prefix means cwd does not move
+			 */
+			if (chdir(cwd))
+				die_errno("Cannot come back to cwd");
+
 			if (offset !=3D len) {
 				root_len =3D offset_1st_component(cwd);
 				cwd[offset > root_len ? offset : root_len] =3D '\0';


(**1**) Not entirely correct, if original cwd is outside worktree,
then prefix is NULL anyway because prefix is not designed to be
"../../../"
--=20
Duy
