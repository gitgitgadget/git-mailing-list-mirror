From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Tue, 17 Feb 2015 06:34:43 +0100
Message-ID: <54E2D2F3.5080800@web.de>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com> <vpqtwyl90mx.fsf@anie.imag.fr> <340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com> <vpqiof14qu8.fsf@anie.imag.fr> <13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fairuzan Roslan <fairuzan.roslan@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 17 06:35:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNaou-0006xG-KF
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 06:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbbBQFfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2015 00:35:36 -0500
Received: from mout.web.de ([212.227.15.14]:53151 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754625AbbBQFff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 00:35:35 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LuIAZ-1XOeSh2koZ-011fz3; Tue, 17 Feb 2015 06:35:32
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
X-Provags-ID: V03:K0:uqahqi7z9YDiHFDdDueQZ0Kc40i99nFlhqZAhofvCRXqrBZ8FvV
 wlr8yWzSHFUTP6w1xRoqs6Ppw3hMaDPhpqbDlpy7cabYxPnmw9A/jWR45DrzTV0XkWyo1be
 UbCMKZU2yuAraBxwAQq0GifeLKKeYondV3evN3D6sIMUDzIEhRFCWCxTkKNxFlXsP//g13V
 ca0tc0XwtUS0Wye+NuV/A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263933>

On 02/17/2015 04:22 AM, Fairuzan Roslan wrote:
>> On Feb 17, 2015, at 3:08 AM, Matthieu Moy <Matthieu.Moy@grenoble-inp=
=2Efr> wrote:
>>
>> [ Please, don't top post on this list ]
>>
>> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>>
>>> I don=E2=80=99t see the issue for the owner of his/her own file to =
have write
>>> access.
>> Object and pack files are not meant to be modified. Hence, they are
>> read-only so that an (accidental) attempt to modify them fails.
>>
>>> Setting tmp idx & pack files to read-only even for the file owner i=
s
>>> not a safety feature.
>> Yes it is. If you do not think so, then please give some arguments.
>>
>>> You should at least give the user the option to set the permission =
in
>>> the config file and not hardcoded the permission in the binary.
>> This is the kind of thing I meant by "investigate alternate solution=
s".
>> I have no AFP share to test, so it would help if you answered the
>> question I asked in my previous message:
>>
>>>> On Feb 17, 2015, at 2:23 AM, Matthieu Moy <Matthieu.Moy@grenoble-i=
np.fr> wrote:
>>>>
>>>> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>>>>
>>>>> Hi,
>>>>>
>>>>> Somehow the =E2=80=9Cint mode =3D 0444;=E2=80=9D in odb_mkstemp (=
environment.c) are
>>>>> causing a lot of issues (unable to unlink/write/rename) to those
>>>>> people who use AFP shares.
>>>> Is it a problem when using Git (like "git gc" failing to remove ol=
d
>>>> packs), or when trying to remove files outside Git?
>> (BTW, why did you try to write/rename pack files?)
>>
>> --
>> Matthieu Moy
>> http://www-verimag.imag.fr/~moy/
> I think its easier if I just show you=E2=80=A6
>
> OS : OS X 10.10.0 - 10.10.2
> Client :  git version 1.9.3 (Apple Git-50) and git version 2.2.1
> AFP share : //user@hostname._afpovertcp._tcp.local/installer on /Volu=
mes/installer (afpfs, nodev, nosuid, mounted by user)
>
> 1. git clone example
>
> $ git clone https://github.com/robbyrussell/oh-my-zsh.git
> Cloning into 'oh-my-zsh'...
> remote: Counting objects: 11830, done.
> remote: Total 11830 (delta 0), reused 0 (delta 0)
> Receiving objects: 100% (11830/11830), 2.12 MiB | 481.00 KiB/s, done.
> Resolving deltas: 100% (6510/6510), done.
> warning: unable to unlink /Volumes/installer/oh-my-zsh/.git/objects/p=
ack/tmp_pack_zjPxuc: Operation not permitted
> error: unable to write sha1 filename /Volumes/installer/oh-my-zsh/.gi=
t/objects/pack/pack-cceafdc9ef02bc58844138ba543ec6cc38252bb1.pack: Oper=
ation not permitted
> fatal: cannot store pack file
> fatal: index-pack failed
>
> $ ls -l oh-my-zsh/.git/objects/pack
> total 5008
> -rw-------  1 user  staff       32 Feb 17 09:59 pack-cceafdc9ef02bc58=
844138ba543ec6cc38252bb1.keep
> -r--r--r--  1 user  staff   332312 Feb 17 09:59 tmp_idx_oUN1sb
> -r--r--r--  1 user  staff  2223007 Feb 17 09:59 tmp_pack_zjPxuc
>
> $ rm -rf oh-my-zsh/.git/objects/pack/tmp_*
> rm: oh-my-zsh/.git/objects/pack/tmp_idx_oUN1sb: Operation not permitt=
ed
> rm: oh-my-zsh/.git/objects/pack/tmp_pack_zjPxuc: Operation not permit=
ted
>
> Detail Errors:
> 1. delete_ref_loose (refs.c) -> unlink_or_msg (wrapper.c) -> "unable =
to unlink %s: %s"
> 2. move_temp_to_file (sha1_file.c ) -> =E2=80=9Cunable to write sha1 =
filename %s: %s=E2=80=9D
>
> 2. git pull example
>
> Textual git:master $ git pull
> remote: Counting objects: 435, done.
> remote: Compressing objects: 100% (398/398), done.
> remote: Total 435 (delta 219), reused 18 (delta 12)
> Receiving objects: 100% (435/435), 1.22 MiB | 756.00 KiB/s, done.
> Resolving deltas: 100% (219/219), done.
> warning: unable to unlink .git/objects/pack/tmp_pack_vDaIZa: Operatio=
n not permitted
> error: unable to write sha1 filename .git/objects/pack/pack-977a2dc0f=
4be3996dc1186e565a30d55d14b5e87.pack: Operation not permitted
I'm somewhat unsure how this is connected to 0444 ?

It seems as if you don't have write permissions for some reasons.
(on the higher directory), what does
ls -ld  .git/objects/pack/
ls -ld  .git/objects/
give ?

can you run
rm .git/objects/pack/pack-977a2dc0f4be3996dc1186e565a30d55d14b5e87.pack

on the command line ?
