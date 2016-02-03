From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each
 valid atom
Date: Wed, 3 Feb 2016 17:19:41 -0500
Message-ID: <CAPig+cRmfNjP8PYoQFZ7YrECgt03aE1=QynG58-+cd9ORJneZw@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 23:19:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR5mD-0004HF-2d
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 23:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965614AbcBCWTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 17:19:45 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35212 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965611AbcBCWTn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 17:19:43 -0500
Received: by mail-vk0-f68.google.com with SMTP id e185so1088887vkb.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 14:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=C01b58AJfDJ6o4fEAJ9JKrQNWatm2a82qA1q0xk1+J0=;
        b=b0IuwaZ18SNnpRgKLOlMY4zLrYPI9otLH00qrKGtdGS8/IdtjA67/8C7rfRh8KCOyF
         15kcZsKsjECQ8iukSsep1HOQuiwC7/moSrQlJH4UubYGZJ8I6qSvTmn5PBxGO1F12rbq
         PVu4lKtaYpt1P/Aaz0ud5cd/AuiHvjjY0jJqvYcM9uxB31NCAOKraR0tPQRlj3L7yloy
         eZzOHfz8zvxedARutf2b+v4DlrqAkJCSl2FJfFI7O0YVBe4XzAzxEw/MTaC1xDv3c8uh
         CQla0A1AG8DSEeo6ZpO4jWaxVFTBThwUyQjmukYNUmVwgE2KEf1L1RfvcpbSbxMV+RUo
         Fwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C01b58AJfDJ6o4fEAJ9JKrQNWatm2a82qA1q0xk1+J0=;
        b=mWOQ9Df/UFS6laKDRuKX7cKHU9cCImToZQNu60tMRtQq6ZsNCyVoeur1zXaGjWktmv
         ++BJ0U5pu1oT4G+tWGUtmRUWt55QqloVpjryFucPxtpmtjQeY5ObJAkF+TNtv0ETQi2u
         kvQo1Ik4hDdjmcytGrvAatGofEM6VIEHLSL9snkd9g4Eqb0xl957AmAxoLQARF/Rbf76
         ggyl+JXGF2/w6wgl6ExTF7w5Aojxu1nW5IqnLXG0BJud9UmNtMFqviBMRyz+AE2bsWCM
         nbYJDn5Q/ycfKVRJ5CSiI0DU+sjzudwtNQHQLSCh0MVYDokh0pjrUfwPxK+K5tn4M/F8
         yXzQ==
X-Gm-Message-State: AG10YOTOhLjkImemb+d+XQPrMSlOaZJAYW84x+VD6Owrh4tVkrt3JJLQGbTYMlUBITh6SGO87WNJg+6e2aAXDQ==
X-Received: by 10.31.47.135 with SMTP id v129mr3144281vkv.115.1454537981691;
 Wed, 03 Feb 2016 14:19:41 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 3 Feb 2016 14:19:41 -0800 (PST)
In-Reply-To: <1454262176-6594-6-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: OHLUqjpAug7EYlpMymZ78h4ur8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285375>

On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Parsing atoms is done in populate_value(), this is repetitive and
> hence expensive. Introduce a parsing function which would let us parse
> atoms beforehand and store the required details into the 'used_atom'
> structure for further usage.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -36,6 +36,7 @@ static int need_color_reset_at_eol;
>  static struct {
>         const char *name;
>         cmp_type cmp_type;
> +       void (*parser)(struct used_atom *atom, const char *arg);

It's a little bit weird to pass in 'arg' as an additional argument
considering that the parser already has access to the same information
via the atom's 'name' field. I guess you're doing it as a convenience
so that parsers don't have to do the strchr(':') or memchr(':')
themselves (and because parse_ref_filter_atom() already has the
information at hand), right? A typical parser interested in a
(possibly optional) argument currently looks like this:

    void parse_foo(struct used_atom *a, const char *arg) {
        if (!arg)
            /* default behavior: arg absent */
        else
            /* process arg */
    }

That doesn't change much if you drop the 'arg' argument:

    void parse_foo(struct used_atom *a) {
        const char *arg = strchr(a->name, ':')
        if (!arg)
            /* default behavior: arg absent */
        else
            /* process arg */
    }

It does mean a very minimal amount of duplicated code (the single
strchr() line per parser), but it also would remove a bit of the
complexity which this patch adds to parse_ref_filter_atom(). So, I
dunno...

>  } valid_atom[] = {
>         { "refname" },
>         { "objecttype" },
> @@ -138,10 +140,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>                  * shouldn't be used for checking against the valid_atom
>                  * table.
>                  */
> -               const char *formatp = strchr(sp, ':');
> -               if (!formatp || ep < formatp)
> -                       formatp = ep;
> -               if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
> +               arg = memchr(sp, ':', ep - sp);

Why this change from strchr() to memchr()? I understand that you're
taking advantage of the fact that you know the extent of the string
via 'sp' and 'ep', however, was the original strchr() doing extra
work? Even if this change is desirable, it seems somewhat unrelated to
the overall purpose of this patch, thus might deserves its own.

Aside from that, although the "expensive" strchr() / memchr() resides
within the loop, it will always return the same value since it doesn't
depend upon any condition local to the loop. This implies that it
ought to be hoisted out of the loop. (This problem is not new to this
patch; it's already present in the existing code.)

> +               if ((!arg || len == arg - sp) &&
> +                   !memcmp(valid_atom[i].name, sp, len))
>                         break;
>         }
>
> @@ -154,6 +155,10 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>         REALLOC_ARRAY(used_atom, used_atom_cnt);
>         used_atom[at].name = xmemdupz(atom, ep - atom);
>         used_atom[at].type = valid_atom[i].cmp_type;
> +       if (arg)
> +               arg = used_atom[at].name + (arg - atom) + 1;

This is a harder to understand than it ought to be because it's
difficult to tell at first glance that you don't actually care about
'arg' in relation to the original incoming string, but instead use it
only to compute an offset into the string which is ultimately stored
in the newly allocated used_atom[]. Re-using 'arg' for a different
purpose (in a manner of speaking) confuses the issue further.

The intention might be easier to follow if you made it clear that you
were interested in the *offset* of the argument in the string, rather
than a pointer into the incoming string which you ultimately don't
use. A variable named 'arg_offset' might go a long way toward
clarifying this intention.

> +       if (valid_atom[i].parser)
> +               valid_atom[i].parser(&used_atom[at], arg);
>         if (*atom == '*')
>                 need_tagged = 1;
>         if (!strcmp(used_atom[at].name, "symref"))
> --
> 2.7.0
