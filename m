From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 1/2] git-p4: support multiple depot paths in p4 submit
Date: Tue, 8 Dec 2015 12:32:55 +0000
Message-ID: <CAE5ih78K5zzJBK3y-MMf2tWBoPOtkPJzYRZWxH02qBE=OnUhVA@mail.gmail.com>
References: <20151205112203.GA15745@hocevar.net>
	<F328D5D9-754A-41CC-A7B2-993B9315ED33@gmail.com>
	<20151207185129.GA48528@hocevar.net>
	<14B51656-26D1-4805-9F07-102CBD81B387@gmail.com>
	<20151208114106.GB48528@hocevar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: Sam Hocevar <sam@hocevar.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 13:33:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6HSK-0000yG-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 13:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbbLHMc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 07:32:56 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35406 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbLHMc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 07:32:56 -0500
Received: by igl9 with SMTP id 9so94960356igl.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eEjVMO5kE2qlzuyej1LMpqvvEkM+0fRPqJ9ql3shG1w=;
        b=Y9UgcgtxhjUlrOyOKMICLplBIueCc9mQcGWN8FIl/D1YICedKCx5X5tig2JSbDKDrO
         c10wZoJkfgLG5VbMjccGTCP7lHwt8y4hDnC2s69S8Elxd2tr45qjeFPH/n6v0+y7Akc6
         40QOM0e9J3MmbgeLXTOMm5tFQz05XwKdSnf5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=eEjVMO5kE2qlzuyej1LMpqvvEkM+0fRPqJ9ql3shG1w=;
        b=euwUiELR0Nv3yB24H5Avv5I64xmByqpt/MadEp3RYViHW6DeOCjxAydMY/kHce5RSx
         M2fflod4cmSzwApTqb/u9N1nMsF5FhAipxxXYSiQRnQ5yK6PhJB0ULF3C9W1Z7j2LksL
         jQesgMIjdSaKVvJRG/FqOUeitzKmftPs08ocRxlk76N6FONk1okS/+IYRInNdao/6YO7
         orbyHw52THHVABuIaQVw+9qaDwmB0Z4KkNNcIVjPxhVIIXqwhipJtAuEfZfe7MPXFvu1
         u9bvMOzely7TmGa4PxyznvQCInDxNneJsBnrwdgMu+b6B1UIX1u0dsuNRD7szTcgCTW9
         gnqA==
X-Gm-Message-State: ALoCoQkzlxghsYTRBoANkyBxcB2HmG792qm091Osst1hnLrZH4yBTRx5y/Dwr6wYorDFHFYZpykiCGkVrQsMgB9GEheKbmtV1g==
X-Received: by 10.50.43.199 with SMTP id y7mr22221501igl.47.1449577975260;
 Tue, 08 Dec 2015 04:32:55 -0800 (PST)
Received: by 10.79.94.194 with HTTP; Tue, 8 Dec 2015 04:32:55 -0800 (PST)
In-Reply-To: <20151208114106.GB48528@hocevar.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282156>

On 8 December 2015 at 11:41, Sam Hocevar <sam@hocevar.net> wrote:
> On Tue, Dec 08, 2015, Lars Schneider wrote:
>
>> >   Would a refactor of lib-git-p4.sh (and probably all git-p4 tests) to
>> > support multiple depots be acceptable and/or welcome? I prefer to ask
>> > before I dig into the task.
>>
>> Can you outline your idea a bit? Are you aware of the following way to define client specs: [1] ? Would that help?
>
>    That's the idea, but the bug occurs when the client view looks like this:
>
>      //depot/... //client/dir1/...
>      //depot2/... //client/dir2/...
>
>    And is then cloned with (it is not legal in Perforce to specify //...
> directly to grab both depots at once):
>
>      git p4 clone --use-client-spec //depot/... //depot2/...
>
>    Then when a file is modified in dir2/, git p4 submit does not elect it
> for the changelist. A file in dir1/ will work fine.
>
>    Unfortunately the current test suite assumes everything is under
> //depot/ so in order to write a test for this situation there are a few
> things to change in lib-git-p4.sh.

I think the existing structure ought to mostly work, but it might need
a bit of tweaking.

You would need to create a new depot, but you can do that in your test script.

And you would need a client spec that pointed at this depot, but again
you can do that in your script with the client_view shell function.

I've not tried it myself though, so maybe it's harder than that.

Luke


>
> Regards,
> --
> Sam.
