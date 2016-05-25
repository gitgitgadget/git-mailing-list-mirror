From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v8 2/3] bisect: rewrite `check_term_format` shell function
 in C
Date: Wed, 25 May 2016 10:43:43 +0530
Message-ID: <CAFZEwPPf6sRnJDyW9hLjEYa-=6Bjw_rWss9T5D_n_aXUX=TcGA@mail.gmail.com>
References: <20160524072124.2945-1-pranit.bauva@gmail.com>
	<20160524072124.2945-3-pranit.bauva@gmail.com>
	<alpine.DEB.2.20.1605250657250.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 25 07:13:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5R8d-0004SM-Fm
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 07:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbcEYFNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 01:13:45 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34480 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbcEYFNo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 01:13:44 -0400
Received: by mail-yw0-f194.google.com with SMTP id j74so5226455ywg.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 22:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=n9+BVx3u7x9NrMlE20d/ch3d6KTBsU2vqMwUKTFZwlg=;
        b=thOgOeVcGgKZ6MAynNH88uzTCV5oxo3rw5Hg0JMspAQZlRUC+P4MHXi0xUIFUbRR5B
         pLhjcPPZ6ANI+gx9wMmfJLrhIhu4SaqUgZ+85UzxJ6y5rCsSxf2E0OgKRmMjQy+s65Qk
         YGLGzQr++QzFUh2cUHvgosk8Qm0ho5h4GHmf0+3JPcrSZTM0KELE/EnNbEOtlIF95f0Q
         I0bUQlv6V7y7RZxvjk0jVXV1PJiZf+q2N22xEFLsfTqcYMD9N00uKFYerjW77ImqlW6b
         wpw499GKlpwS0lunIt4PCqZQjt1txcpWHv5ckSrDdKzkndZM6JeoGw+001OCzY9b0j8X
         W4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=n9+BVx3u7x9NrMlE20d/ch3d6KTBsU2vqMwUKTFZwlg=;
        b=iNtioY5vc+JubU4hBzntRtU2FSSdAYiKzSj8lAPj2WvIvk7VJchyndfDCY10tboKHz
         tkk3IsdUOI7jmUEC+ChOGVdjbD68qhZbEI0NLNst3SwNsKBxJz2GAQv4QgI6eAZbYLsa
         UC7xWCtaRfvdnyoeYPiZBPlEWQhHTZtXmgAKM/ODW7qkwyKL32bUsPkELPm8Bp4U83wK
         PPvH2wgnbX98sRUxbYBvx5+aA/6TVoL/otjeDOG2E/qNoUS+c24yPTXjK6viGtEeQ3OF
         aI36bfwAmOwxkyQXb5AICnfUBZBfE6i6k3UDLrMteuEKMTUUcVTfjDWr1DV41BbmFlsu
         +sHw==
X-Gm-Message-State: ALyK8tIfvcSSq57yEdRxq9by2CoyxkIGmbEq5+fOvBkFq+8CPfCGB0XooYntQt3aQs586DcAdepshr2kw2d4LA==
X-Received: by 10.129.164.145 with SMTP id b139mr1241943ywh.171.1464153223234;
 Tue, 24 May 2016 22:13:43 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Tue, 24 May 2016 22:13:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605250657250.4449@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295559>

Hey Johannes,

On Wed, May 25, 2016 at 10:34 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Pranit,
>
> I think this patch series is now in a fine shape. Just one minor nit:

Thanks!

> On Tue, 24 May 2016, Pranit Bauva wrote:
>
>> +             OPT_CMDMODE(0, "check-term-format", &cmdmode,
>> +                      N_("check format of the term"), CHECK_TERM_FMT),
>
> Just like with cmd_mode and CMD_MODE, it would be more consistent to use
> CHECK_TERM_FORMAT (instead of abbreviating it) when the option is already
> spelled --check-term-format and the function name is check_term_format.
>
> It not only causes the eyes to stumble less, being consistent in naming
> causes less typos and also makes it easier to dig into the source code
> (think: `git grep -i check.name.format`).
>
> Not a big thing, but if you re-roll for any other reason, it would be good
> to make the naming consistent, too.

Sure I would include this in a re-roll. Anywhich ways it will really
not make a big difference because after some time, "git grep -i
check.term.format" wouldn't return anything except for the method
name. Other occurrences would be vanished.

Regards,
Pranit Bauva

> Ciao,
> Johannes
