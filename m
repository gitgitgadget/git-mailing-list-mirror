From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/5] attr.c: pass struct git_attr_check down the callchain
Date: Wed, 8 Jun 2016 16:54:53 -0700
Message-ID: <CAGZ79kZ0uSvTgc9YnVKg01PtRcG4vuhUE+TZoPadT8Xqeqi=Tg@mail.gmail.com>
References: <20160608225818.726-1-gitster@pobox.com> <20160608225818.726-3-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 01:55:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAnJL-0006Ao-2m
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 01:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbcFHXyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 19:54:55 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33340 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbcFHXyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 19:54:54 -0400
Received: by mail-qg0-f52.google.com with SMTP id l44so11332422qgd.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=arR+3rgVPnSuH9J5LhR8qY1FOGcU25BbiMLpg+KROkg=;
        b=IYZvL1BdHFFdZRpzxXHBRFgu5Q+z9Sc/kA8WpBEA1uPtj7DvmrcV1n0AsxCVxXDx1Z
         +WsX8TUowCV9FMvXLtVjfK2/C8MS4wEmkZuLFZ6HlqNHxNcbsKUGAb1ax74Tqn0xaNhc
         M74riNUNsRGGKDuZIGXgyPkdlu2PGmVY9Qf5W/RgaHM0nhxbfvfkeLJo1calgB5lub3R
         P3SWykw4Ei5izcdpUXzdNCBSfZemDROa206BUP5G57oRc+J2Gg8LE8PhIHMQ1Lkkw1jn
         QU3fEXDYkyV8e7iO/EUAMR4zL+X/HHb76C0OXaaluwUzp2V9eoigLVWFGeyvCSsN8OBA
         J7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=arR+3rgVPnSuH9J5LhR8qY1FOGcU25BbiMLpg+KROkg=;
        b=QJBPT2RSJtloqckq+bLq0Kmrb9UALE+ig5LfifDBAV8YFoWbueMkiHT+SzkGFxhTBS
         hacuzR17YaMtwOM92fVbfb5C9i0KWOn5KSsFdVNXwMEO07kDKGoXH5U4eDX5NGtDdKL5
         sI8Q744Yy8Va9u+tCa3DbGBX5AupJxrqt9i5iynMvyubVwH3Wl9jBh1XX74sAHSQrFbS
         Jbm9n6m7D9RNraw2MyyrK9xgWOEWE7DuHH+7uH7jLzVR15Uf6/q84/tu/8kLcJolJuxT
         EoH5yR7OQzQVD/Yif+5na+xO8tBQqSJ7XrJcLuFBBW7lYAiSn2plg1TNKmByk2R3e+Yi
         M60g==
X-Gm-Message-State: ALyK8tIk54nFqThDeWAbS4kY6KU48Xwh4Cab6SNybra0l7c8hY7QjeE00IAN2J9Z3ulTdRVPT7ZmvGDAN71zLpKg
X-Received: by 10.140.238.66 with SMTP id j63mr7252939qhc.48.1465430093481;
 Wed, 08 Jun 2016 16:54:53 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Wed, 8 Jun 2016 16:54:53 -0700 (PDT)
In-Reply-To: <20160608225818.726-3-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296861>

On Wed, Jun 8, 2016 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The callchain that starts from git_check_attrs() down to
> collect_some_attrs() used to take an array of git_attr_check_elem
> as their parameters.  Pass the enclosing git_attr_check instance
> instead, so that they will have access to new fields we will add to
> the data structure.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  attr.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 26228ce..4e2172a 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -746,14 +746,25 @@ static int macroexpand_one(int nr, int rem)
>   * check_all_attr. If num is non-zero, only attributes in check[] are
>   * collected. Otherwise all attributes are collected.
>   */
> -static void collect_some_attrs(const char *path, int pathlen, int num,
> -                              struct git_attr_check_elem *check)
> +static void collect_some_attrs(const char *path, int pathlen,
> +                              struct git_attr_check *check)
>
>  {
>         struct attr_stack *stk;
>         int i, rem, dirlen;
>         const char *cp, *last_slash = NULL;
>         int basename_offset;
> +       int num;
> +       struct git_attr_check_elem *celem;
> +
> +       if (!check) {
> +               /* Yuck - ugly git_all_attrs() hack! */
> +               celem = NULL;
> +               num = 0;
> +       } else {
> +               celem = check->check;
> +               num = check->check_nr;
> +       }
>
>         for (cp = path; cp < path + pathlen; cp++) {
>                 if (*cp == '/' && cp[1])
> @@ -773,9 +784,9 @@ static void collect_some_attrs(const char *path, int pathlen, int num,
>         if (num && !cannot_trust_maybe_real) {
>                 rem = 0;
>                 for (i = 0; i < num; i++) {
> -                       if (!check[i].attr->maybe_real) {
> +                       if (!celem[i].attr->maybe_real) {
>                                 struct git_attr_check_elem *c;
> -                               c = check_all_attr + check[i].attr->attr_nr;
> +                               c = check_all_attr + celem[i].attr->attr_nr;
>                                 c->value = ATTR__UNSET;
>                                 rem++;
>                         }
> @@ -789,18 +800,19 @@ static void collect_some_attrs(const char *path, int pathlen, int num,
>                 rem = fill(path, pathlen, basename_offset, stk, rem);
>  }
>
> -static int git_check_attrs(const char *path, int pathlen, int num,
> -                          struct git_attr_check_elem *check)
> +static int git_check_attrs(const char *path, int pathlen,
> +                          struct git_attr_check *check)
>  {
>         int i;
> +       struct git_attr_check_elem *celem = check->check;

We don't need this outside the for loop; maybe we want to move
this in there including indexing?

Or rather dropping the arrays and use pointers
in there if we're concerned about performance?
(That would be a slightly larger refactoring, roughly):

    struct git_attr_check_elem *cur = check->check;
    struct git_attr_check_elem *end = cur + check->check_nr;
    while (cur < end) {
        value = check_all_attr[cur->attr->attr_nr].value;
        cur->value = (value == ATTR__UNKNOWN) ? ATTR__UNSET : value;
        cur++;
    }


Looks correct as it is, though.

Thanks,
Stefan
