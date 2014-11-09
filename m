From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 22/22] untracked cache: guard and disable on system
 changes
Date: Sun, 09 Nov 2014 22:39:46 +0100
Message-ID: <545FDF22.2020404@web.de>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com> <1415439595-469-1-git-send-email-pclouds@gmail.com> <1415439595-469-23-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 22:39:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnaDG-0002jN-FD
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 22:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbaKIVjz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 16:39:55 -0500
Received: from mout.web.de ([212.227.15.14]:54140 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbaKIVjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 16:39:54 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0M6mgu-1XzSIe1G6e-00wZLO; Sun, 09 Nov 2014 22:39:52
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1415439595-469-23-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:jjIbsP3G7EGd7l/Czcx5+qZR/4vDlEqMd6fIkuKOxRI+byZFQ4h
 8efxEVisp/jvQPWwTAA0yYkz4xWILWi+tsWwB5g9r9lLW7C49VOlWk3n6FX4weLOfobyd/c
 aeWrRHgZ/BC5VtoVuX6gR5Cpj8wCBBGx0eYTqPfPCZKwOmHoinTqqsIBcG8TA+6SDDS6O1I
 XZoddJqcQcbb+7jjVljag==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-11-08 10.39, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> If the user enables untracked cache, then
>=20
>  - move worktree to an unsupported filesystem

How do we detect this move ?
Shouldn't we be able to detect an unsupported file system=20
(by probing if stat(root_dir_of_repo) =3D=3D stat(what_we_have_in_index=
_file))
>  - or simply upgrade OS
>  - or move the whole (portable) disk from one machine to another
How does this effect Git ?
I would rather expect an update of Git to be an issue,
but knowing that Git strongly tends to be backward compatible, there
shouldn't be a issue.

>  - or access a shared fs from another machine
This is interesting.
I have done some basic test on git.git using a medium fast laptop
talking to a medium fast server using a medium normal WLAN.
git status was is in a range of 2-3 seconds, with your patch 1-1.5 seco=
nds.

(That all depends on the network load, some caching here or there)

But roughly twice the speed, very nice!

I will do some tests with networking file systems, like=20
Linux+ext4 -- SMB -- Windows (cygwin/Git for Windows)
Linux+ext4 -- SMB -- Mac OS X
Linux+ext4 -- NFS -- Linux
Windows    -- SMB -- Linux
Windows    -- SMB -- Mac OS X
(and then we have some cases where a virtual machine runs a "shared" FS=
 with a host file system,
where the untracked cache looks promising)

I am not really sure when we need this protection.
What I understand is that stat(dir).mtime must be reliable.
Another problem may be mixing old Git with new Git, but the old Git
should write an index file without UNTR, and we should be safe ?
The new Git will write an index file with UNTR, which the old Git will =
ignore.

What do I miss ?
