From: "Ken Pratt" <ken@kenpratt.net>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 00:43:27 -0700
Message-ID: <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <20080811030444.GC27195@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 09:44:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSS4t-0007v8-Hu
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 09:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbYHKHn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 03:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbYHKHn3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 03:43:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:40633 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbYHKHn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 03:43:28 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2133776rvb.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=4TmvDO+oiwZJH+XffZeM0sjrKYABHqC8cIb+vph8D8U=;
        b=oDC06DD+wL2ojaMTU54uu8YixkIzN/Mt3/Ewd4D/+fzlwG56Pzvlb0jYQ66hRvubeL
         FGpKIct1zyRkmKhxQlSv+OeS33PG2SPCBqPjZfugAGIWxGqjmGcuW5KjC+O6qgl499TJ
         1DMM5at7trHCUOclAk9kjgzlEMTYiOPIDChA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=FXuwDcvGTtJsocduN//AYjMqsaWOwUQj1KFJxO/fNTXMrwlno614Ty4uUb1hLcr4lR
         CuVxdagS3Xd8iasPap7fibgnEYBfP+RykUqIfDtT/flWQeap5kbVp8Jy/cAiLUnjCyy6
         hPTMcDMxFMMmb+lkIEECbvxpONjES3/pBM8So=
Received: by 10.141.195.5 with SMTP id x5mr3281197rvp.263.1218440607719;
        Mon, 11 Aug 2008 00:43:27 -0700 (PDT)
Received: by 10.141.42.15 with HTTP; Mon, 11 Aug 2008 00:43:27 -0700 (PDT)
In-Reply-To: <20080811030444.GC27195@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 4dbbdfac4b3f09a5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91921>

> Have you tried something like this?
>
>        [core]
>                packedGitWindowSize = 16m
>                packedGitLimit = 64m
>
>        [pack]
>                threads = 1
>                windowMemory = 64m
>                deltaCacheSize = 1m
>
> On a 64 bit system packedGitWindowSize and packedGitLimit have very
> large thresholds which will cause it to mmap in the entire pack file.
> You may need to try even smaller settings than these; 256m physical
> memory isn't a lot when dealing with a repository 180m in size.
> Especially on a 64 bit system.

I just went as low as:

[core]
        packedGitWindowSize = 1m
        packedGitLimit = 4m
[pack]
        threads = 1
        windowMemory = 4m
        deltaCacheSize = 128k

And it didn't make a dent in memory usage. Server is still swapping
within ~10 seconds of starting object compression.

I'm starting to think repacking is just not feasible on a 64-bit
server with 256MB of RAM (which is a very popular configuration in the
VPS market).

Thanks!

Ken
