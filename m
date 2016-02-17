From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Wed, 17 Feb 2016 22:28:24 +0530
Message-ID: <CAOLa=ZSgt=+OnSQsDvp0S5yKNekZ0XF4D1OncfyH4152Nvf6QQ@mail.gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
 <1455649215-23260-3-git-send-email-Karthik.188@gmail.com> <20160216192231.GA16567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 17 17:58:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW5RK-0004Xb-SD
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 17:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbcBQQ6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 11:58:55 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35015 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030335AbcBQQ6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 11:58:54 -0500
Received: by mail-vk0-f53.google.com with SMTP id e6so19992193vkh.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NiTwJF0+8lMnAOVYjwCLGvMxObtNSB8Ob0xEk56quX4=;
        b=MdpcUu4eAP+9JDcpIEFlkQSzEJOZbRP/QbDqiK8U3URcokd1Missrd1BQ0xIAMvdjV
         8MteO4zF/Kzrr/urxaLODi+tZbHoKbmMJG6v7XvCAmz6fyjJy8Gh2fgy40PQO9D9qRzN
         66gY+UvDHdSxDD2JDk+bqjxo9oXc5uAnnP+PxK2KMKqzedHs+VNUmjligJGlFqteuAqQ
         uVIlNyjHX26sGuTIQ7c0i0ZdJqNEeWJznkp4O1+oLGDCwcfq8/StOWrCdaQzw1VhCUq7
         eS8pwle5G/TRmGnvuAzz7vYuBX7TwhAFu9TE8EsaED3SoRDzf8GfTuT1YpDToytV1JEg
         BRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NiTwJF0+8lMnAOVYjwCLGvMxObtNSB8Ob0xEk56quX4=;
        b=BYyZu5762ontfaD8EaKjy10wyt16hgaU32JtQUxrXNixRYe+yWuWrxkk4fNoPt0V76
         pVPe6yQad9gncN+W1GVJD1TuVzA1TI1lU5DnW6USm0AtJavIMGbcXpwHP30MjF2g8R51
         WRVyriAPHAMeP+EwwZw4xHAFAPuIsrxHBq4JyEqR54nAt/GZtaURyThWLnttl6JCKOnd
         j8vDVQJ4VtuLuF0uXDkldqt4sknJJkvHM/AgvoTFcncKBsd68hvWmHFRkb/i4xrliYv6
         I5HOCQJQ9tmpqX9N3agfqzV/Sgd/la8Ijev64XsjURxzUwAUEV58Kre3WR29ZXlwtZe2
         UlOw==
X-Gm-Message-State: AG10YOSxPASKeUxFBneD/OCi1sMb+hT+1I2zhKdvjY+LxLPXSzi3wCtAbbukRUtpbTwXCrS2gPpTZfRJNKaZYg==
X-Received: by 10.31.16.37 with SMTP id g37mr1978049vki.106.1455728333523;
 Wed, 17 Feb 2016 08:58:53 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Wed, 17 Feb 2016 08:58:24 -0800 (PST)
In-Reply-To: <20160216192231.GA16567@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286511>

On Wed, Feb 17, 2016 at 12:52 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 17, 2016 at 12:30:05AM +0530, Karthik Nayak wrote:
>
>> Use the newly introduced strbuf_split_str_omit_term() rather than
>> using strbuf_split_str() and manually removing the ',' terminator.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>>  ref-filter.c | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> Did you consider just using string_list_split for this? AFAICT, you
> don't care about the results being strbufs themselves, and it would do
> what you want without having to bother with patch 1. The result would
> look something like the patch below.
>

I haven't, thanks for bringing it up :)

> Sorry to waltz into a review of v5 with a suggestion to throw out all
> the work done in previous iterations. :-/ I just think the strbuf_split
> interface is kind of clunky and I'd be happy if we could slowly get rid
> of it rather than growing it. Maybe that's not realistic, though (some
> of the callsites _do_ want to do things like strbuf_trim() after
> splitting).
>
> -Peff

That's fine, as I see it, it's better to wait a while and get a better version
of something.

-- 
Regards,
Karthik Nayak
