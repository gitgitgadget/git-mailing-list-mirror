From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Can I set up a GIT server w/o administration privileges on a Solaris machine?
Date: Thu, 4 Jun 2009 19:34:00 +0200
Message-ID: <32C5F26D-7498-440C-8BF4-97AF137EF78F@dbservice.com>
References: <4A27F7E6.8060405@xnet.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: stuart <stuart@xnet.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 19:34:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCGpg-0006E6-MF
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 19:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbZFDReS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbZFDReR
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 13:34:17 -0400
Received: from office.neopsis.com ([78.46.209.98]:55322 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZFDReR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 13:34:17 -0400
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Thu, 4 Jun 2009 19:34:16 +0200
In-Reply-To: <4A27F7E6.8060405@xnet.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120702>


On Jun 4, 2009, at 6:35 PM, stuart wrote:

> Hi...
>
> Can I set up a GIT server w/o administration privileges on a Solaris  
> machine?
>
> I think this should be a simple question to answer.  I have looked  
> in the archives - but most, if not all, who post are setting up GIT  
> servers  using administration privileges.  I have a shell account on  
> a Solaris box where I can create web pages and trigger the execution  
> of scripts from those pages...but no administration right.  So, I  
> started down the path of privately installing software.  However, it  
> became apparent that I need git listing on this port and running  
> that daemon...both of which are almost impossible with out  
> administration rights.

The default port of the git daemon is 9418. Unix systems usually don't  
require admin privileges to bind to port >1024. Maybe there's a  
firewall between you and the solaris box preventing you from  
connecting to such non-standard port? If you are sure there is no such  
thing, then simply fire up git-daemon and try to connect to it:

(assuming /path/to/repo.git is the git repository on the server)
server$ git-daemon --export-all --verbose --base-path=/path/to/ /path/ 
to/
client$ git ls-remote git://<server>/repo.git

If the connection was successful, then stop git-daemon, add '--detach'  
to its command line and start it again. It will put itself into the  
background, so you can log off the server and git-daemon will keep  
runnig. One downside is that it will not be automatically restarted  
when it crashes, or when the server is restarted.

> So, is there a way to get some basic GIT functionality through  
> serving up web pages and executing CGI scripts.  Is there somewhere  
> I can read up on this type of server installation?

Git can be used over dumb http protocol. Fetching through http is  
fairly easy, simply put the git repo into a directory where the web  
server has read rights. Pushing through http will likely require you  
to edit the http server settings. Also, git:// protocol is almost  
always preferable over http://.

tom
