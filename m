From: Erik Warendorph <erik@warendorph.org>
Subject: Re: preserving mtime
Date: Fri, 16 Nov 2007 13:09:30 +0100
Message-ID: <20071116120929.GA28144@localhost.localdomain>
References: <473D63F9.4010201@inrim.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fabrizio Pollastri <f.pollastri@inrim.it>
X-From: git-owner@vger.kernel.org Fri Nov 16 13:09:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It019-0000W3-0o
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 13:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046AbXKPMJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 07:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756217AbXKPMJd
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 07:09:33 -0500
Received: from lakepoint.domeneshop.no ([194.63.248.54]:54766 "EHLO
	lakepoint.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbXKPMJd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 07:09:33 -0500
Received: from localhost ([195.1.76.68])
	(authenticated bits=0)
	by lakepoint.domeneshop.no (8.13.8/8.13.8) with ESMTP id lAGC9ULR020725;
	Fri, 16 Nov 2007 13:09:30 +0100
Content-Disposition: inline
In-Reply-To: <473D63F9.4010201@inrim.it>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65219>

* Fabrizio Pollastri <f.pollastri@inrim.it> [2007-11-16 10:33:45 +0100]:
>
> is it possible to tell git to preserve the file modification time in a 
> checked out copy? It is useful when managing web files, where mtime is 
> tested by spiders for download decisions.

You may find the script "git-set-file-times" in the GitWiki
useful:

  ExampleScripts - GitWiki
  Setting the timestamps of the files to the commit timestamp
  of the commit which last touched them
    <http://git.or.cz/gitwiki/ExampleScripts#head-a57deb2b4ab1e2de80ab5fd3c681a6055a9d3247>

You should of course pay attention to advice about (and
against) doing stuff like this, both in the description of that
script and in other postings on this list.  But as you are
using Git to manage web files and you (probably) don't care
about build systems such as "make", you should be pretty safe.

About the script:  I think it originally was made by Eric Wong
(= normalperson) who is also on this list.  I have just made a
tiny, tiny modification to it (adding " or s/\0$//" to the
elsif test).

I've also thought about adding a --prefix option to the script.
This would enable it to be used together with git-archive,
leaving the working directory alone and affecting the files in
the directory where the archive is extracted instead.  In this
way, you would distinguish between your working directory and
your "live" directory, and the command sequence

  git archive --prefix=foo/ HEAD | (cd /var/www/ && tar xf -)
  git-set-file-times --prefix=/var/www/foo/

would be part of the build system, publishing your working
directory to your "live" directory (in this case
/var/www/foo/).

-- 
Erik Warendorph <erik@warendorph.org>
