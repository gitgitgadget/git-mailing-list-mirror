From: Michael Edgar <adgar@google.com>
Subject: Re: [PATCH] clone: check if server supports shallow clones
Date: Thu, 11 Jun 2015 14:18:00 -0400
Message-ID: <CALkbG6+vRqKwmBjK9jwSph4iUUbqPjiuNdHEeT3nvFhFJ0VpEg@mail.gmail.com>
References: <1433961320-1366-1-git-send-email-adgar@google.com>
 <20150610190512.GB22800@peff.net> <CACsJy8CiwiWgf2CarNNN5NgN7QbRB8oxGMmxF+VX8T=ZV2M1ow@mail.gmail.com>
 <20150611143204.GA3343@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 11 20:18:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z373j-0007SI-Ss
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 20:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbbFKSSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 14:18:24 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36769 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbbFKSSY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 14:18:24 -0400
Received: by wgbgq6 with SMTP id gq6so9689653wgb.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e/e2Nb7aCmWRwX5KtA7ZsdX7KyRbWjUJGisee+LwzgQ=;
        b=DFNMHwIUGqEq8dc22Ma9T8Fs+OKvaamWGmaxTZRu9H5YjQUFbMT6WKvZT1B/qvuvW+
         /wkX5EO1PSasHJe7CSeuDP961DO+Pi6JF/piEr4qBPF2rtqy92UXK9snBkPYKBuIrFsP
         DSxTIF9mJDEojUc9N1/iZt/rplf0iGeFG8nJgEQ7aEvdWIYy95P1u+5eTDCCH6L68wHH
         BwzxdWDOIvIVsZY1IyepGGuZVR0oi2O7qTKOrAOrRfcFHxzBbwDCgSMDvXy/LgHAgzem
         UuBWQbIVfYxPv6d+MiBtdVu+AvmN1O4GVd+2OH5oeMKMdWw/UgYwFO7c06H0g0G4uxbr
         cAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=e/e2Nb7aCmWRwX5KtA7ZsdX7KyRbWjUJGisee+LwzgQ=;
        b=CMu2Q3g6XdXGUi1HYivLmp3yF97oofhbztq0i9G3SIfC4beixM7UMEqnig8+LZnY7o
         3ghrL9Ru5lfCmtdT0yC9BnXc+rS4Jnof5+LIxp0tcRqqrcJYJ3aCU9p7JHDZ3T1Fz0W4
         Ld9GDbZ5hrxr0bp26yKbMHdnpbLY71vLfFglsab0fFULsoiAuTZdzeRPrUz4uXdSDMsl
         PURObSaM3sblMmPt/hMrvcntLRm+Ez7moDmeEinGZXU/nTbb5q0zc67Ikzth+epnxGK8
         dSar1DxKnplS8DrPZovlf4S8BmOPYWm9QIS3WG+QgSMvLj8v8333gHgQy2omXx9NpdOV
         ICPw==
X-Gm-Message-State: ALoCoQk9L7zTPfoqDybfIjHmIH/1Cd1ca7IzA4KjR/WZ8ifD4nUI6XuIPSvPPVkmY4MdgOgmUaTR
X-Received: by 10.180.106.73 with SMTP id gs9mr21495221wib.1.1434046701691;
 Thu, 11 Jun 2015 11:18:21 -0700 (PDT)
Received: by 10.28.162.2 with HTTP; Thu, 11 Jun 2015 11:18:00 -0700 (PDT)
In-Reply-To: <20150611143204.GA3343@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271447>

On Thu, Jun 11, 2015 at 10:32 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 11, 2015 at 08:02:33PM +0700, Duy Nguyen wrote:
>
>> > I see that do_fetch_pack checks server_supports("shallow"). Is that
>> > enough to cover all fetch cases? And if it is, why does it not cover the
>> > matching clone cases?
>>
>> I think this replacement check would do
>>
>> if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
>>         die("Server does not support shallow clients");
>
> Oh, indeed, there is the depth flag I was looking for. :)
>
> And from some rudimentary testing, I believe that:
>
>   git init
>   git fetch --depth=1 ...
>
> is currently broken in the same way as clone (we are not shallow yet, so
> it does not complain when the server does not support it). I think the
> patch above fixes both that and the clone case.

Great point! Duy's proposed fix worked for me testing against the Git
server that
led me to the original bug (code.google.com), for both clones and init/fetch.

Shall I send that out as a revised patch for review? (This is my first
stab at a Git
patch)

> Of course it's hard to add to the test suite, since we do not have a way
> of hitting a server that does not understand shallow (I simply fudged
> server_supports() to return false on the client).

I noticed this, and figured it would be more dangerous for users to include a
testing backdoor (eg a flag overriding the advertised capabilities). Is that an
accurate assessment, or is there a safer way to test these sorts of interop
cases?

Cheers!
-- 
Michael Edgar | Software Engineer | adgar@google.com
