From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Tue, 17 Jun 2008 00:34:41 +0200
Message-ID: <200806170034.42621.jnareb@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <200806161843.09372.jnareb@gmail.com> <4856DFE8.9010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 00:35:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8NIn-0006yh-Lo
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 00:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575AbYFPWe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 18:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758565AbYFPWe6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 18:34:58 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:12470 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758477AbYFPWe4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2008 18:34:56 -0400
Received: by yw-out-2324.google.com with SMTP id 9so3247791ywe.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lxCskBXi5fcGd7bb6mtxldsk/eir/CANzMgG5O2MHgw=;
        b=jveTo2PvfVTFkuffN/ZLWcvL0TRRpP5u0c1OMngIsP+xLllOtCS4dPQlfYBmFXLdkr
         Io/V8S7udn3cIZBLxCuvqbbFeyTvASOF/JueRLoR5HCsmw8ZXo26gMcRuOe28SMTwOMH
         WmdCmM9bbqonktWMY6i7F5QRpFOZHwcO2hfnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WJsUFsskJysdSyyhYWOAozd4BAVgNntsC8SINWLZeXi2KOfldW4i1W3j1+OlZ1PPHC
         vpWHLcSPmrJpnC2pedr+djWIJsoveR/Py5Hvvzg27f7nlJlTQm/8YHH7HFB25sRPM7jC
         Bick+OqtX96dtrTG3LSPh0MVwJzxFKXHElR18=
Received: by 10.150.79.22 with SMTP id c22mr11557286ybb.160.1213655690601;
        Mon, 16 Jun 2008 15:34:50 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.236.117])
        by mx.google.com with ESMTPS id k29sm1514318qba.7.2008.06.16.15.34.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 15:34:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4856DFE8.9010809@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85243>

On Mon, 16 Jun 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
>>
>> Well, we could, perhaps, examine stderr (or redirect it to stdout and
>> examine upon error) to check what was the error.
> 
> We don't have to -- gitweb's current (suboptimal) error checking is 
> because it doesn't interface with git very well.

The "examine stderr" was a bit tongue-in-cheek, i.e. solution which
would require least changes... but I guess very impractical.

> The API I'm writing  
> will fix this (i.e. provide proper feedback in all cases) so we'll have 
> more specific status codes.  IOW, we'll be able to differentiate between 
> 500 and 404.  Trust me on this one. ;-)

I have thought that Git.pm API together with catching (and examining)
Error, perhaps with redirecting STDERR somewhere (but it would be best
if it would not be needed) would be enough.

>> But I think in all, or almost all cases, the source is wrong parameters
>> in URL.  Now, returning 5xx _server_ error would make me want to email
>> webmaster about error on his/her server, while 4xx _user_ error would
>> make me examine my input
> 
> Since the status codes will get better (more accurate) anyway, I care 
> more about correctness than practicalities right now (and I'm convinced 
> that only 500 is correct in the cases we're talking about).  That said, 
> if you really want 404s in there, go ahead and send a follow-up patch, I 
> won't object.

If the source of error is some misconfiguration on server, then 5xx is
appropriate (for example git binary is not found, something which
perhaps we should check upfront at the beginning).  But I think it
should be very, very rare, and result of misconfigured gitweb, or error
installing git... or corrupted repository.

If source of error is mistake in URL, I would certainly want 4xx error.
So the user knows that he/she has to look at the URL.

That said, perhaps I am worrying over nothing, and
  or die_error(undef, "Open <git command> failed");
can happen only on some serious server error (like corrupted
repository).


>From RFC 2616 (http://tools.ietf.org/html/rfc2616)

 10.4 Client Error 4xx

   The 4xx class of status code is intended for cases in which the
   client seems to have erred.

 [...]

 10.5 Server Error 5xx

   Response status codes beginning with the digit "5" indicate cases in
   which the server is aware that it has erred or is incapable of
   performing the request.
 
>> BTW. I got three copies of this email: was it you fighting VGER
>> anti-spam filter?
> 
> Yup.  Apparently it simply greps for Content-TypXe: text/hXtml.  *shakes 
> head* :-)

It is unfortunately very simple pattern based filter, not Markovian,
spam/ham Bayesian, or even simple Bayesian.

-- 
Jakub Narebski
Poland
