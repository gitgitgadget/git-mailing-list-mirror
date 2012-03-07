From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Approaches to SVN to Git conversion
Date: Wed, 07 Mar 2012 23:32:44 +0000
Message-ID: <4F57F01C.8080400@pileofstuff.org>
References: <4F536FE9.1050000@pileofstuff.org>	<3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail>	<CA+7g9Jwb=7wH7R3=ShhOGMdHXWmq4ZahocpaEuJdf+yBfCpA8A@mail.gmail.com>	<4F5690FB.9060800@pileofstuff.org> <CA+7g9JzETuynGMCRo1MLuNErFiFc3AmhGS6Hr+jO-hoV2j4JDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephen Bash <bash@genarts.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, David Barr <davidbarr@google.com>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:32:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5QLn-0000Sx-Dn
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 00:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578Ab2CGXct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 18:32:49 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:56319 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755264Ab2CGXct (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 18:32:49 -0500
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120307233246.TRRF14668.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Wed, 7 Mar 2012 23:32:46 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120307233246.XAOM13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Wed, 7 Mar 2012 23:32:46 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <CA+7g9JzETuynGMCRo1MLuNErFiFc3AmhGS6Hr+jO-hoV2j4JDg@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=UeB0h7Mj1QQA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=yXrTWXe-fTtcEUH_iEUA:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192502>

On 07/03/12 23:08, Nathan Gray wrote:
<snip>
> 
> I'm not sure I understand.  So if I have /trunk/projectA and
> /trunk/projectB then do I have to blacklist /trunk/projectB to extract
> only projectA's history?  Assuming it's always lived there will your
> code detect /trunk/projectA as the "trunk?"  Would it be possible to
> specify /trunk/projectA directly instead of blacklisting everything
> else?

Please do try it, but the process should go something like this for you:

1. run the SVN export "configure" stage - this reads through your repo
   and suggests two trunks - "/trunk/projectA" and "/trunk/projectB".
   You can explicitly ignore "/trunk/projectB", but at present there's
   no way to ignore trunks by default.  No particular reason, I just
   hadn't thought to add it :)

2. run the SVN export "make" stage - this looks through whichever
   trunks you've specified, and tracks the branches coming from it.  I
   didn't explain this correctly in my previous e-mail, but yes this is
   transitive - branches from branches from branches from trunk are
   tracked in the appropriate way.

3. edit the file created in stage 2.  If you wanted to ignore a
   specific branch from (a branch from...) trunk/projectA, your best
   bet is to exercise your text-fu on this file

4. Import the history into git

I'll be interested to hear how you and Phil get on, as it sounds like
yes this approach should work for both of your repos.

	- Andrew
