From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 14:30:20 -0500
Message-ID: <32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com> 
	<20100113135753.GA7095@Knoppix> <20100113141218.GA17687@inner.home.ulmdo.de> 
	<20100113144745.GA7246@Knoppix> <20100113161711.GB17687@inner.home.ulmdo.de> 
	<20100113173610.GA7609@Knoppix> <20100113183520.GA23674@inner.home.ulmdo.de> 
	<20100113191802.GA8110@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:30:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV8vW-0003DO-MF
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab0AMTal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191Ab0AMTal
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:30:41 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:41682 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab0AMTak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:30:40 -0500
Received: by iwn35 with SMTP id 35so16633935iwn.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 11:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=uXH5/BIRAtQHx6P0ph0p2qHPkJZySXDIvEq2efSlJx8=;
        b=bJRcYnC4JCGTMkZbR1vFYJ09B9wRIn5rUvsAxTCqb4lahjjpp6TAQLPhniDEfu60/h
         MdIhgSg6Aa/idghFDIgscr0nTRggZ8q5i6fwILkKipfr8PuklMSKNs4TtAcMfLD5VlAQ
         7U5QTdy5+20Yvw2+ag7UG/ss0WAWlbcQ7zjSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Udw4T6LPj4nkpjD7ppFNWGhAibLjz8ud9zcwBy0etHm/I42n5O2GqAyxFfd/Ek7jw1
         ywv3LQt0Gu5TAhg6e0aad7KwAl8KuUTZBUjtCVLg1ugUdEjSSR6+aP2PuGrVjF9uPkWK
         z9IUnLD/YvmYAmBs0JqZht03/BwgHyyDt4jNc=
Received: by 10.231.40.216 with SMTP id l24mr1763918ibe.40.1263411040074; Wed, 
	13 Jan 2010 11:30:40 -0800 (PST)
In-Reply-To: <20100113191802.GA8110@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136861>

On Wed, Jan 13, 2010 at 2:18 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
>> Please consider my objections revoked, other than the claim that
>> it could be done with stunnel, however ugly that would be.
>
> Only if you don't care about complexity introducing PKI would bring
> (yes, I read those manuals).

I think you're overstating the situation a bit here.  You can use
X.509 certificates without setting up a full PKI.  Basically, an X.509
cert is just a public key with some extra crud thrown into the data
file.  You could validate it using a PKI, but you could also validate
it by checking the verbatim public key just like ssh does.  It's not
elegant, but it works, and it's a worldwide standard.

(I don't know if stunnel does this type of validation... but *I've*
done this with the openssl libraries, so I know it can be done.)

>> Of course, you have another problem in that case...also I'd personally
>> like to rely on ssl client certificates when using https.
>
> And how many (relative) use client ceritificates with SSL? Keypairs with SSH?
> Why you think this is?

At least hundreds of thousands of people, including non-technical
people, use X.509 client certificates and SSL in various big
industries with high security requirements.  That's why every major
web browser supports them.  In contrast, ssh is only ever used by
techies, and there are fewer of those.  Of course, as techies our
informal observations might lead us to believe otherwise.

Furthermore, how many people who really want ssh-style keypairs (and
thus refuse to use X.509 and PKI) can't just use ssh as their git
transport?  I don't actually understand what the goal is here.

Have fun,

Avery
