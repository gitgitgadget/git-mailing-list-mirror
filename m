From: Stefan Beller <sbeller@google.com>
Subject: Re: Segfault in the attr stack
Date: Wed, 1 Jun 2016 15:29:49 -0700
Message-ID: <CAGZ79kZ6dh7AP5b5N_2RRHQmq=OKpr05JEwyOCbfOj6KWjFC2A@mail.gmail.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
 <xmqqpos0wodp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:30:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8EeG-0001mV-9y
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 00:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbcFAW3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 18:29:51 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34425 "EHLO
	mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcFAW3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 18:29:50 -0400
X-Greylist: delayed 5679 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jun 2016 18:29:50 EDT
Received: by mail-qt0-f171.google.com with SMTP id q45so1208032qtq.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OC0rpdLeyq11JVgnb5qX/diaUz59AdgDtqXo6gW4HZQ=;
        b=P2jndIfE6s1Ti8T9FYr7U/OY6JcEcN4in8eiOJYwJ47EQFX1roHlvywmbWXmehm3Sj
         Rgcd5FG3hnFEsPD7CN/TeSX0eTgnQ/vprR6+nbi+pjMf6sjn3lWjVt8FQotQyY43LIjR
         Mnkr94KWTnJeO/BsQOK1XOqHU7z/CpF3xGfdi/Q4B29IKRB1QfBcdsQGStFb5Aw499pX
         yOPPa9GCpD8RjrEQfh8GhoCub5h2VRP8CbAM4Cjb2gAQ6EiqXyKtDSVzgK3+W8YrA3sg
         K0tfdP/n+AaVfUaWDdPiONNdiR+Pj2hOa9ywCTnemWgknW2HHSE2ejuP4epx/m+r1QOO
         ACRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OC0rpdLeyq11JVgnb5qX/diaUz59AdgDtqXo6gW4HZQ=;
        b=gPZuNOtZhG1/sbjV27sOX2cIwO33CMV86ehUvk26/H6z+yq4lUu+zF0g+Jlv1Y+yrZ
         EO/baoNYY+Q1tDFIToa+6nGf0Aqjc4YgRbI2sxHx4OOsGJj0RLl9sVIijAGb9xzFnqdx
         9Ri25pEKLm0s9xh0MXU6YQ8CRUaKACaulvTsiKtN8kKvvrdOD94zWlTUJhLFaPK4SMyS
         8PWR9+xRko+0DTU2M0/qgE4Cl6m0fL+d4YBu0d0wQnqbvetIzsOFozuQCbab9+hS3zcP
         O9hq7COaVdGUBaY1HuIjINmBufc3rxzIGO4F0ugkxVHKv5XEjwyN+pbjNtt6+aNZzcfo
         Oa9Q==
X-Gm-Message-State: ALyK8tK94ZK2e8DRgYLbtKvDbflDKi8cTitOgmhy7CGxA+cIHPCo/Rzn8a4PO4cpXFVsD4iMBu5ac4ASP4Rhb1qP
X-Received: by 10.237.53.100 with SMTP id b33mr6144166qte.59.1464820189955;
 Wed, 01 Jun 2016 15:29:49 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Wed, 1 Jun 2016 15:29:49 -0700 (PDT)
In-Reply-To: <xmqqpos0wodp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296173>

On Wed, Jun 1, 2016 at 3:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> By the way, I just noticed that the <specification> part of the
> ':(attr:<specification>)' syntax would need to be rethought.  In the
> .gitattributes file everybody has, we see these lines:
>
>         *.[ch] whitespace=indent,trail,space
>         *.sh whitespace=indent,trail,space
>
> but because comma is a special separator in the pathspec magic
> system, we cannot do
>
>         $ git status ':(attr:whitespace=indent,trail,space)'
>

Right. In [1] I wrote:

>>
>>> +     if (!item->attr_check)
>>> +             item->attr_check = git_attr_check_alloc();
>>
>> Given more than one "attr" magic, e.g. ":(attr:A=a,attr:B)/path",
>> the check may not be empty when we process the second one; we just
>> extend it without losing the existing contents.
>
> That is why I am not super happy with it though.
>
>    ":(attr:A=a,attr:B)/path",
>    ":(attr:A=a B)/path",
>
> are the same for the user as well as in the internal data structures.
> This "wastes" the white space as a possible convenient separator
> character, e.g. for multiple values. On the other hand it will be easier
> to type, specially for many attrs (read submodule groups).

So at that time I thought I had communicated the issue enough and we'd
be fine ignoring it for now. I propose to not escape commas, but use
white spaces instead, i.e.

    git status ':(attr:whitespace=indent trail space,attr:label=with
more values)' ':attr(attr:foo:bar)'

would match
* all files that have the whitespace AND the label setting (matching
exactly the values)
* OR foo=bar attribute

This syntax would require to repeat ",attr:" for multiple ANDed attributes,
but would save us from escaped commas, which may be a pain both in parsing as
well as doing the input on a shell?

[1] http://thread.gmane.org/gmane.comp.version-control.git/294989/focus=295016

> I think we should introduce a quoting mechanism to hide these commas
> from the pathspec magic splitter, e.g.
>
> where attr_value_unquote() would copy string while unquoting some
> special characters (i.e. at least ' ' and ',' because they are used
> as syntactic elements in the higher level; there might be others).
>
> diff --git a/pathspec.c b/pathspec.c
> index 0a02255..fb22f28 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -132,7 +132,7 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
>                                 am->match_mode = MATCH_SET;
>                         else {
>                                 am->match_mode = MATCH_VALUE;
> -                               am->value = xstrdup(&attr[attr_len + 1]);
> +                               am->value = attr_value_unquote(&attr[attr_len + 1]);
>                                 if (strchr(am->value, '\\'))
>                                         die(_("attr spec values must not contain backslashes"));
>                         }
>

If we go by whitespaces, we can implement attr_value_unquote as a `tr " " ","`
conceptually, which seems easy.

Thanks,
Stefan
