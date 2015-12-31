From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] avoid shifting signed integers 31 bits
Date: Thu, 31 Dec 2015 12:10:33 +0700
Message-ID: <CACsJy8CAAqZFQCfadUov7DFhSgh=dtGfE-onbXZQXO-0Y2652g@mail.gmail.com>
References: <20151229063449.GA28755@sigill.intra.peff.net> <20151229063545.GA30340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 31 06:11:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEVW3-0002eJ-V2
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 06:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbbLaFLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 00:11:07 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36435 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbLaFLF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 00:11:05 -0500
Received: by mail-lf0-f50.google.com with SMTP id z124so230218550lfa.3
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 21:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8OY26DRuCGUKkz2AoQ46NfnxMOni0am++mftDTD+B7o=;
        b=yCGv5ywGAzwWKo3xaepbz8/mdF9MRorPhsysd2s/oIMv8E9b3WGoqlOWqF7S0pt41m
         pD7nwoqOBOmD9VwbYlw7DZG60tsrzgWUY6z/KHDU5LpfLT8KEbyETZS925al1VF5y+FD
         ntQQqXZPfUvenWHB1y0cXK2gVIu6AA5ezWQ3rkfgwRv1FD1dMWy3s1EYXElju4QCKNrp
         AUy8mP/JUawpwxf/wkrYaCntMZpR4vxT/raj6EqORNTunhdBNkGKaPPqn8pUpuOTxaRH
         JsTqJ4FEdLwmSdvlY9R3Jl2HD0dIqtz83tVNWvLv/fjY4bF1+JRGQyz0bvo6F5bdAviV
         dp8w==
X-Received: by 10.25.144.17 with SMTP id s17mr10518991lfd.94.1451538663290;
 Wed, 30 Dec 2015 21:11:03 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 30 Dec 2015 21:10:33 -0800 (PST)
In-Reply-To: <20151229063545.GA30340@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283225>

On Tue, Dec 29, 2015 at 1:35 PM, Jeff King <peff@peff.net> wrote:
> We sometimes use 32-bit unsigned integers as bit-fields.
> It's fine to access the MSB, because it's unsigned. However,
> doing so as "1 << 31" is wrong, because the constant "1" is
> a signed int, and we shift into the sign bit, causing
> undefined behavior.
>
> We can fix this by using "1U" as the constant.

We have this in cache.h, should it be fixed as well?

/* CE_EXTENDED2 is for future extension */
#define CE_EXTENDED2         (1 << 31)
-- 
Duy
