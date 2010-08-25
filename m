From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fix 'git log' early pager startup error case
Date: Tue, 24 Aug 2010 20:36:25 -0500
Message-ID: <20100825013625.GC10423@burratino>
References: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthias Lederhofer <matled@gmx.net>,
	=?utf-8?B?SsO8cmdlbiBSw7xobGU=?= <j-r@online.de>,
	Eric Blake <eblake@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 25 03:38:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo4wX-0004RF-2C
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 03:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab0HYBiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 21:38:15 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37735 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab0HYBiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 21:38:13 -0400
Received: by qwh6 with SMTP id 6so38068qwh.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=f79Wc8kbNQNWipXgjQwjGnTxLPnaFaqPv9oMhVLqQjo=;
        b=TPbbUgyCGhkyhrAwnrC4KA/IYZRh83lyhRMVsDFNoEKpFdy4EizvMofLFMqYCK7L9x
         DS8ZE5lKSlT+JG9omF2rvk0lEh1V5tbmLHSdxognyMpDjipbo8oZWTEb5fGvEE565Htg
         OpPuIo/c3Cg3xSYwX2PYSBvjDFmeG4Jq4wapk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VC3mbc6lQMSB5ODx0v0co2Sp5m4D9lHPeNzMJAp4AH+8hYGbS6IFU0rDl/JgxhOXDQ
         8YAd13iedla0kn/Kb0/EZsOm3bQKKzjTuTyGKFAYamDpWxiqYa/Gz9jJQggi7+cJh6if
         wuYssCVkDMV6mcd1HZUUrRCYW/HGqPX0ItZfc=
Received: by 10.224.28.137 with SMTP id m9mr5041034qac.207.1282700292991;
        Tue, 24 Aug 2010 18:38:12 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id l8sm888827qck.42.2010.08.24.18.38.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 18:38:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154392>

Linus Torvalds wrote:

> I dunno. I noticed this as a result of a typo, and some (un)happy timing 
> ("less" will still start up as a pager if the input is delayed a bit). I 
> think this is the right thing to do, but as mentioned, I only fixed a 
> particular small error case.

I like it.

FWIW the change this undoes is v1.4.2-rc3~25^2~1 (Builtins: control
the use of pager from the command table., 2006-07-31). [1]

 > AFAICS Matthias' patch has the added benefit of moving setup_pager to
 > before large files (i.e. packs) are mapped. This helps non-COW-fork
 > (i.e. cygwin) tremendously. Actually with Linus' setup refactoring
 > this could probably be easily moved to the wrapper,...

Mingw Git uses spawnvpe now, but Cygwin users might still suffer from
fork() troubles.  I think it should be possible to work around that by
using posix_spawn() from start_command() on such platforms (or
someting similar).

[1] http://thread.gmane.org/gmane.comp.version-control.git/24438/focus=24507
