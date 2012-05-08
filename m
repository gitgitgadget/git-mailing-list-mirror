From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] checkout: do not corrupt HEAD on empty repo
Date: Tue, 8 May 2012 18:52:11 +0200
Message-ID: <CABPQNSbyh8oMfz8GbDDn_bdLc8RpEt5sq7wxtVFh61ekD_j8yQ@mail.gmail.com>
References: <1336493114-4984-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSau5snkNLqsnBnsLVBVNKHXnvb8rsE8DbNfpo9__5uijA@mail.gmail.com> <7vsjfawrmw.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j.sixt@viscovery.net, schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 18:52:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnek-0004EH-CM
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351Ab2EHQwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 12:52:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47423 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757256Ab2EHQwx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 12:52:53 -0400
Received: by pbbrp8 with SMTP id rp8so8258575pbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ruNioLymojHqzvi12ucy+ccRzqlEjHWdk3zSNsyZhSU=;
        b=Dn3G1dnN0/fcFVsDRUewCU6M5Vsfais2c811rCnBijg2ULnof7sCEfN12BoWti34Ov
         iYBPciQaWIYY6LayWWjyMawRvfnZle7ePo5CUvunfZyF1pQLxGW4djOibsnTugYM34xe
         eR8sEihbHz1Suw/YQlxJe4EGoiCr06nGgnJ4szMWApdLGCt9cJjk41kRnN1weI3qrjjy
         mjFMEPwnMlrkvLjNzFtLkXLNJoAV0dXLwyCwt64Q+HddXtwS5v7G1RMJxiUx7qjYU3zN
         FGq8t2qI1Sg/vCWsCL2+EREp22novW44jX5dWmFuE7LnVQ/cIJ1khE3GI29hmbJgMLfW
         J8JQ==
Received: by 10.68.202.167 with SMTP id kj7mr9680436pbc.9.1336495973309; Tue,
 08 May 2012 09:52:53 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Tue, 8 May 2012 09:52:11 -0700 (PDT)
In-Reply-To: <7vsjfawrmw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197393>

On Tue, May 8, 2012 at 6:43 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Hmh, this is needlessly cluttery. The following should cover it:
>>
>> ---
>> diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
>> index 2fa9458..b49fedf 100755
>> --- a/t/t2015-checkout-unborn.sh
>> +++ b/t/t2015-checkout-unborn.sh
>> @@ -50,10 +50,7 @@ test_expect_success 'checking out in a newly crea=
ted repo' '
>> =A0 =A0 =A0 test_create_repo empty &&
>> =A0 =A0 =A0 (
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd empty &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 cat .git/HEAD >expect &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 test_must_fail git checkout &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 cat .git/HEAD >actual &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 test_cmp expect actual
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_must_fail git checkout
>> =A0 =A0 =A0 )
>> =A0'
>
> Hrm, I am of two minds. =A0Yes, we may want checkout to fail, but at =
the
> same time, we would want to make sure that a failed checkout does not
> corrupt the HEAD.

Good point.

> =A0Perhaps it would make it more palatable if you replaced
> "cat .git/HEAD" with "git symbolic-ref HEAD" in the original?

Ah, yes. That's much better. Do you want me to resend (improving the
test and replacing "CRT" with "vsnprintf")? I also spotted a typo in
the commit message ("crasheed" vs "crashed")...
