From: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Subject: Re: [RFC/PATCH v2] pull: add --set-upstream
Date: Tue, 7 Jun 2016 14:54:20 +0200
Message-ID: <22613f02-06b8-9f5f-fd92-15df3ca3a34f@grenoble-inp.org>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
 <20160606093437.1992-1-erwan.mathoniere@grenoble-inp.org>
 <vpqvb1mgvn5.fsf@anie.imag.fr> <xmqqoa7ew319.fsf@gitster.mtv.corp.google.com>
 <vpqeg89bhqt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.de-gea@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 14:54:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAGWZ-0005nc-DX
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 14:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbcFGMyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 08:54:23 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:53982 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbcFGMyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 08:54:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A20E7256B;
	Tue,  7 Jun 2016 14:54:20 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LElUNFy2ar0v; Tue,  7 Jun 2016 14:54:20 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 916B22561;
	Tue,  7 Jun 2016 14:54:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 8E0CA2066;
	Tue,  7 Jun 2016 14:54:20 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A11TSDZOKp6b; Tue,  7 Jun 2016 14:54:20 +0200 (CEST)
Received: from [130.190.32.141] (eduroam-032141.grenet.fr [130.190.32.141])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 781532064;
	Tue,  7 Jun 2016 14:54:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <vpqeg89bhqt.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296669>



On 07/06/2016 09:06, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>>> +test_config_unchanged () {
>>>> +	git config --list --local >original
>>>> +	"$@"
>>>> +	git config --list --local >modified
>>>> +	test_cmp original modified
>>>> +}
>>>
>>> The test passes if "$@" fails. You should &&-chain the lines here to
>>> catch things like crashes or unexpected "exit 1" in git.
>>
>> That is true, but allowing "$@" failure may be deliberate.
>
> I don't think so:
>
> +test_expect_success 'pull -u should not work when merging unrelated histories' '
> +	git checkout master &&
> +	test_config_unchanged test_must_fail git pull -u step_parent master
> +'
>
> ;-)
>

When writing `test_config_unchanged` procedure, I wanted to return the 
comparison even if "$@" failed. But it's indeed not consistent with the 
way I wrote the tests.

Adding "&&" between instructions and using `test_must_fail` when calling 
the procedure is clearer and more logical.
