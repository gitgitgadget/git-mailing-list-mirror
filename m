From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bug/feature request: apply textconv in "git add -p" diff output
Date: Sat, 20 Jun 2009 11:41:15 +0200
Message-ID: <4A3CAEBB.9030107@drmicha.warpmail.net>
References: <fcaeb9bf0906200017x6cc63c29q5515c11c202e424e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 11:41:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHx4g-0008NH-DT
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 11:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbZFTJlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 05:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbZFTJlQ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 05:41:16 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39724 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750900AbZFTJlP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Jun 2009 05:41:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 31C6636565D;
	Sat, 20 Jun 2009 05:41:18 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 20 Jun 2009 05:41:18 -0400
X-Sasl-enc: Y5UwOLikcKvV5hmvNXn5NxxGJ7sJZKDGl63In73ZWXVF 1245490877
Received: from localhost.localdomain (p54858056.dip0.t-ipconnect.de [84.133.128.86])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 889512A277;
	Sat, 20 Jun 2009 05:41:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090617 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <fcaeb9bf0906200017x6cc63c29q5515c11c202e424e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121939>

Nguyen Thai Ngoc Duy venit, vidit, dixit 20.06.2009 09:17:
> Hi,
> 
> I use git to manage bdf font files. It it quite cryptic so textconv
> for diff output makes it much easier to keep track of changes. The
> only problem is that "git add -p" does not seems to use textconv, so I
> have to run in parallel "git diff" and "git add -p", then add chunks
> accordingly. Can somebody add textconv support to "git add -p" please?
> I'm not so good at Perl to do the job.

I don't think this is possible: textconv filters are meant to produce
easily readable output from diff, but in no way are they required to be
injective mappings. So, textconv output cannot to be used in order to
specify a patch uniquely.

The appropriate approach is to use smudge/clean filters. They are
mutually inverse. And, in fact, I just checked: add -p uses the cleaned
version. So, if clean converts to "something textual" which gives you
readable diffs and meaningful stats (and smudge converts to binary bdf)
then that is the way to go.

Michael
