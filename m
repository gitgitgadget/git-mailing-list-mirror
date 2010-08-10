From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Black smoke from git rebase -i exec
Date: Tue, 10 Aug 2010 16:12:46 +0200
Message-ID: <4C615E5E.3090301@viscovery.net>
References: <AANLkTikCgSNRipTbjiL+uPOqCL3WXwn08_QV=UJ7EwvT@mail.gmail.com>	<vpqlj8ezizq.fsf@bauges.imag.fr> <AANLkTimgRu=nRFpO+QW758SWbQ+Vs+8gtpAc4N-cNWr6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 16:13:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OipZZ-0004Qc-TG
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 16:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757728Ab0HJOMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 10:12:53 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50764 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757505Ab0HJOMw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 10:12:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OipZP-0006Xq-CF; Tue, 10 Aug 2010 16:12:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1F3581660F;
	Tue, 10 Aug 2010 16:12:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <AANLkTimgRu=nRFpO+QW758SWbQ+Vs+8gtpAc4N-cNWr6@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153108>

Am 8/10/2010 15:57, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Tue, Aug 10, 2010 at 13:37, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>>
>>> There's some black smoke in pu after the git rebase -i series was
>>> applied: http://smoke.git.nix.is/app/projects/report_details/14
>>
>> Strange, I can't reproduce this on my box (tried on RHEL x86_64 and
>> Debian i686).
>=20
> Hi. The issue appears to be that there's some non-POSIX code in your
> patch (but I didn't check what). The test works for me with bash, but
> fails with dash (which is the Debian testing /bin/sh).
>=20
> Can you try with dash or some other non-bash POSIX shell and see if i=
t
> fails?

The culprit is commands like these:

	FAKE_LINES=3D"exec_echo_foo_>file1 1" \
		test_must_fail git rebase -i HEAD^ &&

You cannot apply single-command-export if the command is a shell functi=
on.
You must rewrite this as:

	(
		export FAKE_LINES=3D"..." &&
		test_must_fail git rebase ....
	) &&

-- Hannes
