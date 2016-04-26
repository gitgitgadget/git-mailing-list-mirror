From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 05/83] builtin/apply: extract line_by_line_fuzzy_match()
 from match_fragment()
Date: Tue, 26 Apr 2016 18:15:05 +0200
Message-ID: <CAP8UFD228joDLyomvae7rVs02TuTbmEHerwWvH=VR+FE-YFLRA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-6-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kYi0seMF12+Y4VxHBJxTh9wo4LUw0A50PYRvZEBvj6SBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:15:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av5dr-0007Pt-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbcDZQPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 12:15:09 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37891 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbcDZQPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 12:15:07 -0400
Received: by mail-wm0-f41.google.com with SMTP id u206so12989630wme.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=mESAsCLq8iZJtuts3JIctQlrhvtlqLdVGxzn6h8QSlo=;
        b=laFY6N+7mt04Ji2AqmyPimSa4+28InPMf5SE2bnJ3RePCq6vkFWmJXauHAPKZFKWI8
         U9gt/3wxwiRFkX7hbDl5iyehhkKZjGnM2md3A/YeCxfuHYMncOGd8i9kr8OwQMmDUR8s
         u3hTtDEuvmHCGbjHhzQgvdOePBUl9dYtvZ8WBK4SexNSjsl6dE4upldUMNqohejg8eTK
         9QF03TenOuDbvUiVu6z/0OD48x8d3Z0LrkRew1IgarpiqgC7o5fbmDQqSWWeT28Og5w9
         tJ67oedMjfE4sKCPmVpHp4gMpVqSFlLLZcWZ2poFy3Tq08yEezfvkjdYT1JzlIk/4oUE
         0lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=mESAsCLq8iZJtuts3JIctQlrhvtlqLdVGxzn6h8QSlo=;
        b=Pi81xQd4YEX5HGeojrQb+AklpUElLLNwEfban9cAE/dYZvMk786kK3X5zWOz0eNjmK
         tt1yJY/de2V2OJxf/aeTw+ckb2SMAJ1SzlxWXN+8xzZ09/kvTBjjSD0gzfsK3P2uYL8Q
         OGkkm+H5qk+S0w1RzvInRmwhWZ8CQpd2dKRgdyzJblF+e0kdHtNd9KI+NRdCq2vWRc1P
         77OexV+phnB7wkAnz296NH9nwm3cQv9VOn4aS2O25DuXwnadWyI/DadOfHB3y3ILvER7
         kCZgJNNl1GpBtBgB6bEqb5HbdtP//1ziGTaPLvM32S75N+xD8sF/MiHqZKcB7jbjCq1S
         2QFA==
X-Gm-Message-State: AOPr4FX+fzqSuZMmT/oW3umDNdkXILYSRZLST/qUCIl28ACaIJR9BCZ7L/OB4dGu813MtqXWh6xbbq9PMPN1mg==
X-Received: by 10.194.117.70 with SMTP id kc6mr4512464wjb.94.1461687305609;
 Tue, 26 Apr 2016 09:15:05 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Tue, 26 Apr 2016 09:15:05 -0700 (PDT)
In-Reply-To: <CAGZ79kYi0seMF12+Y4VxHBJxTh9wo4LUw0A50PYRvZEBvj6SBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292609>

On Mon, Apr 25, 2016 at 8:50 PM, Stefan Beller <sbeller@google.com> wrote:
>> @@ -2251,7 +2319,7 @@ static int match_fragment(struct image *img,
>>                           int match_beginning, int match_end)
>>  {
>>         int i;
>> -       char *fixed_buf, *buf, *orig, *target;
>> +       char *fixed_buf, *orig, *target;
>>         struct strbuf fixed;
>>         size_t fixed_len, postlen;
>>         int preimage_limit;
>> @@ -2312,6 +2380,7 @@ static int match_fragment(struct image *img,
>>                  * There must be one non-blank context line that match
>>                  * a line before the end of img.
>>                  */
>> +               char *buf;
>
> patches 1-4 looking good, with no comment from me. Here is the first spot to
> comment on.
>
> It's not clear why we need to declare buf here? Oh wait it is. It's just
> moved from the start of the function. But why do it in this patch?
> It seems unrelated to the general intent of the patch. No need to reroll
> for this nit alone, it just took me a while to figure out it was an unrelated
> thing.

Yeah, I agree it's a bit unrelated. But rather than add another patch
to an already long series just for this, I added the following to the
commit message:

While at it, let's reduce the scope of "char *buf" in match_fragment().
