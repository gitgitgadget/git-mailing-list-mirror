From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: Re: [PATCH v2] Windows: improve performance by avoiding a static 
	dependency on ws2_32.dll and advapi32.dll
Date: Thu, 28 Jan 2010 13:18:56 +0300
Message-ID: <63cde7731001280218g29a63094od4f5a8135c6986a4@mail.gmail.com>
References: <1264666525-4956-1-git-send-email-michael.lukashov@gmail.com>
	 <4B61543F.6020904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 28 11:25:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaRYb-0007NM-2C
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 11:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab0A1KY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 05:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791Ab0A1KYz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 05:24:55 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:54427 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab0A1KYy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 05:24:54 -0500
Received: by ewy19 with SMTP id 19so559881ewy.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 02:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=6jWgTV2XyyAzuDmPI0BlpVlh5mc/qZ1z6h42A0ywamc=;
        b=CvgGxInc54uL+exP63n8DIeT8O3DKtg9ZPA+xiDzktm73Y1HGQkM4Wz8I6puezMKPD
         t42B2VadIdZAd3MT1ju6UX4+6M1LuEWqre/Z2ymYbrvwuzgtJkwUly2vKNvPf2m263MJ
         iGrrh18C8VI3S/XW3xDShcf/PmD97MkktWUPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Fl6yzXQ8hcFKDvMrwiJWA+AG/3c1l03fytS4BMd+W9nx9hFOiv8SdHtAhjLX45aEQb
         OaWbPTOVXtdap1n9l//TlCyUAyQKQmr90o1wEaa+5D84fRjH8TlkYWTiTZmxmbmvV3tF
         J++jzGSBJDjzA7H4ELU0a+0/O3qq2z2YIm7lY=
Received: by 10.216.91.15 with SMTP id g15mr1911288wef.24.1264673936906; Thu, 
	28 Jan 2010 02:18:56 -0800 (PST)
In-Reply-To: <4B61543F.6020904@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138242>

> Thanks. Due to the size of the change, I would acknowledge it only if you
> have a proof that the reduced startup costs are noticable, for example, by
> running the test suite.
>
> What's the deal with bswap? Isn't it an unrelated change? It needs some
> better justification. It is unobvious because it is not straight-forward
> "use pointer to function that was looked up instead of function".
>
> Will the result not break the MSVC build?
>
> -- Hannes
>

"git status" calls ntohs function, which was loaded from ws2_32.dll
I've noticed that bswap.h contains implementation of ntohl htonl functions,
so I decided to add implementation of ntohs htons functions, which is
pretty trivial.
After that call to "git status" doesn't load ws2_32.dll
