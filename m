From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 7/7] t7006-pager: if stdout is not a terminal, make
 a new one
Date: Fri, 19 Feb 2010 18:39:51 -0600
Message-ID: <20100220003950.GA18550@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
 <20100219072331.GG29916@progeny.tock>
 <20100219080819.GA13691@coredump.intra.peff.net>
 <20100219081947.GA12975@progeny.tock>
 <20100219083440.GC13691@coredump.intra.peff.net>
 <28d--OB9y5MtIy1nJel2Km6d5sqJ3yX6fVUhecDU5ehJUYJmZlE0-A@cipher.nrlssc.navy.mil>
 <setkR9a6yaRMOU11ekUmlY6ty8nNSPCcidBKotdDxpQsZLCxc54hKw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 01:39:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NidNm-00016k-WE
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 01:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab0BTAjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 19:39:37 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:48271 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab0BTAjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 19:39:36 -0500
Received: by gxk9 with SMTP id 9so766222gxk.8
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 16:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KCDg3q04mZC8uqQW3ZFWipAo42Gn4TKUCcrp/MElyQU=;
        b=OdI7KkVBllv5ur46QociE2AMZAdLM8Fdc1E4bDmlbvS51ypjg+9Bqq79aa4rtJvrg6
         sf/9ZXsUxGDpfifzVgpI3ZTE8qhP0Rrj3HUfTj5zQ5pV3vkdipg+jlU2ZWsHUDE1Vvx0
         PtJMQTCeA4bE5wxbQI0Kk3OF4vQpUr3rHAlGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=l4Dgln7kffXcZklFvVJ+sSQTE7BbcPeuExYEhP3tiK7hEWcytrKRBqMfWO5EUAVCMr
         Xthh5l49+0RizXNvXGHQAN0OQAeB1sKckXMPTAmul6gyXZ2ABRrKe9DPSDseT2uTp/M3
         QzxS96JBH/VWLkfBRsJ1MGezufufoUSAY086c=
Received: by 10.100.56.21 with SMTP id e21mr1443768ana.23.1266626376096;
        Fri, 19 Feb 2010 16:39:36 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 35sm309034yxh.69.2010.02.19.16.39.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Feb 2010 16:39:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <setkR9a6yaRMOU11ekUmlY6ty8nNSPCcidBKotdDxpQsZLCxc54hKw@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140509>

Brandon Casey wrote:
>>> On Fri, Feb 19, 2010 at 02:19:47AM -0600, Jonathan Nieder wrote:

>>>> Hmm, how about /dev/ptmx?  (One can check by replacing posix_openp=
t(...)
>>>> with open("/dev/ptmx", ...) in the test-terminal.c I sent.)
>=20
> Didn't work on Solaris 7.  I applied your series on top of master wit=
h the
> change you described.  Here's the diff:
[...]
> Here's the result of the terminal test:
>=20
>   # ./test-terminal sh -c "test -t 1"
>   # echo $?
>   1
[...]
>
> And here's the output of t7006-pager:
> *** t7006-pager.sh ***
> *   ok 1: set up terminal for tests
> * no usable terminal, so skipping some tests

Thanks for trying it out.  That=E2=80=99s an excellent outcome: it mean=
s that
test-terminal compiled without trouble with no makefile magic.  It
does seem strange to me that there was no error message.  Is
sh -c "test -t 1" false for an ordinary terminal?

Jonathan
