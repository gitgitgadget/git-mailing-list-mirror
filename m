From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 18:03:18 +0100
Message-ID: <490B3A56.3040601@gmx.ch>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com> <m37i7pggnk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jakub Narebski <jnareb@gmail.com>,
	Thanassis Tsiodras <ttsiodras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 18:07:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvxQJ-0005a7-09
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 18:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbYJaRDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 13:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbYJaRDV
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 13:03:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:58477 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751016AbYJaRDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 13:03:20 -0400
Received: (qmail invoked by alias); 31 Oct 2008 17:03:18 -0000
Received: from 165-179.0-85.cust.bluewin.ch (EHLO [192.168.123.204]) [85.0.179.165]
  by mail.gmx.net (mp018) with SMTP; 31 Oct 2008 18:03:18 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/J6iMhrY7JBqJQ4ap6b7EWcxIKUkd/engQt6ul7G
	+dXCkU/DM/pxRm
User-Agent: Thunderbird 2.0.0.17 (X11/20080928)
In-Reply-To: <m37i7pggnk.fsf@localhost.localdomain>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99607>

Jakub Narebski wrote:
> "Thanassis Tsiodras" <ttsiodras@gmail.com> writes:
>> Then again, I must confess I only did the git-gc after I pushed.
>> Does the git-push actually take advantage of the similarities only if
>> I do a git-gc first?
> 
> Git does deltification _only_ in packfiles. But when you push via SSH
> git would generate a pack file with commits the other side doesn't
> have, and those packs are thin packs, so they also have deltas...

AFAICT, git stopped pushing thin packs by default with 1.5.3.2, so
you have to explicitely ask for it.  The original poster might not
be clear about this (or even know what a thin pack is).

Thanassis, try to use "git push --thin".  'man git-push' says:

  --thin, --no-thin
      These options are passed to git-send-pack. Thin transfer spends
      extra cycles to minimize the number of objects to be sent and meant
      to be used on slower connection.

I did a quick test with big random files and it indeed only sends
small deltas on small changes, but if you don't pass --thin, it
will send the full objects.

I didn't find a configuration variable to change that default.  It
would make sense for people that regularly push over slow lines.

Hope this helps,
jlh
