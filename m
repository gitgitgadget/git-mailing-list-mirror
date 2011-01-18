From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t/t5400-send-pack.sh: add test_when_finished
 commands
Date: Tue, 18 Jan 2011 15:10:57 -0800
Message-ID: <7vfwspkdtq.fsf@alter.siamese.dyndns.org>
References: <1295386896-21828-1-git-send-email-avarab@gmail.com>
 <1295386896-21828-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 00:11:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfKhl-0003i1-MI
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 00:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab1ARXLI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 18:11:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab1ARXLG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jan 2011 18:11:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA6B02ED3;
	Tue, 18 Jan 2011 18:11:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DU0JKmJqyOok
	vC/ohkpmn6Jb+CM=; b=NfqaU3ykVkzmK06jSCEIIe16MNfwQyKA2/IW9JzrQV3z
	qZwCx+qwXPnqYxxUSzD6FuOloU7+3f2YsRET+YrfkE7Wi26Hd7R8f6K600dK4DSW
	9wmeNHsz2grwqOHtviwcetaqn94CCnhaU5kcCFky+ehk7+ltPWGlVk3cnjNK6wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Aa+MO8
	LFS8hs1bl05vgCj0SQsV4npwZ55YkKa5F5agvW0SpSh/IeAg3ewmPzaBd4NxyjHm
	TUml8NE+0FSEyTvAyqTcUxMG73cHgZ8ZG5vhauqigg9H3Bd8SoRHJgPHRLz/IU3O
	9moGk/H9ghl6i4/VyqhyNer1pBXchANmgTvxs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A70A02ED1;
	Tue, 18 Jan 2011 18:11:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B050B2ECF; Tue, 18 Jan 2011
 18:11:45 -0500 (EST)
In-Reply-To: <1295386896-21828-2-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue\, 18 Jan
 2011 22\:41\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 538504DE-2358-11E0-BA48-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165231>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index 656ab1a..0357610 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -90,7 +90,8 @@ test_expect_success 'refuse deleting push with deny=
Deletes' '
>  	    git config receive.denyDeletes true &&
>  	    git branch extra master
>  	) &&
> -	test_must_fail git send-pack ./victim :extra master
> +	test_must_fail git send-pack ./victim :extra master &&
> +	test_when_finished "(cd victim && git config --unset receive.denyDe=
letes)"
>  '

I agree that you are trying to do a good thing, but does this
implementation work in practice?  If somebody breaks send-pack in such =
a
way that this push succeeds, doesn't the &&-chain will prevent your
"when-finished" hook to be registered to begin with?  IOW, wouldn't you
want to have when-finished as _early_ as possible, before any test that
might fail to help us identify a new breakage?

The same comment applies to other two hunks in the patch.
