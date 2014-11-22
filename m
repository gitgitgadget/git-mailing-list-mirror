From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Sat, 22 Nov 2014 15:59:12 +0100
Message-ID: <5470A4C0.3070501@web.de>
References: <546F5CC7.8060904@drmicha.warpmail.net> <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net> <20141121180105.GB26650@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Nov 22 15:59:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsCA9-0003zP-LY
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 15:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbaKVO7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2014 09:59:44 -0500
Received: from mout.web.de ([212.227.15.4]:61256 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbaKVO7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 09:59:43 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M3xKs-1YAHCe41WU-00rUn3; Sat, 22 Nov 2014 15:59:19
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141121180105.GB26650@peff.net>
X-Provags-ID: V03:K0:e8pHk7DZtJ/N/uePLptBo5hCXtEB3WQ+U8FKylywQhtVyAKRcOR
 7W8Bd2TL8BmwMhWKP100EUeOrikPYxm/GW8kANfiufWzuKjOcyfm26XDrV3tBoUKdKFKMGm
 e2p2sMVBxWsCwv4d+MdfsTmdVgknO8P3Ft/OWNo9jjJHhkWQKsQmDYlDrelCyyKXZsWT97/
 yMPgaA3JKvWRhACQmqLkg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260070>

>> +test_expect_success 'error out when attempting to add ignored ones but add others' '
>> +	touch a.if &&
>> +	test_must_fail git add a.?? &&
>> +	! (git ls-files | grep "\\.ig") &&
>> +	(git ls-files | grep a.if)
>> +'
> 
> I am somewhat allergic to pipes in our test suite, because they can mask
> errors (especially with a negated grep, because we do not know if they
> correctly produced any output at all). But I guess this is matching the
> surrounding code, and it is quite unlikely for `ls-files` to fail in any
> meaningful way here. So I think it's fine.
> 
> -Peff

2 small comments:
Why the escaped "\\.ig" and the unescaped "a.if"  ?

The other question, this is a more general one, strikes me every time I see
! grep

Should we avoid it by writing "test_must_fail" instead of "!" ?
(The current code base has a mixture of both)

The following came into my mind when working on another grepy thing,
and it may be unnecessary clumsy:

test_expect_success 'error out when attempting to add ignored ones but add others' '
	touch a.if &&
	test_must_fail git add a.?? &&
	git ls-files >files.txt &&
	test_must_fail grep a.ig files.txt >/dev/null &&
	grep a.if files.txt >/dev/null &&
	rm files.txt
'

(It feels as if there should be a "grepnot" ;-)


The 3rd comment:
Thanks for taking this up!
