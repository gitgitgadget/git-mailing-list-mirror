From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 1/5] Allow explicit ANSI codes for colors
Date: Sat, 27 Feb 2010 13:24:53 -0500
Message-ID: <ca433831002271024t5af1dba9m6ca719c114e54892@mail.gmail.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com> 
	<1267246670-19118-2-git-send-email-lodatom@gmail.com> <20100227085144.GD27191@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 19:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlRM5-0002XN-Ha
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 19:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441Ab0B0SZP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 13:25:15 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:42734 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030293Ab0B0SZO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2010 13:25:14 -0500
Received: by yxe12 with SMTP id 12so550726yxe.33
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 10:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GNUc8KaeLT4/FPKCK0hqyqprOhI/aqCgoSTSPFZdv0c=;
        b=P1Ywcpqzepbz4Fj25C4KZqyXgv6EX0C6V+SLjLwM3gUBbb2loFXNaTfw8qJf9T5oXo
         JF2a8kOcXCjk6pvzmlAAa3Tat0P6/3NQWKIHqXRvzkoEP3Tg9XXAuhp6m7Y/CXOssX6l
         F+fn2EBnPCexRlz/8UuxSOvkyjQt5XFHt8QyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dDZymo4qO3DSHZzagDJdOW89ugnrpl/KONIMLtXStcexApUKCc5DN7PJVKHsLTxg+v
         +ABd3GYrq4c5qCNVp9Pi8LumFZjnJbP/3yO+F7AQ2rwEJyRsrsYJa3VWJUNBLQOzqFzI
         drr8sv6Ms54vOWKvflpSJddEokSbZTwHKQbhs=
Received: by 10.90.13.27 with SMTP id 27mr1859309agm.28.1267295113237; Sat, 27 
	Feb 2010 10:25:13 -0800 (PST)
In-Reply-To: <20100227085144.GD27191@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141220>

On Sat, Feb 27, 2010 at 3:51 AM, Jeff King <peff@peff.net> wrote:
> I am not against this patch if it gets us some flexibility that is no=
t
> otherwise easy to attain,

Besides disallowing multiple attributes (e.g. bold blink), the current
parser does not have a way to specify colors for 16-color mode colors
8-15, 256-color mode colors 0-7, or any 88-color mode colors.  There
are also other esoteric attributes [1] that some user might want to
use, such as italic or franktur.  I don't know if anyone will ever use
this feature, but it wasn't hard to implement.

> but wouldn't it be more user friendly for us
> to support "red blink bold ul italic"?

Yes, I think this should be done whether or not the patch in question
is accepted.

> AFAICT, the only things standing
> the way of that are:
>
> =C2=A0- we don't support the italic attribute yet (are there are a lo=
t of
> =C2=A0 =C2=A0others that we are missing?)

Wikipedia [1] lists a whole bunch of codes, including italic, but I
doubt anyone uses them.  My thought was if someone really wanted to
use one of these obscure codes, they could do it with the patch in
question.  I don't think it's worth allowing users to type "italic".

> =C2=A0- the parser in color_parse_mem already understands how to pars=
e
> =C2=A0 =C2=A0multiple attributes, but it just complains after the fir=
st one

It seems like this restriction should be lifted.  However, if this is
done, then COLOR_MAXLEN should be increased to 32 or so, and there
must be explicit checks to make sure the buffer does not overflow.
Technically, VT500 terminals accept up to 16 parameters up to 5 digits
each [2], which would be 98 bytes, but this is overkill.

[1] http://en.wikipedia.org/wiki/ANSI_escape_code
[2] http://vt100.net/emu/dec_ansi_parser#ACPAR
