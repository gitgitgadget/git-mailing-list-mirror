From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 04/12] ref-filter: implement an `align` atom
Date: Tue, 25 Aug 2015 19:00:13 +0530
Message-ID: <CAOLa=ZS1EiU3FFLwR3QUUebCtVkrwUS=qP9xvc93LHanA5eh=A@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <1440214788-1309-5-git-send-email-Karthik.188@gmail.com> <xmqqmvxg2v3u.fsf@gitster.dls.corp.google.com>
 <vpqk2sj7tlb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 25 15:30:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUEJR-0007Gb-Bx
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 15:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbbHYNao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 09:30:44 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33256 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbbHYNan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 09:30:43 -0400
Received: by obbhe7 with SMTP id he7so141819370obb.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PnKZ+TQgNJZfb2ChoCxlSmJaD2qKXVAZ58eGKH8qhaY=;
        b=jLG4vsgDOJieR8bsQzM2GhmltL4/N0hM2wifyuxMoeoVR+IeYgbXWvvZaPbsZFIJWb
         b0Lc49ZqMcE+VrhJPoD5NBCDIdpMYdvhO0TF62qV273EmajdscziHQ5OPirFPyxGjgln
         iXQGK+7oStdbxRRYxrEXhQxKXDpCYn/ch0Y35BPU9Jon3HoOKtgKGTbzxf3XuT3VGI1P
         HKwenb4VikDa9q+pRDzn/JejKrFVv1lsS4XnMOD+fxvq2QQgn8G38qDW1SFENIC1nJ6s
         TbtrDirNoQ+2nyIOxKYENxbojvB0yovQUPjPiUZsdH62qIAcQ3nBj8K6HASkHnoIwB0D
         97tA==
X-Received: by 10.60.92.37 with SMTP id cj5mr26427876oeb.30.1440509443077;
 Tue, 25 Aug 2015 06:30:43 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 25 Aug 2015 06:30:13 -0700 (PDT)
In-Reply-To: <vpqk2sj7tlb.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276529>

On Tue, Aug 25, 2015 at 12:17 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> You can see that I expected that "if !state.stack->prev" check to be
>> inside append_atom(), and I would imagine future readers would have
>> the same expectation when reading this code.  I.e.
>>
>>       append_atom(struct atom_value *v, struct ref_f_s *state)
>>         {
>>               if (state->stack->prev)
>>                       strbuf_addstr(&state->stack->output, v->s);
>>               else
>>                       quote_format(&state->stack->output, v->s, state->quote_style);
>>       }
>>
>> The end result may be the same,
>
> There's another call to append_atom() when inserting the "reset color at
> end of line if needed", so moving this if inside append_atom means we
> would do the check also for the reset color. It would not change the
> behavior (by construction, we insert it only when the stack has only the
> initial element), so it's OK.
>
> I agree that this is a good thing to do.
>
>> Moreover, notice that the function signature of append_atom() is
>> exactly the same as atomv->handler's.  I wonder if it would be
>> easier to understand if you made append_atom() the handler for a
>> non-magic atoms, which would let you do the above without any if/else
>> and just a single unconditional
>
> I can't decide between "ah, very elegant" and "no, too much magic" ;-).
> I lean towards the former.
>

I like the idea of using atomv->handler() a lot, mostly cause this
would eventually
help us clean up populate_atom() which currently seems like a huge dump of code.

-- 
Regards,
Karthik Nayak
