From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Fri, 19 Jan 2007 13:10:31 +0100
Message-ID: <200701191310.32417.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <Pine.LNX.4.63.0701171334410.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200701171500.33220.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 13:10:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7sZH-0002K5-Is
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 13:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbXASMJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 07:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbXASMJ7
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 07:09:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:30710 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965084AbXASMJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 07:09:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so441855uga
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 04:09:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gsGMZ5l4lmVEC0f/diwliFUSXNYng3OHfzb+SAafWf+9kzRMfciV7KgkLeAsomNma1PAalWdisg+82Ru4fQ4KL6MdKiM9qsBm6Z1hcE8V1AQg84Cj3h1vloB/uwG8PcTrSobHR5eyRE+HD88ND7L7K9IN0KndR1u7vgb/fQtRzQ=
Received: by 10.66.232.10 with SMTP id e10mr2922949ugh.1169208597109;
        Fri, 19 Jan 2007 04:09:57 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id 27sm2467954ugp.2007.01.19.04.09.56;
        Fri, 19 Jan 2007 04:09:56 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <200701171500.33220.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37174>

Jakub Narebski wrote:

> BTW. it looks like C escape sequences are parsed, but not octal
> escape sequences, nor no-op escaping other character.
 
From a bit of testing, as documentation of config file format
is woefully incomplete, (yes, I know I should use the source)
_some_ of C escape sequences aka. character escape codes (CEC)
are parsed:
 - "\t", tab character (HT, TAB)
 - "\n", newline (NL)
 - "\b", backspace (BS)
It's a bit strange that "\b" is parsed...

Other CEC cause "fatal: bad config file line 41 <nn> in <file>"
error:
 - "\r", return (CR)
 - "\f", form feed (FF)
 - "\a", alarm (bell) (BEL)
 - "\e", escape (ESC)
 - "\v", vertical tab (VT)
I think supporting "\e" could be useful, but also dangerous.

Octal char sequences (like \040 or \0 for NUL) are not supported
and result in "bad config file" error.

Literal/unknown escape sequences like "\w" or "\." also result
in "bad config file" error, with the obvious exception of escaping
quote character i.e. \" and escaping escape character i.e. \\

Values of configuration variables can span multiple lines by escaping
newline, i.e. putting \ as the last character. Nice. (This doesn't work
for comments, of course). This doesn't work for section headers nor key 
names.

-- 
Jakub Narebski
Poland
