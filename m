From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 21:34:05 +0200
Message-ID: <CAHGBnuNu7G+6T8jySwNfkjrUaQZzwxf5ginq+x0S1erY6L_ZoQ@mail.gmail.com>
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
	<CAHGBnuN+HkZt48Pg2sHnYAhYW7EufWhO6rfgKpgaSOGeGA0Z4w@mail.gmail.com>
	<xmqqtxhokdao.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 21:34:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKZ88-0003Fj-TQ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 21:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab3IMTeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 15:34:08 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:48729 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852Ab3IMTeG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 15:34:06 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so1373772lab.35
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D/2/Xzx6HMzQ/06F7SwGuNMY8IBCBn6fL5RhfYmb4OU=;
        b=u0SJv57RYG7Z29kRB/zDCB9j6HcVW2HDjT9bHhooyKvQ+5dxDubi5h2I/Tmbf8TmDe
         8XR4/NaLL6LUrIGEHxVChDb0orTboUf98Tod2Lii34KEPdLg2ZKEkeIvvE9nssZt8GnA
         EdxGq7vm8s9jBnr3pjN5q55uwnGUjycZaV8ab/x5JretUTL+892/Rmgz2qZz20tu6Ap4
         WgW6q8IHJUCUy0tjWteUPzw2li70LCWTJ1/aCZXhiuHZsZo5SBiJFAGW+VD78diufWKR
         LImfxelkcDTfiacY3d0R7i0pkp21pxO9OVEEr7IDazrffnl8I7wl6cxzyqNNbw1XprdY
         agJA==
X-Received: by 10.112.89.100 with SMTP id bn4mr13101773lbb.16.1379100845529;
 Fri, 13 Sep 2013 12:34:05 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Fri, 13 Sep 2013 12:34:05 -0700 (PDT)
In-Reply-To: <xmqqtxhokdao.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234763>

On Fri, Sep 13, 2013 at 4:26 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>> Perhaps the real issue is that the header file does not give an
>>> equivalent "those who want to take the address of strcasecmp will
>>> get the address of _stricmp instead" macro, e.g.
>>>
>>>         #define strcasecmp _stricmp
>>>
>>> or something?
>>
>> Now it's you who puzzles me, because the header file *does* have
>> exactly the macro that you suggest.
>
> Then why does your platform have problem with the code that takes
> the address of strcasecmp and stores it in the variable?  It is not
> me, but your platform that is puzzling us.
>
> There is something else going on, like you do not have that #define
> "enabled" under some condition, or something silly like that.

Exactly. That define is only enabled if __NO_INLINE__ is defined.
Which is what my patch is all about: Define __NO_INLINE__ so that we
get "#define strcasecmp _stricmp".

-- 
Sebastian Schuberth
