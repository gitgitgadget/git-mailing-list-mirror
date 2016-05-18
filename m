From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] attr: add counted string version of git_attr()
Date: Wed, 18 May 2016 14:36:46 -0700
Message-ID: <CAGZ79kbMsitKNeb-D3gmTFwrRS-6ZiCZcmu1MP42UCd5AHcHbA@mail.gmail.com>
References: <20160518190222.28105-1-sbeller@google.com> <20160518190222.28105-6-sbeller@google.com>
 <xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com> <xmqqy477qfr2.fsf@gitster.mtv.corp.google.com>
 <xmqqmvnnqdtd.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 23:36:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b399B-0002h9-4P
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 23:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbcERVgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 17:36:48 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34712 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcERVgr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 17:36:47 -0400
Received: by mail-io0-f171.google.com with SMTP id 190so82966838iow.1
        for <git@vger.kernel.org>; Wed, 18 May 2016 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hmb/WkoVY/Ln3jxy8K5zdZCfc1DpPcmayC3GO99WKus=;
        b=HSoxo+oVB4NjTLYCXG2gTdlUVH1Fxv0i98FgXGjNBipiZ75GNbfo5wog3sQuTbmOQV
         TkBVHxUfRHalAUQUDtStI5VPd2B/bwgSd3jJ/p2sGtlfMIt82U1sv9sYwazWdH3bPOci
         NzZWJeDsD5UFoUIt4v23CmagCZhyoxR1mqIs7/u5GHwo0CY8IEqomu6gOFQGIDR9H4I0
         eR8Mj4MJ299xMPcNiK/os4m1e53/t5hDs6gqxm+Nx36UbXr5H8JRkYKQjpul1jaT5oHU
         p1dH6UZPY47qmnj8x5FbnBS8aTOUen5gJpa5tBUuAt+hYwBZDzkHOO9pvC/hsJkSqn2G
         8l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hmb/WkoVY/Ln3jxy8K5zdZCfc1DpPcmayC3GO99WKus=;
        b=E5n8A55UYcjRaIYbYRFHqcOfkfBPOw2jZ5t8bCT2oM4+UJLqdC9WNbaCYLo3ababzY
         dp9S4UvmnS4HBdvMpGxDd2Om4UofPZPVg/EjpO3bupaAM7SJ1reTvxkR7X6esgpr3g6p
         WPoAFi4+BUp/5po7EzSghkCw546jNMWuMyEgeInheZ5owOvy1mvUwYRom1w5ylmj1X+t
         BYUKFeNXkVPbqqSfyhL+0srEAbE+vQc+1L8FOMegm6qR/TTHI63cuYfvwFHl6JDndKpy
         TU8O9MhgYbjmU/oRpFix1PaBuWCabBewvK+9rwZ2MVrKdTqH55vO32XGWDDfefBFRNPk
         6CPA==
X-Gm-Message-State: AOPr4FXxSCaYQxYdAf1ryDatlD+Q9iL9kru4+NqkYfPZ7pq1AeCdXFw3oyLC5RsEBnysT6hxZg18+C6vs6DyAZkg
X-Received: by 10.107.53.204 with SMTP id k73mr6915513ioo.174.1463607406701;
 Wed, 18 May 2016 14:36:46 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 18 May 2016 14:36:46 -0700 (PDT)
In-Reply-To: <xmqqmvnnqdtd.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295013>

On Wed, May 18, 2016 at 2:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Often a potential caller has <name, namelen> pair that
> represents the name it wants to create an attribute out of.
>
> When name[namelen] is not NUL, the caller has to xmemdupz()
> only to call git_attr().
>
> Add git_attr_counted() that takes such a counted string instead of
> "const char *name".

s/ "const char *name"/a standard C string that is null terminated/ maybe?

"const char *name" is not a strong hint that it is not counted?
