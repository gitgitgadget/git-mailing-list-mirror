From: Stefan Beller <sbeller@google.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Fri, 4 Dec 2015 13:36:47 -0800
Message-ID: <CAGZ79kZwZuKEuYqRBFBRCu_bY6PmTnC+3e=Znpf24rxZB6hEbA@mail.gmail.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
	<CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
	<20151204212712.GA22493@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jason Paller-Rzepka <jasonpr@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:36:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4y28-00056o-B4
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496AbbLDVgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:36:49 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35894 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906AbbLDVgs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:36:48 -0500
Received: by ykdr82 with SMTP id r82so139311315ykd.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 13:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HJD2heVF9DHMcPRC/7HN//wh2pepu1dTkv4mk6xBQ1Y=;
        b=K9OkzHoKg1N2gy6QD4S/J/belD71aEG0G7DquhKlh/Mt1YgdLrwedUjtM8JzUn41wx
         snDjBakrnT6FjBdHvXQv/G7TALTa9DA4DE63Rlwybx9aKeWr1WMVfngIbnCcdvGjOP6m
         kBKW4DmS6Hf+Ib36HF8aEfPWcKa9Gt5hr18NbGBJk5g91RF5/2fJztuvV2NBiUji7Vye
         ihsYPSZrOSp+yhIRmqPwMNBmqpbvymCHtO/MMelhya2iAstU7JDQfqO2gjyO7MJ3lp2I
         d4c+kl/0xPF+dPThFmWTUl6bSzSCqNWaPUgMBGRkBb+5t/AbnWDH10koTKQI3eEoauib
         TcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HJD2heVF9DHMcPRC/7HN//wh2pepu1dTkv4mk6xBQ1Y=;
        b=C5qule5ErAm4IaER7BSJzHAbTDPdOSdibLuDtL418zFM74WZ+UU6NKrFkSPou8OJhG
         zV5vx2UuJqQv1dRRvMTb3bt2zwJA2EXi4QvUI12KpwWzOv0pFnCHo3k7XFOpDF+MVvFI
         ocWvBuLjaQ/TXXfQd1UZ0gtI5DkFtYfyhI+Uj923glfFlAUkjeujvjN+IQk5xyM7wqtq
         ow6VN7msBMizYGuGcKKaVnpva/8gfsQZXfMcISeUHg7+kwCgE0bxmOH04DeDR6YgV0qZ
         lxdGLu6i6j+3PVnBaizqxZG3s4igfoFWAKUYp/JRuRvqA0b2UmHRXbsC56bistErpUXK
         +WFg==
X-Gm-Message-State: ALoCoQlgYi7IfmjxL6X4xfSDcXWowU+pWxQmjL2dk6rJnVqDIffUw2j5/zkh5SDBJ7eVl8ohqhUG
X-Received: by 10.129.104.137 with SMTP id d131mr12913111ywc.199.1449265007506;
 Fri, 04 Dec 2015 13:36:47 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Fri, 4 Dec 2015 13:36:47 -0800 (PST)
In-Reply-To: <20151204212712.GA22493@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282006>

On Fri, Dec 4, 2015 at 1:27 PM, Jeff King <peff@peff.net> wrote:
>>
>> and could not see a second fetch, but only a
>> fetch-pack with --depth=2147483647
>
> This seems to reproduce consistently for me:
>
>   $ git clone --depth=1 git://github.com/git/git

I used the http protocol, so I guess that's the difference.
