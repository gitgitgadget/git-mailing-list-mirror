From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 09:58:27 +0200
Message-ID: <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
References: <4A97193A.8090502@facebook.com>
	 <20090828060538.GA22416@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 09:58:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgwM7-0004rB-3F
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 09:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbZH1H62 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 03:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbZH1H62
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 03:58:28 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:48130 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbZH1H61 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 03:58:27 -0400
Received: by fxm17 with SMTP id 17so1415232fxm.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mBL+joyQMYeQiZS6Q6und6CRni6MN2QcNVLxv5oZGm4=;
        b=M/mX/FzGmD+XUewcOhjIvXh1xltNYJ4nkf2qtvxG9l7rZ4ongTC2QsOQd8QzWFVKCX
         ygZmA6fW2/OK17X9c+iDNRTcQu2vYhhu5i2IWfnIC7u/kv80OPrbabn644ZLv0DDQEnw
         vR+T5+ZWvdqc/YI3U1go/J/92LpzShOIOMJc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RUg3G+4rq19A6zro9HW7gjaalv4P2F6IJTUBPbhj1t4ebX6iMpgTXcyx+vCA+8CR13
         uN9iPK8ZGZbtQ5/nOvOzPRiTnVmdSlmUUCiwwJT9MXIrn4NzkZIY/OmUNgdBcZGEIMVl
         0f0+qk6OYcYrULgl+Nab46OEYNhY9crdjneEI=
Received: by 10.204.161.204 with SMTP id s12mr679103bkx.26.1251446308009; Fri, 
	28 Aug 2009 00:58:28 -0700 (PDT)
In-Reply-To: <20090828060538.GA22416@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127274>

On Fri, Aug 28, 2009 at 08:05, Jeff King<peff@peff.net> wrote:
> On Thu, Aug 27, 2009 at 04:39:38PM -0700, David Reiss wrote:
>
>> Previously, a commit from 1 year and 7 months ago would display as
>> "2 years, 7 months ago".
>
> Wow, embarrassing.
>
> Acked-by: Jeff King <peff@peff.net>
>
>> Here's my test script. =C2=A0Let me know if you'd rather have it as =
part
>> of the test suite.
>
> I couldn't find any tests related to relative date processing, so it
> would be really nice to have some. But I'm not sure of the best way t=
o
> do it without dealing with race conditions. Annoyingly, show_date cal=
ls
> gettimeofday at a pretty low level, so there isn't a way of
> instrumenting it short of LD_PRELOAD trickery (which is probably not
> very portable).

Maybe better prepare the _test_ so that it uses current time and time
arithmetics then put yet another cludge in operational code? Especially
when we already have a greate number of GIT_ environment variables,
documented nowhere, with effects not immediately obvious:

  $ git grep -n '"GIT_'| perl -ne '/"(GIT_\w+)/ && print "$1\n"' |
sort |uniq | wc -l
  49

  $ git grep -n '"GIT_'|grep ^Documentation
  $

GIT_FLUSH? GIT_SEND_EMAIL_NOTTY?! GIT_CHERRY_PICK_HELP?!!
