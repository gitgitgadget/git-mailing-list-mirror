From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t5541: Improve push test
Date: Wed, 11 Dec 2013 16:13:46 +0100
Message-ID: <52A8812A.4060004@web.de>
References: <201312092103.29047.tboegi@web.de> <xmqq61qxwu8f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>, Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 16:13:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqlU1-0007Ks-5T
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 16:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab3LKPNt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Dec 2013 10:13:49 -0500
Received: from mout.web.de ([212.227.17.12]:56274 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab3LKPNs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 10:13:48 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LpfFO-1VNVHA2YsA-00fOXt for <git@vger.kernel.org>;
 Wed, 11 Dec 2013 16:13:46 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqq61qxwu8f.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:nB23HJAVx2pRz1Xm5/4j4eqZymOmCgvspLZS0xquYcyI2nHBcaq
 ZjJ3+zb9RAtyQtLDFsglRODOJCOWTaJEiUCjxB3LNqOb1lLzROVEPA128Ql9y2EnRGpZ/X7
 rulNwk+UatW/RJPUcqfyq2CQsgPIdQmlxRN6CEkW3jn3nfQA09aFEWgUcYakw751yf5YeGh
 bRnEuCZOcsS3s4bj1LS1g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239204>

On 2013-12-09 23.10, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> The old log-line looked like this:
>>  + 9d498b0...8598732 master -> master (forced update)
>> And the new one like this:
>>    9d498b0..8598732  master -> master
>>
>> - Loosen the grep pattern by not demanding "(forced update)"
>=20
> Hmm, what is the reason for the change the output?  The output this
> piece is testing is the result of this:
>=20
> 	git push origin master:retsam
>=20
> 	echo "change changed" > path2 &&
> 	git commit -a -m path2 --amend &&
>=20
> 	# push master too; this ensures there is at least one '"'push'"' com=
mand to
> 	# the remote helper and triggers interaction with the helper.
> 	test_must_fail git push -v origin +master master:retsam >output 2>&1=
'
>=20
> This is run inside test_repo_clone, which has /smart/test_repo.git
> as its origin, which in turn has 'master' branch (and nothing else).
>=20
> It
>=20
>  - pushes master to another branch retsam;
>=20
>  - amends its 'master';
>=20
>  - attempts to push the updated master to force-update master, and
>    also retsam without forcing.  The latter needs to be forced to
>    succeed, and that is why we expect it to fail.
>=20
> If the output from the push process says
>=20
>   + 9d498b0...8598732 master -> master (forced update)
>   ! [rejected]        master -> retsam (non-fast-forward)
>   error: failed to push some refs to '../test_repo_copy/'
>=20
> I think that is a good thing to do, no?  After all, that is what we
> show with Git native transports.
>=20
> Is this patch merely matching a test to a broken behaviour of some
> sort?  Puzzled...
Thanks for the analysis: I thing the patch isn't the way to go.
The regression in t5541 was introduced in f9e3c6bebb89de12.
Which was a cleanup to previous commits:
"transport-helper: add 'force' to 'export' helpers"
So reverting f9e3c6bebb89de fixes t5541, but breaks
contrib/remote-helpers.

=46elipe, could you have a look, please ?
/Torsten

=20
force
