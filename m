From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] init - Honour the global core.filemode setting
Date: Fri, 03 Oct 2014 18:54:16 +0200
Message-ID: <542ED4B8.40603@web.de>
References: <CAE1pOi0zhnUNNdHsrq+4H_6LiFnr-qoY-owrcJquy6dyG+Mk4g@mail.gmail.com>	<5427F68E.5030003@web.de>	<CAE1pOi1dAO7XFZtrgZyNm-eLVKQx=KpeejbGmF8khCofAppDLg@mail.gmail.com>	<xmqqy4szpvfv.fsf@gitster.dls.corp.google.com>	<542D33E1.6080709@web.de> <xmqqzjdeo16d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 03 18:54:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa67h-0005Ml-0U
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 18:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbaJCQyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Oct 2014 12:54:25 -0400
Received: from mout.web.de ([212.227.17.11]:51172 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828AbaJCQyY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 12:54:24 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MQepd-1XfqM831ET-00Tynd; Fri, 03 Oct 2014 18:54:17
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqqzjdeo16d.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:jBJPTCMmW//BXbjDmxaiYNVxL/EiOiS1PHgAK1ltXgQgYuvAJi4
 lHh57dOrtesVDcZ9qeA56PMkWcCIU8ScggrsGiATAguKwTRXemL5XgTvPPhJ0fCRO0cE0X+
 ZKG9GYugrtnUw9It+3UYVDkxTlYmZwWj3J6MZekjyIBZqDa1aCdRkdPwAYAMoqLlaSqTBRH
 Dmj0S6BB4V0uwWYQh3yoA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257840>

On 2014-10-02 19.02, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> On 2014-10-01 19.10, Junio C Hamano wrote:
>>> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>>
>>>> Perhaps I completely misunderstand the meaning of core.filemode bu=
t I
>>>> thought it determined whether Git cared about changes in file
>>>> properties?
>>>
>>> By setting it to "false", you tell Git that the filesystem you
>>> placed the repository does not correctly represent the filemode
>>> (especially the executable bit).
>>>
>>> "core.fileMode" in "git config --help" reads:
>>>
>>>        core.fileMode
>>>            If false, the executable bit differences between the
>>>            index and the working tree are ignored; useful on broken
>>>            filesystems like FAT. See git-update- index(1).
>>
>> Out of my head: Could the following be a starting point:
>>
>>         core.fileMode
>>             If false, the executable bit differences between the
>>             index and the working tree are ignored.
>>             This may be usefull when visiting a cygwin repo with a n=
on-cygwin
>>             Git client. (should we mention msysgit ? should we menti=
on JGit/EGit ?)
>=20
> Between these two sentences, there may still be the same cognitive
> gap that may have lead to the original confusion.
>=20
> The first sentence says what happens, as it should.
>=20
> But it is not directly clear what makes the executable bit differ
> and when it is a useful thing to ignore the differences, so the
> second sentence that says "This may be useful" does not give the
> reader very much.
>=20
Clearly a major improvement.

Does this (still) include the original line
"See linkgit:git-update-index[1]"

which helps the user to add *.sh files "executable" to the index, even =
if
core.filemode is false ?
One minor improvement below.

> Here is my attempt.
>=20
> 	Tells Git if the executable bit of files in the working tree
> 	is to be honored.
>=20
> 	Some filesystems lose the executable bit when a file that is
> 	marked as executable is checked out, or checks out an
> 	non-executable file with executable bit on.  "git init" and
> 	"git clone" probe the filesystem to see if it records
> 	executable bit correctly when they create a new repository
> 	and this variable is automatically set as necessary.
>=20
>         A repository, however, may be on a filesystem that records
>         the filemode correctly, and this variable is set to 'true'
>         when created, but later may be made accessible from another
>         environment that loses the filemode (e.g. exporting ext4 via
>         CIFS mount, visiting a Cygwin managed repository with
>         MsysGit).  In such a case, it may be necessary to set this
>         variable to 'false'.
          ^^^^^^^^=20
