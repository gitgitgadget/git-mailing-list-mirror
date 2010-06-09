From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use strncpy to protect from buffer overruns.
Date: Wed, 9 Jun 2010 21:31:09 +0200
Message-ID: <AANLkTikQpJa9gzj1riKF79MflGAKv9IqJVXpICgHLXAG@mail.gmail.com>
References: <1276078921-25429-1-git-send-email-smichalske@gmail.com>
	<AANLkTikID-cEqdDD8XEEYmClSYEkcxdAU-rjYA2LoRVe@mail.gmail.com>
	<34152ED6-ACCC-467B-9076-1A742612AC75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 21:31:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMQzf-0001rW-5Z
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 21:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758185Ab0FITbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 15:31:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51993 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250Ab0FITbN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 15:31:13 -0400
Received: by gye5 with SMTP id 5so4080390gye.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vo6w37/TMq+rAxdzKzUfQ/e4VREfRMYY2lwKbxvZXYw=;
        b=dJsde6s7dednHNvRrBVHOSizBseNS5o3M9b1HmtBpeUHl9QmIgirNsVDy8yEJtw5jl
         F1p6HftEvAyR5Cee4pxyy/4MxjoxOW5dLsT3CcurHFNE5e5FSmuWlN9kn7Ti13IC9hT3
         iASThXKUQoHHtYnQ8/tVUq0kk9E3qP1y9LEtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hNgVZnh6qbS7zA+dd7jFP9dgPd0U5is/6Nnud6t7Np83HHk2ZAZnmwxjNSmTvWOBUB
         akVvzERRQQF/RIhR3l2jPdxwAwC8iKB+ngwO///qdjK1DLpTHN4afJIGXFP2EM3wode6
         5cxqYtzs45pj0kCnOOI+e9swL17vMEdkDBX/s=
Received: by 10.101.192.24 with SMTP id u24mr18368719anp.181.1276111872662; 
	Wed, 09 Jun 2010 12:31:12 -0700 (PDT)
Received: by 10.100.229.5 with HTTP; Wed, 9 Jun 2010 12:31:09 -0700 (PDT)
In-Reply-To: <34152ED6-ACCC-467B-9076-1A742612AC75@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148807>

On Wed, Jun 9, 2010 at 20:25, Steven Michalske <smichalske@gmail.com> w=
rote:
>> On Wed, Jun 9, 2010 at 12:22, Steven Michalske <smichalske@gmail.com=
> wrote:
>>> is_git_directory() uses strcpy with pointer arithmitic, protect it =
from
>>> overflowing. =C2=A0Even though we currently protect higher up when =
we have the
>>> environment variable path passed in, we should protect the calls he=
re.
>>
>> Why? The function is static.
>>
> The code might be locally constrained.
>
> I always assume that a bit of code can be overwritten from other port=
ions of code.
>
> A small vulnerability is discovered that lets an attacker remove the =
length check
> or edit the pointer in the function call, but could not squeeze in th=
e full shell code
> snippet. =C2=A0But the now edited function here lets you put in arbit=
rarily long code.

Eh?

>>> - =C2=A0 =C2=A0 =C2=A0 strcpy(path, suspect);
>>> + =C2=A0 =C2=A0 =C2=A0 path[sizeof(path) - 1] =3D '\0';
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 strncpy(path, suspect, sizeof(path) - 1);
>>
>> And we have strlcpy for such things.
>
> It is not portable.

Git has its own copy of the function:

  $ git ls-files *strlcpy.c

  $
