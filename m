From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 6/6] tag.c: Change gpg_verify_tag argument to sha1
Date: Mon, 4 Apr 2016 22:00:17 -0400
Message-ID: <CAPig+cQ4i86JpLFe0tqA-tjFj6Y3DvxDz3nFL8XAMVDBLwLUPg@mail.gmail.com>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
	<1459808535-8895-7-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:04:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anGLo-0006tx-AD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 04:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944AbcDECBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 22:01:33 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35369 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786AbcDECBc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 22:01:32 -0400
Received: by mail-io0-f193.google.com with SMTP id q128so295931iof.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 19:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=j41NaVTS+fY7ob6npKNsqs2Fhsmzmd0Dc+fKyapndjY=;
        b=vK1g/vzjgD4OaiIPCkKXCxMrKcx9v8B9sr8CjPDf5Al8ZWKqivsqWZI9LAw1ubuolv
         nHzqdcwoLTN84PmbbNlCyj7hoR3gaPd4uGDlJt3CsRjuEHLrNvBlaBwlmkk6Bd2BHVSF
         qDjoGeCohQ2hVXBapFDrA+aLOKU44zKsId9w8HVj50tT5Wmi09L/tg9W6M/NhN3nvcfy
         7KZDieuLmaq/tqs6SfZfNxG3ayARgzQK1XiFYLXpLGs3RD/c8hFiKKu0HDBBQSDqpAI0
         HQykUF2cYt6DHvlCMA79j9MGyGAzR1QfJJOSmtP55T3vLemTchy+ZC2SkqfiKcIt+a/q
         UpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=j41NaVTS+fY7ob6npKNsqs2Fhsmzmd0Dc+fKyapndjY=;
        b=FQSZorssubgMMt3vc2m9XCd7Kf1VL2KjIZwQEEKPGZIr4UNweEa1+ABugLl9bqFHwk
         NzPPU7xVn3QdZ69CWp/9aOf3h+ijfV+agWM028mdbZS30biu/EPRvtxh/IHGouGfH8WD
         J9IwbeMqoAoBrobYW1sgsqud9rYJZXmhtoLhZMjDB+/Aa5ZqwJShMHodzm0a447ZyUqa
         5FqEsoXm2wJEs8Ys7HdSqcOjJfjttkuJAz9w/Kz/scuw1kKtJV4xCMFwPdVZCALo+xlM
         Z+EN9R/2ZH7Ulaykwg2rSxqFUH0czGyVN6YnIRQMZc+M3JEIXlhoUAMaxMmGnOxxdfbD
         uc9Q==
X-Gm-Message-State: AD7BkJLyalEL/AIwhZnt6ZhjKpLLO0vVHmP81IL7rXv1BMSwODDVDJ9ygq+D9KQj6XyYR+Z04ojBJv/AnJw0Iw==
X-Received: by 10.107.130.138 with SMTP id m10mr13641780ioi.34.1459821617762;
 Mon, 04 Apr 2016 19:00:17 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 19:00:17 -0700 (PDT)
In-Reply-To: <1459808535-8895-7-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: W29i527I0FMbFSjRvAM5Q65zX4k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290754>

On Mon, Apr 4, 2016 at 6:22 PM,  <santiago@nyu.edu> wrote:
> tag.c: Change gpg_verify_tag argument to sha1

s/Change/change/

> The gpg_verify_tag function resolves the ref for any existing object.
> However, git tag -v resolves to only tag-refs. We can provide support
> for sha1 by moving the refname resolution code out of gpg_verify_tag and
> allow for the object's sha1 as an argument.

This description leaves me fairly clueless about why this change is
being made since justification seems to be lacking. More about this
below...

> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> diff --git a/builtin/tag.c b/builtin/tag.c
> @@ -104,7 +104,7 @@ static int delete_tag(const char *name, const char *ref,
>  static int verify_tag(const char *name, const char *ref,
>                                 const unsigned char *sha1)
>  {
> -       return gpg_verify_tag(name, GPG_VERIFY_VERBOSE);
> +       return gpg_verify_tag(sha1, GPG_VERIFY_VERBOSE);
>  }

So, by this point, 'name' has already been resolved to 'sha1', thus
this change avoids a second resolution of 'name' inside
gpg_verify_tag(). Therefore, this is really an optimization, right?
Perhaps the intent of the patch would be clearer if the commit message
sold it as such. For instance, the commit message might start off:

    tag: avoid resolving tag name twice

and then go on to say that by hefting tag name resolution out of
gpg_verify_tag(), the extra resolution can be avoided.

>  static int do_sign(struct strbuf *buffer)
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> @@ -46,8 +47,12 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>         if (verbose)
>                 flags |= GPG_VERIFY_VERBOSE;
>
> -       while (i < argc)
> -               if (gpg_verify_tag(argv[i++], flags))
> +       while (i < argc) {
> +               if (get_sha1(argv[i++], sha1))
> +                       return error("tag '%s' not found.", argv[i]);

Why does this 'return' after the first error, but the gpg_verify_tag()
call below merely sets a 'had_error' flag and continues? I would
expect this one to set the flag and continue, as well.

> +

Style: unnecessary blank line

> +               if (gpg_verify_tag(sha1, flags))
>                         had_error = 1;
> +       }
>         return had_error;
>  }
> diff --git a/tag.c b/tag.c
> @@ -30,25 +30,21 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
> -int gpg_verify_tag(const char *name, unsigned flags)
> +int gpg_verify_tag(const unsigned char *sha1, unsigned flags)
>  {
>         enum object_type type;
> -       unsigned char sha1[20];
>         char *buf;
>         unsigned long size;
>         int ret;
>
> -       if (get_sha1(name, sha1))
> -               return error("tag '%s' not found.", name);
> -
>         type = sha1_object_info(sha1, NULL);
>         if (type != OBJ_TAG)
> -               return error("%s: cannot verify a non-tag object of type %s.",
> -                               name, typename(type));
> +               return error("cannot verify a non-tag object of type %s.",
> +                               typename(type));

This error message becomes much less useful since it now only says
that there is a problem with *some* tag but doesn't give any
identifying information. How about including the sha1 in the error
message?

>
>         buf = read_sha1_file(sha1, &type, &size);
>         if (!buf)
> -               return error("%s: unable to read file.", name);
> +               return error("unable to read file.");

Ditto regarding making this more useful by including the sha1.

>         ret = run_gpg_verify(buf, size, flags);
