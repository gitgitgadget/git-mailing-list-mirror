From: skillzero@gmail.com
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 10:33:02 -0800
Message-ID: <2729632a0901141033p47b4d8dah46f5bac27307d306@mail.gmail.com>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
	 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
	 <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
	 <496D9572.2090303@viscovery.net>
	 <2729632a0901140008r59e429aeq3ce367e1bc7df71@mail.gmail.com>
	 <496DA3B2.1070807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 19:34:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNAZa-0003KO-4l
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 19:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbZANSdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 13:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZANSdG
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 13:33:06 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:47725 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbZANSdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 13:33:04 -0500
Received: by yw-out-2324.google.com with SMTP id 9so289478ywe.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 10:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Hp8VinBAW4leqJ5LZll3VTIPkb56K2Z6XEx+WqX2Yt0=;
        b=GSj5tKWEy9ROUwBbNhz/RakS0loaCpkfAtOUS4n90MamuDX7PtIZFDU7DvyhgVz1Hy
         wZifYtmhyte/Ue/W8SmLOoMGyKKGaX4nPl3fdTUWVWOjO57d2WI9t2KJzgstOj68U/lg
         YHg0qsHXg4iVm2Ib3fPisbqVr4n7MO6S4Ou+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=c2+pa6iLwchrFIX8PTln4AnaW2MvSLKJir4TkoM0BGGNU8JkfXKSCuwW/TIAf0qCk8
         1p6xzPwYeR2AtfB7ape6Rg9MQcUvh4f5H0dAqMKifVjJVrCZ+mGRkJRi8IfTxmNu2gbx
         JBeVrDKZg80HCaHnNgcu4oq3C4V36Z8ihiyFw=
Received: by 10.65.133.12 with SMTP id k12mr161331qbn.65.1231957982325;
        Wed, 14 Jan 2009 10:33:02 -0800 (PST)
Received: by 10.65.241.19 with HTTP; Wed, 14 Jan 2009 10:33:02 -0800 (PST)
In-Reply-To: <496DA3B2.1070807@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105678>

On Wed, Jan 14, 2009 at 12:34 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:

> After you created the fixup, you have this situation:
>
>    o--o--o   <- A (feature branch)
>   /
> --o--x        <- X (the fix-up branch)
>   \
>    o--o--o   <- Z (probably your master)
>
> You merge the fix-up into the feature branch and continue developing the
> feature:
>
>    o--o--o--M--o--o   <- A
>   /        /
> --o--x-----'           <- X
>   \
>    o--o--o            <- Z
>
> Other people need the fix in Z right now, so you merge it into Z as well:
>
>    o--o--o--M--o--o   <- A
>   /        /
> --o--x-----<           <- X
>   \        \
>    o--o--o--N         <- Z
>
> You complete your feature and merge it into Z:
>
>    o--o--o--M--o--o     <- A
>   /        /       \
> --o--x-----<         \   <- X
>   \        \         \
>    o--o--o--N---------O <- Z
>
> The fix-up commit is only once in your history.

Thanks for the info. That's what I was hoping, but I was thinking that
I'd get duplicate commits if I did that. I'll have to try it out when
I run into this situation again.

Related to this, is there a way to easily find the common merge base
given a bunch of a branches? When I want to fix a bug, I want to say
"Given branches A, B, C, D, and E, where should I fork my bug fix
branch from so that I can merge this branch into all those branches
without getting duplicate commits?".
