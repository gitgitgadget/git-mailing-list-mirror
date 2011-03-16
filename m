From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Allow git mv FileA fILEa when core.ignorecase = true
Date: Wed, 16 Mar 2011 14:18:28 +0100
Message-ID: <AANLkTikvkzUKBCqygGJoUG3qXNDArXpEX0RM5_5dbnBD@mail.gmail.com>
References: <201103042240.38969.tboegi@web.de> <AANLkTin2s_=TVaKx6yv+nDvXB41BxebWHX4iaDYSGd-e@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 14:20:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzqeS-0007w3-Tw
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 14:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab1CPNUc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 09:20:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35630 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab1CPNUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 09:20:30 -0400
Received: by fxm17 with SMTP id 17so1636020fxm.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PqkThXY0a/ShKVKccA1KEkZ3QqMQPFKtYio1bVeSx+8=;
        b=UaFsN46HQvNvQjkIm0SezxGsVH8JNt5WwTOF67d5cbMjGYPjtv/myU2N/4/axy6KLK
         umhgpq3H1/8uWU0rCaw55TwDPyVhMfNDoBj1Txw/lU46XlN/RhzfIwQOOsaZlWuGbUu8
         jqf2Pm4UehafGCBicVV3dsOmEv787M5cxxE+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Lt96RUlAIUNlGn7VeUkKkYGVHX8FXyPM+gBVdNV3IImugMaplMMRzhh9J+HTR0Qlf4
         SlA1BcPKKVLW/SkbxZLnu5H2qGgmhO4rd2gN14WznjVY6DH3th04Orx3wFWjewxTvNza
         0j1pHIKwB0t2gRxEUSeFuc/gDIyCO7Z/xG+ns=
Received: by 10.223.56.220 with SMTP id z28mr975232fag.11.1300281628442; Wed,
 16 Mar 2011 06:20:28 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Wed, 16 Mar 2011 06:18:28 -0700 (PDT)
In-Reply-To: <AANLkTin2s_=TVaKx6yv+nDvXB41BxebWHX4iaDYSGd-e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169150>

2011/3/16 Erik Faye-Lund <kusmabite@gmail.com>:
> 2011/3/4 Torsten B=F6gershausen <tboegi@web.de>:
>> =A0 =A0The typical use case is when a file "FileA" should be renamed=
 into fILEa
>> =A0 =A0and we are on a case insenstive file system (system core.igno=
recase =3D true).
>> =A0 =A0Source and destination are the same file, it can be accessed =
under both names.
>> =A0 =A0This makes git think that the destination file exists.
>> =A0 =A0Unless used with --forced, git will refuse the "git mv FileA =
fILEa".
>> =A0 =A0This change will allow "git mv FileA fILEa", when core.ignore=
case =3D true
>> =A0 =A0and source and destination filenames only differ in case and =
the file length
>> =A0 =A0is identical.
>> =A0 =A0On Linux/Unix/Mac OS X the mv is allowed when the inode of th=
e source and
>> =A0 =A0destination are equal.
>> =A0 =A0On =A0this allows renames of M=C4RCHEN into M=E4rchen on Mac =
OS X.
>> =A0 =A0(As a side effect, a file can be renamed to a name which is a=
lready
>> =A0 =A0hard-linked to the same inode)
>>
>> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
>> ---
>> =A0builtin/mv.c =A0| =A0 20 +++++++++++++++-----
>> =A0t/t7001-mv.sh | =A0 29 +++++++++++++++++++++++++++++
>> =A02 files changed, 44 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index 93e8995..e0aad62 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -62,7 +62,7 @@ int cmd_mv(int argc, const char **argv, const char=
 *prefix)
>> =A0 =A0 =A0 =A0};
>> =A0 =A0 =A0 =A0const char **source, **destination, **dest_path;
>> =A0 =A0 =A0 =A0enum update_mode { BOTH =3D 0, WORKING_DIRECTORY, IND=
EX } *modes;
>> - =A0 =A0 =A0 struct stat st;
>> + =A0 =A0 =A0 struct stat st, st_dst;
>> =A0 =A0 =A0 =A0struct string_list src_for_dst =3D STRING_LIST_INIT_N=
ODUP;
>>
>> =A0 =A0 =A0 =A0git_config(git_default_config, NULL);
>> @@ -164,15 +164,25 @@ int cmd_mv(int argc, const char **argv, const =
char *prefix)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (cache_name_pos(src, length=
) < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bad =3D "not under ve=
rsion control";
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (lstat(dst, &st) =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (lstat(dst, &st_dst) =3D=3D 0)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int allow_force =3D fo=
rce;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bad =3D "destination =
exists";
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (force) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Allow when src and =
dst have the same inode (Mac OS X) */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Allow when ignore_c=
ase and same file length (Windows) */
>
> Wait, what? Same file length is sufficient to trigger overwriting
> without -f? I find this to be a very dubious heuristic...
>
> Shouldn't you be checking something like nFileIndexLow/High from
> BY_HANDLE_FILE_INFORMATION instead? (ref:
> http://msdn.microsoft.com/en-us/library/aa363788(v=3DVS.85).aspx)
>
> Sure, we'd need some API to check that, but if we assume that this
> code path is rare-ish we could do something like this (note,
> untested):
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 6750e67..fee4113 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -299,6 +299,21 @@ void mingw_mark_as_git_dir(const char *dir)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "dotGitOnly" : "true"));
> =A0}
>
> +int is_same_file(const char *a, const char *b)
> +{
> + =A0 =A0 =A0 BY_HANDLE_FILE_INFORMATION hia, hib;
> + =A0 =A0 =A0 HANDLE ha =3D OpenFileA(a, NULL, OF_READ),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0hb =3D OpenFileA(b, NULL, OF_READ);
> + =A0 =A0 =A0 if (!ha || !hb ||
> + =A0 =A0 =A0 =A0 =A0 !GetFileInformationByHandle(ha) ||
> + =A0 =A0 =A0 =A0 =A0 !GetFileInformationByHandle(hb))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +

And if couse:
CloseHandle(ha);
CloseHandle(hb);
