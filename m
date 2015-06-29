From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 04/11] for-each-ref: add '--points-at' option
Date: Tue, 30 Jun 2015 01:25:11 +0530
Message-ID: <CAOLa=ZQTPTdYYphPcQaGtUmhusNAOc7o9jB_mM5KHc0XNWFhPQ@mail.gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com> <1435222633-32007-4-git-send-email-karthik.188@gmail.com>
 <xmqqioa6be6s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 21:55:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9f9f-00086Y-MT
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 21:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbF2Tzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 15:55:42 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35139 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbF2Tzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 15:55:41 -0400
Received: by obbop1 with SMTP id op1so112055532obb.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/VQZuXea+Xiq3W+bNkW1U8K3V76u3uxAKLx/rFblaAA=;
        b=pqOkaBKeBYRP7sGVpYDS0N58u2KtOII8zyNKCCHRlDPjOff19BpTTuYq7eoKM+NIHi
         0RsaOELjNCasmZMgmj3zbzTHXXFISDGTKXD/thvt6LxkfqG4DLR0ml4qTVxZ0NdJXmJA
         zaunFpu2Oiq1U9zrRuoPDGSTjdnOntD6sbO3e2ojAnjZfoW34Z6zYzlGBJ9+S/NdAr0U
         RM9frqOV8bIsynWB7x8MXxA2nxYzisj02MpvsGsg9B8VaDon7U5RObsS/YAX82QSemLN
         JFqughdVxJP2bwhJRKiFuU2YdrHO0AUkGJfFG2IY60RfAEWxALWTKfDCwe3obNQ3wwev
         4kNA==
X-Received: by 10.60.62.105 with SMTP id x9mr12753999oer.1.1435607740630; Mon,
 29 Jun 2015 12:55:40 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 29 Jun 2015 12:55:11 -0700 (PDT)
In-Reply-To: <xmqqioa6be6s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272997>

On Mon, Jun 29, 2015 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add the '--points-at' option provided by 'ref-filter'. The option
>> lets the user to pick only refs which point to a particular
>> commit.
>
> It somehow feels strange that the option name is points-at and all
> the explanation (like the above and also in the doc) talks about
> pointing to an object.  Not limited to this patch but the previous
> one had the same, I think.
>

Will have a look and change, thanks :)

>> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
>> index b1fa8d4..7269a66 100644
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -16,4 +16,24 @@ test_expect_success 'setup some history and refs' '
>>       git update-ref refs/odd/spot master
>>  '
>>
>> +test_expect_success 'filtering with --points-at' '
>> +     cat >expect <<-\EOF &&
>> +     refs/heads/master
>> +     refs/odd/spot
>> +     refs/tags/three
>> +     EOF
>> +     git for-each-ref --format="%(refname)" --points-at=master >actual &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'check signed tags with --points-at' '
>> +     cat >expect <<-\EOF &&
>> +     refs/heads/side
>> +     refs/tags/four
>> +     refs/tags/signed-tag four
>> +     EOF
>> +     git for-each-ref --format="%(refname) %(*subject)" --points-at=side >actual &&
>> +     test_cmp expect actual
>> +'
>
> This shows that we would want to add a "annotated doubly" tag in the
> preparation step 01/11; the expected outcome is that it will not
> show in the output, I think.
>
> Thanks.

Will add!

-- 
Regards,
Karthik Nayak
