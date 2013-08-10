From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Sat, 10 Aug 2013 02:07:45 -0500
Message-ID: <CAMP44s1NE-ac_tWej9EhMWJLRm7aq1WKOm17fZm5y_aA4ppq5g@mail.gmail.com>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
	<CAMP44s13y39f-eCP1sBuMEedciU230C1O11+iMb1SHi45RnSNQ@mail.gmail.com>
	<7v7gfu4ikb.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Ky2AkEt-XS_nAo=_RrPXSVAL=8cGiMuJabw0=BRU0Dw@mail.gmail.com>
	<7vmwoq304o.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Q2x9uz5Ajr=BgVjSjO88XD5UYzVSEqgMeK5_YAYSa5A@mail.gmail.com>
	<7vioze2kev.fsf@alter.siamese.dyndns.org>
	<CAMP44s3ULMBg6BJr6m4zkqHyD70rHSwLcuG5ph+ABr6KME8T=w@mail.gmail.com>
	<7v38qi2g63.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 09:07:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V83HD-0007Kc-9k
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 09:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484Ab3HJHHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 03:07:47 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:46885 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856Ab3HJHHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 03:07:47 -0400
Received: by mail-we0-f179.google.com with SMTP id t57so4215907wes.10
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NqoXvyG8IRUz360kaOzVtYKky13E6ur2Q+oB2suGM84=;
        b=W5Fm6SyoPSOPtWJwVrwiJA14JjBwgnCBrvsjMEU/B8oVVzlzzTsu9UCRbe8DRRw/a6
         zkkHmH55sQSZGd9Ne5wVr80DX/493km+61SI/4RStvK5lGxPxY5fGicGtBflL1BnE1JH
         hYS2RCjrke9CCiJhvNz7ZE00TnkH7QXm2L7irrPQVH6hgVL6qbzuH7YyzV4Fn7ZgT36p
         6wWNaOkDy9EpCkkpbHYBjkZOWs2btcyxKD+6WFTjtoSRgSOfN9GH0n8fnd6FYeEkfBcn
         rwulmy08Fn16nGBAUEv6OOH0sSroFI9n5ILch7Hwosh6hsf/NkYKcEl8h2JHqV8zUSsP
         PDdg==
X-Received: by 10.180.182.229 with SMTP id eh5mr2172631wic.63.1376118465946;
 Sat, 10 Aug 2013 00:07:45 -0700 (PDT)
Received: by 10.194.39.234 with HTTP; Sat, 10 Aug 2013 00:07:45 -0700 (PDT)
In-Reply-To: <7v38qi2g63.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232073>

On Sat, Aug 10, 2013 at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> If I clone ~/git, and then change my username, and move my home
>> directory, doing a 'git fetch' in ~/git wouldn't work anymore, because
>> we have expanded the path and fixed it to my old home, if instead we
>> simply return without fixing, it would still work just fine.
>
> Antoine's patch runs expanduser() only to see if the given one gets
> modified to absolute path, and makes fix_path() return without
> calling the extra 'git config', so it is my understanding that the
> above describes exactly what the patch does.  Am I reading the patch
> incorrectly?

Antoine's *second* patch, which I missed, does that, yeah. That should
work fine.

-- 
Felipe Contreras
