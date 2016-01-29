From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 05/10] grep/icase: avoid kwsset when -F is specified
Date: Fri, 29 Jan 2016 01:23:21 -0500
Message-ID: <CAPig+cS0Aqjn7+E4bh-QjXpaP+wfRFFkE2CuiAPbcdNv7-2cGw@mail.gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1453982183-24124-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 07:23:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP2St-00065a-4M
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 07:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbcA2GXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 01:23:23 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36287 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbcA2GXW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2016 01:23:22 -0500
Received: by mail-vk0-f66.google.com with SMTP id e64so2464414vkg.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 22:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ow6tXAGwo7eGaRf6oF7iJVYkN4owSbnOGTy7WJFpbNo=;
        b=HBwtoP3mcOGA4L/Eh5eix8WmCCo00uRftLTBWJFe+2OzjgfmFCpc4QX0q3CWuWeFs2
         UchuT/9rMTGSv4iDmbYasZTv5vW8I2jbkpjYwmirizZlllLYc2bbQQcwpmMLzv3/HCrY
         KhKLIUDoNtn9AcwpbG1gBGHLCHbLJDe9Or6eu8yM4ynC5TYG8y0oYZWob3x0tFz20dOY
         DtS7lJrEWm6VWNlaHWAq+EzPm5pNecj6DPjh/sgKimdmnP4bLK2Cm0F/f3URLMewhu1x
         7nxElgYW5G8xp8PL5Ue07793sbYNciES34Fk7zIH9ViYkXvmOYxXWrrIOTzs9LRdGaOv
         X4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ow6tXAGwo7eGaRf6oF7iJVYkN4owSbnOGTy7WJFpbNo=;
        b=L17xV3n3zAjbVA0gE07Ex+JtV6a/k3SyRHc/BtBXjow0TYfWIMkLLxttZSIGbc0Y2I
         //sWlBiepUDYgGTPRkMZq4Gj5YzV7FPOOzWUfDv3Ka8Bn9Wg5qHMZeZtBAoXPejnJPry
         NjGNH8M28OtavIjdhVVlBsJSjfG7LCLHJOUftcSzvbBk2YdC8ZNDuNJt//VVePMKC1E8
         AZ5xegUuZlnwqTzBIn8B+GcgJ1SaA3V+SiwmlR67566ZgDVkF09WWFA9AlCWYC5IrYoT
         hHddzq9P6JsOCvLhVKp/lsVAnp7Oq6Y8oAGcMrKc8m5U7HaZjlt69kYwgsCmORK4Rvhs
         biEA==
X-Gm-Message-State: AG10YOQDuSws+OwsxsWpvAfBJwoV6EXIFUEmo54cpO1hH/fRIuRQeFUuN/VytFcXQ8QDXkiwjqKHTdNSTO61TQ==
X-Received: by 10.31.141.2 with SMTP id p2mr4836940vkd.37.1454048601985; Thu,
 28 Jan 2016 22:23:21 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 28 Jan 2016 22:23:21 -0800 (PST)
In-Reply-To: <1453982183-24124-6-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: gJDiBO8bQMawy8jhz0Xf5eIriSE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285065>

On Thu, Jan 28, 2016 at 6:56 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Similar to the previous commit, we can't use kws on icase search
> outside ascii range. But we can't simply pass the pattern to
> regcomp/pcre like the previous commit because it may contain regex
> special characters, so we need to quote the regex first.
>
> To avoid misquote traps that could lead to undefined behavior, we
> always stick to basic regex engine in this case. We don't need fancy
> features for grepping a literal string anyway.
>
> basic_regex_quote_buf() assumes that if the pattern is in a multibyte
> encoding, ascii chars must be unambiguously encoded as single
> bytes. This is true at least for UTF-8. For others, let's wait until
> people yell up. Chances are nobody uses multibyte, non utf-8 charsets
> any more..

s/any more../anymore./

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/grep.c b/grep.c
> @@ -397,6 +398,24 @@ static int is_fixed(const char *s, size_t len)
> +static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt=
 *opt)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       int err;
> +
> +       basic_regex_quote_buf(&sb, p->pattern);
> +       err =3D regcomp(&p->regexp, sb.buf, opt->regflags & ~REG_EXTE=
NDED);
> +       if (opt->debug)
> +               fprintf(stderr, "fixed%s\n", sb.buf);

Did you want a space or colon or something after "fixed" for human
consumption? (I realize that the test case doesn't care.)

> +       strbuf_release(&sb);
> +       if (err) {
> +               char errbuf[1024];
> +               regerror(err, &p->regexp, errbuf, 1024);

I guess this was copy/pasted from compile_regexp(), but for this new
code, perhaps: s/1024/sizeof(errbuf)/

> +               regfree(&p->regexp);
> +               compile_regexp_failed(p, errbuf);
> +       }
> +}
