From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: git diff looping?
Date: Wed, 17 Jun 2009 13:02:11 +0200
Message-ID: <4A38CD33.9020402@gmail.com>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org> <20090616171531.GA17538@coredump.intra.peff.net> <4A38AD5D.6010404@gmail.com> <20090617102332.GA32353@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, John Bito <jwbito@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 13:02:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGsuW-0006f0-Dj
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 13:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbZFQLCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 07:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbZFQLCW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 07:02:22 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:62477 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbZFQLCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 07:02:21 -0400
Received: by ewy6 with SMTP id 6so377990ewy.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=cTcyJthkN3gNwb1B5c5E/9fT+VwjsG1kXybVSPU3Eqc=;
        b=HEPKx201QJoqZaYqT0CeUkUBeBDYAnuq6D3ly2UfWBewx/TbNEm5EeyG1FWJdtJOr1
         tkZd8Dw/AZeO4AV5/kZENv7k5BIP3UHK1itBWGFkNjJ4PaZ5b/I9BahvnPXUYvJwAPtP
         PXsjaWod/7EASj01D28TyhUwoqVm2FCvx39HM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ula1swk3bERMViC1naVGzHhPehNFX3tH1y7m0iDoj61GD1x/8JGmOQaYFJCKQo8LVD
         wCbjt8wJMYyBrTnOsVCarKpWlBdAmIYkP/CWynkl6wGNEe9m/JyZZxGzz8tJvbTxxMgz
         uEsHv9QF8MCL12VB6Y6tMTbHdnMa4sYr7i73Q=
Received: by 10.210.12.18 with SMTP id 18mr52718ebl.2.1245236543225;
        Wed, 17 Jun 2009 04:02:23 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 10sm121171eyd.27.2009.06.17.04.02.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 04:02:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <20090617102332.GA32353@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121734>

>   system,  orig:   0.22s
>   system, paolo:   0.22s
>   system,   ".":   0.15s
>   compat,  orig: 150.88s
>   compat, paolo:   0.43s
>   compat,   ".":   0.15s
> 
> Besides the exponential behavior on the original regex, it is still
> about twice as slow as the system one.

The reason is that the glibc regex is a DFA-based matcher.  It is much 
slower on regexes with backreferences, but otherwise it is faster.

>   1. Replace the builtin diff.java.xfuncname pattern with what Paolo
>      suggested (though I haven't verified its correctness beyond a
>      cursory look at the results).

I checked it a bit harder, but still it is not easy to check because of 
the false positives in the original regex.  I'm pretty sure it's correct 
  though; I find it even easier to read (though longer) than the 
original one.

>      I haven't looked at how large or how portable the glibc
>      implementation is.

Decently portable, but I don't think it's worth it.  Users that write 
regexes so complex should know of the exponential behavior, I think.

Paolo
