From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Fri, 08 Jun 2007 09:29:00 +1200
Message-ID: <4668789C.7010104@vilain.net>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz> <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com> <46676D44.7070703@vilain.net> <alpine.LFD.0.99.0706062314410.12885@xanadu.home> <466793EB.2060102@vilain.net> <alpine.LFD.0.99.0706070932000.12885@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 23:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwPXf-00014P-DL
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 23:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760090AbXFGV3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 17:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760755AbXFGV3L
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 17:29:11 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:33419 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759797AbXFGV3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 17:29:10 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 63EA41574BD; Fri,  8 Jun 2007 09:29:08 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id B42CC1574BB;
	Fri,  8 Jun 2007 09:29:04 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <alpine.LFD.0.99.0706070932000.12885@xanadu.home>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49389>

Nicolas Pitre wrote:
> >> Well that depends how many loose objects there are :)  I heard about on
>> Windows a case where packing 30k loose objects took over an hour.
> > And your patch cannot change anything to that, right?
> You shouldn't wait until 30k loose objects accumulate before repacking.

Absolutely.  But the generational approach would make it practical to
repack very often, in fact automatically, and keep the time of that
repack reasonably bounded.  As I said in the original patch, the
intention is that this style of repacking works best when applied
automatically, perhaps on commit.

>> If you repack every 100 objects without -a, sure it will be fast, but
>> you'll end up with too many packs.
> You just need to adjust this treshold of 100 objects.
> And latest GIT behaves _much_ better with lots of packs, almost like if 
> there was only one pack.  See the test results I posted to the list.

The test run with 66 packs?  What about a repository with 300000 objects
that was repacked every 100 new objects, would it work well with with
3000 packs?  Surely there is some value in conglomerating older packs,
even though your LRU patch might make it very small (which I do find
impressive).  Do you really need me to prove this with a benchmark?

"Adjust the threshold" you have already said.  But the problem with that
is what to?  I want the automatic repack to be *fast*.  So making it
larger will make it slower.  But making it too small will make the packs
excessive.

Sam.
