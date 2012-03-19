From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: SVN Branch Description Format
Date: Mon, 19 Mar 2012 01:28:45 +0000
Message-ID: <4F668BCD.3010306@pileofstuff.org>
References: <4F5C85A3.4080806@pileofstuff.org> <7B2F5CA7-F2C1-483A-9913-B19A14AA9101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Nathan Gray <n8gray@n8gray.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 02:28:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9RP7-00064l-4e
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 02:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757257Ab2CSB2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 21:28:52 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:30743 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756673Ab2CSB2v (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2012 21:28:51 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120319012848.DUNS21084.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Mon, 19 Mar 2012 01:28:48 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120319012848.XABZ5924.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 19 Mar 2012 01:28:48 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7B2F5CA7-F2C1-483A-9913-B19A14AA9101@gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=_K96qfqeG7gA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=mV9VRH-2AAAA:8 a=8pif782wAAAA:8 a=9M1gIAc9lpACE-6sdcgA:9 a=KWK4NoCfYfXWEjVbiuwA:7 a=wPNLvfGTeEIA:10 a=gHNH_UPw9HoA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193406>

On 18/03/12 23:18, Steven Michalske wrote:
> Consider .SVN_BDF or .SVN.BDF instead of .BDF
> 
> I worry about a branch or tag containing a "
> Can subversion contain a "?
> 
> Steve

I had a look into valid paths during the week, but hadn't checked quote
marks specifically.  Thankfully it seems to work:

mkdir test_dir
cd test_dir
svnadmin create repo
mkdir checkout
svn checkout file://$(pwd)/repo/ checkout/
cd checkout/
mkdir '"'
svn ci -m 'Created directory "'

I'll add this to the test suite :)

Of course, it wouldn't do for SVN to make things that simple.  [1] seems
to be the official definition of what a valid path looks like, and I've
skipped over some important requirements in the spec.  Most importantly,
redundant '/'s are allowed at the end of a path, and multiple '/'s are
collapsed down to one in SVN, so it seems prudent to import that little
eccentricity into this format.

I could be persuaded about making '.svn-bdf' the recommended extension,
but I'd also be happy to go with a more TLA-friendly name for the whole
thing.  "SVN Branch Format" would lend itself neatly to a three-letter
extension (.sbf) that doesn't appear in Wikipedia's list of file
formats[2], although it still encourages the RAS syndrome[3] I've
repeatedly stumbled over while writing the spec.  "SVN Branching
Language" might work, and unlike "BDF" or "SBF", "SBL" doesn't sound at
all like "PDF" when mumbled indistinctly.  Alternative suggestions are
welcome, with the obvious proviso that this is largely subjective and
I'm going to pick whatever sounds best to my ear :)

I'm approaching a natural break in defining the format, so I'll paste a
new version next week.  After that I'll probably pause the format and
work on the SVN exporter for a bit, so I'll have a structure to continue
building the tests and reference implementation against.

	- Andrew

[1]http://subversion.apache.org/docs/api/latest/group__svn__fs__directories.html#details
[2]http://en.wikipedia.org/wiki/List_of_file_formats
[3]http://en.wikipedia.org/wiki/RAS_syndrome
