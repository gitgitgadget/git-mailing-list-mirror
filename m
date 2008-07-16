From: Kevin Ballard <kevin@sb.org>
Subject: Useful tip about !aliases
Date: Tue, 15 Jul 2008 17:46:08 -0700
Message-ID: <3BD7F543-7CB4-48B6-8D2C-DEA2ADC6EF5F@sb.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 02:47:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIvAk-0007oM-24
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 02:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbYGPAqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 20:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbYGPAqL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 20:46:11 -0400
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:59539 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752404AbYGPAqK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 20:46:10 -0400
Received: from [10.100.18.129] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 5E3B2109EB9
	for <git@vger.kernel.org>; Tue, 15 Jul 2008 17:46:09 -0700 (PDT)
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88616>

Here's something I discovered recently about !aliases that other folks  
might find useful. The canonical form for a shell alias is something  
like

   git config alias.foo '!echo bar'

where any args given to foo, as in `git foo blah` are passed along to  
the shell, so in this case `echo bar blah` would be invoked.

Something that I find very useful is the ability to interpolate  
arguments into the middle of a command. This doesn't seem possible at  
first glance, not without a helper script. But it certainly is  
possible, with the help of shell functions:

   git config alias.reverse '!foo () { args=''; while [[ -n "$*" ]];  
do args="$1 $args"; shift; done; echo $args; }; foo'

Now if you invoke `git foo one two three` you'll get the response  
"three two one".

Here's another example. This one I particularly like. I call it 'send- 
patches', because what it does is it takes a single hash and creates  
patches out of all commits since that hash, invokes send-mail on them,  
and deletes them. It's a rather quick way of sending off patches. And  
if you pass any extra arguments, they're given to git-send-email. The  
most useful part is it adjusts the patch prefix to contain the name of  
the repository itself, so your recipient knows exactly what your patch  
is for.

   git config --global alias.send-patches '!foo () { rev="$1"; shift;  
git send-email $(git format-patch -o .mbox --no-prefix --subject- 
prefix="$(printf "PATCH: %s" $(basename $(cd "$(git rev-parse --show- 
cdup)" && pwd)))" $rev) "$@"; rm -rf .mbox; }; foo'

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
