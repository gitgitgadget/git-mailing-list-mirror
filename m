From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix chop_str not to cut in middle of utf8 multibyte chars.
Date: Sat, 24 May 2008 15:34:23 +0200
Message-ID: <200805241534.25517.jnareb@gmail.com>
References: <g0vdse$rj6$1@ger.gmane.org> <7vve185d6s.fsf@gitster.siamese.dyndns.org> <4833D314.4010904@0x63.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Waldenborg <anders@0x63.nu>
X-From: git-owner@vger.kernel.org Sat May 24 15:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jztuf-0008Eo-Fw
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 15:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbYEXNei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbYEXNei
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 09:34:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:52673 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbYEXNeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 09:34:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so701308fgg.17
        for <git@vger.kernel.org>; Sat, 24 May 2008 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=012eeYOD326S99ot+rIJMePQWXdA0vqNzBN/d7tN0Rc=;
        b=j4xVIWYwc1Wguu4NK7bnhYoAV+f59QcGTOW6RUO6JDac3z4UGAPFDbSGsUqdJv0R7g174Mro6rf6Uco5xiwxifUB6hhEhoRXQPfvELBgwQVOYOfwSUT+qKkP8JxNNkteVYpOKMAWfy5CnWcdlPJRx9TldiWab4dwtlPRCA2GSpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bq3JZgUVCgbCM/QBWn1KKlxQlirp5q5hf6Vd3gRj9OsUCuPkINLNXC6afMDB8C3e6ZaTIGxycPg2pFrjc3j/Md54p2QldHJ2eTbPy4KZyJ3dgUHCEZsJjR6sHUJBYhEsfE2OrOJc4pSyOSYfiUG+GL1tnR23XbMvQD1scpklMC4=
Received: by 10.86.52.6 with SMTP id z6mr1829098fgz.18.1211636075550;
        Sat, 24 May 2008 06:34:35 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.233.1])
        by mx.google.com with ESMTPS id d4sm7629480fga.4.2008.05.24.06.34.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 06:34:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4833D314.4010904@0x63.nu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82814>

On Wed, 21 May 2008, Anders Waldenborg wrote:
> Junio C Hamano wrote:

>> I haven't followed the codepath but what do the callers do to the string
>> returned from chop_str?  Don't they assume the string hasn't been decoded
>> (because the old implementation of chop_str did not do this to_utf8), and
>> emit the result directly to the output because it also assumes the
>> undecoded format is what the outside world wants?  In other words, don't
>> they now need to do different things because returned string has gone
>> through the to_utf8() processing already?
> 
> The to_utf8() (defined in gitweb.perl, not part of perl it self) is kind 
> of sneaky, it checks if the string already is valid utf8. (guess it 
> should be called ensure_utf8())

Perhaps it should...

> chop_str needs to work on decoded string, otherwise character count goes 
> all wrong. But maybe it is better to add the to_utf8() to the callsites?

Or do "binmode $fd, :utf8".

But yes, I guess converting to Perl internal form on input would be
good idea.  Gitweb currently does it partially...

-- 
Jakub Narebski
Poland
