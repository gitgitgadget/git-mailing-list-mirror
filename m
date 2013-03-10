From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2 3/6] match_basename: use strncmp instead of strcmp
Date: Sun, 10 Mar 2013 12:54:18 +0100
Message-ID: <CALWbr2x6V6TB9g_nQCgG2r9L__a2wxG28Qi5KTXChHxj5JSQ8w@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
	<1362896070-17456-1-git-send-email-pclouds@gmail.com>
	<1362896070-17456-4-git-send-email-pclouds@gmail.com>
	<7vy5dvd7yq.fsf@alter.siamese.dyndns.org>
	<CACsJy8A_4SqLu5L6P0PJ78Lwy12fjL7T2p-KbVEVLJmKNqhyRw@mail.gmail.com>
	<CALWbr2wEJy0p2hcFK_rLtA98koeacE8rS2T=9P130GUFjWKc0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 12:54:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEepz-0000WU-02
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 12:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056Ab3CJLyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 07:54:20 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:38792 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3CJLyT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 07:54:19 -0400
Received: by mail-qc0-f175.google.com with SMTP id j3so1124093qcs.6
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=OGZcFMn6KeIhFgt/6FX7QmINETXMFtZcNS792KHdQ20=;
        b=h54nphnccIAyzWgq7U6XPesIGExPSUi9IRblYV/M3zzeyHwQPNg7hLx//dq5DPr/nQ
         WboIcSCuHQeWcPdNmNnDaJ5yGu3dzck46HRWSH19WwsQHndu1Tq4k7I2TmI1gv7GO6lf
         SpFUDSQ+ISSb+CgWvhHTaKVv8M06i8bw/Xxsh42GG1JZhXVpN40FjYLhlB9MQBLzw2z/
         0vr5IcR00+L0r1jAxEYByZ4xJZlWTSLVVu5LftAdsXQYYMHgO8gdnQqOL9aIrciHVnLY
         Dig62SHUI0w8WXOZMYqsJZFuOkBxcK64dyaHfEryXAzy91QWql6ylduQDGpSta8iAQxI
         oL7g==
X-Received: by 10.49.127.116 with SMTP id nf20mr14109241qeb.2.1362916458614;
 Sun, 10 Mar 2013 04:54:18 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Sun, 10 Mar 2013 04:54:18 -0700 (PDT)
In-Reply-To: <CALWbr2wEJy0p2hcFK_rLtA98koeacE8rS2T=9P130GUFjWKc0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217802>

On Sun, Mar 10, 2013 at 12:43 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Sun, Mar 10, 2013 at 11:38 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> glibc's C strncmp version does 4-byte comparison at a time when n >=4,
>> then fall back to 1-byte for the rest.
>
> Looking at this
> (http://fossies.org/dox/glibc-2.17/strncmp_8c_source.html), it's not
> exactly true.
>
> It would rather be while (n >= 4), manually unroll the loop.

By the way, if we know the length of the string, we could use memcmp.
This one is allowed to compare 4-bytes at a time (he doesn't care
about end of string). This is true because the value of the length
parameter is no longer "at most".
