From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 04/12] ref-filter: implement an `align` atom
Date: Tue, 25 Aug 2015 18:58:56 +0530
Message-ID: <CAOLa=ZQfVbyX=7LhTbsFRyWY180zyG7=aeYz6zOjnwd=yUUivw@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <1440214788-1309-5-git-send-email-Karthik.188@gmail.com> <xmqqmvxg2v3u.fsf@gitster.dls.corp.google.com>
 <xmqqfv382uzo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 15:29:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUEI6-0006GQ-Bl
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 15:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223AbbHYN30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 09:29:26 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35957 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbbHYN30 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 09:29:26 -0400
Received: by obkg7 with SMTP id g7so141566301obk.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5hn1g68B/WukQgNZR6w93h0NXI19qptwqiCjObipHC0=;
        b=uRqP08znzVUYRNqIwD8Tn039Lyvq9SVAttD51/c+53cXD+ukiqrbaNpVhs5M9Pfbl9
         VDGdNGaUOzFb7Gk+j07IpclXgYht9TZwAnwjKJVELI12uoNXId1exDDIsKftcvw+1WIo
         VhUKSAJjdKteuIW/6qic9oczBHaTrzeufT+U2o1UZmrqjOVVF5h/RNmQkHZWyDalYOOJ
         +p7RGcZaM5Fv3oYbhco8VDCWnQg9zYqDWN0HYRqdnDF9Kcm4Sjfv3cw6tr7w2j2J9eeU
         JTgu0FbdAqzlUGv2I/Q8SHgc1fGnMRXU+TALeP1tzR2luQQ1ptjRb9kkxSe7LND2ij6B
         F+nQ==
X-Received: by 10.182.81.98 with SMTP id z2mr26429885obx.70.1440509365402;
 Tue, 25 Aug 2015 06:29:25 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 25 Aug 2015 06:28:56 -0700 (PDT)
In-Reply-To: <xmqqfv382uzo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276528>

On Tue, Aug 25, 2015 at 3:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> +static void end_atom_handler(struct atom_value *atomv, struct
>>> ref_formatting_state *state)
>>> +{
>>> +    struct ref_formatting_stack *current = state->stack;
>>> +    struct strbuf s = STRBUF_INIT;
>>> +
>>> +    if (!current->at_end)
>>> +            die(_("format: `end` atom used without a supporting atom"));
>>> +    current->at_end(current);
>>> +    /*
>>> +     * Whenever we have more than one stack element that means we
>>> +     * are using a certain modifier atom. In that case we need to
>>> +     * perform quote formatting.
>>> +     */
>>> +    if (!state->stack->prev->prev) {
>>
>> The comment and the condition seem to be saying opposite things.
>> The code says "If the stack only has one prev that is the very
>> initial one, then we do the quoting, i.e. the result of expanding
>> the enclosed string in %(start-something)...%(end) is quoted only
>> when that appears at the top level", which feels more correct...
>
> As this already allows us to use nested construct, I think we would
> want to have test that uses
>
>     %(align:30,left)%(align:20,right)%(refname:short)%(end)%(end)
>
> or something like that ;-)
>
> Very nice.

Ok, will do that :)

-- 
Regards,
Karthik Nayak
