From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Commit cache to speed up rev-list and merge
Date: Fri, 28 Sep 2012 09:14:54 +0700
Message-ID: <CACsJy8APNsDrTH+hUxgcB=MY0eECCGktm6P1feEEpz2427OQqg@mail.gmail.com>
References: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 04:16:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THQ7l-0008LF-GX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 04:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720Ab2I1CPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 22:15:25 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33863 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab2I1CPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 22:15:25 -0400
Received: by ieak13 with SMTP id k13so6207108iea.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 19:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D2mof/owBNRHPprcGnfl7zbLqGmDZruqhlG8Y1hj0H8=;
        b=0kCc4YWws77QumHZEwqr+kkPSimWoVjIfxVkoaBatHGYyT88ozJjVIgiEdgKT94dRv
         D3IWqEqF+ReIKNLl71igtNXrjXebGw2Tl0Fm3OiQDIrTkyY1Fa+0i9hTaJtbrQFRNjY/
         m/+RyUU1nU0Z6y5sizfYddO1BEzH74G4X6MRW2/1ejI0AWmfa4cFZKM6lIySTvPYbLYH
         /TW294qrMcdG5CuaRdKgF4LzWEXkKNyMCfFNT48F+AyBRfJiTIwzRnfrgwL78xMXmBij
         /a3FrhQBy3fm5YmeOI9dSIbfS/H/4U/yiM6oEbr3360y4iAnFvDqmXF3w5Kn4Il8zat2
         XNmA==
Received: by 10.50.158.194 with SMTP id ww2mr304306igb.40.1348798524301; Thu,
 27 Sep 2012 19:15:24 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Thu, 27 Sep 2012 19:14:54 -0700 (PDT)
In-Reply-To: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206535>

On Thu, Sep 27, 2012 at 10:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
> In Linus' Linux kernel tree there are currently about 323,178 commits.
> If we store just the pre-parsed commit time as an int32 field this is
> an additional 1.2 MiB of data in the pack-*.idx file, assuming we can
> use additional data like pack offset position to correlate commit to
> the parsed int. If we stored parent pointers in a similar way you
> probably need at least 3.6 MiB of additional disk space on the index.
> For example, use 12 bytes for each commit to store enough of the
> parsed commit time to sort commits, and up to 2 parent pointers per
> commit.... with a reserved magic value for octopus merges to mean the
> commit itself has to be parsed to get the graph structure correct.

This is much better than my naive approach (storing sha-1 and
timestamps). We could use less space by storing parent pointer of
non-merge commits only. Merge commits linux-2.6 is 6% the number of
commits. git.git has higher percentage, 21%. I bet many projects do
not merge as much and the number of merge commits is less than 5%.
-- 
Duy
