From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Sat, 7 Feb 2009 09:34:48 +0100
Message-ID: <200902070934.50555.jnareb@gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de> <200902061149.16210.jnareb@gmail.com> <7vd4duzo07.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 09:35:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LViex-0007tH-2X
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 09:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbZBGId7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 03:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbZBGId7
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 03:33:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:48906 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbZBGId7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 03:33:59 -0500
Received: by fg-out-1718.google.com with SMTP id 16so698553fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 00:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AF/zh/9dnMbpD1pELCFKwEbiOfc0s++Xr80baQYoKgs=;
        b=DDvYgP/pZC1BrBg6avhsYkMFyYSxvXHg0M/RVB7jIVIT6Z87i3Kn1gRlnWtjMk2scr
         mMi2zoYRu0AlgY2vyFvyEp0eXX4OjKXkNRjX2z9W57SU1BcC+oenAznZnfyLJmPpfGo8
         fbJR9QS5B79I9R7UAStjqdZz49Nb++naD7+9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kLMEWSM6w1MOXyeFolJcO82Qbuzn9ZyrVHykzySEJ7k9B8XN0QUdTNAxulj20kXL+/
         +vJorrd+GZdyiGjyOKtknAXi/9L4x+4fOGsgHuAytr3sszSPzQirtrzFfvVjZ2DDeqIa
         k2vTUVpyLxUD/Inrhh+VC6R0vpJ3SAKo0Pi04=
Received: by 10.223.113.3 with SMTP id y3mr2124442fap.71.1233995637124;
        Sat, 07 Feb 2009 00:33:57 -0800 (PST)
Received: from ?192.168.1.13? (abwn77.neoplus.adsl.tpnet.pl [83.8.237.77])
        by mx.google.com with ESMTPS id p9sm563561fkb.1.2009.02.07.00.33.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 00:33:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vd4duzo07.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108830>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Make SHA-1 regexp to be turned into hyperlink (SHA-1 committag)
> > to match word boundary at beginning and end.  This way we limit
> > false matches, for example 0x74a5cd01 which is hex decimal (for
> > example memory address) but not SHA-1.
> >
> > Also make sure that it is not Message-ID, which fragment just
> > looks like SHA-1 (e.g. "Message-ID: <46A0F335@example.com>"),
> > by using zero-width negative look-ahead assertion to _not_
> > match '@' after.
> 
> Your message I am responding to is:
> 
>     Message-ID: <200902061149.16210.jnareb@gmail.com>
> 
> Does your description mean that "200902061149" would match, because the
> LAA will say "Ah, dot is not an at-sign"?

It would unfortunately falsely match... but we cannot eliminate this
case (well, at least not checking if hexnumber is followed by dot),
because of totally legitimate

   ... at commit 8457bb9e.

So even with that we would have still false matches...
-- 
Jakub Narebski
Poland
