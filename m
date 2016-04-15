From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC 0/6] fetch with refspec
Date: Fri, 15 Apr 2016 12:30:13 -0700
Message-ID: <CAGZ79kYwO0TVetGjqGgQQgJjtnATGdae3JsgZ2Pn89ExDSd_Qw@mail.gmail.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 21:30:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9Re-0004TI-SN
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbcDOTaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:30:16 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36965 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbcDOTaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:30:14 -0400
Received: by mail-ig0-f176.google.com with SMTP id g8so31962874igr.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=EEkeQV2lS6HKy4DDvPeg9YGE3jqgylO8++1fEXanpig=;
        b=hyGIHZRIX8kouUHPRGexX6H1gPzMtkz5ojJTbcfuQx0j8KD8NShhgjGXoXdDaTxO5G
         eBSUD1ouMlFnEbWn9OoffGOwoZh35rD8tCREeoz6hcJ1yuEvSHoPaNVZCKkRx2Q78bQB
         8cxj3TmEF7OPkLzPc3ntaB2nuq3c2HT+s6JAvDen0eplNVRGIxUNYiXXuiMUId1dBTMh
         7XJDXG80hbu4vPk3Xu0Qb+/f90GIEsxOelv7zmCcv/P/W2SbJpiPEexzZgXGLp2g1UcN
         W7fBt2/aGu/UxMa82jYYfNYCl/6NN11hbUW//gSEqKWETTJTHO1dRlRQ8yd5p6NJzqlI
         FPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=EEkeQV2lS6HKy4DDvPeg9YGE3jqgylO8++1fEXanpig=;
        b=hxDie54QMUipehhFytr4jpJv8j9zGUycWhCjAFILfuWReKwGp/XUnWRxM7lbgrPdpX
         m+r4kbxJ5ru75ilpiGlXt1vGh2zR8H36cG6qXLnGyNyjS8gNBJCnBlDWmzg1yzoyQ9+m
         wg/5O+fvbz18Mhkxhm9JmPSWIqYZFz8GylLwLhstxKPsUkHqyOoiXeb7qmUFL0VwFnkZ
         hXAkGm0JUFBGxJVnuzR+xpGxF9RA3LvVuf8BOo52cjyXX4oIfPkddgXlwpOkU+4RakfX
         bx4DMx0UlAXQkws9SGz8T3wmRVALS5IFu8wyjKHVcL2vXANgZGia1XxaqL01/qgI34X0
         Zd/Q==
X-Gm-Message-State: AOPr4FWiw/AmsWJeaKJH2LTNZO3yaD2tnmOMrjvyrawYNnzzkmrKaWTbrBOKzKvbbFChTWkLl6LMgCdLa1r+mP00
X-Received: by 10.50.98.195 with SMTP id ek3mr6904482igb.85.1460748613737;
 Fri, 15 Apr 2016 12:30:13 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 12:30:13 -0700 (PDT)
In-Reply-To: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291646>

On Fri, Apr 15, 2016 at 12:19 PM, David Turner <dturner@twopensource.com> wrote:
> We've got a lot of refs, but pretty frequently we only want to fetch
> one.  It's silly for the server to send a bunch of refs that the client
> is just going to ignore.  Here are some patches that fix that.
>
> Let me know if this seems reasonable.

Thanks for working on this!

I had a similar goal back then for non-http traffic and that series
exploded in size[1]
The issue at my attempt was non http traffic would require a protocol
update such that
the client speaks first to transport the refspec to the server. To
make "client speaks first"
happen, we'd need to have a protocol v2. So that attempt of mine
stalled as it seemed like
a huge thing.

[1] WIP at https://github.com/stefanbeller/git/tree/protocol2-10

This series looks small and reasonable from a cursory read.

Thanks,
Stefan

>
> (and I'll start in on another round of index-helper as soon as this is sent!)
>
> David Turner (6):
>   http-backend: use argv_array functions
>   remote-curl.c: fix variable shadowing
>   http-backend: handle refspec argument
>   transport: add refspec list parameters to functions
>   fetch: pass refspec to http server
>   clone: send refspec for single-branch clones
>
>  Documentation/technical/protocol-capabilities.txt | 23 +++++++
>  builtin/clone.c                                   | 16 ++++-
>  builtin/fetch.c                                   | 24 ++++++-
>  builtin/ls-remote.c                               |  2 +-
>  builtin/remote.c                                  |  2 +-
>  http-backend.c                                    | 23 +++++--
>  remote-curl.c                                     | 25 ++++---
>  t/t5552-http-fetch-branch.sh                      | 47 +++++++++++++
>  transport-helper.c                                | 44 ++++++++----
>  transport.c                                       | 14 ++--
>  transport.h                                       |  4 +-
>  upload-pack.c                                     | 81 ++++++++++++++++++++++-
>  12 files changed, 261 insertions(+), 44 deletions(-)
>  create mode 100755 t/t5552-http-fetch-branch.sh
>
> --
> 2.4.2.767.g62658d5-twtrsrc
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
