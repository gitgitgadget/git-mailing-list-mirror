From: Felipe Franciosi <felipe@paradoxo.org>
Subject: Re: [PATCH] Initialise hash variable to prevent compiler warnings
Date: Mon, 13 Oct 2014 22:55:01 +0100
Message-ID: <CANxchRRtd03LvjbWO7d45EE-GB_yTZjEhcJccZW_Y3mgDpENrQ@mail.gmail.com>
References: <1413211041-28732-1-git-send-email-felipe@paradoxo.org>
	<xmqq38ar3f1o.fsf@gitster.dls.corp.google.com>
	<CANxchRS1mGapb77hc9Ywqj_-8UeexSAWK4UK9y9M76pvoN-Yeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:55:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdnaA-0005nd-Ak
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 23:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbaJMVzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 17:55:04 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36416 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbaJMVzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 17:55:03 -0400
Received: by mail-oi0-f50.google.com with SMTP id i138so14441625oig.23
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 14:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7dswAKhk6OWGaUPJVoyiY+3HaVaO5B9zhW1A5Bc5+qI=;
        b=AvhBnZEJtLPaN2AQe0trkHVKOFOKFwKXnkadJGBxLpQs6CKoljdAj2PP215iJ+7Ga9
         038BMMAXde1ll6CPaxdg78qChNBAuNN3zdLQTI6QSy2NR9XDIf09TO0r4Sm9IHGccFSa
         +4kJz4hkPW3s3y4U/CSTGTxL5aeGbZOjTCfCZ9ancLt544P29oYaejOtkncFOwucFjmV
         3M474We4fI2ysElA+DoqwvuuUD/SPsrTmc35WnaOvJM1D5aAkMB6sCAs65UJfAfRLpIu
         pL95uFwOdmvH6/+DXglNO/ZwDw4KFregOvGfbBLOtZG6e50QrrXipN6CJmde75Yh313b
         we4Q==
X-Gm-Message-State: ALoCoQl4yYlLlvYhdq6u6UI0EUnfxGeCBWawybspfCcXkQFnmt3zniDJgbuVSgfYGDHxJyPB1jZX
X-Received: by 10.60.48.4 with SMTP id h4mr1053338oen.42.1413237302026; Mon,
 13 Oct 2014 14:55:02 -0700 (PDT)
Received: by 10.182.250.201 with HTTP; Mon, 13 Oct 2014 14:55:01 -0700 (PDT)
X-Originating-IP: [94.6.216.142]
In-Reply-To: <CANxchRS1mGapb77hc9Ywqj_-8UeexSAWK4UK9y9M76pvoN-Yeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 10:53 PM, Felipe Franciosi <felipe@paradoxo.org> wrote:
>
> On Mon, Oct 13, 2014 at 9:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Felipe Franciosi <felipe@paradoxo.org> writes:
>>
>> > The 'hash' variable in test-hashmap.c is not initialised properly
>> > which causes some 'gcc' versions to complain during compilation.
>>
>> FNV/I/IDIV10/0 covers all the possibilities of (method & 3), I would
>> have to say that the compiler needs to be fixed.
>>
>> Or insert "default:" just before "case HASH_METHOD_0:" line?
>>
>> I dunno.

Hmm... The "default:" would work, but is it really that bad to
initialise a local variable in this case?

In any case, the compilation warning is annoying. Do you prefer the
default or the initialisation?

Cheers,
F.

>
>
> Hmm... The "default:" would work, but is it really that bad to initialise a
> local variable in this case?
>
> In any case, the compilation warning is annoying. Do you prefer the default
> or the initialisation?
>
> Cheers,
> F.
>
>>
>> >
>> > Signed-off-by: Felipe Franciosi <felipe@paradoxo.org>
>> > ---
>> >  test-hashmap.c |    2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/test-hashmap.c b/test-hashmap.c
>> > index 07aa7ec..cc2891d 100644
>> > --- a/test-hashmap.c
>> > +++ b/test-hashmap.c
>> > @@ -47,7 +47,7 @@ static struct test_entry *alloc_test_entry(int hash,
>> > char *key, int klen,
>> >
>> >  static unsigned int hash(unsigned int method, unsigned int i, const
>> > char *key)
>> >  {
>> > -     unsigned int hash;
>> > +     unsigned int hash = 0;
>> >       switch (method & 3)
>> >       {
>> >       case HASH_METHOD_FNV:
>
>
