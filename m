From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 17:21:50 +0100
Message-ID: <4BFE9C1E.7050308@llaisdy.com>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com> <4BFE83A7.4020604@llaisdy.com> <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com> <4BFE8A99.5060906@llaisdy.com> <20100527151514.GB18590@coredump.intra.peff.net> <4BFE8DF8.8050301@llaisdy.com> <20100527153812.GA23484@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu May 27 18:22:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHfqq-0005uU-1w
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 18:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134Ab0E0QVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 12:21:53 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:55585 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755411Ab0E0QVw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 12:21:52 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id EF797DEC52
	for <git@vger.kernel.org>; Thu, 27 May 2010 17:21:50 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id LukyUP8KKF75 for <git@vger.kernel.org>;
	Thu, 27 May 2010 17:21:50 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id C1008DEB75
	for <git@vger.kernel.org>; Thu, 27 May 2010 17:21:50 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100527153812.GA23484@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147885>

On 27/05/2010 16:38, Jeff King wrote:
> Then the next thing to try is probably (assuming you are running Linux):
>    
Well, kind of: it's CentOS, which I'm finding quite recalcitrant (e.g. I 
had to install strace).
>    strace -f -e execve git pull
>
> Though I suspect we may just see:
>
>    execve("/opt/libexec/git-core/git-core/git-pull", ...) = -1 EACCES (Permission denied)
>
> which doesn't help much. I just want to be sure that is the source of
> the problem.
>    
No, the output is interesting.  The permissions denied is from the 
erroneous /root install (see separate email):

     [pid  3485] execve("/root/libexec/git-core/git-pull", ["git-pull"], 
[/* 18 vars */]) = -1 EACCES (Permission denied)

It looks in /opt/bin, but not /opt/libexec.

It could be a botched git install or it could be a botched PATH --- I 
have had to fiddle about with it a bit.  For example, /opt/libexec is 
not on my PATH  ...  In fact my PATH *is* botched:

     $ $PATH
     bash: /opt/bin:<snip/>:/usr/bin:/root/bin: No such file or directory

Those last two items don't look good at all.  And:

     $ PATH=/opt/libexec/git-core/:$PATH
     $ git pull
     remote: Counting objects: 8, done.
     ...
      1 files changed, 2 insertions(+), 1 deletions(-)

Working!

So:
- git itself is probably OK
- I have a botched PATH, which I should fix asap

Does git expect certain paths to be on a user's PATH?  If so perhaps 
that is all that is wrong.

Best wishes

Ivan

-- 
============================================================
Ivan A. Uemlianin
Speech Technology Research and Development

                     ivan@llaisdy.com
                      www.llaisdy.com
                          llaisdy.wordpress.com
                      www.linkedin.com/in/ivanuemlianin

     "Froh, froh! Wie seine Sonnen, seine Sonnen fliegen"
                      (Schiller, Beethoven)
============================================================
