From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] core.precomposeunicode is true by default
Date: Tue, 27 Aug 2013 17:06:35 +0200
Message-ID: <521CC07B.4000504@web.de>
References: <201307270321.32398.tboegi@web.de> <7vmwp5z3iu.fsf@alter.siamese.dyndns.org> <521CAD88.4080609@web.de> <xmqqvc2rfau9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:06:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEKr6-0002Nk-ID
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704Ab3H0PGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 11:06:48 -0400
Received: from mout.web.de ([212.227.17.12]:61607 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab3H0PGs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:06:48 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MYefK-1Varxc26MM-00VREl for <git@vger.kernel.org>; Tue,
 27 Aug 2013 17:06:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqvc2rfau9.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:DFwaeMGFm4jTzODm1INCTZ/vvWb41r3aj72HTDgzv8PNDNP+Mil
 H/Z6ulDlKgY3NNx3QQT2//wnR35P8TC2vIfJof36iEZdDtT98XSppK4jCp1LPjTxfkVnLV0
 3m0X3cnGqufQQaIR3XfNJ0nXm7s+wnQqCPPnj/DvDG8B89BC6SJoTC1I5pE5/l2pF9XPODG
 qwA0MWXd2O1EgidqpAlBA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233097>

On 27.08.13 16:49, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>>> ... see if that path can be seen under its alias.  Why do we set it
>>> to "false"?  Isn't this the true culprit?
>>>
>>> After all, this is not in the "reinit" codepath, so we know we are
>>> dealing with a repository that was created afresh.
>> There is nothing wrong with the auto-sensing as such.
>> The problem for many users today is that we set core.precomposeunico=
de
>> to false, when it should be true.
> I think we are in agreement then.
>
> The code detects a broken filesystem just fine, but what it does
> when it finds the filesystem is broken is wrong---it sets the
> variable to false.  That makes the whole auto-sensing wrong, and I
> think it makes sense to correct that behaviour.
>
>> Let's look what precomposed_unicode does and go through a couple
>> of git operations.
>>
>> 1)
>> When we create a repo under Mac OS using HFS+,
>> we want to have precomposed_unicode =3D 1
> Yes.
>
>> 2)
>> When we access a repo from Windows/Linux using SAMBA,
> You mean s/repo/repository that resides on HFS+/?
Sorry being unclear here, trying being clearer with an example:
I have a /data/Docs on my linux box, which is handled by git

I export /data/Docs via SAMBA, and use the Finder under Mac OS to have =
it
mounted on my Mac OS X box:
//tb@Linux/Docs on /Volumes/Docs (smbfs, nodev, nosuid, mounted by tb)
>> readdir() will return decomposed.
>> When the repo is created by nonMacOS, core.precomposeunicode is unde=
fined.
>> The precomposition is off, but should be on,=20
>> precomposed_unicode =3D -1, but should be =3D 1
> I do not think UTF-8-MAC is widely available; even if you flip the
> bit on, would it help much?
In the above example
/data/Docs/.git/config was created by Linux, so it does not have
core.precomposeunicode set, neither false nor true.
The Linux box does not have  UTF-8-MAC under iconv,
but will ignore core.precomposeunicode anyway (since the code is not co=
mpiled here)

The Mac OS machine sees it under /Volumes/Docs/.git/config
And here we want the precomposition, even if core.precomposeunicode
is not present in the config.

=20
