From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 08/12] ref-filter: introduce align_atom_parser()
Date: Thu, 4 Feb 2016 18:48:41 -0500
Message-ID: <CAPig+cQXK6xENN864XuxYFQEKtw59FAO7qh=wEGv4maomKpCzA@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:48:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTdn-0007tN-Ac
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 00:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933337AbcBDXsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 18:48:43 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33824 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbcBDXsm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 18:48:42 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so2069386vkh.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 15:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6Ed+jLXpgh/vXM/Wrs4qBzZ2Xb2FaDi0f42r7LEvOFg=;
        b=hk9BW4NUBtZBSB87A3zZ4SQZt4/T9mKooQNtMjp3Rkh5sf63R2IZ9uI29eXXNhuF6U
         8NYAugoBGyhD4KxeuA8xnA8CeO9VrXCVNlbqWlKqAsR5iBHjlaCh5Kv0ctBlbMQgG0Vf
         MPqzOIdyizxgt5zpOzMRws8/bdsnSEblInDjdA7VrK7fwMNF862z6pADEqSAL3BjSnnU
         nipmZs5CInqdndYX7eTzoPss4AGb32MqOq8NLBMFnL1dmadXd1lL5rYJDZeVR3GMMoss
         T1UPOz9kX0I1GuIW1d9rA9B4wWQeOVcxBejAUoBh7gvy8W8W/JmITTyRE2VAwPMeGlDc
         ssog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6Ed+jLXpgh/vXM/Wrs4qBzZ2Xb2FaDi0f42r7LEvOFg=;
        b=AOqy/mJQqBXPIMaAQlHRn2LZi7AYspjWft0yWULD6amtDW5QCS/LDzO/KGfTyvV8X3
         /clE9mh822XDBQ8Hfup6GwM6n5llNXghLGTLsSX5rTb5iaWIbLIdlfpP9p6RqDPiwR3P
         fpDSF55cGaTU8LIAF/NEA3cieAW7aMKf7uuKM3qQfrCQUs8KXDBd6rSW/Xdp1X0KxTeZ
         bZyhG2daZ3NB3bTZAnm/U0UIqTGXugOhLWt7Q6ItbKHVktTnDqJ1lXUhdiKyw90lF9xH
         dI8eWVm+l4MTKhddGyP+lbzS+6oKhXzKwzO6NCrkyUefF5GcGZiXS6DC72OFgEKEuSst
         TEoA==
X-Gm-Message-State: AG10YOSCrCLXe+HkeD7D+7XbuI17xpGJN6uGpMsmb+x2eKc7GMaQ/Er2s0xw3avADm8BnNP3PA4IY5fB+xWmqg==
X-Received: by 10.31.150.76 with SMTP id y73mr7368592vkd.84.1454629721279;
 Thu, 04 Feb 2016 15:48:41 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 15:48:41 -0800 (PST)
In-Reply-To: <1454262176-6594-9-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: 9jDP4LPt8jtxf1i3EgqyA2xOcTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285523>

On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce align_atom_parser() which will parse an 'align' atom and
> store the required alignment position and width in the 'used_atom'
> structure for further usage in populate_value().
>
> Since this patch removes the last usage of match_atom_name(), remove
> the function from ref-filter.c.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -55,6 +61,37 @@ static align_type parse_align_position(const char *s)
> +static void align_atom_parser(struct used_atom *atom, const char *arg)
> +{
> +       struct align *align = &atom->u.align;
> +       struct strbuf **s, **to_free;
> +       unsigned int width = ~0U;
> +
> +       if (!arg)
> +               die(_("expected format: %%(align:<width>,<position>)"));
> +       s = to_free = strbuf_split_str_omit_term(arg, ',', 0);
> +
> +       align->position = ALIGN_LEFT;
> +
> +       while (*s) {
> +               int position;
> +               arg = s[0]->buf;

It's confusing to see 'arg' being re-used here for a different
purpose, and leads the reader to wonder if this is done because the
s[0]->buf might be needed outside the loop (when, in fact, it isn't).
It would be better to declare a new variable here in the scope of the
'while' loop to hold this value.

(I might have named the result of the strbuf split 'tokens' or even
short-and-sweet 'v' -- for vector -- and then used 's' for the name of
the new variable here in the 'while' loop, but these name suggestions
aren't particularly important; it is important to declare a new
variable here -- whatever you name it -- rather than re-using 'arg'.)

> +
> +               if (!strtoul_ui(arg, 10, &width))
> +                       ;
> +               else if ((position = parse_align_position(arg)) >= 0)
> +                       align->position = position;
> +               else
> +                       die(_("unrecognized %%(align) argument: %s"), arg);
> +               s++;
> +       }
> +
> +       if (width == ~0U)
> +               die(_("positive width expected with the %%(align) atom"));
> +       align->width = width;
> +       strbuf_list_free(to_free);
> +}
