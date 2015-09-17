From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Thu, 17 Sep 2015 23:55:58 +0530
Message-ID: <CAOLa=ZTn+arYr1HHA3CH+E2Sd7z9-ry=7D-QRSUM98kSKKcXdg@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
 <1442129035-31386-4-git-send-email-Karthik.188@gmail.com> <xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ51+TKvOiJvWa-emmJJGirAqkr9m0a_7BrQ2UbiSJdjA@mail.gmail.com>
 <CAOLa=ZQxounTiJk0t+zB2-7=UQa8oL+uJ9EQpTkWL7kYFHjxwQ@mail.gmail.com>
 <vpqpp1hqgcd.fsf@anie.imag.fr> <xmqqh9mtkrg0.fsf@gitster.mtv.corp.google.com>
 <vpqio79oxva.fsf@anie.imag.fr> <xmqqeghxj8i1.fsf@gitster.mtv.corp.google.com> <vpqmvwlm0rt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 17 20:26:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcdtB-00020L-OC
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 20:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbbIQS03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 14:26:29 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35833 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbbIQS03 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 14:26:29 -0400
Received: by vkao3 with SMTP id o3so16194879vka.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 11:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iL+bR0mimA23Fu8mShn4e8qXSYlqz7EVf8suP4fTEC0=;
        b=EcWXRtV/0U2TTF9ebAF1yzGnEbuVo/izSynKvlWiDyoG4sJ2hvwlCfXwYkZ/kzJbSp
         Tl46G9er/Yb0HMUUIj8C7EcWfrG6VzHtsNC2YVPx8/6Q7S5VOb8OLMc5A38R1t4OtgQC
         F+skzRocqmxNac8qRjXfn4nFj1hhusy1ndbYVN2i8XSpH7h0wLC9aq3/6hAVKuvbKOG9
         /6TUfc2nnLD3/I8rbFwmMS07olzXqJAaB1Ln7ichY7Qdh12BlC42nZ74qCzpS6vamPcU
         sEyKaW3tqdDAKjXMJDy/gIDPQsy5ZTulK0utDWT+ta3ub3EsLM7GVOnGmXRN6WtZPs4P
         b7rA==
X-Received: by 10.31.21.149 with SMTP id 143mr607978vkv.79.1442514388056; Thu,
 17 Sep 2015 11:26:28 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Thu, 17 Sep 2015 11:25:58 -0700 (PDT)
In-Reply-To: <vpqmvwlm0rt.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278158>

On Thu, Sep 17, 2015 at 10:38 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> But that's still workable: struct ref_sorting could contain a flag
>>> "head_first" that would be set by ref_default_sorting() and only it, and
>>> then read by cmp_ref_sorting.
>>
>> Hmm, I am still puzzled.  "refname" atom would expand to things like
>> "HEAD", "refs/heads/master", etc., so I still do not see a need for
>> head_first option at all.  "HEAD" will sort before "refs/anything"
>> always, no?
>
> Ah, you mean, the alphabetic order on refname already sorts HEAD first
> because other refs will start with "refs/"? So, there's no need for any
> special case at all indeed. Nothing to teach compare_refs, it's already
> doing it.
>
> However, just relying on this seems a bit fragile to me: if we ever
> allow listing e.g. FETCH_HEAD as a reference, then we would get
>
>   FETCH_HEAD
> * (HEAD detached at ...)
>   master
>
> which seems weird to me. But we can decide "if sorting on refname, then
> HEAD always comes first anyway".

Thanks for explaining what I had in mind, Seems like the confusion is sorted,
I have nothing more to add to this discussion. Junio is right, sorting
by "refname"
would indeed work, I was just thinking along the lines of what you're ;)

-- 
Regards,
Karthik Nayak
