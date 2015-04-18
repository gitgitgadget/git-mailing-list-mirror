From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 1/7] path.c: implement xdg_config_home()
Date: Sat, 18 Apr 2015 16:48:35 +0800
Message-ID: <CACRoPnRMHDO3VC1-S2rpx7jgcv=c_ym6wRSx2xxNRk=k_vtXvA@mail.gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
	<e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
	<20150414172854.GA27623@yoshi.chippynet.com>
	<CAPig+cTrErOBwPteeA1d_gdve5SiyLnbyFPpQ1sTN7aajGJfeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 10:49:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjOQz-0004nr-NV
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 10:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbDRIsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 04:48:41 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35964 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbbDRIsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 04:48:37 -0400
Received: by lbbqq2 with SMTP id qq2so98722665lbb.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aAKx15pXN1aIYmNWEFoR0aeaDk6BcTcrJuShYDUrRxI=;
        b=kl7vUPF1JjF4c/bzGyqkplf9LJ1QZ8tfrorihdkHHOq3XKZmFhMl5snFltN7xayend
         L/1cnt1CHD2P/cuAfNmi1tCpwcrEkBkRgdU8HZje8y0fRVdkXeIidW7PHXGwXudD1hy1
         jSCz1q7Kb/CymeBQ6xLPFlObU8RBbevJpCTrJvlqSiuH7okDOh3wytdBiLq2TCH1VApV
         rRvU6nzdn5IKWSSM2GU2yXl2QoqrAtHNrlrVTEKHDIFw9zs4+Q5Y2gqdR2ZuyqtFPI4/
         nHcq9pR2T/v6TThYbOBSxJkp7MH/MQBkN8d20EFB9nRowyxL9N02evP9FTTS7Nw2MxV+
         FkEw==
X-Received: by 10.152.120.70 with SMTP id la6mr7667230lab.65.1429346915766;
 Sat, 18 Apr 2015 01:48:35 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sat, 18 Apr 2015 01:48:35 -0700 (PDT)
In-Reply-To: <CAPig+cTrErOBwPteeA1d_gdve5SiyLnbyFPpQ1sTN7aajGJfeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267411>

Hi,

On Fri, Apr 17, 2015 at 5:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Apr 14, 2015 at 1:28 PM, Paul Tan <pyokagan@gmail.com> wrote:
>> Below is the fixed patch. I also decided to return NULL if `filename` is
>> NULL because such an input usually indicated an uncaught error.
>
> Unfortunately, this blurs the line between programmer error (passing
> NULL for filename) and a user/configuration error (XDG_CONFIG_HOME and
> HOME being undefined). If there is indeed no valid interpretation for
> filename==NULL, then it may be better to die() or assert() here to
> flag the programmer error as early as possible, rather than returning
> NULL.

I'm inclined to agree, but off the top of my head an API user may wish to do:

    xdg_config_home(function_which_returns_NULL_on_error())

And wish for the error to propagate, but that may be considered sloppy
programming and so it's better to treat a NULL input as a bug.

Will fix this by calling assert(). Thanks.

Regards,
Paul
