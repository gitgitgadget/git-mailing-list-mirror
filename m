From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] make pack-objects a bit more resilient to repo corruption
Date: Fri, 22 Oct 2010 13:50:01 -0700
Message-ID: <AANLkTimy-ihrF1syWYe3T4W6-UHzCaj5Jud5rdFmv3D5@mail.gmail.com>
References: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
 <20101022144600.GA5554@sigill.intra.peff.net> <alpine.LFD.2.00.1010221427390.2764@xanadu.home>
 <alpine.LFD.2.00.1010221606550.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 22:50:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9OZJ-0007mc-Ik
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 22:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab0JVUuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 16:50:23 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35194 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0JVUuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 16:50:22 -0400
Received: by gwj21 with SMTP id 21so1446316gwj.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 13:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Fw8t9nY59L/B4jNsFfEfSLeECoSbqVsSnpSrCgnyuQs=;
        b=MIVOh0yowEwWs2QEWib3EiM7cTcFfvc8cRQqex1kmkDBkHPBcrSn5MpLtR03opqIZB
         Glu9DOdVVtO+jRjyCQSGiM9zOed0PpewIp/JJOdN0edxU5RFqmDbEsxisAs+gXM7YN2p
         3T6chwMKOrs3IPArvh8irktM/B4BOo/Z6ZC1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nnAJM3eUNWrwWpqCoQ5d0ZyThoFjc/RuKMZfRX15YPVOZCfxHkuY/zWFOuEQdrAV+W
         U6BhXrU7UG5vsw+zkB3Yl+nAfaOvu5K17HSS1H8MsXyNyQSc+ZTYCWueKsjWByA8QmS/
         ftlF5yvVkFPrgy8OxY1mForORJVvzjHjDfzxw=
Received: by 10.151.111.1 with SMTP id o1mr3405941ybm.376.1287780621925; Fri,
 22 Oct 2010 13:50:21 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 22 Oct 2010 13:50:01 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010221606550.2764@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159747>

SGV5YSwKCk9uIEZyaSwgT2N0IDIyLCAyMDEwIGF0IDEzOjI2LCBOaWNvbGFzIFBpdHJlIDxuaWNv
QGZsdXhuaWMubmV0PiB3cm90ZToKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHN0YXRpYyBpbnQgd2FybmVkID0gMDsKPiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICghd2FybmVkKyspCj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB3YXJuaW5nKCJv
YmplY3QgJXMgY2Fubm90IGJlIHJlYWQiLAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2hhMV90b19oZXgoc3Jj
X2VudHJ5LT5pZHguc2hhMSkpOwoKSG93IGRvZXMgdGhpcyBoYW5kbGUgbXVsdGlwbGUgbWlzc2lu
ZyBvYmplY3RzPyBXaWxsIGl0IG9ubHkgd2FybiBmb3IKdGhlIGZpcnN0IG9uZT8KCi0tIApDaGVl
cnMsCgpTdmVycmUgUmFiYmVsaWVyCg==
