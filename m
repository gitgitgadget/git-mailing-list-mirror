From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Wed, 10 Apr 2013 23:30:59 +0200
Message-ID: <5165DA13.8010100@gmail.com>
References: <20130409054553.GA1537@mteis.lan> <20130409171247.GD21972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Magnus Therning <magnus@therning.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:31:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2c5-0008Ju-TL
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936828Ab3DJVbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 17:31:06 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:33594 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759732Ab3DJVbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:31:04 -0400
Received: by mail-ee0-f50.google.com with SMTP id e53so462693eek.37
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=cBcm6rVtsNhQQICbbkH11SgdeUczWagvsLukiblfIrU=;
        b=l7XSH6Enmi7XpUYOuAcSIMOUYVKVVIKRECtaoSUhEVUXpLgpvzcDWPe1dydWS36awu
         QfifEPDgHEo1sTFeG67UcjtQYQiAsNKhjH9Pva3KBgsmuItrlIzDMRDqMHsixcJxYydt
         832kelAR8fvKVwTTvJ7FEND4UMSdmpwI/NyPpK+ndBL9yEg1Byw5hXec0RrvHRmPUjNX
         LHpT1U/B0ELkS3+ZWAjc0HC21nuSlPwSC3kkcnKpgE0i1C1r/BV5kFP1lDOF/cUP8C/j
         mIKukP+ODks9zp9rxP2AcXoMbS3oPZrRU2ggcNByY1ED/HdQz1aIfCWholm6WuiFrIUW
         tChw==
X-Received: by 10.14.87.199 with SMTP id y47mr9695508eee.17.1365629462844;
        Wed, 10 Apr 2013 14:31:02 -0700 (PDT)
Received: from [192.168.1.14] (edx151.neoplus.adsl.tpnet.pl. [83.21.9.151])
        by mx.google.com with ESMTPS id bj2sm2184243eeb.1.2013.04.10.14.31.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 14:31:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130409171247.GD21972@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220776>

Jeff King wrote:
> On Tue, Apr 09, 2013 at 07:45:53AM +0200, Magnus Therning wrote:

>>     % git push=20
>>     error: The requested URL returned error: 403 Forbidden while acc=
essing
>>
http://magnus@tracsrv.local/git/foo.git/info/refs?service=3Dgit-receive=
-pack
>=20
> Something in your config is blocking access to info/refs there. It
> should not be the block shown above, which handles only the actual PO=
ST
> of the data. The sequence of http requests made is:
>=20
>   1. GET $repo/info/refs?service=3Dgit-receive-pack
>=20
>      This makes initial contact and gets the ref information which pu=
sh
>      uses to decide what it is going to push. So it is read-only, and=
 in
>      an anonymous-read setup, does not need to be protected.

Yes, it doesn't need to be protected, but *git-receive-pack* requires
(or required) valid user even for above GET request for getting refs.

>   2. POST $repo/git-receive-pack
>=20
>      This actually pushes up the objects and updates the refs, and
>      must be protected.
>=20
> The setup listed above does work with apache; it is tested as part of
> our test suite (you can see the actual config in t/lib-httpd/apache.c=
onf).
> So what in lighttpd is giving us the 403? Can you share your whole
> config?

I think I have seen a patch on git mailing list to correct this, but
I am not sure.

Are you sure that we test this correctly?

--=20
Jakub Nar=C4=99bski
