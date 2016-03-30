From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/6] imap-send.c, cram: allocate enough memory for null
 terminated string
Date: Tue, 29 Mar 2016 21:02:15 -0400
Message-ID: <CAPig+cSX4Jye60CKxR=OjhtAai09WSMNMOau2WHUxgXbKX2aDQ@mail.gmail.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
	<1459298333-21899-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:02:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4Ws-0003ho-M8
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbcC3BCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:02:19 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36050 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbcC3BCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:02:16 -0400
Received: by mail-vk0-f65.google.com with SMTP id z68so4544964vkg.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=XYKHZOfq7Tj3xlPix+VRo+IaPu7cM6MDKB2Rx6jBa3s=;
        b=QMZbjO6vTsTpUFNLlUMJ/hIrUiaWcU4wFvgMXH0AZ0lu208hvU4buzzmtWJRVyxWpw
         6i/ohYF6N1rerzwXdJNMeej3EwkPY3rmCKvXCf8eLcf65h/ZuQhk48VNqWVYeVxkrS6N
         +wEW155HAZ5X+nl9BTzzaysagN+WTnvO5shFUuwZkGAho5Ii78UpvO4nkz8Hck7VTDYy
         DB/SwJ7wO2AZUvmZys7+LrQspb/M2/sjN6/LYSAfjqLCKGsROVOIHpsMMUMh4rBsKRpp
         yXVLwOvN+eD/RODtAspG3nKROc0eIj5W/dZ215kqA4GuxA0OU5au8xQ1xGBzHQBBSjIy
         FWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=XYKHZOfq7Tj3xlPix+VRo+IaPu7cM6MDKB2Rx6jBa3s=;
        b=mVP/LFQyfpN8N31X2QfykKNXu4BIjvHutdUpSBD1mhS+qRe5Hfxh0L3ZPQwFdX45Ij
         fF/gBpn7FE+MkhVmSPlCl+CssAbDB+zj1U+8PLDnqOQSiPpt3TOY5mANVxR+ci+qfyo9
         VSgvgJF8NqucB8WMqiHQQw6DcyLurjS4ZfiN8QrRI13KQL3RuyQ3q/MyvG4Ju6fa9Qz9
         xTgq8weadnczqfkveRwDxR3TxskPycQAZzE8QKP+VgSRe2KeQn5qPzzVINx5QnMOfCJl
         WB4NPazzmlSsgb4W6tJeKKbUXwNdCpJWXasJ0YLweDB4PxKJfLGrpVhVYRwyt0z/rxgQ
         aQBQ==
X-Gm-Message-State: AD7BkJLQ+Tw6HK4l3rWyppRQLFzxYxvMqAHoiqlW/CcTQ4rRZjB6cFSjGr5AZVyQ7hNnnuP0t2mPf53Pr2on/g==
X-Received: by 10.31.146.5 with SMTP id u5mr3077612vkd.19.1459299736001; Tue,
 29 Mar 2016 18:02:16 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 18:02:15 -0700 (PDT)
In-Reply-To: <1459298333-21899-3-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 0_6YtQnI_tZDwZV6ZsQkvvkfo9Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290243>

On Tue, Mar 29, 2016 at 8:38 PM, Stefan Beller <sbeller@google.com> wrote:
> `strlen` returns the length of a string without the terminating null byte.
> To make sure enough memory is allocated we need to pass `strlen(..) + 1`
> to the allocation function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  imap-send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 2c52027..f7e9909 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -872,7 +872,7 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
>          * enough upper bound for challenge (decoded result).
>          */
>         encoded_len = strlen(challenge_64);
> -       challenge = xmalloc(encoded_len);
> +       challenge = xmalloc(encoded_len + 1);

'challenge' is never used as a NUL-terminated string, and
EVP_DecodeBlock() is not advertised as adding a terminating NUL, so
why is this an improvement?

>         decoded_len = EVP_DecodeBlock((unsigned char *)challenge,
>                                       (unsigned char *)challenge_64, encoded_len);
>         if (decoded_len < 0)
> --
