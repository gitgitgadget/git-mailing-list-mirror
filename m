From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git prompt: Use toplevel to find untracked files.
Date: Sun, 15 Mar 2015 14:18:50 -0700
Message-ID: <xmqqd24at0w5.fsf@gitster.dls.corp.google.com>
References: <xmqqmw3hzakn.fsf@gitster.dls.corp.google.com>
	<1426420144-10584-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Cody A Taylor <cody.taylor@maternityneighborhood.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Mar 15 22:19:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXFw1-0001Xb-EX
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 22:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbbCOVSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2015 17:18:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751300AbbCOVSw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 17:18:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CFAA3FCEA;
	Sun, 15 Mar 2015 17:18:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Gi2YckweAZsv
	G4guSz0OKNunqZQ=; b=eYhIO9RygzPET9MPZ1xTysg0+QQgFwkC0Kzfm39Tt5Tn
	AeBWneEM/RXUKVFeDA0ohfV3DdXkvos8+kQWlbsKzChcVlzUbRrzneJ9IGh6Lv7A
	TMjqbihUA3R2ni2DLJwC/mjcwnxHOJhxAjvbE7eeqabbRB0rvpTn1CxtOsN+PQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xqfiCq
	8HYKUkMCEC7cDwt46b8TvV65zz8y/ktMWg2/LhKRFCQR/WK4+FIbD/1uxVLkKJcS
	6Ib3Bpa+Q+EEA6uG8Kv3J03EZFs2kB840WPc1rgKGpdu7VxrcojHPoWC3d/bc50/
	KY/c88li7YKwZkkWjiHrZvUauFo7HA3ZS/p14=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 338103FCE9;
	Sun, 15 Mar 2015 17:18:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B01B13FCE8;
	Sun, 15 Mar 2015 17:18:51 -0400 (EDT)
In-Reply-To: <1426420144-10584-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Sun, 15 Mar 2015 12:49:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0D208E4-CB58-11E4-A3C4-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265525>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Hi,
>
> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Cody A Taylor <cody.taylor@maternityneighborhood.com> writes:
>>> The __git_ps1() prompt function would not show an untracked
>>> state when the current working directory was not a parent of
>>> the untracked file.
>>
>> Good find, and nicely explained.
>
> Somehow I had a hard time making sense out of "when the current worki=
ng
> directory was not a parent of the untracked file".  Perhaps "when the
> untracked files are outside of the current working directory" would b=
e
> easier to grok?

Sounds good; let me use that when squashing your test updates in.

Thanks, both.

>
>> I wonder if we can add a test
>> or two to t9903-bash-prompt.sh?
>
> This test fails without the patch in question and succeeds with it.
>
> -- 8< --
>
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 51ecd3e..3d1a95f 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -397,6 +397,16 @@ test_expect_success 'prompt - untracked files st=
atus indicator - untracked files
>  	test_cmp expected "$actual"
>  '
> =20
> +test_expect_success 'prompt - untracked files status indicator - unt=
racked files outside cwd' '
> +	printf " (master %%)" >expected &&
> +	(
> +		cd ignored_dir &&
> +		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
> +		__git_ps1 >"$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
>  test_expect_success 'prompt - untracked files status indicator - she=
ll variable unset with config disabled' '
>  	printf " (master)" >expected &&
>  	test_config bash.showUntrackedFiles false &&
