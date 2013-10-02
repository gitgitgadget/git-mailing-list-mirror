From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] clone: local URLs are not for ssh
Date: Wed, 02 Oct 2013 20:40:05 +0200
Message-ID: <524C6885.8020602@web.de>
References: <201309282137.21802.tboegi@web.de> <CACsJy8B-wA=bX6+E6O6UvX2vEtOwnR1PCMZNoi-q0x_jacB89Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 02 20:40:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRRLR-0003sE-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 20:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab3JBSkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Oct 2013 14:40:15 -0400
Received: from mout.web.de ([212.227.15.3]:56172 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366Ab3JBSkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 14:40:14 -0400
Received: from [192.168.209.26] ([217.208.218.204]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LaTdP-1W741j3AND-00mH3I for <git@vger.kernel.org>;
 Wed, 02 Oct 2013 20:40:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CACsJy8B-wA=bX6+E6O6UvX2vEtOwnR1PCMZNoi-q0x_jacB89Q@mail.gmail.com>
X-Provags-ID: V03:K0:GESX/8uC4PyYV+afMJJHoWLRkg+gdLTBTGkDRV6cEV/luyvBe7H
 C5yO7yvAHYmSgE7Rv+BWA0VWtxeq7iVNwhfpRsiOKaICTYE8lzx6/8IRYYT5vMRItCkOe5c
 UvzNxWvKNGE8TQoLaHp+QgayGC58LJN1pJtIMG1NtMXAVGnSu8HqvyclyhLLLxyK7DhY0Dv
 Ix2wvwJRe148zai+f4agQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235669>

On 2013-09-29 02.33, Duy Nguyen wrote:
> On Sun, Sep 29, 2013 at 2:37 AM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> "git clone /foo/bar:baz" or "git clone ../foo/bar:baz"
>> are meant to clone from the local file system, and not to clone
>> from a remote server over git-over-ssh.
>=20
> I don't think this is necessary. Commit 6000334 should detect both
> cases fine because both have a slash before the first colon.
Sorry for the noise, I noticed it when I was trying to construct test c=
ases.

What do we think about adding this at the end of t5505:



test_expect_success 'fetch fail [noexistinghost0:2223]:blink.git' '
	(
		! git fetch [noexistinghost0:2223]:blink.git 2>err &&
		grep ssh err &&
		rm err
	)
'

test_expect_success 'fetch fail noexistinghost1:2223:blink.git' '
	(
		! git fetch "noexistinghost1:2223:blink.git" 2>err &&
		grep ssh err &&
		rm err
	)
'

test_expect_success 'fetch fail noexistinghost2:2223' '
	(
		! git fetch "noexistinghost2:2223" 2>err &&
		grep ssh err &&
		rm err
	)
'
test_expect_success 'fetch fail ./noexistinghost4:2223"' '
	(
		! git fetch "./noexistinghost4:2223" 2>err &&
		grep "does not appear to be a git repository" err &&
		rm err
	)
'
