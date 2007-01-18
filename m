From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch,
 not .txt
Date: Thu, 18 Jan 2007 11:29:53 -0800
Message-ID: <45AFCAB1.8010903@midwinter.com>
References: <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>	 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>	 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>	 <45AF7FE8.5060003@op5.se>	 <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>	 <20070118152620.GB15428@spearce.org> <81b0412b0701180752x1664f661o17ce78a7024590f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>, Josh Boyer <jwboyer@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 20:30:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7cxQ-0007O9-E6
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 20:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbXART3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 14:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbXART3x
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 14:29:53 -0500
Received: from tater.midwinter.com ([216.32.86.90]:40083 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932446AbXART3w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 14:29:52 -0500
Received: (qmail 14014 invoked from network); 18 Jan 2007 19:29:51 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=vhozfWA/LeUUZZUJ2yPGggq+bnZGb34Z+jiRCwvEHviivRpXKLfUVKgiJesN3n7R  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 18 Jan 2007 19:29:51 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701180752x1664f661o17ce78a7024590f3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37131>

Alex Riesen wrote:
> I count 17 instances (excluding run_command). At least fetch-pack
> is not trivial (the sideband code. Could be done in a  thread, which
> is not portable just as well).

I looked at that briefly a while ago -- at the prompting of a Windows 
developer friend of mine who has some interest in git -- and it seemed 
like the best thing for portability to non-fork()ing systems would 
probably be a refactor. It looked to me like it'd be possible to 
reorganize the code such that it'd work all in one process with no 
threads or forking or anything. Not *trivial*, mind you, but possible. 
There's nothing in the code path that I saw (I didn't analyze it 
super-thoroughly) that looked like it actually needed to run in parallel.

IMO it's worth doing at some point post-1.5.0 simply because it means 
one less hurdle for someone who's looking to port Git to Windows. Plus 
it'll probably make the code slightly more efficient even on Linux and 
friends; there'd be less context-switching latency.

 From my brief look, that was the only nontrivial use of fork(). Almost 
all of the rest are simple fork/exec pairs.

Of course, the bigger hurdle for a native Windows port is all the shell 
scripts. Mercurial solves that by using Python for all its scripts, 
which at least has a native Windows version that can be installed. I 
wonder if git will/should eventually move its remaining shell scripts to 
Perl for that reason, Perl being git's de facto non-shell scripting 
language of choice.

-Steve
