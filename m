From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH 4/4] git-imap-send: Add method to convert from LF to CRLF
Date: Thu, 11 Feb 2010 23:38:13 +0900
Message-ID: <4B741655.6090107@dcl.info.waseda.ac.jp>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org> <1265717345-2118-5-git-send-email-mitake@dcl.info.waseda.ac.jp> <alpine.LFD.2.00.1002090918180.3829@localhost.localdomain> <7vbpfye0e5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 15:38:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaBQ-0007uZ-Sf
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572Ab0BKOiQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:38:16 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:64042 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab0BKOiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:38:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 28FA2EAF5CF;
	Thu, 11 Feb 2010 23:38:14 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Od-9X24CXJBM; Thu, 11 Feb 2010 23:38:13 +0900 (JST)
Received: from [192.168.11.2] (FL1-122-130-141-251.tky.mesh.ad.jp [122.130.141.251])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id BC951EAF5CB;
	Thu, 11 Feb 2010 23:38:13 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vbpfye0e5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139593>

(2010=E5=B9=B402=E6=9C=8810=E6=97=A5 03:20), Junio C Hamano wrote:
> Linus Torvalds<torvalds@linux-foundation.org>  writes:
>
>> So I suspect that CRLF should be unconditional.
>
> That matches my reading of the RFC.  Thanks.

OK. I'll make converting LF to CRLF default behaviour.

>
> Hitoshi, can we have a modified version of 4/4 as a separate patch, s=
o
> that we can apply it independently from the rest of the series?

Yeah, but as I describe below, I'll rewrite
my patch series and these only has 2 parts.

>
> As to the MD5 implementation, I am somewhat torn.
>
> Even if your md5 implementation were vastly superiour and faster than
> OpenSSL one (I don't know), the use of MD5 is not performance critica=
l
> like SHA-1 is (for which we uniformly use Linus's block SHA-1 these d=
ays);
> the only thing it would be buying us to have our own implementation i=
s one
> less dependency for people who do want to use imap-send with CRAM-MD5=
 but
> without SSL support.  How common is that combination?

Yes, using OpenSSL's md5 is better implementation.
But git-imap-send.c also asuumes non existence of OpenSSL.

And in theory, CRAM-MD5 and STARTTLS are independent things.
So I import MD5 things from libsylph.
But, as you told, CRAM-MD5 without STARTTLS
is not so common situation.
If you permit, I'd like to use MD5 functions of OpenSSL.

It seems that OpenSSL also provides base64 stuffs,
so I will be able to reduce patch series into 2 part.

I'll send these later. Please discard my previous series.
