From: Nick Townsend <nick.townsend@mac.com>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: Tue, 26 Nov 2013 19:33:45 -0800
Message-ID: <8C8E104C-D88D-47C9-A796-6634BABFAB3E@mac.com>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
 <5294BB97.7010707@web.de> <20131126223858.GA4774@sandbox-ub>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Nov 27 04:34:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlVtS-0001jD-NI
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 04:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab3K0DeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 22:34:23 -0500
Received: from nk11p03mm-asmtp001.mac.com ([17.158.232.236]:40676 "EHLO
	nk11p03mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827Ab3K0DeW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 22:34:22 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MWW005YPKL1SH40@nk11p03mm-asmtp001.mac.com> for
 git@vger.kernel.org; Wed, 27 Nov 2013 03:34:14 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-11-27_02:2013-11-26,2013-11-27,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1311260228
In-reply-to: <20131126223858.GA4774@sandbox-ub>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238405>


On 26 Nov 2013, at 14:38, Heiko Voigt <hvoigt@hvoigt.net> wrote:

> Hi,
>=20
> I like where this is going.
>=20
> On Tue, Nov 26, 2013 at 04:17:43PM +0100, Ren=E9 Scharfe wrote:
>> Am 26.11.2013 01:04, schrieb Nick Townsend:
>>> +		strbuf_addstr(&dotgit, work_tree);
>>> +		strbuf_addch(&dotgit, '/');
>>> +		if (args->treepath) {
>>> +			  strbuf_addstr(&dotgit, args->treepath);
>>> +			  strbuf_addch(&dotgit, '/');
>>> +		}
>>> +		strbuf_add(&dotgit, path_without_prefix,strlen(path_without_pref=
ix)-1);
>>> +		if (add_submodule_odb(dotgit.buf))
>>> +			  die("Can't add submodule: %s", dotgit.buf);
>>=20
>> Hmm, I wonder if we can traverse the tree and load all submodule obj=
ect
>> databases before traversing it again to actually write file contents=
=2E
>> That would spare the user from getting half of an archive together w=
ith
>> that error message.
>=20
> I am not sure whether we should die here. What about submodules that
> have not been initialized and or cloned? I think that is a quite regu=
lar
> use case for example for libraries that not everyone needs or big med=
ia
> submodules which only the design team uses. How about skipping them (=
maybe
> issuing a warning) by returning 0 here and proceeding?
>=20
> Cheers Heiko

I agree that issuing a warning and continuing is best. If the submodule=
 hasn=92t been setup
then we should respect that and keep the current behaviour (just archiv=
e the directory entry).
There is some further debate to be had about the extent to which this s=
hould work with
un-initialized submodules which I=92ll discuss in other replies.

Thanks
Nick