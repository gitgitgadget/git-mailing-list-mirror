From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 1.7.3.4 build regression
Date: Thu, 16 Dec 2010 22:17:51 -0600
Message-ID: <20101217041750.GA7649@burratino>
References: <8779CB66-03D3-4EC9-8650-521532112CA5@apple.com>
 <20101217034123.GA7362@burratino>
 <21774743-8BA8-4A1C-BDCF-1E3F7D85EFB5@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jeremy Huddleston <jeremyhu@apple.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 05:19:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTRmW-0006SO-0j
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 05:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003Ab0LQES2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 23:18:28 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:48488 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab0LQESL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 23:18:11 -0500
Received: by gwb20 with SMTP id 20so187167gwb.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 20:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DwDvikTxF2TtROrcpxCJ3hbGtI1g6EIGDz4YLbAUnGo=;
        b=h9Wqlj6TxugHBwRNbWjAX9feCVDnZrbJ34lLl1EJvAb1ssMjfFo/e05s8/vZgMFPBI
         FeUmtEY87ONWobjgjUPd1pQ6OoKxVlbwsJyz7Z6AEKx+1G1Kuvf3Z63tpXo93c7a0tkS
         f0YG6bufKr0+LHM7gnia5x4h1SyIHQQ7zPeJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CI+FHMEkKXO5GRAGdMYzBmjp5Ce5lS4WI1TmJ6VLqEEWShaW+qDZUCpG8RHBVcz/9l
         OSjhFALKfZMKYOnAfc8N0avfCasAKPfd1QQhg6YNIJa0R+IiBiNIemA6T/1ot33UoCJe
         CmcnhYH/VAyiyKrM1rxOrImoDXOJZmnEhkSFE=
Received: by 10.236.95.41 with SMTP id o29mr362724yhf.29.1292559491020;
        Thu, 16 Dec 2010 20:18:11 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id j28sm583222yha.44.2010.12.16.20.18.09
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 20:18:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <21774743-8BA8-4A1C-BDCF-1E3F7D85EFB5@apple.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163860>

Jeremy Huddleston wrote:
> On Dec 16, 2010, at 19:41, Jonathan Nieder wrote:
>> Jeremy Huddleston wrote:

>>> make
>>> (strip the built executables)
>>> make install
>>>
>>> During 'make install', the executables get remade even though they
>>> shouldn't be.
>>
>> Just a wild guess: do you pass CC on the "make" and not the "make
>> install" command line?
>
> Yes.  Good guess.  Why would that be affecting it?

See v1.7.3.3~28^2 (Makefile: add CC to TRACK_CFLAGS, 2010-09-12),
found with "git log --no-merges v1.7.3.2..v1.7.3.4 -- Makefile".
That is, now CC is tracked like $prefix and $CFLAGS are.

The idea of that change was presumably that if you switch CC from,
say, "gcc -m32" to "gcc -m64", then the build result will not be
correct unless you remake things.  I have mixed feelings about it,
since from time to time I might want to switch between gcc-4.4 and
gcc-4.5 without rebuilding everything.

> "make" line is:
> /Developer/usr/bin/make -C /tmp/Git-16.roots/Git-16~obj/i386/ \
>	-j`sysctl -n hw.activecpu` \
>	prefix=/usr NO_FINK=YesPlease NO_DARWIN_PORTS=YesPlease \
>	RUNTIME_PREFIX=YesPlease \
>	GITGUI_VERSION=0.12.0 V=1 \
>	CFLAGS='-ggdb3 -Os -pipe -Wall -Wformat-security -D_FORTIFY_SOURCE=2' \
>	'CC=cc -arch i386' 'uname_M=i386' 'uname_P=i386'

Interesting.  It might be convenient to save these variables in
/tmp/Git-16.roots/Git-16~obj/i386/config.mak.

Thanks for reporting.  Some thinking to do.
