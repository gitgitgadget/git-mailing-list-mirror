From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Wed, 06 Feb 2013 21:16:13 +0100
Message-ID: <5112BA0D.6020200@web.de>
References: <201301271557.08994.tboegi@web.de> <CABPQNSYmGhaDG0Dzpp2C0ZwKoFwP5EokJW+TC8JT-Bw6rKa79A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	ramsay@ramsay1.demon.co.uk, git@vger.kernel.org, j6t@kdbg.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 06 21:16:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3BQ4-0004n8-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205Ab3BFUQO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2013 15:16:14 -0500
Received: from mout.web.de ([212.227.17.11]:62609 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756394Ab3BFUQN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:16:13 -0500
Received: from [192.168.209.22] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lxf5f-1V0Avh33CV-016clD; Wed, 06 Feb 2013 21:16:11
 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CABPQNSYmGhaDG0Dzpp2C0ZwKoFwP5EokJW+TC8JT-Bw6rKa79A@mail.gmail.com>
X-Provags-ID: V02:K0:3VytoePXhPGgPdpacaudcs1RvLM8K79QinlSkJHytHw
 swhzE/5TOavtTSCxnul5iV5+wzh42ZZVX4np1i4iz7tYlgKHdE
 Dx3QxL27iL3TF8aHU/VD7h+g+SQXxOa/ZDCxr5jZ9NhP+LNjKe
 yUGu6LNm2AfvnT1QbN+H/DWPjmj7XYrXL9JL+9FKvLKxp8Z+Br
 fDVXjufbhLdCq5Kfd2JWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215631>

Am 2013-02-06 10:34, schrieb Erik Faye-Lund:
> On Sun, Jan 27, 2013 at 3:57 PM, Torsten B=F6gershausen <tboegi@web.d=
e> wrote:
>> t0070 and t1301 fail when running the test suite under cygwin.
>> Skip the failing tests by unsetting POSIXPERM.
>>
>
> But is this the real reason? I thought Cygwin implemented POSIX permi=
ssions...?
t0070:
  'mktemp to unwritable directory prints filename'
   mkdir cannotwrite &&
   chmod -w cannotwrite &&
   test_when_finished "chmod +w cannotwrite" &&
   test_must_fail test-mktemp cannotwrite/testXXXXXX 2>err &&
   grep "cannotwrite/test" err

When a directory under Linux/*nix has no write permission,
it is not allowed to create another directory (or file..) here.
This is not working under cygwin, a directory/file can be created
even if the parent directory has chmod 0.
-------------
tb@PC /cygdrive/c/temp
$ mkdir ttt

tb@PC /cygdrive/c/temp
$ chmod 0 ttt

tb@PC /cygdrive/c/temp
$ ls -ld ttt
d---------+ 1 tb None 0 Feb  6 20:33 ttt

tb@PC /cygdrive/c/temp
$ touch ttt/x

tb@PC /cygdrive/c/temp
$ ls -ld ttt
d---------+ 1 tb None 0 Feb  6 20:33 ttt

tb@PC /cygdrive/c/temp
$ ls -l ttt
total 0
-rw-r--r--+ 1 tb None 0 Feb  6 20:33 x
-------------------------------------------

If this is POSIX compliant? I'm not an expert here.
On the other hand:
This test case does not test git, but rather the file system,
so we can probaly remove it?

About 1301:
Some resereach needs to be done, to find out the connection between
umask, cygwin and the mount options.

On my system I have:
$mount
C: on /cygdrive/c type ntfs (binary,posix=3D0,user,noumount,auto)

/Torsten
