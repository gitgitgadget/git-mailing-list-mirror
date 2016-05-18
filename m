From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] attr: expose validity check for attribute names
Date: Wed, 18 May 2016 14:42:07 -0700
Message-ID: <CAGZ79kYkeF-YTYqsLSsESWLcXmX5Dx-NdCnzmeBiRRnotZ49dA@mail.gmail.com>
References: <20160518190222.28105-1-sbeller@google.com> <20160518190222.28105-6-sbeller@google.com>
 <xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com> <xmqqy477qfr2.fsf@gitster.mtv.corp.google.com>
 <xmqqh9dvqdoy.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 23:42:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b39EN-0006G1-FY
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 23:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbcERVmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 17:42:11 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37029 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbcERVmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 17:42:09 -0400
Received: by mail-ig0-f180.google.com with SMTP id s8so34940345ign.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a6axnP3SIHSo7YXZeV8GNt+FlKh3QNScsy2+WMp2kaQ=;
        b=lVGOABL3m9Ht/CTrhN/HrEIkPW9DuvXk36//2mv0E8u/kee0uLFzfGbU8YrIkvUxAV
         l3uXwEFeh4BTuN9AJReLpKfWVXLNkMYxhDGgg3JrbT0hfjsV58Z2xrQF6SNLRGXX/P/E
         3ipke31neYlaUanH7cnK02NV67nEVRpIrMox77Bf+9gAcfCVnqSSn3359CHBu6Ubmyxv
         8oEJ/qDXtDBiZ3158pFlD/2X7tqTlXZnQ+wHNWyHGQjnO6HuBeZK0uAy/cbXCMpc8TRB
         KkoHc47cZkHL+G0To8EMk24Nva+ykulDHUkEQR39I9qg+rv3UIAYCJIQfpJZkUawUPbE
         yElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a6axnP3SIHSo7YXZeV8GNt+FlKh3QNScsy2+WMp2kaQ=;
        b=YZEjdALBmxZ88FgWgpy1aQEMb6HU8yaduIG9mAzSC1NYMaWS62eLbHx8MW+Q/JdKXb
         EC2ZtPTzE9HiFpsvu6jecfsqsNoN2yhw2mSdkGQoArrY0vloyH7/ltTXKPSQNbgXZusB
         Sf7Mpn58fOz834XF/6gLkd+L4c7RxOQkGykBFbP84/HPwvJvTkIbSp26tNa4D8jVk4Cx
         LxT3DD/h2rybo+t+3hVYcuAcuDj0swFK3o+NMPX18Fv3xgVtuYgutlqH5jaCSM2PxO3z
         MS9+WNjIZrjWEF6X51wqN/QWRIpzhQC8eBDLvXtpBH+qTVtoHrtTSTswuUPe3YTYWS1l
         wEUA==
X-Gm-Message-State: AOPr4FXjOiNSDG8C+I787QU3VIs+8mueuwgPK/gmQOYsApcV5RTw985ySTwFnk1g4vAZzHB3K0nRCBJTHMLmWYp2
X-Received: by 10.50.29.45 with SMTP id g13mr127073igh.93.1463607728226; Wed,
 18 May 2016 14:42:08 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 18 May 2016 14:42:07 -0700 (PDT)
In-Reply-To: <xmqqh9dvqdoy.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295014>

On Wed, May 18, 2016 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Export attr_name_valid() function, and a helper function that
> returns the message to be given when a given <name, len> pair
> is not a good name for an attribute.
>
> We could later update the message to exactly spell out what the
> rules for a good attribute name are, etc.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * And then finally the error message one.  I didn't change
>    the message itself to spell out the rules here, though.
>
>  attr.c | 39 +++++++++++++++++++++++++--------------
>  attr.h |  3 +++
>  2 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 7f20e21..8f54871 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -59,23 +59,38 @@ static unsigned hash_name(const char *name, int namelen)
>         return val;
>  }
>
> -static int invalid_attr_name(const char *name, int namelen)
> +int attr_name_valid(const char *name, size_t namelen)

