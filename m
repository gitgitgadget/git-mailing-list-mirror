From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] attr.c: simplify macroexpand_one()
Date: Sun, 15 May 2016 23:31:55 -0400
Message-ID: <CAPig+cST7phEvTodEDoYk2UpDOssKg9OVcpddT0sZPy-0aMqsg@mail.gmail.com>
References: <xmqqmvnr3p62.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 05:33:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b29HC-000123-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 05:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbcEPDb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 23:31:57 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33097 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbcEPDb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 23:31:56 -0400
Received: by mail-io0-f194.google.com with SMTP id x35so23543413ioi.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 20:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=LuP8065kXMosi4Mh64tUMpfTrGQKvG0MNXpgC0VvyDs=;
        b=hp4FTtfvyg7CUHV4Yue9bHEqEFFB5tkB34WgqXISI59iR78uvaXsWE+Rf/OfylXUEB
         IHyGbPZUjlf2eyzcSwmbHFyPXF3uMtMwzuLzQtl9gGaOsY2dgyQ+DHmYVdeVA6P6xzuL
         t4rb3vFwP6K1GvZ04/nCpn7dJeUASYi0wQr3c+E4LFsIqHtiVzyVjCU3jtByjss3jehL
         WEH6xOnIPLtuFVFQ+7faiMZ+OYMuu9+eVNJRFKovXrP7BD0QzNAeYa2j7Q2CF+KG1lIG
         JwITFX0nIpjw7DVjZTGPglERB4vL2U54N5xgn5hQ3OJE5oslMeAtqqOUpAumdbR+Vwa4
         zoug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LuP8065kXMosi4Mh64tUMpfTrGQKvG0MNXpgC0VvyDs=;
        b=LES2LTrnG+1KNR+S4dh0Ol3BbPHIZUQd3poi8enJUxZMr5uKRvAL71gbRt9BkOgAmq
         geZk1O86ePhV7Kf3t1H/UvmTWHMnGuiEGpeobNuQv5XK1aEi7Btu2kI+jR2Ebg6/7Pne
         Khj2Usw+UXDfoigTSbG3+cBH/Adtliw8lRCUL+5JRedh1uWPFRTz+8JIKJVFzZYidGdM
         VUujLiGvSTE0xzLG9KKwPDpCFStVUOmhc1ajT5OK6u41jFntRAXzvc7WtH5pD0mCAoVQ
         vFLRgDuw/6Aq81ENCanoFKCAdCRhB45MOcM/mVYgRW/iwuGYsJzUcgDHwucTd2NAXTUf
         Uj4g==
X-Gm-Message-State: AOPr4FU2ZyWQn995xRjRZ5zlPfozokW3DuENYXPRFWk51ZSbBZLsnU/1P2rGwwzSKi3WW7tw5IUHBIY7sde6xQ==
X-Received: by 10.36.55.144 with SMTP id r138mr7655650itr.73.1463369515537;
 Sun, 15 May 2016 20:31:55 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 20:31:55 -0700 (PDT)
In-Reply-To: <xmqqmvnr3p62.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: _R4OSW2K74T0Fy1ZvaNAR4h4iXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294719>

On Sun, May 15, 2016 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The double-loop wants to do an early return immediately when one
> matching macro is found.  Eliminate the extra variable 'a' used for
> that purpose and rewrite the "assign found itme to 'a' to make it

What's "itme"?

> non-NULL and force the loop(s) to terminate" with a direct return
> from there.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
