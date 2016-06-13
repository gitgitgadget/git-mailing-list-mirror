From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] parse-options-cb.c: use string_list_append_nodup in OPT_STRING_LIST()
Date: Mon, 13 Jun 2016 07:08:55 +0700
Message-ID: <CACsJy8C+NtiXRo8NcU3rtgWrMSj8Zv3mYtdYfyvzwYRHifKVCQ@mail.gmail.com>
References: <20160610115726.4805-1-pclouds@gmail.com> <20160612220316.GB5428@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 13 02:11:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCFTx-0005of-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 02:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933018AbcFMAJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 20:09:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36724 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962AbcFMAJZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2016 20:09:25 -0400
Received: by mail-it0-f65.google.com with SMTP id h190so5400399ith.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 17:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k5MoPTTu9jH/yBWKtC5VLUJRaTWSAyIyFfiVkuo1/yE=;
        b=TYj2QVYkwjipOe5pjZkaJGCrRVvyr3SdVqRG4vBCjsVT+P6bsXzNk3GqlbFep+o2mc
         zeyav7Jc9hadouKhRRSPmrDbUymnQGYPdiuEvkBlB+oNKvrWhiJdRwfZ0+1QuK88e3Ow
         a4GlOadqMH2hCdghWh7OzAgM+1oGta/cgGTPUqt6+nouU8ZARrdWPGEZZR8994ytrylt
         u+aSJ/Bwfm+Cuj8AiZefXh84csdCy4CrC1mYcVtRPWwMWHm8Mcx+7UiWe9+gYjBG3aBo
         GdJZWa74GPcA3GFWXSejnUByu98bVX0v7BBMNM7P31kbHDRS6RAm8XR5X5uGFm68qYo/
         +gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k5MoPTTu9jH/yBWKtC5VLUJRaTWSAyIyFfiVkuo1/yE=;
        b=hQU4wknjBQ+JTpTO1mXbDEHvXaLlDk2CNJjPpcj9OamtOlsm2eVmTMDvtNq1nCPHiV
         nZMu8U5ta2RF+DHhwKDot6lbwReRx5zQjJsRR1BwIsiG9tfz+OEiq4RyJmSAcb2Zj+O3
         Hq8z1vQ1jkxpIzu5mOQGqLafmfHmJIau7NMLS2XmO6sVQikDkElyffkc5dvzmmRMVSR5
         zHGNsQRKV4jYROQNk26/E7m78cjEihc4+cJxn4i3yHY+VZkBUVgLShxt6WC2elCfVDUF
         J1JPgr+M1V4Hg+XLeh72xVOg433kD5Jgwx2ONvpD+cKKcMn9bcEBsT59UpLuTr5R5kiA
         gaaw==
X-Gm-Message-State: ALyK8tIPa4fdI1sXuzQOwF5nYHOu/DBNLFT7l2nClGmTlXIX2P+D+wxwdm7adf1KS/Cv9kUHpqH8vVeGUGD42w==
X-Received: by 10.36.130.130 with SMTP id t124mr13986404itd.42.1465776564463;
 Sun, 12 Jun 2016 17:09:24 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sun, 12 Jun 2016 17:08:55 -0700 (PDT)
In-Reply-To: <20160612220316.GB5428@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297145>

On Mon, Jun 13, 2016 at 5:03 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 10, 2016 at 06:57:26PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> If the given string list has strdup_strings set (*), the string will=
 be
>> duplicated again. Pointless and leak memory. Ignore that flag.
>>
>> (*) only interpret-trailers.c does it at the moment
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  parse-options-cb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/parse-options-cb.c b/parse-options-cb.c
>> index 239898d..8a1b6e6 100644
>> --- a/parse-options-cb.c
>> +++ b/parse-options-cb.c
>> @@ -144,7 +144,7 @@ int parse_opt_string_list(const struct option *o=
pt, const char *arg, int unset)
>>       if (!arg)
>>               return -1;
>>
>> -     string_list_append(v, xstrdup(arg));
>> +     string_list_append_nodup(v, xstrdup(arg));
>
> Hmm. So I agree this is an improvement, in the sense that we are
> double-allocating when v->strdup_strings is set.  But I think there's=
 a
> deeper issue here. Why are we always allocating in the first place?
>
> If the memory we are getting in "arg" is not stable, then we _do_ nee=
d
> to make a copy of it. But in that case, we want "strdup_strings" to b=
e
> set; without it any time we later run string_list_clear(), we leak th=
e
> allocated memory, because the struct has no idea that it is the owner=
 of
> the memory (and we do call string_list_clear() when we see "--no-foo"=
).
>
> If the memory _is_ stable, then we are fine to add a direct reference=
 to
> it, and can lose the extra xstrdup() here. Only the caller knows for
> sure, so we should be respecting their value of strdup_strings (so lo=
se
> the xstrdup, but keep calling string_list_append()).
>
> In practice, I suspect the memory _is_ stable, because we are general=
ly
> parsing command-line arguments. But it does not hurt to stay on the
> conservative side, and always make a copy (in case we are parsing
> something besides the global argv array) . Apparently I am the origin=
al
> author of this code, in c8ba163 (parse-options: add OPT_STRING_LIST
> helper, 2011-06-09), but there's no mention of this point there, in t=
he
> list archives, or in my brain.
>
> So if we are doing the conservative thing, then I think the resulting
> code should either look like:
>
>   if (!v->strdup_strings)
>         die("BUG: OPT_STRING_LIST should always use strdup_strings");
>   string_list_append(v, arg);

I agree with the analysis. But this die() would hit all callers
(except interpret-trailers) because they all initialize with _NODUP
and setting strdup_strings may require auditing all access to the
string list in question, e.g. to change string_list_append(v,
xstrdup(xxx)) to string_list_append(xxx). it may cause side effects if
we are not careful.

So far all callers are in builtin/, I think it will not take much time
to verify that they all call parse_options() with global argv, then we
can just lose extra xstrdup() and stick to string_list_append().
OPTION_STRING already assumes that argument strings are stable because
they are passed back as-is. Can we go with an easier route, adding a
comment on top of parse_options() stating that argv[] pointers may be
passed back as-is and it's up to the caller to xstrdup() appropriately
before argv[] memory is freed?

>
> or:
>
>   /* silently enable for convenience */
>   v->strdup_strings =3D 1;
>   string_list_append(v, arg);
>
> Of the two, I like the top one as it is less magical, but it would
> require adjusting the initialization of the string-list for most of t=
he
> callers.
>
> -Peff



--=20
Duy
