From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] archive: ignore blob objects when checking reachability
Date: Thu, 6 Jun 2013 20:50:27 -0400
Message-ID: <CAPig+cRMGBjXO3Phmv=SX7FQwZ=uCUTT9YSKiEBb6PU0ts_1uw@mail.gmail.com>
References: <20130605223551.GF8664@sigill.intra.peff.net>
	<20130605224038.GD15607@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ian Harvey <iharvey@good.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 07 02:50:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukksz-0002Bc-Ns
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 02:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960Ab3FGAua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 20:50:30 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:40019 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab3FGAu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 20:50:29 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so1350091lbi.39
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 17:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=TRey1IuFSdC847+oNDDq+lnUjq444fsAJSG52tTfXkU=;
        b=mxXv5ywcy1DchyC4IxbpHpBC9m1maoM3Ys+Cv/y2HtYr82tStDvxcXN8hsa42dc+s9
         +Tq81fG82lN/LIRHPsJeGcBtYAeoLuZKha8wtmEvOl+97cNsi+OIeDk2dzA+oagUtTi0
         xzTxjIBad5l4yJW4Zd698bLq3Doq0EVgsYUqhvKqe238LpPa0q+NB1D1Z6FXECpMBoga
         0ZaMmZoW6gLHWSxVG5eDxV1ZzKRKAaTEXfmSlRK6aHop2P1jAtEojo6B7WHu9hSGm68D
         A5H26TQc+aLRFCH/iooAzBUmjBh9nNId8+JuGhIBVHfjrt4Cptk+nIjbjXRlbN+yss/g
         9LZQ==
X-Received: by 10.112.219.133 with SMTP id po5mr78842lbc.80.1370566227282;
 Thu, 06 Jun 2013 17:50:27 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 17:50:27 -0700 (PDT)
In-Reply-To: <20130605224038.GD15607@sigill.intra.peff.net>
X-Google-Sender-Auth: ywn_tUaZbQGHuZyHSWxDlW4f7_Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226573>

On Wed, Jun 5, 2013 at 6:40 PM, Jeff King <peff@peff.net> wrote:
> We cannot create an archive from a blob object, so we would
> not expect anyone to provide one to us. And if they do, we
> will fail anyway just after the reachability check.  We can
> therefore optimize our reachability check to ignore blobs
> completely, and not even create a "struct blob" for them.
>
> Depending on the repository size and the exact place we find
> the reachable object in the traversal, this can save 20-25%,
> a we can avoid many lookups in the object hash.

s/a/as/

> The downside of this is that a blob provided to a remote
> archive process will fail with "no such object" rather than
> "object is not a tree" (we could organize the code to retain
> the old message, but since we no longer know whether the
> blob is reachable or not, we would potentially be leaking
> information about the existence of unreachable objects).
>
> Signed-off-by: Jeff King <peff@peff.net>
