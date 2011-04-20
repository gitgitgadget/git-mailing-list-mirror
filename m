From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] date: avoid "X years, 12 months" in relative dates
Date: Wed, 20 Apr 2011 06:18:00 -0400
Message-ID: <20110420101800.GA24035@sigill.intra.peff.net>
References: <20110420052435.GA28597@sigill.intra.peff.net>
 <1d0633318ffc778dfcc1c32ecf80fca0327349d6.1303290693.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 12:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCUUA-00013U-Jj
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 12:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab1DTKSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 06:18:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45388
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717Ab1DTKSG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 06:18:06 -0400
Received: (qmail 3149 invoked by uid 107); 20 Apr 2011 10:19:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Apr 2011 06:19:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2011 06:18:00 -0400
Content-Disposition: inline
In-Reply-To: <1d0633318ffc778dfcc1c32ecf80fca0327349d6.1303290693.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171854>

On Wed, Apr 20, 2011 at 11:12:11AM +0200, Michael J Gruber wrote:

> Implement this differently with months of size
> 
>   onemonth = 365/12
> 
> so that
> 
>   totalmonths = (long)( (days + onemonth/2)/onemonth )
>   years = totalmonths / 12
>   months = totalmonths % 12
> 
> In order to do this without floats, we write the first formula as
> 
>   totalmonths = (days*12*2 + 365) / (365*2)

Well now I feel like an idiot. Algebra to the rescue.

The extra multiplications introduce the possibility of overflow, but
since the number of days was arrived at by dividing an unsigned long
number of seconds by 86400, we are guaranteed to have room to multiply
by 24. :)

So looks good to me.

-Peff
