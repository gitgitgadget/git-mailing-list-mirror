From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Add date formatting and parsing functions relative to 
	a given time
Date: Sun, 30 Aug 2009 09:51:25 +0200
Message-ID: <81b0412b0908300051g19bc2c5buecf5d925bd0d40b6@mail.gmail.com>
References: <20090828210404.GA11867@blimp.localdomain>
	 <20090830073619.GA14217@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 09:51:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhfCa-0007YK-7o
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 09:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbZH3HvZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 03:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbZH3HvY
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 03:51:24 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51247 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZH3HvY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2009 03:51:24 -0400
Received: by bwz19 with SMTP id 19so2269752bwz.37
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ykBQY59YUhUMj8/D/owuH6jIx+Np7DVUteK4XwJwDpk=;
        b=YFGsDBBUdSaDH+mK3PZuqHvNswVJzbIf9cwh7fx9mbuY9ysMyusqIN8pL4XdjMBjIt
         62X4MlplEiMhiK3qn6vj8hcqmdLYoZy3Vg6WAg/jkuOuN9NFy1RJMcr38TDmbHxVaTr/
         zxvpJJ7/+xwc7FAGq1RIWdB21eijyjTqJRuPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WCkUTx40PTw3wjReR+iSSbf3zkNH8M0m+Tg4hYGUt9BcUjEWcYeux5pOVw8lwl76ix
         z/ud4CTW8Y2UkPd3CxTTQ9DdKx8sWyzXXBq1mVipJh/Q44g6LBf9aBw5dYuCTKSgiolH
         alOQjioRzQ0tbuP6ahglj2o0kcGJ9VfDIxC+Q=
Received: by 10.204.16.88 with SMTP id n24mr2929513bka.52.1251618685406; Sun, 
	30 Aug 2009 00:51:25 -0700 (PDT)
In-Reply-To: <20090830073619.GA14217@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127397>

On Sun, Aug 30, 2009 at 09:36, Jeff King<peff@peff.net> wrote:
> On Fri, Aug 28, 2009 at 11:04:04PM +0200, Alex Riesen wrote:
>
>> +const char *show_date_relative(unsigned long time, int tz, const st=
ruct timeval *now)
>> +{
>> + =C2=A0 =C2=A0 static char timebuf[100 /* TODO: can be optimized */=
];
>
> This was 200 in the original version. I doubt that it makes a
> difference, but I think in a refactoring patch I think it is best to
> simply reorganize and make no other changes.

Yes, I just noticed that 200 was much too much, made the note
to fix it sometime and forgot the note in the final submission.

>> +static unsigned long approximation(const char *date, const struct t=
imeval *tv)
>
> I know it's static, but this is a terribly undescriptive function nam=
e.
> Approximation of what? =C2=A0Can we call it approxidate_internal or
> something?

Been there, tried that. Didn't like it, because it didn't feel enough
approxidate (the original) anymore. Not even internally, because
of missing parse_date. My other attempts were guessdate and
approxidate_bottom_half (but only very shortly).

The "approximation", if you consider the functions arguments,
seems to me the closest to what the function _is_. OTOH,
maybe I should have used a verb...
