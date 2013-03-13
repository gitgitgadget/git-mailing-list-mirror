From: Brandon Casey <drafnel@gmail.com>
Subject: Re: git-am and CRLF
Date: Wed, 13 Mar 2013 10:42:42 -0700
Message-ID: <CA+sFfMfJp1-REXVjipUhsVrUKDSmhrBkV0yd_=sMwwmiw2aypQ@mail.gmail.com>
References: <CABPQNSb9euNgCY9g617opThHC8OUpZQvJ+peor8Yk39LZ+y+TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 13 18:43:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFphm-0007TF-Je
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 18:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158Ab3CMRmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 13:42:44 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:37163 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933133Ab3CMRmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 13:42:44 -0400
Received: by mail-we0-f169.google.com with SMTP id t11so1299776wey.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=bU7gcKRphQcNdzzbaFIHKKJ/Sz8T3WLhVc6AF9Fzqjs=;
        b=dKs/6ixe71dv4rxBA4N4mGXTmBOQFQi+FgfNcETy/mqKJBGUVhgMN+7D0e2Cu2CTLX
         y9UDwrxkxkCPCgb0r1Vu6Re5MywiVFMPTSsIT4CmtVHXBuwIjyVVDcOMHuggP7PXxliA
         U4K42SqQ9Gj1e9ZX7rLlzB4Wpu+Fj8JmMC8SdW03HioXfV7UShQv9uqYKK9L6gyI36ox
         4VpWRS2RrykYTlTp4/hh0Iks7zjHYdZXvOrzXyDlbJ0fRktW3uiSqnXljnXHFZrQW6XN
         ckSb/cOhm1aa8YK70n7ZDslBR/GbB5P+jIH0SVyvGeO9pSG8kiiXOLDyTsQJigPVZ6O6
         KH3w==
X-Received: by 10.194.76.37 with SMTP id h5mr36278919wjw.21.1363196562908;
 Wed, 13 Mar 2013 10:42:42 -0700 (PDT)
Received: by 10.194.63.46 with HTTP; Wed, 13 Mar 2013 10:42:42 -0700 (PDT)
In-Reply-To: <CABPQNSb9euNgCY9g617opThHC8OUpZQvJ+peor8Yk39LZ+y+TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218074>

On Wed, Mar 13, 2013 at 9:54 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> I recently tried to apply a patch-series to a repo that is
> unfortunately full of CRLF files, and was a bit surprised that it
> didn't work at all.
>
> So I made a small repro-case, and it seems CRLF new-lines is indeed
> the problem. Any clue how to fix it? The way I see it, we should
> simply be able top treat the CR as any other character, and succeed.
> But that doesn't seem to happen...
>
> git init test &&
> (
>         cd test/ &&
>         git config core.autocrlf false &&
>         printf "%s\r\n%s\r\n" "foo" "bar" > test.txt &&
>         git add test.txt &&
>         git commit -m. &&
>         printf "%s\r\n%s\r\n%s\r\n" "foo" "baz" "bar" > test.txt &&
>         git commit -am. &&
>         git format-patch -1 &&
>         git reset --hard HEAD^ &&
>         git am 0001-.patch
> )

Does 'git am --keep-cr' help?

Unfortunately the original information about line ending is lost once
a patch is sent via email since RFC2822/822 dictates that the line
ending in an email must be crlf.  So by default, mailsplit strips it.

-Brandon
