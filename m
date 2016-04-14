From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Thu, 14 Apr 2016 17:43:23 +0700
Message-ID: <CACsJy8B6o-8YJYemcYX3NwyMaY9jV666ZwKJYwfbwMSmzM-YGw@mail.gmail.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
 <1459980722-4836-4-git-send-email-dturner@twopensource.com>
 <CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
 <1460153784.5540.19.camel@twopensource.com> <1460417232.5540.53.camel@twopensource.com>
 <CACsJy8C2FtdetQ_NJSKR_JCZ5Ju0E3rV7Du=J4f2_kn5qrcHxg@mail.gmail.com>
 <1460482108.5540.59.camel@twopensource.com> <xmqqfuuqr9ca.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w6Z2YXIgw77Ds3I=?= <aevarb@gmail.com>,
	jeffhost@microsoft.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 12:44:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqekn-0001jb-Cl
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 12:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbcDNKoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 06:44:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33525 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbcDNKoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 06:44:00 -0400
Received: by mail-lf0-f67.google.com with SMTP id p64so11594423lfg.0
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2blVRnGWgNmE08IAuVtwxJIaeMZxDBFvpn6MPRLV06k=;
        b=A5WWGWsubAKMaFNjnndm3B6zn8oVdyZ0YW5uYMvuMUbq0j1TdTQDg6jzMFQlqkMROH
         LYlZQko/NuLv+p2r2RVmJAR+FrR7sCRJBXYJ42bMBM30rTdvath7WEBt+Ix+7MZY/qcE
         dVDKxMm5yBAkRE4rbsXn97m4/rCmsXXmYI7k05DVH9JtaVQhRODlzlPRFulbZYXVXkR/
         p45FxSvnGnaUyQqi3ZKFEz3rVGxerrifJU6cvJ4kjRpyNnQ/wzKdf8PrkkPYGBCcebMS
         WTqjnSD8OnOkBncRtxQ3hLtCB2gucSkiLqPJFGgoFiYE6fM3Bjlo9RHGdDBLAQbl+39M
         PurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2blVRnGWgNmE08IAuVtwxJIaeMZxDBFvpn6MPRLV06k=;
        b=WLp5Ox7+nQu6eH1wHVQ5fkXN+9dEc6e722he14G7NUxfzZneUmBGlAABrDdwTu6U0a
         8R0gPOoh3VpLaGoLglk/PwRpe8woUJq5HPtsMGN44eECknQvxf4MU+FMPu9V4f9Ovw/l
         vJ04vaJXRDHslgnggUT3Ah3HGgmryxrc+hd35kjA1fxmYk5cP2ovh9FYZV6vCJaA0P3r
         +8EjVCi+luDKoRg2G+Wukfbfo+Bo1rwTqfd3Omk6SRLAjK9+cR3uAafJaHofIQJckchD
         G4zMEno4r6uehVHGE6Rw9/e+2V1MRbTJm12kWyGRNQiawQP+w3atcWZwanROcVigFme4
         E4Cg==
X-Gm-Message-State: AOPr4FXcbMAmROPSZ2YkQDwIYfDtfnp9cAa9BF5J8onnQSs12n740tcoUM45uemun7wfVnTGPbdP+wYgZWzDdA==
X-Received: by 10.25.147.202 with SMTP id v193mr6441904lfd.162.1460630633164;
 Thu, 14 Apr 2016 03:43:53 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 14 Apr 2016 03:43:23 -0700 (PDT)
In-Reply-To: <xmqqfuuqr9ca.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291521>

On Wed, Apr 13, 2016 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>  - access is slow (unless cached, but we can't be sure)
>>
>> We could solve this (and the other problem) with mlock.
>
> Probably you meant madvise(2)?
>
> For something of a size comparable to the index file held by
> index-helper-daemon in-core, I'd expect we wouldn't page too
> badly.

I had a look at linux implementation of madvise(MADV_WILLNEED). All it
does is force populating the entire memory region, which is good. But
I suspect when memory is under pressure, some pages may be reclaimed.
index files in monster repo case can go up to a few hundred megabytes,
chances of being reclaimed rise accordingly. But we can reconsider
mlock() later when/if real problems happen.
-- 
Duy
