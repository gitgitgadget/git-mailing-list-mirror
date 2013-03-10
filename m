From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2 3/6] match_basename: use strncmp instead of strcmp
Date: Sun, 10 Mar 2013 12:43:02 +0100
Message-ID: <CALWbr2wEJy0p2hcFK_rLtA98koeacE8rS2T=9P130GUFjWKc0Q@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
	<1362896070-17456-1-git-send-email-pclouds@gmail.com>
	<1362896070-17456-4-git-send-email-pclouds@gmail.com>
	<7vy5dvd7yq.fsf@alter.siamese.dyndns.org>
	<CACsJy8A_4SqLu5L6P0PJ78Lwy12fjL7T2p-KbVEVLJmKNqhyRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 12:43:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEef6-0000lT-3p
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 12:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab3CJLnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 07:43:05 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:32844 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab3CJLnE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 07:43:04 -0400
Received: by mail-qa0-f44.google.com with SMTP id bv4so532650qab.10
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=oFS7Tp1DBW7nCQa2hPEITZDaJoDcJJZl//LgPL1Q4qw=;
        b=HfQ4dpjFBTTuEqF0+HEPnBVdr5U26KLGjrWAtHiADq6Fsy8wzkuesmiPoZCr3kz567
         mWUzdOWjXgOumHlPD4QUT2ygHeEpSXwB768hePOGH6nfMh0eLOQS3QAEzbJQQUAVwhWu
         QAbCRzAUlWmeYIyI8tdd75sOOJaJmDmuBP9FrQk10v85+uj6EIkp9bmJe0ZDaLbWPDIp
         dEF12hBuutMbG+IcfDjq/FtACk+wxD4eWYp/6FdoHQjkCX1r+lhK+gZHfC8EmzkC7Kut
         4UB5U2UgR/obqPGp0HOvGQIEl+2w6Z9SpBRye2rye0QXdtqU/4E8Wrq2PpdY/LOqlyuN
         umQA==
X-Received: by 10.229.111.79 with SMTP id r15mr2746208qcp.133.1362915782668;
 Sun, 10 Mar 2013 04:43:02 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Sun, 10 Mar 2013 04:43:02 -0700 (PDT)
In-Reply-To: <CACsJy8A_4SqLu5L6P0PJ78Lwy12fjL7T2p-KbVEVLJmKNqhyRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217800>

On Sun, Mar 10, 2013 at 11:38 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> glibc's C strncmp version does 4-byte comparison at a time when n >=4,
> then fall back to 1-byte for the rest.

Looking at this
(http://fossies.org/dox/glibc-2.17/strncmp_8c_source.html), it's not
exactly true.

It would rather be while (n >= 4), manually unroll the loop.
