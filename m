From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 1/9] submodule-config: keep update strategy around
Date: Fri, 5 Feb 2016 12:25:38 -0800
Message-ID: <CAGZ79kYfxYAZif4P0GRdy5LQVXuHAyr3VtwEtX7Uu0sDyD4yoQ@mail.gmail.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
	<1454623776-3347-2-git-send-email-sbeller@google.com>
	<20160205005946.GA19501@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:25:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmwq-0004tX-JG
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 21:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbcBEUZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 15:25:40 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:35413 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbcBEUZj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 15:25:39 -0500
Received: by mail-io0-f176.google.com with SMTP id d63so141041372ioj.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 12:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h57quyG/wxYLRGXk7d8pVz4DWDC6IuHsCy9AArxTHvk=;
        b=WXzVGP/PZLMlR/Cxp8uUfFLIjeBYoaBsN+w8hgaPFchobCaPG/nrvm/PK+e+UvLD/a
         m+LKB10NzN4GQO/19eSEoeJS4wQ4i6qvyDnXzx5/9/4lX4ksFbjiXl+ido2qMxLkcU+6
         1txd0Rpi3igEBxudJB7Gys48vnVGNrpzvOGfD5IDOxLQLQSNZqXfsEmwSNCGEuaBzZwP
         ZQYLEB8i3QjFjFoEKg+qxW4hUfjqjdiCKSEQfmtLX5CSR4/9vWXzECW4jyAN6ynxxLM0
         CFOJCJxR9cuM2Sy8PLjYFRBF1MoH97AMh1S1hquUNS01ptQNLxkToyexYHCdz2+2argP
         1ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=h57quyG/wxYLRGXk7d8pVz4DWDC6IuHsCy9AArxTHvk=;
        b=MqPpSEIuHSFpZaAEP9nJu/GMBiTm6h3Sq97MoOfiBSV2pRD24d4ec03aiBBkLOUcOJ
         6RmKu0zg6DQQltNNQy4e/SDniLCzsU6xOjhyKv6Am73a7KqjGo3AMBvl9SMK8eo1lQNl
         ui+bXYJgZc+ld2qKcGodunKIyPXb61OlEMhUqJp0y3CuOL+zYHDVDluXShD4yybeh3SV
         2CpainGgQRNZQW60+9GAd/vziqNgQ0FbCVthq8GBRJKAFMEQRcEnNeaIwXfJC64TC5wT
         nsn+BBOrIQ3YBS+y4J5KEZOXcNlNSRMINB0lexbf0iKzdVZO6vYmx+RAbKBjM534o1Nt
         zC5A==
X-Gm-Message-State: AG10YORTpDwBb2HtckgHYmNp9rtCvluoVwseVdM6RSOgv9QyTzXRxtH+L4fukjP4S2hX/awwByoatQGpax51g+Mf
X-Received: by 10.107.137.100 with SMTP id l97mr19321913iod.110.1454703939007;
 Fri, 05 Feb 2016 12:25:39 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 5 Feb 2016 12:25:38 -0800 (PST)
In-Reply-To: <20160205005946.GA19501@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285625>

On Thu, Feb 4, 2016 at 4:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> It's been a while since I looked at this series.  Hopefully I can
> come at it with some fresh eyes.  Thanks for your perseverance.
>
> Stefan Beller wrote:
>
>> We need the submodule update strategies in a later patch.
>
> This description doesn't explain what the patch will do or why
> parse_config didn't already retain the value.  If I look back
> at this patch later and want to understand why it was written,
> what would I want to know?
>
> It could say
>
>         Currently submodule.<name>.update is only handled by git-submodule.sh.
>         C code will start to need to make use of that value as more of the
>         functionality of git-submodule.sh moves into library code in C.
>
>         Add the update field to 'struct submodule' and populate it so it can
>         be read as sm->update.


ok

>
> [...]
>> +++ b/submodule-config.c
>> @@ -311,6 +312,16 @@ static int parse_config(const char *var, const char *value, void *data)
>>                       free((void *) submodule->url);
>>                       submodule->url = xstrdup(value);
>>               }
>> +     } else if (!strcmp(item.buf, "update")) {
>> +             if (!value)
>> +                     ret = config_error_nonbool(var);
>> +             else if (!me->overwrite && submodule->update != NULL)
>> +                     warn_multiple_config(me->commit_sha1, submodule->name,
>> +                                          "update");
>> +             else {
>> +                     free((void *) submodule->update);
>> +                     submodule->update = xstrdup(value);
>> +             }
>
> (not about this patch) This code is repetitive.  Would there be a way
> to share code between the parsing of different per-submodule settings?
>
> [...]
>> --- a/submodule-config.h
>> +++ b/submodule-config.h
>> @@ -14,6 +14,7 @@ struct submodule {
>>       const char *url;
>>       int fetch_recurse;
>>       const char *ignore;
>> +     const char *update;
>
> gitmodules(5) tells me the only allowed values are checkout, rebase,
> merge, and none.  I wouldn't know at a glance how to match against
> those in calling code.  Can this be an enum?

"Note that the !command form is intentionally ignored here for
security reasons."

However you can overwrite the update field in .git/config to be "! [foo]",
which we also need to support, so let's keep it a string for now?

>
> Thanks,
> Jonathan
