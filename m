From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Wed, 18 Sep 2013 16:29:05 +0200
Message-ID: <5239B8B1.5050605@web.de>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com> <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com> <5231CBFA.3070806@web.de> <5231F839.3080208@kdbg.org> <xmqq8uz1q2i4.fsf@gitster.dls.corp.google.com> <CANYiYbE6nT+9LrekWp7mryJ13RxQBSQ+p6EyQspAKBMj7oG0zQ@mail.gmail.com> <xmqq7gelmfm5.fsf@gitster.dls.corp.google.com> <CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com> <5238AE60.1010700@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 18 16:29:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMIl4-00047u-DN
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 16:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab3IRO3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 10:29:21 -0400
Received: from mout.web.de ([212.227.17.12]:64750 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab3IRO3P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 10:29:15 -0400
Received: from [192.168.209.26] ([217.208.218.204]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MbyIM-1Vfcqu201O-00JMCP for <git@vger.kernel.org>;
 Wed, 18 Sep 2013 16:29:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <5238AE60.1010700@kdbg.org>
X-Provags-ID: V03:K0:DVD+Hn7+2+mozb91ELW6Nib5Od50Sub9YnctFSw+s1mxo5vdWIN
 MfaHnKsExuopwdvou8x0T+LpxLDzzNNWRb4GBzq7+++v9vZ0mL2xjrpQGBe6vYR3EsyNAnR
 hdo3T5vgzbrzpoBn4ZIZouCiLsCo6E7bok/AH52kORpNlSijp8e/yThLrEcpFdWqpCrOVOu
 DVt/xgZ77CUI7WYbMp+vA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234966>

On 2013-09-17 21.32, Johannes Sixt wrote:
> Am 17.09.2013 10:24, schrieb Jiang Xin:
>> I have checked the behavior of UNC path on Windows (msysGit):
>>
>> * I can cd to a UNC path:
>>
>>     cd //server1/share1/path
>>
>> * can cd to other share:
>>
>>     cd ../../share2/path
>>
>> * and can cd to other server's share:
>>
>>     cd ../../../server2/share/path
>>
>> That means relative_path(path1, path2) support UNC paths out of the box.
>> We only need to check both path1 and path2 are UNC paths, or both not.
> 
> Your tests are flawed. You issued the commands in bash, which (or rather
> MSYS) does everything for you that you need to make it work. But in
> reality it does not, because the system cannot apply .. to //server/share:
> 
> $ git ls-remote //srv/public/../repos/his/setups.git
> fatal: '//srv/public/../repos/his/setups.git' does not appear to be a
> git repository
> fatal: Could not read from remote repository.
> 
> Please make sure you have the correct access rights
> and the repository exists.
> 
> even though the repository (and //srv/public, let me assure) exists:
> 
> $ git ls-remote //srv/repos/his/setups.git
> bea489b0611a72c41f133343fdccbd3e2b9f80b5        HEAD
> ...
> 
> The situation does not change with your latest round (v3).
> 
> Please let me suggest not to scratch where there is no itch. ;) Your
> round v2 was good enough.
> 
> If you really want to check UNC paths, then you must compare two path
> components after the the double-slash, not just one.
> 
> Furthermore, you should audit all code that references
> is_absolute_path(), relative_path(), normalize_path_copy(), and possibly
> a few others whether the functions or call sites need improvement.
> That's worth a separate patch.
> 
> -- Hannes

I tend to agree here.
The V2 patch fixed a regression.
This should be one commit on its own:
Documentation/SubmittingPatches:
(1) Make separate commits for logically separate changes.

Fixing a bug is a good thing, thanks for working on this,

The support for UNC paths is a new feature, and this deserves a seperate commit.
/Torsten
