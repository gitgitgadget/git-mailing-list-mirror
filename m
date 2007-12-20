From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Thu, 20 Dec 2007 10:43:40 +0000
Message-ID: <57518fd10712200243o26641b3bjf9be3898a2f0c7e1@mail.gmail.com>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
	 <476962D5.3050409@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Dec 20 11:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Ism-0005oK-SJ
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 11:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbXLTKnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2007 05:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbXLTKnl
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 05:43:41 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:39569 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbXLTKnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 05:43:40 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2999070rvb.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 02:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=mmh7cMCZWAEjbHSOTIjZk74M82VIKoLOmwvf9QDdV4Q=;
        b=lRQ2VlhD1Y88S1K3atZfg9e0lZWAigE0t8UQ0KJ55Am4X34+k4I+fTRjUp0zGR2ju8vb0Vw6pyae1Bu/cKiKuP5z1q/PthsO4UFHIQP0Gb/167VYUL6qZmRsya8ZI67suZwAwrcykB3Lnw5Z41MHOQ61lIFtf/kNl+I5Bcp63W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=WjdOOCnEGRd9b19d3eqyzRCrRiiWTsNxO5MqiQKlA+q4PkdgPnn0m/FC1mZk/WddjsX/UD1M6IJa90VfDvwg3dgWUh493vb1EkBhMUsn1FHf/Y//FpXE/CIfdZWAoSKNH8obAdaTpXP0lrc/DywMKhRmFdhnUA91PVmKijmhqCM=
Received: by 10.140.201.1 with SMTP id y1mr379850rvf.246.1198147420205;
        Thu, 20 Dec 2007 02:43:40 -0800 (PST)
Received: by 10.140.134.14 with HTTP; Thu, 20 Dec 2007 02:43:40 -0800 (PST)
In-Reply-To: <476962D5.3050409@lsrfire.ath.cx>
Content-Disposition: inline
X-Google-Sender-Auth: 3178117899bf8a96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68988>

On Dec 19, 2007 6:28 PM, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> w=
rote:
> That's strange.  Could you check if this happens with e52a5de, too?
> That's the commit that introduced --pretty=3Dformat.  If it doesn't, =
could
> you then please try to bisect the bug?

As far as I can tell, e52a... never compiled - it's missing prefixcmp
from git-compat-util.h, which doesn't get merged in till 8ab3e18.
And yes, I still get junk output from that build.  (Shame, I was
looking forward to trying out the bisect tool...)


> How many '<unknown>' markers are there in the output of version 1.5.3=
=2E7
> (and e52a5de)?  One per %b?  Are they the only output or are they
> combined with parts of unrelated commits, too?

Only one per %b, and where they appear, they're the only output.
However, even with those builds, I get junk output in addition to the
<unknown> markers.
That is, with a format string of "**%b**", there are three possible out=
puts :
The correct one -  eg **Added test for NSDictionary generator**
The unknown one - eg  **<unknown>**
The complete junk one -  eg **n del
Strothereb0d794bacc1761e8a0681e9b144c514702d9b7a**

The latter's 'body' is almost always terminated by an unprintable
character, which always seems to be 03.


Hmmm.   I wonder if it's coincidence that I can only seem to spot this
problem in my repos that have been set up via submodule init...
