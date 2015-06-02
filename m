From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] config.mak.uname: Darwin: define HAVE_GETDELIM for
 modern OS X releases
Date: Tue, 2 Jun 2015 16:17:38 -0400
Message-ID: <CAPig+cQsrxgMcK0+1jPLY8YXtNF4y17ivTUrFE8L8RS3MeffgA@mail.gmail.com>
References: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
	<1433269138-10890-2-git-send-email-sunshine@sunshineco.com>
	<20150602184413.GA11437@peff.net>
	<20150602190403.GA12660@peff.net>
	<CAPig+cQLSF4=-4b1qOY4ChBj00=trvAO0qFEh0kOjLonJL4MBg@mail.gmail.com>
	<20150602200134.GA13382@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:17:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzsdC-0007W0-TW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 22:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbbFBURp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 16:17:45 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38714 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbFBURj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 16:17:39 -0400
Received: by igblz2 with SMTP id lz2so20420277igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qS6x3ZQgYzyGwbno8a6yTFtpYoNqgT6tpwvGAAfKyEE=;
        b=Xi5ktBeJ1bHaNnEDxe6uxdetxFdoul7OSZ6BNjeteG0I/bgOkRP+CZQoeDHJumoLBB
         fafd864LbAef5tBBDnm/ClWWwi0mN4fs+nwWkbPhjbUD6d3gV+mTLmye2w8/5jyNNtZX
         0sP9vjU/pop29vlSAO5rqjXoD0TNPuXGheRO5cMtEJLCdnYSkdqdc7MjKI9JvUt66CjO
         P2Oc4Ia56nFM0bDzRUC14rxJwDDLaje6dbQYB2VUjflQrvoIrnNZvJd0X9z6uc3hrcGq
         sUtTmt1UR+Yn/h4ZSzWnMuo3nHuVpGMcyiIpindnEiid4iucBKIqcNFTUCHrBzEZ/kr4
         +01A==
X-Received: by 10.50.66.234 with SMTP id i10mr680316igt.22.1433276258664; Tue,
 02 Jun 2015 13:17:38 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 2 Jun 2015 13:17:38 -0700 (PDT)
In-Reply-To: <20150602200134.GA13382@peff.net>
X-Google-Sender-Auth: 6C7_R9-SMbDCStgj3_Uwosr7z9I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270593>

On Tue, Jun 2, 2015 at 4:01 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 02, 2015 at 03:57:44PM -0400, Eric Sunshine wrote:
>
>> > Oops, I missed the trailing '.' in the regex there, and it probably
>> > needs double-quotes in case the inner expr fails to match anything.
>>
>> Which is messy considering the double quotes already surrounding
>> $(uname_R). Suggestions?
>
> The shell should do the right thing with nested quotes inside backticks.
> So just (untested):
>
>   $(shell expr "`expr "$(uname_R)" : '\([0-9][0-9]*\.\)'`" '>=' 11),1)

Right. Temporary brain derailment on my part.

>> I suppose the combination of `...` with built-in 'test' and built-in
>> 'echo' would be the most efficient choice. Do you want it re-rolled?
>
> I can live with it either way. It's all pretty horrible and ugly; the
> saving grace is that we hopefully never have to touch that line again.

I'll re-roll, taking advantage of `...` and (typically, builtin)
'test' and 'echo'. This:

$(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1)

Already tested on OS X 10.10 (Yosemite) and 10.5 (Leopard).
