From: Ben Boeckel <mathstuf@gmail.com>
Subject: Re: [PATCH] add ls-remote --get-push-url option
Date: Fri, 31 Jul 2015 16:51:42 -0400
Message-ID: <20150731205142.GB6556@megas.kitware.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
 <xmqqfv445fxv.fsf@gitster.dls.corp.google.com>
 <20150731185619.GA24622@megas.kitware.com>
 <xmqq4mkk5ex5.fsf@gitster.dls.corp.google.com>
 <20150731190415.GA23674@megas.kitware.com>
 <xmqqzj2c3zoh.fsf@gitster.dls.corp.google.com>
Reply-To: mathstuf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 22:51:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLHHT-000265-HP
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 22:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946952AbbGaUvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 16:51:47 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36777 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946642AbbGaUvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 16:51:45 -0400
Received: by igbij6 with SMTP id ij6so23883435igb.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 13:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aMQPtzaouSSaYpzzoYa8//ZcR20yrnCB4tGViBNCKak=;
        b=ohsDbuOMdkzt6OwGZMBZ5m24SjVfCAFw6i5mwUnCiwrnRcIz51cmWYg0tpye+Q0THO
         2lDKjyl+Qh+9jZGOA6CzOprBWIzOYZBHrcHNzqmjw7vUU+M7Re/ZI7zH1tQYqGAz1l9e
         WqHLMhzHpWJmE12ykQl0csLCNFuX4iEq2sHpu7xIeEiKkemnkcqDS51ix4yVddaA6RQQ
         uyUDemfgdPqUC2idNVMIQ+XHoiHVOaALhFGKNRoOXgfCjuEs1wL6Jkw5TCzAM0akL1YT
         MBfwkVRHuE6O1mxDTGHMH12mdwil7z+B/s9S5eMxVjFjnp8h8PgYpSpy3nOGxdW61QfA
         zhzA==
X-Received: by 10.50.142.37 with SMTP id rt5mr9804401igb.88.1438375905194;
        Fri, 31 Jul 2015 13:51:45 -0700 (PDT)
Received: from megas (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id 71sm4121214ioh.24.2015.07.31.13.51.43
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 13:51:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqzj2c3zoh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275075>

On Fri, Jul 31, 2015 at 12:16:46 -0700, Junio C Hamano wrote:
> Or even "git remote get url [$there]", "git remote get push-url [$there]".

Looking at `git remote`'s existing subcommands, consistency there would
be something like:

    git remote get-url $there
    git remote get-url --push $there

The new call could also show *all* remotes which will be pushed to, not
just the first. Looking at the structure, it also has fields for
multiple fetch urls. I would assume git would fetch the union of refs;
not sure about conflicts and such.

> Or to mirror the existing "ls-remote --get-url [$there]", which directly asks
> "where does this request go if I run it without '--get-url' option?":
> 
>     $ git push --get-url [$there [$refspec...]]
>     $ git push --get-refspec [$there [$refspec...]]
> 
> might be a better option.  The logic in "push" takes the current
> branch and configurations like branch.*.remote and push.default into
> account, so it is likely that you will get the exact information
> without too much code.

This is a little weird to me. `git push` is porcelain; `git ls-remote`
feels more like plumbing (command-list.txt seems to agree). Maybe it is
also useful since it takes these other configuration values into
account. But maybe pushing has enough extra factors? Might it make sense
in addition to a `git remote get-url`?

> I am not opposed to having a scriptable interface to obtain these
> pieces of information.  I was only objecting to teach ls-remote
> anything about push, which ls-remote does not have anything to do
> with.

OK. Thanks.

--Ben
