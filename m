From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: fetch and bundle don't work in (semi-)broken repo
Date: Tue, 19 Oct 2010 16:02:33 -0500
Message-ID: <20101019210233.GA32029@burratino>
References: <20101019160957.GK11713@pengutronix.de>
 <20101019183925.GF25139@burratino>
 <20101019201139.GB28166@pengutronix.de>
 <alpine.LFD.2.00.1010191635030.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 19 23:06:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8JO6-0005dy-Nd
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 23:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757688Ab0JSVGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 17:06:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50460 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990Ab0JSVGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 17:06:16 -0400
Received: by gwaa12 with SMTP id a12so88114gwa.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AcBREh1Ex5GtLWyN7p0uFDrhdtvRsAvTbJPp2xZj+qM=;
        b=oHveuqUnrXHMked+N6u4z4aymXnzvTCSDKSfNjB3iXsA1AXsUvdCh1ClL9Koe8g0Hd
         Sv+v5Ei3Czh7KEIuMP+oh8kclBegXEn5bhB9l8MMwa0/qKwN3tgO9SRdRffQTOF+HjRq
         X47tfmZHi3RaMmb+7Zf3lgccGW2XM9HxWTel4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NZmPOUVEuaRZkvSb55AYkwTZiVt8CBAm/6YG1vRiSv0ddZRwh6L2v+S9XmyWeB7eTi
         O3puPBWTj8Mj8M5hSyOH7/zWZ6rC5XYpDcAC9tsvBmiy7BSv5UtuqibXnSBebOQX6nOX
         yH/wXMu5rtPbDGM1r7F8CNTJiOZL4vpZiSfbc=
Received: by 10.151.47.17 with SMTP id z17mr5324732ybj.422.1287522376147;
        Tue, 19 Oct 2010 14:06:16 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i9sm13963565yha.42.2010.10.19.14.06.14
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 14:06:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010191635030.2764@xanadu.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159367>

Hi,

[out of order for convenience]
Nicolas Pitre wrote:
> On Tue, 19 Oct 2010, Uwe Kleine-K=C3=B6nig wrote:

>> and I'm running git-fsck --full now over night as it's bedtime here.
>
> Given that you exploded your repo into loose objects, it'll take _tim=
e_.

Yep, I gave bad advice. :(  Especially because I forgot that a fsck
would be useful at all.

Better advice would be:

 1. Use "git rev-list --objects" to find out what 40aaeb204dc was.

And if that doesn't work:

 2. Run "git fsck", with packs intact.  This will take a while.  The
    result would include a list of missing objects (like 40aaeb204dc),
    and, most importantly, their type.

=46ollowing howto/recover-corrupted-blob-object.txt would be useful for
identifying a corrupt loose object, but iiuc no corrupt objects are
involved here, anyway.

>                                 But ideally you should simply find a=20
> pack that contains the problematic object in another repository and c=
opy=20
> it with its index=20
> file into the broken repository.

I assume the object is gone for good, but if you have it in another
repo that would be interesting, too.

To be clear: I think the important data has been recovered from the
broken repo already in the form of patches (right?) so the question
at hand is whether it would be possible to teach git to do better at
recovering automatically.  Which might depend on the nature of the
missing objects.

Ciao,
Jonathan
