From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] Moving "git remote add --mirror blah" functionality to
 "git clone --bare --origin=blah"
Date: Thu, 24 Apr 2008 08:23:23 +0200
Message-ID: <4810275B.70404@gnu.org>
References: <480EF334.1090907@gnu.org> <7vhcdstv0f.fsf@gitster.siamese.dyndns.org> <480F96A8.6020304@gnu.org> <7vtzhsqlfi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 08:24:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JousQ-0007Jp-Ev
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 08:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbYDXGX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 02:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbYDXGX1
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 02:23:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:14129 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbYDXGX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 02:23:26 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2937719fgb.17
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=IDJIfI5bQRZE+Ti5XIy4YXUfmOxg7vE8DCR12fxTcZ4=;
        b=TGbAwYoWbLR/gtCN3a8ftEuPIrS2LPYI4Yx985o2Nd8E1SdP5Kv6s4koHtt9KO2c911mOGdPfFKiFJOHWKi2fFMeR/7mhnWCkYSqwVRn7Wax7s+VVkMNEhinqz6I3A0CT20ja7VC0vztxisERhi7gmd9UWlebzIW3vAIrop9Kc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=IXWURLRSAdBRRuiJtd2QjAu1gRn7DwwUHBjdRS1Zf2ar6ZV6+rlgN1sb3GQZ2fpNOeLMJTDuKph1fjIlb1b3M7JuQJ5IG6Vaz+wxzwgW9T5PymxzW3xhhYa4JxiwvtiM3hvRaCbhp8OWkhSiOff1EHhIAwCpKWabOj/7o3U7Up4=
Received: by 10.86.94.11 with SMTP id r11mr4978194fgb.1.1209018201384;
        Wed, 23 Apr 2008 23:23:21 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l12sm1213843fgb.8.2008.04.23.23.23.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Apr 2008 23:23:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <7vtzhsqlfi.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80294>

> Ooo.  But I think that's the other way around.  It was prepared for that
> purpose but people never followed through.  Check the archive around
> commit 3894439 (Teach "git remote" a mirror mode, 2007-09-02).

Well, the thread is not very explicative.  Neither is the commit log 
message.  There is no info as to *why* it is useful.

After finding no particularly good info in the commit, and seeing that 
the functionality is unused within git's shell script porcelain, I wrote 
my RFC on the intuition that it is a failed experiment.  (The rest of 
this message is also assuming this possibly wrong intuition).

>> --mirror" is close to useless: anyone who needs it 99% of the time
>> knows how to hack the config...
> 
> Eh, in that sense, "git remote" itself is useless, isn't it?

Hm, bad sentence on my side.  My point was that my proposed improvements 
to clone:

   git clone --bare -o origin <url> foo.git

satisfy 99% of the usecase; you usually know beforehand if you're 
cloning for local development or for mirrors.   Anyone who *still* needs 
--mirror after that (i.e. needs two mirror-mode remotes, or needs it on 
non-bare repositories), 99% of the time knows how to hack the config. 
Actually in the latter case (non-bare repos) he might have to hack the 
config soon, if Dscho's patch to forbid this is polished and goes in.

In the end, this piece of functionality is almost unused (surely unused 
within git's shell porcelain, if not in the wild) and is dubiously 
placed for two reasons:

1) If the point of git remote is to shield from the config, what the 
user will learn is that "git remote" is about "git branch -r" (maybe 
he'll also learn "refs/remotes/something").  Now instead you have an 
option that goes under "git remote" just because it creates remote.* 
configuration options.  Indeed, "git remote add --mirror -f" will create 
*local* branches, so that "git branch -r" does not show them.

2) Similarly, "--mirror" suggests that the remote will go hand in hand 
with "git push" (that has the "--mirror" option, and this started my 
confusion) rather than "git fetch"/"git pull".  Indeed, even after my 
patch[1] to add some DWIM functionality for mirrors to "git push", the 
user will need to hack the config file manually to activate the DWIM.

Instead, my proposed meaning of "git remote add --mirror" would fix both 
discrepancies...

Paolo

[1] http://marc.info/?l=git&m=120877130932254&w=2
