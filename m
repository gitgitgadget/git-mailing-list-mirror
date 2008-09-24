From: "P. Christeas" <p_christ@hol.gr>
Subject: Re: Git submodule enhancements
Date: Wed, 24 Sep 2008 13:14:27 +0300
Message-ID: <200809241314.29661.p_christ@hol.gr>
References: <200809241100.30758.p_christ@hol.gr> <8c5c35580809240213v5198d2abh489915dc1133c75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 12:30:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiRdO-0005Ea-76
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 12:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbYIXK3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 06:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbYIXK3E
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 06:29:04 -0400
Received: from outgoing.holservices.gr ([62.38.2.44]:54181 "HELO
	outgoing.holservices.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751467AbYIXK3C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 06:29:02 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Sep 2008 06:29:01 EDT
Received: (qmail 16493 invoked from network); 24 Sep 2008 10:20:32 -0000
Received: from unknown (HELO deliver.mail.dc.hol.net) (192.168.20.70)
  by arete.mail.dc.hol.net with SMTP; 24 Sep 2008 10:20:32 -0000
Received: from auth-smtp.hol.gr (takeit01.mail.dc.hol.net [192.168.20.71])
	by deliver.hol.gr (8.12.11/8.11.6) with ESMTP id m8OAEUS8001894
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256 bits) verified OK);
	Wed, 24 Sep 2008 13:14:30 +0300
Received: from pfn1.pefnos (ppp079166044220.dsl.hol.gr [79.166.44.220])
	by auth-smtp.hol.gr (8.13.1/8.13.1) with ESMTP id m8OAEV0b023258;
	Wed, 24 Sep 2008 13:14:31 +0300
Received: from xorhgos2 (cpe-77-83-142-185-dsl.netone.gr [77.83.142.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pfn1.pefnos (Postfix) with ESMTP id 865CDFB02;
	Wed, 24 Sep 2008 13:14:31 +0300 (EEST)
User-Agent: KMail/1.9.9
In-Reply-To: <8c5c35580809240213v5198d2abh489915dc1133c75@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.93.3/8323/Wed Sep 24 10:57:37 2008 on takeit01.mail.dc.hol.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96628>

On Wednesday 24 September 2008, Lars Hjemli wrote:
> It looks like --cloned requires the downstream to know which
> submodules are available from the same remote as the supermodule (and
> with the same path as registered in the supermodule), i.e. quite a
> specific configuration. Is this really common enough to justify a
> special option to `submodule init`?
I agree. My patch is only a temporary fix for the situation and may not cover 
all needs.

> Maybe the .gitmodules file could be extended to contain multiple urls
> instead (i.e. both absolute and relative ones)? Then `submodule init`
> could get options like --prefer-relative-url, --prefer-absolute-url
> and --interactive. What do you think?
I guess there is much room for improvement wrt. with the .gitmodules . For 
one, they should try to mimic the 'git clone' refspec logic, instead of being 
a static file. (in fact, the hooks could let us do that using scripts alone)

> Hmm, after reading through this once more I guess you're trying to
> clone a non-bare repository, possibly also lacking a .gitmodules file
> (hence the --force)?
Not really. I was trying to have the git-submodule script re-write the conf 
with a different url. Merely like running a 'submodule sync' at the same 
time.

> Btw: why doesn't
>   $ git submodule foreach 'git archive HEAD > somewhere/$path.tar'
> work for you?
In fact, it could. You could also replace HEAD with the $sha1 ..

In general, my comment on submodules is that it is a very powerful concept, 
but still lacks many real-life features. Reading the C code, I realized that 
we would have to rework all the core plumbing of git in order to have it work 
accross different git repos inside the same C process. That is a stopper. 
Otherwise, if we could only have read_tree_recursive() span to different gits, 
we could do really beautiful things.

Sorry for posting many ideas and only few patches!
