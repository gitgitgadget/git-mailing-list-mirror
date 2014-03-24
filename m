From: Scott Sandler <scott.m.sandler@gmail.com>
Subject: Re: Git push race condition?
Date: Mon, 24 Mar 2014 17:29:21 -0400
Message-ID: <CAAyEjTM8SSoJQ7+hb_nGEsbb6MC+z7=Y8SP9YQ8-i=_tRxLyuA@mail.gmail.com>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	<CACBZZX4ZEPA3sBp4-3QF6de0EWXzPkcOiqSxH3_CXV27Z=gxtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:29:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCQy-0000Sm-Im
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbaCXV3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 17:29:24 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:64809 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaCXV3X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 17:29:23 -0400
Received: by mail-lb0-f175.google.com with SMTP id w7so4115457lbi.34
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eBY/gbeLGAQO8p/fV0rMGX4Gk9WTu/HXGiqMeZ83T0E=;
        b=NjtowpWCn9NpQoZ2MLXgSNIDhLOrzyhxPNcJuH3mjsDm7gF1wZUy631QIks1irYGFe
         znyRFXs7EH0AlsmPsmG+qo2ZibbC6w17po9lFU0x+zgP3PEu6Iht5ncLr6zKkGylrFD9
         wE0KxvdD8JweLxpADORUCHSSlVVaR5LEhF4H1SqDDsM2z6BxKrMafHg142Ik/gOOJadr
         DwIBFN7a8sk1W/mkURTCxXENfPJ3aXb+JmgGFOrtdXJLBDYIMwktI6lNilFE/ppgWOL1
         fO2CoTodw99Qtyozt/DpRSvAQjmvuoLfqfZzZyXhTX5MRZ63LUy9BfeMXHMNG7r26oaw
         FMFQ==
X-Received: by 10.152.37.137 with SMTP id y9mr46553449laj.8.1395696561663;
 Mon, 24 Mar 2014 14:29:21 -0700 (PDT)
Received: by 10.114.64.103 with HTTP; Mon, 24 Mar 2014 14:29:21 -0700 (PDT)
In-Reply-To: <CACBZZX4ZEPA3sBp4-3QF6de0EWXzPkcOiqSxH3_CXV27Z=gxtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244875>

Right. Receiving that error is what happens during my testing with a
hook that sleeps for 60s, and that outcome makes sense. But whatever
is occurring in production must be different, since both users see
successful pushes with the first one just being overwritten.

On Mon, Mar 24, 2014 at 5:16 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Mar 24, 2014 at 8:18 PM, Scott Sandler
> <scott.m.sandler@gmail.com> wrote:
>> I run a private Git repository (using Gitlab) with about 200 users
>> doing about 100 pushes per day.
>
> Ditto but about 2x those numbers.
>
>> error: Ref refs/heads/master is at
>> 4584c1f34e07cea2df6abc8e0d407fe016017130 but expected
>> 61b79b6d35b066d054fb3deab550f1c51598cf5f
>> remote: error: failed to lock refs/heads/master
>
> I also see this error once in a while. I read the code a while back
> and it's basically because there's two levels of locks that
> receive-pack tries to get, and it's possible for two pushers to get
> the first lock due to a race condition.
>
> I've never seen data loss due to this though, because the inner lock =
is atomic.
