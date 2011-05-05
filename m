From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH V2 4/5] git-grep: Learn PCRE
Date: Thu, 5 May 2011 09:43:50 +0200
Message-ID: <BANLkTinXoDFyb9U0RJVb8eH269zj+XvBdQ@mail.gmail.com>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com> <1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 09:44:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHtEO-00038I-Qy
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 09:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab1EEHoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 03:44:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab1EEHoM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 03:44:12 -0400
Received: by bwz15 with SMTP id 15so1609034bwz.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=fW6Gdmfv+nzhYPEoZ0m1euQKq6XTQsNqOXgwe4G1M5s=;
        b=rZPTjRoWgz/s1IbgnwGrlfMvjtPqH8OfaiSubi7fJIA/2f/6bG1yFJ4GcbWXFy9Ycp
         eGxQ9vsuHNWZJW98l8SuNqokqhxrenJcgzAisN8C8wWCHjhBexrw5UX7DAe+kEosFwOd
         xjCef65nqw14JmBQOlUKrnamB7Yxy3XSRpaK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EY3frwYqry1RfuRlN3F54BpH5a68KMZMbSjn+kapT6cOOz+8+qVWwtuaCk/hbKqOGK
         HOYocr4elcEefLzp+ZXKz7JSyscLfRwAvYiY5bIEaAt/7UjUKnCxWvfTh3vTwruIvhUu
         IWLYg8ucVTAcc6IOGNkLU/PuevDvTvHOJUck0=
Received: by 10.204.152.5 with SMTP id e5mr1960891bkw.138.1304581450690; Thu,
 05 May 2011 00:44:10 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Thu, 5 May 2011 00:43:50 -0700 (PDT)
In-Reply-To: <1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172814>

2011/5/5 Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>:
> +#ifdef NO_LIBPCRE
> +static void compile_pcre_regexp(struct grep_pat *p, struct grep_opt =
*opt)
> +{
> + =C2=A0 =C2=A0 =C2=A0 die("cannot use Perl-compatible regexes when l=
ibpcre is not compiled in");
> +}

Looks like these two functions below can be just left empty, because yo=
u will
exit when calling compile_pcre_regexp in compile_regexp.

> +static int pcrematch(struct grep_pat *p, char *line, char *eol,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regmatch_t *match,=
 int eflags)
> +{
> + =C2=A0 =C2=A0 =C2=A0 die("cannot use Perl-compatible regexes when l=
ibpcre is not compiled in");
> +}
> +
> +static void free_pcre_regexp(struct grep_pat *p)
> +{
> + =C2=A0 =C2=A0 =C2=A0 die("cannot use Perl-compatible regexes when l=
ibpcre is not compiled in");
> +}
> +

These will be never called, because...

> @@ -70,6 +135,11 @@ static void compile_regexp(struct grep_pat *p, st=
ruct grep_opt *opt)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p->fixed)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> + =C2=A0 =C2=A0 =C2=A0 if (opt->pcre) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compile_pcre_regex=
p(p, opt);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }

=2E.. you die here, if PCRE not available.
