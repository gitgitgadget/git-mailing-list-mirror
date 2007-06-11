From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Sun, 10 Jun 2007 23:20:08 -0700
Message-ID: <466CE998.9000706@midwinter.com>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net> <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu> <11786309071033-git-send-email-tytso@mit.edu> <Pine.LNX.4.64.0705090056231.18541@iabervon.org> <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net> <46418E24.9020309@midwinter.com> <20070509191052.GD3141@spearce.org> <466BAAD0.9060408@vilain.net> <alpine.LFD.0.99.0706102144080.12885@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 08:20:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxdGJ-00027W-Ex
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 08:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbXFKGUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 02:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbXFKGUO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 02:20:14 -0400
Received: from tater.midwinter.com ([216.32.86.90]:33082 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750765AbXFKGUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 02:20:13 -0400
Received: (qmail 16507 invoked from network); 11 Jun 2007 06:20:13 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=hsf3G7IU99HWstPUGCMUWB7w1Kf7x8/XdhTiAmqxhQERsOVT/Fus+OehYWzSBcqh  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 11 Jun 2007 06:20:13 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <alpine.LFD.0.99.0706102144080.12885@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49821>

Nicolas Pitre wrote:
>
> It won't happen for a simple reason: to be backward compatible with 
> older GIT clients.  If you have your repo compressed with bzip2 and an 
> old client pulls it then the server would have to decompress and 
> recompress everything with gzip.  If instead your repo remains with gzip 
> and a new client asks for bzip2 then you have to recompress as well 
> (slow).  So in practice it is best to remain with a single compression 
> method.
>   

Not that I really think this is all that important (my original question 
was more out of curiosity than anything) but I don't think those are 
really issues.

Even with a better compression scheme, nobody would want to remove gzip 
support; if you are creating a repo that needs to be compatible with old 
clients -- and of course not all repositories need that -- you'd just 
configure it to use gzip (or more likely, *not* configure it to use the 
other method.) There are already options whose documentation says, 
"Don't enable this if you want your repo to be accessed by git clients 
older than version X." In other words, git already has an established 
approach for adding new non-backward-compatible features. Some projects, 
e.g. internal corporate ones, can mandate that everyone upgrade their 
clients, and more importantly, once any new git feature has been out for 
a long enough time, even public projects can reasonably say, "You need 
version X to access our repo." If alternate compression were introduced 
today, in five years would anyone care that there'd be some ancient, 
ancient clients that couldn't use it?

And since the hypothetical new client would have support for both 
compression types, pulling from a gzip-based repo could be accomplished 
totally transparently; you could, one assumes, even pull from a gzip 
repo and pack locally using the other scheme if you felt like it.

-Steve
