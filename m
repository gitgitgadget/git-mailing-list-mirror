From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Wed, 4 Apr 2007 23:27:49 +0200
Message-ID: <200704042327.49632.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <7vmz1t6oe2.fsf@assigned-by-dhcp.cox.net> <200704031657.25698.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 01:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZEhR-0003Sf-3o
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 01:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbXDDXOk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 19:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbXDDXOi
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 19:14:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:30891 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbXDDXOf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 19:14:35 -0400
Received: by ug-out-1314.google.com with SMTP id 44so836577uga
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 16:14:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=U7BKOYqnEByLbWQcMXkMaLnhUpIhPNnN3GkG/5yj5lf370f67Hj7aMOAqS+N7aFFp8GGMBvsWmw2anbuNnfU3KiigFwAKQV1TaxlWVIXOthohHcXlyNbDdCndmuZkqQOub8muKWKar2RHHSNn3z5YftzgEymUTQbW7ah0BprINY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=diEwSgRTsNd+iejrggeZozv4cBKKtKZ2lMcnuXI0U6pNp5WpLf2OvkV6ypmuaheK1BgLfMPZFvbjRowSCSr13uuUKeT1z1utUvtUg7X2Rh5bWlMQ83MPF9NRmIuo69YvGS0khjIZRroFmAVY3osBq6o9f6puADFkW+VjK1BAbTc=
Received: by 10.66.221.6 with SMTP id t6mr1735138ugg.1175728474421;
        Wed, 04 Apr 2007 16:14:34 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w5sm2670402mue.2007.04.04.16.14.32;
        Wed, 04 Apr 2007 16:14:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200704031657.25698.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43789>

On Tue, Apr 03, 2007 at 16:57 +0200, Jakub Narebski wrote:
> On Sun, Apr 1, 2007, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>>> First is not escaped filename in HTTP header. There was some discussion
>>>> about this, and even patch by Luben Tuikov which added to_qtext 
>>>> subroutine to deal with escaping in HTTP [...]
>>>
>>> Junio, do you remember by chance why this patch was dropped?
>> 
>> No, but I suspect that was because the noisiness of the thread
>> around them suggested they were not ready to be applied.  I do
>> not remember if people submitted the patch and commented on
>> reached a consensus.
> 
> Probably not. Here is alternative proposal. It does not implement
>   RFC2184: MIME Parameter Value and Encoded Word Extensions
> but I'm not sure if 1) it is needed for _HTTP_ Content-Disposition
> header filename, 2) all browsers implement it.

[...]
> P.P.S. Here is an example of RFC2184 encoded header:
> 
>    Content-Type: application/x-stuff
>     title*1*=us-ascii'en'This%20is%20even%20more%20
>     title*2*=%2A%2A%2Afun%2A%2A%2A%20
>     title*3="isn't it!"

Another example:

  Content-Type: text/plain; charset=utf-8\r
  Content-Disposition: inline; filename*=utf-8'en-US'This%20is%0A%20%2A%2A%2Afun%2A%2A%2A


Although "RFC 2183: The Content-Disposition Header Field" says:

  Parameter values longer than 78 characters, or which contain non-ASCII
  characters, MUST be encoded as specified in [RFC 2184].

the limit of 78 characters is because it is was created for mail, and
some old MUA had limit on line length. It is not the case of HTTP
protocol: lines can be, and are, quite long. Besides for example
Apache 2.0.54 does not understand MUA-style continued HTTP headers
if in 'parse headers' mode: it returns server error.

As to browsers: Mozilla 1.7.12 implements RFC2183 correctly, although for
example shows %0A / \n as a strange symbol in "save as" dialog, created
file has embedded newline in filename, as it should. But both Lynx 2.8.5,
and ELinks 0.10.3 do not implement it fully and without errors.

So that is why we have:

	# It not worth potential problems to try to carry newlines
	# in the header; it is just _suggested_ filename
	$filename =~ s/[[:cntrl:]\n\r]/_/g;


P.S. If there were no objections (no discussion), I'd resend
content_disposition subroutine as patch to gitweb in about a week.

-- 
Jakub Narebski
ShadeHawk on #git
Poland