Mental note:
The patch series with the pathspec attrs on top of this series makes this
non-static and exposes the invalid_attr_name for wider use, so I'll resolve
the merge conflict accordingly.

>  {
>         /*
>          * Attribute name cannot begin with '-' and must consist of
>          * characters from [-A-Za-z0-9_.].
>          */
>         if (namelen <= 0 || *name == '-')
> -               return -1;
> +               return 0;
>         while (namelen--) {
>                 char ch = *name++;
>                 if (! (ch == '-' || ch == '.' || ch == '_' ||
>                        ('0' <= ch && ch <= '9') ||
>                        ('a' <= ch && ch <= 'z') ||
>                        ('A' <= ch && ch <= 'Z')) )
> -                       return -1;
> +                       return 0;
>         }
> -       return 0;
> +       return -1;
> +}
> +
> +void invalid_attr_name_message(struct strbuf *err, const char *name, int len)
> +{
> +       strbuf_addf(err, _("%.*s is not a valid attribute name"),
> +                   len, name);
> +}
> +
> +static void report_invalid_attr(const char *name, size_t len,
> +                               const char *src, int lineno)
> +{
> +       struct strbuf err = STRBUF_INIT;
> +       invalid_attr_name_message(&err, name, len);
> +       fprintf(stderr, "%s: %s:%d\n", err.buf, src, lineno);
> +       strbuf_release(&err);
>  }
>
>  struct git_attr *git_attr_counted(const char *name, size_t len)
> @@ -90,7 +105,7 @@ struct git_attr *git_attr_counted(const char *name, size_t len)
>                         return a;
>         }
>
> -       if (invalid_attr_name(name, len))
> +       if (!attr_name_valid(name, len))
>                 return NULL;
>
>         FLEX_ALLOC_MEM(a, name, name, len);
> @@ -176,17 +191,15 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
>                         cp++;
>                         len--;
>                 }
> -               if (invalid_attr_name(cp, len)) {
> -                       fprintf(stderr,
> -                               "%.*s is not a valid attribute name: %s:%d\n",
> -                               len, cp, src, lineno);
> +               if (!attr_name_valid(cp, len)) {
> +                       report_invalid_attr(cp, len, src, lineno);
>                         return NULL;
>                 }
>         } else {
>                 /*
>                  * As this function is always called twice, once with
>                  * e == NULL in the first pass and then e != NULL in
> -                * the second pass, no need for invalid_attr_name()
> +                * the second pass, no need for attr_name_valid()
>                  * check here.
>                  */
>                 if (*cp == '-' || *cp == '!') {
> @@ -229,10 +242,8 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
>                 name += strlen(ATTRIBUTE_MACRO_PREFIX);
>                 name += strspn(name, blank);
>                 namelen = strcspn(name, blank);
> -               if (invalid_attr_name(name, namelen)) {
> -                       fprintf(stderr,
> -                               "%.*s is not a valid attribute name: %s:%d\n",
> -                               namelen, name, src, lineno);
> +               if (!attr_name_valid(name, namelen)) {
> +                       report_invalid_attr(name, namelen, src, lineno);
>                         return NULL;
>                 }
>         }
> diff --git a/attr.h b/attr.h
> index 78d6d5a..fc72030 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -13,6 +13,9 @@ extern struct git_attr *git_attr(const char *);
>  /* The same, but with counted string */
>  extern struct git_attr *git_attr_counted(const char *, size_t);
>
> +extern int attr_name_valid(const char *name, size_t namelen);

ok, I agree with this one.

> +extern void invalid_attr_name_message(struct strbuf *, const char *, int);

This makes sense, too, so the caller can just collect the error message and
attach its own flair to it, i.e. another message to explain the context about
wrong attributes.

Thanks,
Stefan

> +
>  /* Internal use */
>  extern const char git_attr__true[];
>  extern const char git_attr__false[];
> --
> 2.8.2-759-geb611ab
>
