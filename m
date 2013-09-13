From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 14:33:01 +0200
Message-ID: <CAHGBnuN+HkZt48Pg2sHnYAhYW7EufWhO6rfgKpgaSOGeGA0Z4w@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<xmqqd2odq45y.fsf@gitster.dls.corp.google.com>
	<20130912183849.GI4326@google.com>
	<CAHGBnuPejvs_zTdV52GWVCF35+Bdih2c1zNuBdHJRd_2ShcnKQ@mail.gmail.com>
	<xmqqvc25ol9n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 14:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKSYe-0000RR-VY
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 14:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab3IMMdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 08:33:05 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:54371 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab3IMMdD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 08:33:03 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so930623lab.36
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dKmLurPA/gzDoM7nbmL2CTE1umQtul5b3eCaGZ0adEs=;
        b=S3VvamoOQnyQ3GEOZl4wU3j+s+4xAOojRgEN/74RtH2qyw5P3wFW1WkuSuQ00krm9J
         /kUZinDmMTAHETHWEXW4Qjnwy3/bmvHfy+7/GN/gE6O1JlA1y3Kjs5lsul9FNFxd188h
         pDGjeh1a4XZmw+TVpP3+wFBA/EWtkLsIv6Z2a1n5ZORyrpIjhM2ed3iSoEUHribJc8Sy
         cuLcDfMoKJWff95ITbVS6U/CvfLfBEDBbWuT6jWYcLfKPQYweNudI/vAw+Otm7qU1wmj
         Pknq8Z/mJl6WeQJnIMi2XjKfUHmw7GQS1eMIkdnUrLBlJuJpalv39w7j8t5DocBc89NQ
         oIZg==
X-Received: by 10.112.167.3 with SMTP id zk3mr11646211lbb.23.1379075581381;
 Fri, 13 Sep 2013 05:33:01 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Fri, 13 Sep 2013 05:33:01 -0700 (PDT)
In-Reply-To: <xmqqvc25ol9n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234750>

On Thu, Sep 12, 2013 at 10:08 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> I'm not too happy with the wording either. As I see it, even on MinGW
>> runtime version 4.0 it's not true that "string.h has _only_ inline
>> definition of strcasecmp"; there's also "#define strncasecmp
>> _strnicmp" which effectively provides a non-inline definition of
>> strncasecmp aka _strnicmp.
>
> I do not get this part.  Sure, string.h would have definitions of
> things other than strcasecmp, such as strncasecmp.  So what?

Sorry, I mixed up "strcasecmp" and "strncasecmp".

> Does it "effectively" provide a non-inline definition of strcasecmp?

Yes, if __NO_INLINE__ is defined string.h provides non-inline
definition of both "strcasecmp" and "strncasecmp" by defining them to
"_stricmp" and "_strnicmp" respectively.

> Perhaps the real issue is that the header file does not give an
> equivalent "those who want to take the address of strcasecmp will
> get the address of _stricmp instead" macro, e.g.
>
>         #define strcasecmp _stricmp
>
> or something?

Now it's you who puzzles me, because the header file *does* have
exactly the macro that you suggest.

Anyway, I think Peff's reply to my other mail summed it up nicely. I
will come up with another patch.

-- 
Sebastian Schuberth
