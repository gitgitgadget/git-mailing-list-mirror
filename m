From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Excessive mmap [was Git server eats all memory]
Date: Tue, 10 Aug 2010 01:28:17 +0400
Message-ID: <AANLkTinx+NXMBY3K-KGtHQA1=pdz66o5bRgeG8U_Kyd7@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
	<87hbj74pve.fsf@kanis.fr>
	<AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
	<wesy6cgm6wd.fsf_-_@kanis.fr>
	<AANLkTi=6JcwLuyNWq9oYzE_E+7DSn-sEvR-X3AHvXM6U@mail.gmail.com>
	<westyn3n3sa.fsf@kanis.fr>
	<AANLkTiktriuvciNTNPD4941AG3th6rWwUYT4v_UnaAz3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, jnareb@gmail.com, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 23:28:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiZtP-0001j6-UO
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 23:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393Ab0HIV2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 17:28:19 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54319 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab0HIV2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 17:28:18 -0400
Received: by qyk7 with SMTP id 7so2603187qyk.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2Nponyj95du7e8XryAkY2LAUp51aHIM0EwXRgxspxMY=;
        b=MFyiaCEdWnbpsTG2FEK0DIWNYdekLMCyeNDt998usYcmfouojtqLc5bydzAtJZzPZK
         5wJAXrJT5zk+bs1WPzco09NXkplDNHGyt0fhe9aM+Dz6JCFurR0l1lsjhVUNJlF2UoSY
         j+zfTqeCqdLSmbjTDwj5lXMSyymFiKOXDc9EU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RIJPJDvzr8Jlhfp1JivEyGa0JhwwBRQAP49r07iGlDgtxFW/dANH96wWwbrAhNx1TC
         8o4Jz7pPczzeM4OruHHg0FaRdXEn8WnBqVLQN7EJmk6RiZkv3nIHil45I+YkSMBfgYTN
         fS/4WPJLuq5ZgomcIcbVlcF/SvV1XJ+qQMDBw=
Received: by 10.224.72.205 with SMTP id n13mr8990352qaj.286.1281389297859; 
	Mon, 09 Aug 2010 14:28:17 -0700 (PDT)
Received: by 10.229.251.3 with HTTP; Mon, 9 Aug 2010 14:28:17 -0700 (PDT)
In-Reply-To: <AANLkTiktriuvciNTNPD4941AG3th6rWwUYT4v_UnaAz3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153030>

On Mon, Aug 09, 2010 at 12:50:30PM -0400, Avery Pennarun wrote:
>
> On the other hand, perhaps a more important question is: why does git
> feel like it needs to generate entirely new packs for each person
> doing a clone on your system? =A0Shouldn't it be reusing existing one=
s
> and just streaming them straight out to the recipient?

Git cannot send the whole pack, in general, because it sends only those
objects that are requested by the client. So, except the initial clonin=
g,
it is never the whole pack. Moreover, even during the initial cloning,
it may not be the whole, but only visible objects from it. So, git has
to generate a new pack for every clone operation. But the generated pac=
k
should reuse deltas from the initial pack, so it should not a very
expensive operation.


Dmitry
