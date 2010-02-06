From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] t9501: Skip testing load if we can't detect it
Date: Sat, 6 Feb 2010 15:05:13 +0100
Message-ID: <201002061505.13886.jnareb@gmail.com>
References: <1265432440-52146-1-git-send-email-brian@gernhardtsoftware.com> <m3eikya9tn.fsf@localhost.localdomain> <0CD6B283-3181-4FAB-A6B2-13AFF9E5071C@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 15:05:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdlHu-0005gb-5e
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 15:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891Ab0BFOFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 09:05:25 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:59910 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab0BFOFY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 09:05:24 -0500
Received: by bwz19 with SMTP id 19so604944bwz.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 06:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iKV79pKIeMhVjiR1ODNl03fkMbNcwNGx0kV7xXNIUnE=;
        b=S94iXV+79moyAAhwGTvhefaDMZH5YzkigV+MrTpeISFON4svSgDLq4J7+CPbg/fIra
         ZCMcQqome7B1+t335U+pJT8dGUY26n27Ujra7nb3+yAkpwTWtDPv7NDBMBdgYiV2mU1H
         DqBCC8boSXoa6sGc7JshCnTI8ZXoP2lgTRPIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BFPtw05DYXvjkNoaNFkVmGCPsY0z086qmE/UY7qijhcDhG46J1uNSLThnU2fKWcJxj
         KsqH7j3WIIcSbSnrs7fvgIQgsEIsZ9b/lDumiPesWT67RKHaHFYIUUZ2PmTWeMIZK1Au
         P8ZeYnMnthggW+4F+yFxSHiGU55usjKmukELc=
Received: by 10.204.48.144 with SMTP id r16mr1780541bkf.176.1265465121890;
        Sat, 06 Feb 2010 06:05:21 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id 16sm1129329bwz.7.2010.02.06.06.05.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 06:05:21 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <0CD6B283-3181-4FAB-A6B2-13AFF9E5071C@gernhardtsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139168>

Brian Gernhardt wrote:
> On Feb 6, 2010, at 6:22 AM, Jakub Narebski wrote:
>> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
>> 
>>> Currently gitweb only knows how to check for load using /proc/loadavg,
>>> which isn't available on all systems.  We shouldn't fail the test just
>>> because we don't know how to check the system load.
>>> 
>>> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
>> 
>> NAK.  It is not necessary, and it would be hindrance (one more place
>> to update) if we are to extend get_loadavg() in gitweb to work without
>> /proc/loadavg, e.g. via BSD::loadavg module.
> 
> Without this patch, the test fails on my OS X machine (which doesn't
> have /proc).  So _something_ is necessary.

Right.

> Skipping the test because we can't use the feature on the host machine
> seemed more in line with what the other tests do with things like
> symlinks and file modes.

This is more test that gitweb returns correct HTTP response in 'load
too high' situation, than testing of it finding average system load.

> And if get_loadavg() is updated to use BSD::loadavg, the test should
> still be skipped if the module isn't installed.      

This test should succeed both when get_loadavg() returns true system
load and when it can't read load average and it returns 0.

>> Third, the test (as you can see below in context line in quoted diff
>> below) forces gitweb to go over maximum load by setting $maxload to 0.
>> This means that regardless of true load, and regardless whether gitweb
>> can detect system load (remember that if it cant get system load it
>> returns 0 instead) gitweb would be in "load too high" situation.
> 
> I did check the code.  Skipping the test seemed more in line with other tests.
> 
> sub get_loadavg {
>     if( -e '/proc/loadavg' ){}
>     return 0;
> }
> 
> if (defined $maxload && get_loadavg() > $maxload) {
> }
> 
> Setting $maxload to 0 does _not_ trigger failure because zero is not
> greater than 0.  Setting $maxload to -1 might work though.  I'll try
> it and test it in a little bit.  While I disagree that it's a good
> way to handle the situation, I will see if it works.   

Oops.


Either gitweb should be modified to read

  if (defined $maxload && get_loadavg() >= $maxload) {

or the test should use 

  $maxload = -1;

to artificially force 'load too high' situation.

-- 
Jakub Narebski
Poland
