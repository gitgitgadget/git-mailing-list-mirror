From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: 'git replace' and pushing
Date: Thu, 25 Nov 2010 09:37:52 +0100
Message-ID: <4CEE2060.4020507@drmicha.warpmail.net>
References: <AANLkTinzPCeCJ486cysmk981HE61=dv9MS7E8Ap4rQ5r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Cory Fields <FOSS@AtlasTechnologiesInc.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:40:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLXNA-0007aT-J7
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab0KYIkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:40:00 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58842 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751681Ab0KYIkA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 03:40:00 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D486839C;
	Thu, 25 Nov 2010 03:39:59 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 25 Nov 2010 03:39:59 -0500
X-Sasl-enc: WBJA9I+lS8cmRenKhVaUlub3SvmYwgo07IDAoh25hAmK 1290674399
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4B21B5E753C;
	Thu, 25 Nov 2010 03:39:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <AANLkTinzPCeCJ486cysmk981HE61=dv9MS7E8Ap4rQ5r@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162117>

Cory Fields venit, vidit, dixit 24.11.2010 05:33:
> I am having some trouble understanding how a replaced object (commit)
> should behave when pushed to a remote repo. Here's my scenario:
> 
> We are moving from svn to git. Our svn repo is huge, and most of the
> history is useless. To save space, I would like to do a 50/50 split so
> that when the repo is cloned, 50% is seen by default, and the
> historical 50% can be seen by fetching the replacement history. I've
> done this by creating a phony snapshot at 3 then using a 'replace' to
> put the others on top. The history is purely linear.
> 
> 1---2---3---4---5
>                  \---4---5

I assume the "other" 4 goes off 3 (you're not using a monospaced font,
are you?).

Also, the other 4 should have no parent, otherwise you've not cut-off
any history.

> 
> When the replacement is in place, the repo is half size (commit-wise)
> as expected. The problem is that 'git push' does not honor the
> replace. So when I push, all objects go with it, which defeats the
> purpose. The only way that seams to work is doing a filter-branch and
> replacing the other way.
> 
> Is this by design? I would really like a way to split the repo without
> breaking hashes for the developers that have already begun using git
> svn.

It is by design since a replace creates a "fake history", and this
should not be created behind a users back.

The 5 is not rewritten, and it's ancestry contains the whole history. If
that is the commit your developers have already and that you want to
preserve then there's not much you can do.

You could try to push or pull your replacement refs first (refs/replace)
but I don't think this will change what objects the push of 5 will
transfer. Just have a try.

Michael
