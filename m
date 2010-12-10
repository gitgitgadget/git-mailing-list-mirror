From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 12/18] gitweb: Change file handles (in caching) to lexical variables as opposed to globs
Date: Fri, 10 Dec 2010 01:47:19 +0100
Message-ID: <201012100147.20747.jnareb@gmail.com>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <m3d3pa1o0j.fsf@localhost.localdomain> <7vwrnieac8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:47:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQr93-00017r-PU
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593Ab0LJAr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 19:47:28 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:51554 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab0LJAr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 19:47:28 -0500
Received: by fxm18 with SMTP id 18so3152494fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 16:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xruN80ftc0sZlZPPjfBpwaGYDzrLAyR7/2af1isqVSo=;
        b=rawe1jAD2+cYtvb7n8ENrGL7H8Wbj7wyOp4aO20cNJ50gpPJpxa99EcV5OBH4B6enk
         hxlIW1BrT5agNlzU2c+TfR4GdhhEP8hJos83oPrunQ3QPN2UhsGEPzJEe88CDyturFbT
         qXxbz71T/uN53lw9/73yotS9xlP5w7Y94od+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qudjRqRWUVRaBi1ETVuXkCi0VxP4SdJIQQeOiUfnBmYzDEy2cF/KAzwD/S4bviUfcS
         rqxfTNwmvq8GNyNuyZ0fhrAFBNKk/x1nHyVW7qN0gvf63hk8PZaoYxEI+gjcPcFp9lQy
         31cHaSn/BQo9448Ml/4qqdWf7JSZf1OJmcVxQ=
Received: by 10.223.103.3 with SMTP id i3mr100172fao.137.1291942046706;
        Thu, 09 Dec 2010 16:47:26 -0800 (PST)
Received: from [192.168.1.13] (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id 21sm752359fav.17.2010.12.09.16.47.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 16:47:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwrnieac8.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163372>

On Fri, 10 Dec 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> "John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:
>>> 
>>> +# Global declarations
>>> +our $cacheFile;
>>> +our $cacheFileBG;
>>> +our $cacheFileBinWT;
>>> +our $cacheFileBin;
>>
>> You are trading globs for global (well, package) variables.  They are
>> not lexical filehandles... though I'm not sure if it would be possible
>> without restructuring code; note that if variable holding filehandle
>> falls out of scope, then file would be automatically closed.
> 
> Hmm. why is it a bad idea, when you need to access these from practically
> everywhere, to use global variables to begin with?  To a certain degree,
> it sounds like an unnecessary burden without much gain to me.

If you check my rewrite of gitweb output caching:

  "[PATCHv6/RFC 00/24] gitweb: Simple file based output caching"
  

http://repo.or.cz/w/git/jnareb-git.git/shortlog/refs/heads/origin..refs/heads/gitweb/cache-kernel-v6
https://github.com/jnareb/git/compare/origin...gitweb/cache-kernel-v6

you would see that I always use lexical filehandles, and I never need
to use global variables / glob filehandles.

http://en.wikipedia.org/wiki/Global_variables
-- 
Jakub Narebski
Poland
