From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: ANNOUNCE git-what-branch (was Re: Find out on which branch a
 commit was originally made)
Date: Wed, 22 Sep 2010 22:27:27 +0200
Message-ID: <4C9A66AF.5000302@gmail.com>
References: <1jp42v5.w5dez21d3nlciM%lists@haller-berlin.de> <4C973E5B.4090201@gmail.com> <4C9782A3.5010005@gmail.com> <201009210015.o8L0FcJt020691@no.baka.org>        <4C981475.10404@gmail.com> <201009221635.o8MGZnLD024629@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Wed Sep 22 22:27:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyVum-0001Q2-ML
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 22:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab0IVU1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 16:27:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50391 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab0IVU1c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 16:27:32 -0400
Received: by eyb6 with SMTP id 6so283001eyb.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 13:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=a1vFLGOg+mY7nJiiycI7NA5roFI9j3I9/IFhAHCCqqw=;
        b=L1RhPrGmDh9J+n7VvQbBUNGYMbK1/uLfGVdSIjKcGV1QBhvRQfLt/UfGWLMQv9MN20
         R6xrxhPNORNF1MBSLqfWqmudpEiBgvz7NtcsHIYPNgtbBk4jnH/07FFdIOwtGZyJuDvC
         wfjg1rDDm4I82cTKIiiXPOu/aKDXG4C6gmNIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=jr/q5N67NKZnMEw9wTH3EXv+qyiBfUh9BVYrUCQGnRPQY08PaqEAilE8/02Ci9Q09P
         tJt8sv1kTSSGfPsCTfYQHPWfSdlYDJrR0s4FVbdOUDvPTCENQ262iydglYkLqxn0GWhn
         4b2TJssqqi8yb4Y5hRxzHdQ1TFtjhb6r5eOy0=
Received: by 10.213.47.70 with SMTP id m6mr1182982ebf.63.1285187250483;
        Wed, 22 Sep 2010 13:27:30 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-122-220.multimo.pl [89.174.122.220])
        by mx.google.com with ESMTPS id v8sm15339444eeh.2.2010.09.22.13.27.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 13:27:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <201009221635.o8MGZnLD024629@no.baka.org>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156833>

On 09/22/10 18:35, Seth Robertson wrote:
> looking at just one branch, it is looking at 150+ branches.  If you
> use --reference-branch to specify the one branch you are looking at,
> it takes a much more reasonable 15-20 seconds.  Likewise if you select

This started in a thread about locating dead topic branches, but what
you want is something slightly different, hence the confusion. 
AFAIUI it now, your case is basically this: you have several
independently developed topic (or side-) branches, which are
periodically merged into a master branch, the side branches
themselves are also merging 'master' to receive changes happening
elsewhere. So the graph could look like this:

 m-> m -> m -> m -> m -> m -> m ->   master
  \        \       /         /
   b -> b -> b -> b -> b -> b ->    side-branch#1

Ditto for the other n side-branches. 

What you're asking for is: given commit C and a list of several side
branches, tell me where (ie on which branch) this commit originated.

Two things make the above trivial history a bit more complicated.
A) one side-branch can merge another, and build on top of changes that
   are not yet available on 'master'; the result can then appear in master
   via either one or both paths. This is why showing when and how a change
   became visible on every side branch can be interesting.
B) when a side branch does not contain any new changes, but is made uptodate
   wrt master, the resulting history could end up like this:

 m-> m -> m -> m -> m -> m -> m ->   master
  \           /      \       /
   b -> b -> b        c ->  c ->    side-branch#1
    
   What happened was -- git "optimized" the simple merge away, turning it
   into a fast-forward, saving one merge commit, but loosing the link
   connecting the 'c' and 'b' parts of 'side-branch#1'.   

Do you (anybody) happen to know a public repo, w/ history as above, ie
w/ more then one long-lived branch that has seen some fast-forwards? 
I wonder how reliable recovering the missing link would be...

And there's no reason why this operation should take ~20 minutes, even
for the randomly chosen, but real, worst case. But finding a good repo
to test w/ would take longer than writing the code...

artur
