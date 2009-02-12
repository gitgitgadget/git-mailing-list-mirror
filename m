From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not  author
Date: Thu, 12 Feb 2009 11:11:44 +0100
Message-ID: <200902121111.51147.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <200902121007.29867.jnareb@gmail.com> <cb7bb73a0902120152h7b3e0ac6w379bd9319712ea2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Deskin Miller <deskinm@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 11:13:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXYZb-0003sU-SW
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 11:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754AbZBLKMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 05:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbZBLKMH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 05:12:07 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:57133 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZBLKMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 05:12:05 -0500
Received: by fxm13 with SMTP id 13so1708071fxm.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 02:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1nbtrwvKxcYVYwN2HJu8hm8PRT+M18hF4UjibgucrbU=;
        b=HRWMMuVc/lZORojFbMx2RrO/D/+5oDUXY/d0QZuG5v44oJc7pwdOVkYKwsQ5vD7My1
         XMi5QwqvrBKzKNfhXRAJdj5cV4Thhbw/gBJ7u8KRvUkxXLpiRZPLkEsKObS6IIt97LSY
         om3lZ57U4NuFfvtJgN/VapqMBtTTnxxh8oxaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uwZDvxOGFpzhyqjns4+O9L0nBSTyGnz5GMl+9ujeEis+N+KqKwJQIxfUJGsGobCigY
         XGLee4DcJjVXi80HQcodZl01wShEajHeHDZ12NcvGYPrDNVHWCY6SQYTYAFD4bWXhx54
         ++XohMNwhERD3A0RQ+mFD6jBUKCn8Sx/KQU2I=
Received: by 10.102.247.4 with SMTP id u4mr268600muh.104.1234433522886;
        Thu, 12 Feb 2009 02:12:02 -0800 (PST)
Received: from ?192.168.1.13? (abxc167.neoplus.adsl.tpnet.pl [83.8.252.167])
        by mx.google.com with ESMTPS id 23sm3167619mum.7.2009.02.12.02.12.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 02:12:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0902120152h7b3e0ac6w379bd9319712ea2b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109594>

On Thu, 12 Feb 2009, Giuseppe Bilotta wrote:
> On Thu, Feb 12, 2009 at 10:07 AM, Jakub Narebski <jnareb@gmail.com> 
> wrote: 

>> You can disable reflog by setting core.logAllRefUpdates to false...
>> which of course do not remove reflog.  But checking for this config
>> variable in gitweb shouldn't be too hard, although you would need
>> to somehow change assumption that we are interested only in ^gitweb\.
>> section of config.
>>
>> There is other side of this issue: reflog is expired, so you can
>> have empty reflog if branch was updated long time ago.
> 
> I'm thinking that what I could do (that should always work as
> expected) is to consider as 'last modified' the most recent date
> between the commit date and the reflog date (if the reflog is found).
> This basically implements an 'automatic' fallback for
> disabled/obsolete/expired reflog to commit date. (Of course, assuming
> the last commit doesn't suffer from a ridicously long clockskew in the
> future.)

That is, I think, a very good idea. It also covers situation where we
use non-head 'h'/'hb', for example explicit SHA-1 (not that it makes
sense, but...) 
 
Well, that beside my little doubt whether using publish date is a good
idea or not...


P.S. What would you do for explicit and implicit HEAD? HEAD reflog,
or 'current branch' reflog?
-- 
Jakub Narebski
Poland
