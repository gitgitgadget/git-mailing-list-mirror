From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Sat, 29 Mar 2008 10:02:43 +0100
Message-ID: <200803291002.43768.robin.rosenberg.lists@dewire.com>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803290941.54091.robin.rosenberg.lists@dewire.com> <20080329084947.GB19200@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 29 10:04:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfWz5-0000NL-5L
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 10:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYC2JDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 05:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbYC2JDh
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 05:03:37 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27438 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbYC2JDg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 05:03:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 031638026E9;
	Sat, 29 Mar 2008 10:03:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GLf5KDKyQhfK; Sat, 29 Mar 2008 10:03:33 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id C656D802679;
	Sat, 29 Mar 2008 10:03:33 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080329084947.GB19200@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78458>

Den Saturday 29 March 2008 09.49.48 skrev Jeff King:
> On Sat, Mar 29, 2008 at 09:41:53AM +0100, Robin Rosenberg wrote:
> > > OK. Do you have an example function that guesses with high probability
> > > whether a string is utf-8? If there are non-ascii characters but we
> > > _don't_ guess utf-8, what should we do?
> >
> > Any test for valid UTF-8 will do that with a very high probability. The
> > perl UTF-8 "api" is a mess. I couldn't find such a routine!?. Calling
> > decode/encode and see if you get the original string works, but that is
> > too clumsy, IMHO.
>
> Does that work? I would think you would have to compare the normalized
> versions of each string, since decode(encode($x)) is not, AIUI,
> guaranteed to produce $x.

I don't claim to understand it either. Hopefully some perl guru will step 
forward and just explain how to do this in perl.

My proof is entirely empirical. What happens is that attempting to decode a 
non-UTF-8 string will put a unicode surrogate pair into the (now Unicode) 
string and encoding will just encode the surrogate pair into UTF-8 and not 
the original. As a result, the encode(decode($x)) eq $x *only* if $x is a
valid UTF-8 octet sequence. Why would you not get the original back if
you start with valid UTF-8?

-- robin
