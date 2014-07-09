From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: No fchmod() under msygit - Was: Re: [PATCH 00/14] Add submodule test
 harness
Date: Wed, 09 Jul 2014 08:39:35 +0200
Message-ID: <53BCE3A7.8070600@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>	<53B5C7AC.4040701@web.de> <xmqqsimddrq3.fsf@gitster.dls.corp.google.com> <53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de> <53BC53C3.1010304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Wed Jul 09 08:41:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4lZN-0003CH-Le
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 08:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbaGIGl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 02:41:29 -0400
Received: from mout.web.de ([212.227.17.11]:58067 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbaGIGl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 02:41:28 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MA5v3-1Wu0zB3xHt-00BOZ1; Wed, 09 Jul 2014 08:40:25
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <53BC53C3.1010304@ramsay1.demon.co.uk>
X-Provags-ID: V03:K0:RXY5xHMWwn3GUsCrLcqSZZvfgVUOPOtQagOlKeJFaR8sStkWd0P
 d3WBkH7DyAiAzziG0LpTxABUf0l87jLQYcVQJJpbEuUfsa1VsPqQTCTqAp4tEozoFmE3H3m
 rzRrVxzDYdr+JEozUHwvG5zBDAIgo4K9VKJ2nYoBkfLOPEv6Yvw430XDx94zH3zYV2U7mly
 ZG1uKUz3LUKqT4vXckclQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253070>

On 07/08/2014 10:25 PM, Ramsay Jones wrote:
> On 08/07/14 20:34, Jens Lehmann wrote:
>> Am 07.07.2014 21:40, schrieb Torsten B=F6gershausen:
>>> On 2014-07-07 19.05, Junio C Hamano wrote:
>>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>>
>>>>> Junio, do you want me to resend 02/14 without the non-portable "e=
cho -n"
>>>>> or could you just squash the following diff in?
>>>> Amended locally here already; thanks, both.
>>> There seems to be some other trouble under Mac OS, not yet fully tr=
acked down,
>>> (may be related to the "diff -r")
>> Torsten sees failures of this kind under Mac OS:
>>
>> diff -r .git/modules/sub1/config sub1/.git/config
>> 6d5
>> <     worktree =3D ../../../sub1
>> 8a8
>>>      worktree =3D ../../../sub1
>> So the config contains the same content, but the worktree setting mo=
ved
>> to a different line. This seems to be the result of setting core.wor=
ktree
>> in the test_git_directory_is_unchanged function just before the "dif=
f -r",
>> but only under Mac OS.
>>
>>> And Msysgit complains
>>> error: fchmod on c:/xxxt/trash directory.t7613-merge-submodule/subm=
odule_update_repo/.git/modules/sub1/config.lock failed: Function not im=
plemented
>> I'm not sure what this is about, seems to happen during the "cp -R" =
of
>> the repo under .git/modules into the submodule.
> I haven't looked into this at all, but from the above message, and
> noting that fchmod() is not implemented in mingw (see compat/mingw.h
> line 91), and the following:
>
>      $ git grep -n fchmodcommit daa22c6f8da466bd7a438f1bc27375fd737ff=
cf3
> Author: Eric Wong <normalperson@yhbt.net>
> Date:   Tue May 6 00:17:14 2014 +0000
>
>      config: preserve config file permissions on edits
>     =20
>
>      compat/mingw.h:91:static inline int fchmod(int fildes, mode_t mo=
de)
>      config.c:1639:          if (fchmod(fd, st.st_mode & 07777) < 0) =
{
>      config.c:1640:                  error("fchmod on %s failed: %s",
>      config.c:1818:  if (fchmod(out_fd, st.st_mode & 07777) < 0) {
>      config.c:1819:          ret =3D error("fchmod on %s failed: %s",
>      $
>
> [I happen to be on the pu branch at the moment, so YMMV!]
>
> Both calls to fchmod() above are on config lock files, one
> in git_config_set_multivar_in_file() and the other in
> git_config_rename_section_in_file().
>
>

commit daa22c6f8da466bd7a438f1bc27375fd737ffcf3
Author: Eric Wong <normalperson@yhbt.net>
Date:   Tue May 6 00:17:14 2014 +0000

     config: preserve config file permissions on edits

(And why is it  "& 07777" and not  "& 0777")
Can we avoid the fchmod()  all together ?
