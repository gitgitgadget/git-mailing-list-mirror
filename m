From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCH] Configurable hyperlinking in gitk
Date: Sat, 17 Sep 2011 22:01:11 +1200
Message-ID: <4E746FE7.4060608@gmail.com>
References: <20110917022903.GA2445@unpythonic.net> <4E7467B7.1090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Sat Sep 17 12:01:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4rho-000518-BY
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 12:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846Ab1IQKA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 06:00:58 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:49673 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab1IQKA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 06:00:57 -0400
Received: by pzk1 with SMTP id 1so4614942pzk.1
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 03:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zaBFqgs4yX8Dxkh4C9BWTIuAMux6QixsQWE6SgbpRVQ=;
        b=ZMApmjswhLpDyuKHKsa8s8gugtAxz2u2Aa52/fUJZuf1jpXk+Snfcl9vqrLHZuSS8R
         HOUj4idHvtGQi+AK9m0DcfAUGDHlmyfgl/KScXc3y7TC5RiC0a+CsD63c4tu/aWLdyqz
         wCnI/m6erOlx8ns7z8oLVhVK4gHVDhYksyBJA=
Received: by 10.68.64.101 with SMTP id n5mr658280pbs.279.1316253657276;
        Sat, 17 Sep 2011 03:00:57 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id i3sm42504266pbg.10.2011.09.17.03.00.54
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Sep 2011 03:00:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.20) Gecko/20110804 SUSE/3.1.12 Thunderbird/3.1.12
In-Reply-To: <4E7467B7.1090201@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181574>

On 17/09/11 21:26, Chris Packham wrote:
> Hi,
> 
> On 17/09/11 14:29, Jeff Epler wrote:
>> Some time ago I hardcoded this into gitk for $DAY_JOB and find it very
>> useful.  I made it configurable in the hopes that it might be adopted
>> upstream. (unfortunately, the configurable version is radically
>> different from the original hard-coded version, so I can't say this
>> has had much testing yet)
> 
> This is definitely something folks at my $dayjob would be interested in.
> We've already done some customisation of gitweb to do something similar.
> I'm not actually sure what the changes where or how configurable they
> are. I'll see if I can dig them out on Monday someone else might want to
> polish them into something suitable (I might do it myself if I get some
> tuits).
> 
>> The definition of the allowed regular expression in the docs
>> probably needs some refinement.  Basically, they have to also be REs
>> that can be concatenated with the "|" character, which is not true
>> of REs that begin with the *** flavor selector (which I had not
>> heard of before rereading `man re_syntax` just now) or (?xyz)
>> embedded options.  Or maybe there's an efficient alternate approach
>> to scanning for the next non-overlapping match among several
>> patterns that doesn't involve concatenating the patterns.
>>
>> I'm not sure about the "one line" restriction; at first I thought
>> that everything was fed to 'appendwithlinks' in arbitrary chunks,
>> but not I see that they are mostly logical chunks (and probably only
>> the comment, not the headers or commit descriptors, will have
>> anything to linkify).  The problem again seems to be how to succinctly
>> describe what is permitted.
> 
> For my use case the one line restriction is fine. We tend to put the bug
> number in the headline anyway.
> 
> Sometimes when a commit fixes multiple bugs we put all the bug numbers
> in separated by commas. I don't know Tcl well enough to tell if your
> code supports that or not.
> 
>> There are probably better names for the configuration options, too.
> 
> It'd be nice if the config variables weren't gitk specific. .re and .sub
> could be applied to gitweb and maybe other git viewers outside of
> gig.git might decide to use them. My bikeshedding suggestion would be to
> just drop the gitk prefix and have linkify.re and linkify.sub.

That should be linkify.<name>.re and linkify.<name>.sub

>> Suggestions?  Problems?  Successes?
> 
> Re-compiling now. I won't be able to actually test it properly until I'm
> back in the office but I can at least check that the links are generated.

Slight complication. The URL of our bug tracker has an ampersand '&' in
it. Tcl's substitution does what one might expect and puts the matched
text where the '&' is. I've tried using url friendly %26 but something
eats the %. I've also tried backslashes to no avail.

To answer my own question since I started writing this email I've found
that using %% works (only the first one gets eaten). Not sure if that's
expected behaviour or not (printf escaping maybe?).

Also since I've been playing around I've tried a commit with multiple
bug numbers on one line and that works as expected.

Thanks
Chris
