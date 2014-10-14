From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Initialise hash variable to prevent compiler warnings
Date: Tue, 14 Oct 2014 09:41:31 -0700
Message-ID: <CAPc5daXFuuxW=PSB_wKw3CcUGiM1sBPZXQ4UJoqHd1ZOPh7F8w@mail.gmail.com>
References: <1413211041-28732-1-git-send-email-felipe@paradoxo.org>
 <xmqq38ar3f1o.fsf@gitster.dls.corp.google.com> <CANxchRS1mGapb77hc9Ywqj_-8UeexSAWK4UK9y9M76pvoN-Yeg@mail.gmail.com>
 <CAPc5daWmHe-EbgO-wjy9UsodTFERa1vpz-SEDF-UM_eLm7CuCw@mail.gmail.com> <CANxchRQ=kR4N5s5S8eSJy2de__BydWDgowCNb6QQW6JZyvQAMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Franciosi <felipe@paradoxo.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 18:47:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe5G6-0007mm-0e
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 18:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbaJNQrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 12:47:33 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:39567 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbaJNQrd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 12:47:33 -0400
Received: by mail-la0-f45.google.com with SMTP id q1so8860492lam.4
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+vljhGP5jedbV6NIyvM9C5SCI5j28gxpP5cut5GYFso=;
        b=kiqtosgjIarCznQlDhSYMGLn0yzNFGnWnPCVT0fjuCdbZOSiJoRS6eslssLwf0581e
         NPChE5D59EBjq/nHmuDrYeS8rUGnjAUGSWAXBBi+vYXiCtDGZj0O7ExGwXfXzYiGKipl
         NFPWN4+VoPPANlHPkow3h4CgWNhDl02Ohdn2izXqu24BPY7qrHU1fcFkr2AFZyYOK0xR
         fk4Op5bxOJZeE+wTddlPtst0jS7/agW3ieoM+XZdBoDdmCnH7hBsyAr358ilwFTOB5E/
         QSpNUgvNuEfx55oDt+9G7AeWU+ZSMIb6XAxbTz7qFD1+8oMxprSg+OP4Fl5WvDoOVn8i
         kgcw==
X-Received: by 10.152.178.197 with SMTP id da5mr6549733lac.83.1413304911734;
 Tue, 14 Oct 2014 09:41:51 -0700 (PDT)
Received: by 10.112.209.35 with HTTP; Tue, 14 Oct 2014 09:41:31 -0700 (PDT)
In-Reply-To: <CANxchRQ=kR4N5s5S8eSJy2de__BydWDgowCNb6QQW6JZyvQAMw@mail.gmail.com>
X-Google-Sender-Auth: I9Zs1kgfF6Bg3iCwjdHo5-9hBPc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 14, 2014 at 4:44 AM, Felipe Franciosi <felipe@paradoxo.org> wrote:
> On Tue, Oct 14, 2014 at 2:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> If I really had to choose between the two, adding a useless initialization
>> would be the less harmful choice. Adding a meaningless "default:" robs
>> ...
> Being a bit defensive in that
> sense and initialising local variables is what I would do. On top of
> that (and putting the compiler flaw aside for a moment), having it
> sensibly initialised is another way of protecting the code against
> errors introduced in the future.

That is a false sense of safety. You will not know if the new method
introduced in the future would behave sensibly if the variable is left
in a state the blanket initialization created, so setting it to 0 upfront
is not really being defensive; you would rob compilers a chance
to notice something is amiss in the future code with the initialization,
just like a "default:" would. We need to accept that both are not about
being defensive but are ways to work around stupid compilers from
reporting false positives.

I am not saying that we should not do a work around. I am only
saying that it is wrong to try selling such a work around as a defensive
good practice, which is not.

> What do you think?

Again, if I really had to choose between the two, adding a useless
initialization would be the less harmful choice, as the other one has
an extra downside.
