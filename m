From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 1/2] submodule: port resolve_relative_url from shell to C
Date: Fri, 22 Jan 2016 12:23:54 -0800
Message-ID: <CAGZ79kZ9rEXmtgTpdP5uG46xbxjeboLx3_pdgvspThdebmpyOw@mail.gmail.com>
References: <xmqqa8o188i0.fsf@gitster.mtv.corp.google.com>
	<1453255396-31942-1-git-send-email-sbeller@google.com>
	<1453255396-31942-2-git-send-email-sbeller@google.com>
	<56A27D1F.60007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 21:24:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMiFU-0000M8-3S
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 21:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbcAVUX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 15:23:57 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:34627 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbcAVUXz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 15:23:55 -0500
Received: by mail-io0-f176.google.com with SMTP id 1so99642378ion.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZUIzwtmMIAzxXergS46lZmK0ez3g8MwUP0zHIM6NTKU=;
        b=Zk0Q7HlAXNcpCTk5KOAnl5KrxZJXpHyqWxjMhlkLGIXxoTYXrG1FTQ+qidcfThtwVY
         VdrUGClOy15KXLSYLBDdWmAaW//if38oijknl0i7feXZUMrxrYrqz5Yi/fFkQZAJisjD
         LFfDtuUqUrqAhmayqd8xU9Wau2Cj713kFIaO9xAbvMInI/rtu/X2YJWC73s1XVAwQjjE
         pTUlqgbo+fB9iYkq7K3jF6uzCip3glX78JXmN/IF9Y3kaY+E8TMKAdLHC6VmfmfblZbI
         lU2UB2fbmyzAaOMCs2osuFy1LDQS0UwuEDOMsmeawFGBwPKMIDYcwRXhXRJqhYjTUSVc
         nyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZUIzwtmMIAzxXergS46lZmK0ez3g8MwUP0zHIM6NTKU=;
        b=Yobc46b0agVDZJr0/JlacEUOLUdlrthkO3VUuT8iW0lJ4oEoSxM1jHvKTTmNSaOAyV
         wy5dw50Q6X71YspaVumFwDG/RYpFuB9UXNSVhc21H3FFzIFMtbqWEzhcSzJ1oBpoDOTk
         jMz5JpQkpR2JODPJ83Qtx5YMpTG987feW1zL38tZbc0qNjDv+fH5/Rpbfq1cuX9878pu
         58lhc3KK1ZBXaVySJ1JmoiG2eu/DCxd8pA9lmM3HN4FtU/UUwRxVOCJbljrj19KK4Zl2
         OvPOmvkbMrogGnIrbzruxlgvLQ/GtMSk1Q5xQshIb9Ebg/pQ8dMJ0zeUruo1+XN1Ba59
         tSOw==
X-Gm-Message-State: AG10YORnzMlJJXPg1kEAPmdTTkIuQfw6df6MnQaSa/yFgO6TWg3aFCbdoISFPlE9RyUXvh4N8gmRW9YV/noEhxGo
X-Received: by 10.107.137.68 with SMTP id l65mr6367433iod.110.1453494234714;
 Fri, 22 Jan 2016 12:23:54 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Fri, 22 Jan 2016 12:23:54 -0800 (PST)
In-Reply-To: <56A27D1F.60007@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284590>

On Fri, Jan 22, 2016 at 11:03 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 20.01.2016 um 03:03 schrieb Stefan Beller:
>> +static char *last_dir_separator(char *str)
>> +{
>> +     char *p = str + strlen(str);
>> +     while (p-- > str)
>> +             if (is_dir_sep(*p))
>> +                     return p;
>> +     return NULL;
>> +}
>> +
>
> I just noticed that we already have this function. Please squash in the
> following.

thanks for reviewing! squashed.

>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1484b36..92d7d32 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -51,21 +51,12 @@ static int starts_with_dot_dot_slash(const char *str)
>         return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
>  }
>
> -static char *last_dir_separator(char *str)
> -{
> -       char *p = str + strlen(str);
> -       while (p-- > str)
> -               if (is_dir_sep(*p))
> -                       return p;
> -       return NULL;
> -}
> -
>  /*
>   * Returns 1 if it was the last chop before ':'.
>   */
>  static int chop_last_dir(char **remoteurl, int is_relative)
>  {
> -       char *rfind = last_dir_separator(*remoteurl);
> +       char *rfind = find_last_dir_sep(*remoteurl);
>         if (rfind) {
>                 *rfind = '\0';
>                 return 0;
>
