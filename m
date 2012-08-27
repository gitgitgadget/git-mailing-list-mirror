From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: [PATCH 2/3] branch: add --unset-upstream option
Date: Mon, 27 Aug 2012 19:30:34 +0200
Message-ID: <87a9xgnsxx.fsf@centaur.cmartin.tk>
References: <1345470460-28734-1-git-send-email-cmn@elego.de>
	<1345470460-28734-3-git-send-email-cmn@elego.de>
	<7vpq6h2tmk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 19:30:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6397-0006cX-K3
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 19:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab2H0Raf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 13:30:35 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:54046 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab2H0Rae convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 13:30:34 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id 8BC9C800D4;
	Mon, 27 Aug 2012 19:30:32 +0200 (CEST)
Received: (nullmailer pid 11373 invoked by uid 1000);
	Mon, 27 Aug 2012 17:30:34 -0000
In-Reply-To: <7vpq6h2tmk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 23 Aug 2012 14:20:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204360>

Junio C Hamano <gitster@pobox.com> writes:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>
>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index e9019ac..93e5d6e 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -383,6 +383,22 @@ test_expect_success 'use --set-upstream-to modi=
fy a particular branch' \
>>       test "$(git config branch.my13.remote)" =3D "." &&
>>       test "$(git config branch.my13.merge)" =3D "refs/heads/master"=
'
>> =20
>> +test_expect_success 'test --unset-upstream on HEAD' \
>> +    'git branch my14
>> +     test_config branch.master.remote foo &&
>> +     test_config branch.master.merge foo &&
>> +     git branch --set-upstream-to my14 &&
>> +     git branch --unset-upstream &&
>> +     test_must_fail git config branch.master.remote &&
>> +     test_must_fail git config branch.master.merge'
>> +
>> +test_expect_success 'test --unset-upstream on a particular branch' =
\
>> +    'git branch my15
>> +     git branch --set-upstream-to master my14 &&
>> +     git branch --unset-upstream my14 &&
>> +     test_must_fail git config branch.my14.remote &&
>> +     test_must_fail git config branch.my14.merge'
>> +
>
> What should happen when you say "--unset-upstream" on a branch B
> that does not have B@{upstream}?  Should it fail?  Should it be
> silently ignored?  Is it undefined that we do not want to test?

I'd say it should be ignored, as the end result we want is for there to
be no upstream information. What we do underneath is remove a couple of
config options, wich doesn't fail if they didn't insist in the first
place.

Would you like a test that makes sure two --unset-upstream in a row
don't cause any errors?

   cmn
