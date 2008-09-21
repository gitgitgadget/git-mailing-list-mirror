From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 01/14] Extend index to save more flags
Date: Mon, 22 Sep 2008 00:21:11 +0200
Message-ID: <200809220021.11820.jnareb@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com> <m3skrulbrd.fsf@localhost.localdomain> <fcaeb9bf0809202134p2457e0cdn50ae8183ba07bcde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 00:22:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhXJz-0006Cp-Cq
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 00:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbYIUWVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 18:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbYIUWVS
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 18:21:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:16527 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbYIUWVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 18:21:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1167532fgg.17
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 15:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=svkcHExqf8MEsYQs5AMClumwyvEmjJO74GdcMaGadT4=;
        b=yBerUZqKw2kboO8O7EYxZwSA3v+5HQi/3BXP74KEz/q2xZjdpYOYbUMu98WdQ1obLC
         L3H7EOdxqKfhio2jPu62YYTdCmHNRTbPfPbotxIIc29mM65uuJye3qEbzLU67r5RCpYJ
         GWI4ye1NDkKCYmj0W+jc2je84BcOWOoxO707Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lozOcCrQACDV4j6P3HJyNm6otWXC1Cn3v29DJvNrqDPxYjdnK4k9LS2pizYCxsMeCf
         WQF6FKlO0bxQP0S2E8M+0YtLo7ZoQBjZW3rpE/027apxlmEiH1GPLUBrQfGJNmHdsdTw
         XpKcD1JgqZnwi/gd1zX8lKYzgdu9aTu7wKnIM=
Received: by 10.86.83.2 with SMTP id g2mr4186958fgb.54.1222035674760;
        Sun, 21 Sep 2008 15:21:14 -0700 (PDT)
Received: from ?192.168.1.11? (abvi218.neoplus.adsl.tpnet.pl [83.8.206.218])
        by mx.google.com with ESMTPS id l12sm5522835fgb.6.2008.09.21.15.21.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 15:21:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0809202134p2457e0cdn50ae8183ba07bcde@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96443>

On Sun, 21 Sep 2008, Nguyen Thai Ngoc Duy wrote:
> On 9/21/08, Jakub Narebski <jnareb@gmail.com> wrote:
> > > +
> > > +#define CE_EXTENDED_FLAGS (0)
> > > +
> > > +/*
> > > + * Safeguard to avoid saving wrong flags:
> > > + *  - CE_EXTENDED2 won't get saved until its semantic is known
> > > + *  - Bits in 0x0000FFFF have been saved in ce_flags already
> > > + *  - Bits in 0x003F0000 are currently in-memory flags
> > > + */
> > > +#if CE_EXTENDED_FLAGS & 0x80CFFFFF
> > > +#error "CE_EXTENDED_FLAGS out of range"
> > > +#endif
> >
> >
> > I don't quite understand the above fragment (especially with the fact
> >  that CE_EXTENDED_FLAGS is defined as (0))...
> 
> Because this patch does not introduce any new on-disk flag yet so
> CE_EXTENDED_FLAGS remains 0. In the next patch, CE_EXTENDED_FLAGS will
> be updated to have CE_NO_CHECKOUT.

Well, now I understand CE_EXTENDED_FLAGS being (0).

What I still don't understand the pattern it is protected against.  
As I understand it if CE_EXTENDED_FLAGS & 0x0000FFFF it is bad,
because ce_flags saved flags are not extended flags, and 
CE_EXTENDED_FLAGS & 0x003F0000 are in-memory flags.  But why
CE_EXTENDED_FLAGS & 0x80C00000 is bad, and why (if I understand it)
CE_EXTENDED_FLAGS & 0x00300000 is not bad.

-- 
Jakub Narebski
Poland
