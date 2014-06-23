From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] diff: mark any file larger than core.bigfilethreshold binary
Date: Mon, 23 Jun 2014 19:18:37 +0700
Message-ID: <CACsJy8A5StEv4O64rnd39+1jMNWiaAv4oOd0+Yko_JPuk6EYZw@mail.gmail.com>
References: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
 <1401368227-14469-1-git-send-email-pclouds@gmail.com> <1401368227-14469-4-git-send-email-pclouds@gmail.com>
 <1403180845.10052.16.camel@thomas-debian-x64>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	"Dale R. Worley" <worley@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 14:19:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz3DN-00076H-TG
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 14:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbaFWMTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 08:19:09 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:54430 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbaFWMTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 08:19:08 -0400
Received: by mail-qa0-f48.google.com with SMTP id x12so5464585qac.7
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dAMGT9EBi+PQ3J9GMO4gztAm9P2WtUeLJDpuCvMs2VQ=;
        b=dBrW2+2DW+kaVMo3jAShGh3oxy33+nl5/0Nstyh4NEP/D1+B5ST3K7VCYABWeROwue
         a2qkCM43Mto+N4UF3ACfr8h/qTOo1zv9bfiqIJptdCZ55VTyQpbryp1nuUb0uh+cqhUr
         mrL7F95Of5s5E+5GSmWHZutV01sMwkVuaiCGXD7Ch2K6hqdwxpNErYr98AYE4gFDvS4G
         2d7oacN1QBCFhDowCTf4VegkH7GdEIhHqkGnvlaEkcKEqB1eUgG1qnJV6NapDBcPG93U
         yPFYZ+fB/cxKM2N+SDt2dQwQe97hSKRr4ts6MmupD5hqxP+DWjWPQE2x5qSQ87o7c9Do
         n2qw==
X-Received: by 10.140.109.118 with SMTP id k109mr30057590qgf.98.1403525947737;
 Mon, 23 Jun 2014 05:19:07 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 23 Jun 2014 05:18:37 -0700 (PDT)
In-Reply-To: <1403180845.10052.16.camel@thomas-debian-x64>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252343>

On Thu, Jun 19, 2014 at 7:27 PM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
>> @@ -2721,6 +2721,11 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>>               }
>>               if (size_only)
>>                       return 0;
>> +             if ((flags & DIFF_POPULATE_IS_BINARY) &&
>> +                 s->size > big_file_threshold && s->is_binary == -1) {
>> +                     s->is_binary = 1;
>> +                     return 0;
>> +             }
>
> Why do you check for s->is_binary == -1 here? I think it does not matter
> what s_is_binary says here.

If some .gitattributes to mark one file not-binary, we should respect
that, I think. Same for below too.

> I would also add a note to the documentation e. g:
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 9f467d3..7a2f27d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -499,7 +499,8 @@ core.bigFileThreshold::
>         Files larger than this size are stored deflated, without
>         attempting delta compression.  Storing large files without
>         delta compression avoids excessive memory usage, at the
> -       slight expense of increased disk usage.
> +       slight expense of increased disk usage.  Additionally files
> +       larger than this size are allways treated as binary.
>  +
>  Default is 512 MiB on all platforms.  This should be reasonable
>  for most projects as source code and other text files can still

Thanks. Will do. Sorry a little busy these days and could not reply earlier.
-- 
Duy
