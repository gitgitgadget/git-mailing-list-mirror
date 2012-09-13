From: Jens Bauer <jens-lists@gpio.dk>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 20:55:37 +0200
Message-ID: <20120913205537072129.afbbbae7@gpio.dk>
References: <20120913170943725232.01d717ef@gpio.dk>
 <1347550490.24469.54.camel@drew-northup.unet.maine.edu>
 <20120913154309.GB726@sigill.intra.peff.net>
 <20120913175300953765.9ccf790f@gpio.dk>
 <20120913201720399747.156466ee@gpio.dk>
 <20120913182344.GA2181@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:55:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCEZo-0003te-Oq
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851Ab2IMSzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:55:41 -0400
Received: from [92.246.25.51] ([92.246.25.51]:62238 "EHLO mail.multitrading.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab2IMSzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:55:39 -0400
Received: (qmail 87522 invoked from network); 13 Sep 2012 18:55:37 -0000
Received: from unknown (HELO ?10.0.2.26?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 13 Sep 2012 18:55:37 -0000
In-Reply-To: <20120913182344.GA2181@sigill.intra.peff.net>
X-Mailer: GyazMail version 1.5.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205414>

Hi Jeff and Drew.

Excellent. I now removed the repository from the server, removed it from my gitolite.conf, added it to gitolite.conf, re-initialized and it works.
git diff shows what I wanted.

Thank you *very* much for making my dream come true. :)
-And thank you all for all the hard work you're doing. -Git is how all other open-source projects should be: Well-written and well-defined (oh - and fast!). :)


Love
Jens

On Thu, 13 Sep 2012 14:23:44 -0400, Jeff King wrote:
> On Thu, Sep 13, 2012 at 08:17:20PM +0200, Jens Bauer wrote:
> 
>> In my home directory, I have a .gitconfig file, here's the 
>> interesting part:
>> [core]
>>         editor = nano
>>         excludesfile = /Users/jens/.gitexcludes
>>         attributesfile = /Users/jens/.gitattributes
>> 
>> [filter "cr"]
>>         clean = tr '\\r' '\\n'
>>         smudge = tr '\\n' '\\r'
>> 
>> 
>> In my home directory I added .gitattributes:
>> *.osm   filter=cr
> 
> Looks right.
> 
>> Now, when I clone the project, make a change and then issue this command...
>> $ git diff mypcb.osm
>> 
>> ...I get a strange diff. On line 3, one of the files shows a lot of 
>> control-m (<cr>) lines.
>> After that, I see <lf> lines, all prefixed with a '+', as if they 
>> were added.
>> 
>> I think I might be nearly there, just missing some obvious detail 
>> somewhere.
> 
> Yes, that's expected.  The point of the "clean" filter is to convert
> your working tree file into a canonical (lf-only) representation inside
> the repository. But you've already made commits with the cr form in the
> repository. So you can choose one of:
> 
>   1. Make a new commit with these settings, which will have the
>      canonical format. Accept that the old history will be funny, but
>      you will be OK from here on out.
> 
>   2. Rewrite the old history to pretend that it was always LF. This
>      gives you a nice clean history, but if you are collaborating with
>      other people, they will need to rebase their work on the new
>      history. See "git help filter-branch" for details.
> 
> -Peff
