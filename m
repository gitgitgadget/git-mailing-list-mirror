From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each
 valid atom
Date: Sat, 6 Feb 2016 20:45:01 +0530
Message-ID: <CAOLa=ZQxbCYd_bpf4PSpRVvejOgi=farNPtHgP_mZZypOf6cnQ@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com> <1454262176-6594-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <Karthik.188@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 16:15:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS4aH-0005yN-3A
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 16:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbcBFPPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 10:15:33 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33937 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbcBFPPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 10:15:32 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so3335186vkh.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 07:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GBCGdljlyuEDMh/hnSZ8uk6nzls4+uhougVD709tUbM=;
        b=IbYVSARTrMeSckQFxTCxC/Sxxg+Wy850oACA6JV6jD6/BsvZmyL4drHWbjz57EKCy0
         +4vIRk+Jmn/ziqnCzWP8tFzDjZPiQMSyGBRwmUvlfz96Oz09j8So1MtWSeE5V9zryzJS
         HaEHh/jnanz4wU9ZGaPzfYkiHJYS9wLaZ0G+7lmL/YyXKeN05vRG2ZW3HwHhRTnUkUXD
         4OHb7TdtXko4x8gyom4DQW7SGJC9PGc3nZTdoJO3Q71YSjj/HpS7WpHjo9qEMfldOnc0
         C69RxIKhz2wgT694yLAuCF2mDbZXq3RZ/EYX835zsn8zZWmtMyUqKIQbPZbj1Y5Wky9E
         qgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=GBCGdljlyuEDMh/hnSZ8uk6nzls4+uhougVD709tUbM=;
        b=WrGm7gffU3sa7KZmbtZm83sOTtFWUnwpEUgKS0pSGPT0xkH3BZ2SPWEhaTHq6of09r
         q4XXnlnmRY7sr9UkgNiBo3xTuVtZuCQ/GY+Ld42faaZOlC4RzfLRSSAAzMablPM6/3bW
         rXdYBF94SMyBbtGP3URKHppUkYDxHWagzJdGcAaknctGdbM8qC1s/TjvHhbKKNhAEQsj
         e8Og7aQr0eB3BNjIavmOR7QPjR3XYNia4bbZ5ywtb6E3orvqnj0+afbMsClPJJ2pLHA5
         og4FnbSyKmbkl8RVZteC1v7bd0dGJ4g01ujsBM8+DQe7rgZK76xsVKP3JZkKFnxx1vX1
         x+/A==
X-Gm-Message-State: AG10YOSeJckhf0GC7SRTzgkyc/Jii+GMoli7rkUgfTv+A9Vg9zgzv0ZgDlDoL5V9qfzsdSIOh6n+jooBFsFczg==
X-Received: by 10.31.16.37 with SMTP id g37mr12919075vki.97.1454771731170;
 Sat, 06 Feb 2016 07:15:31 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sat, 6 Feb 2016 07:15:01 -0800 (PST)
In-Reply-To: <1454262176-6594-6-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285694>

On Sun, Jan 31, 2016 at 11:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> @@ -138,10 +140,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>                  * shouldn't be used for checking against the valid_atom
>                  * table.
>                  */
> -               const char *formatp = strchr(sp, ':');
> -               if (!formatp || ep < formatp)
> -                       formatp = ep;
> -               if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
> +               arg = memchr(sp, ':', ep - sp);
> +               if ((!arg || len == arg - sp) &&
> +                   !memcmp(valid_atom[i].name, sp, len))
>                         break;
>         }
>

Also having a look at this, this breaks the previous error checking we
had at parse_ref_filter_atom().
e.g: git for-each-ref --format="%(refnameboo)" would not throw an error.

I think the code needs to be changed to:

-               if ((!arg || len == arg - sp) &&
+               if ((arg || len == ep - sp) &&
+                   (!arg || len == arg - sp) &&

-- 
Regards,
Karthik Nayak
