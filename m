From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Tue, 09 Dec 2008 09:53:29 +0100
Message-ID: <493E3209.9060105@drmicha.warpmail.net>
References: <493A6CEC.4060601@tuffmail.com>	 <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>	 <493C1F36.7050504@tuffmail.com> <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com> <493C47FD.4080302@tuffmail.com> <493D1CC2.8050407@drmicha.warpmail.net> <493D66BB.3060907@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Grzegorz Kossakowski <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 09:55:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9yNT-0002xS-7K
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 09:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbYLIIxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 03:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbYLIIxm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 03:53:42 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33617 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753471AbYLIIxl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2008 03:53:41 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A348B1E512C;
	Tue,  9 Dec 2008 03:53:39 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 09 Dec 2008 03:53:39 -0500
X-Sasl-enc: aATtHSM0FuGUdns3g5KD61pXqi8etNC/AjYSZ5YKoRNY 1228812819
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D36A32B08F;
	Tue,  9 Dec 2008 03:53:38 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <493D66BB.3060907@tuffmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102608>

Grzegorz Kossakowski venit, vidit, dixit 08.12.2008 19:26:
> Michael J Gruber pisze:
>> Could it be as simple as a missing "cd cocoon" between git clone and git
>> svn rebase? No, you probably did that.
> 
> That would be too easy.
> 
>> But note that you did not follow Peter's instructions. The point is that
>> your clone creates "remotes/origin/trunk" whereas Peter's instructions
>> mirror the source, creating "remotes/trunk", which is what git svn needs
>> (unless you say "git svn init -s --prefix=origin/" or "git config
>> svn-remote.svn.fetch trunk:refs/trunk" etc.). The prefix solution should
>> be the best.
>>
>> Michael
>>
>> P.S.: Peter starts off a different layout (standard svn remotes, which
>> need special instructions to be cloned). Ordinary clone + git svn init
>> --prefix=origin/ should work fine for the cocoon layout.
> 
> This almost worked. Actually, Cocoon repository hosted on Jukka's server does not have local head
> named "trunk" so there is no remotes/origin/trunk created during cloning process.
> 
> I had to run:
> 
>   git update-ref refs/remotes/origin/trunk refs/heads/master

Uhm, I misread gitweb output... So, cocoon really has remotes/trunk, so
that Peter's original suggestion would work. If the cocoon git-svn clone
isn't going to change then Peter's way of doing it might be the best: it
ensures that future pulls from origin (cocoon) will update the correct
refs so that you can pull/fetch from the git-svn clone (fast) and then
git-svn rebase rather than git-svn rebasing directly, which would fetch
new commits from the svn repo first (slow).

I think all in all it shows that git-svns default location for branches
is not the best choice: they're not local, but they're no "proper"
remotes either (unless you use --prefix).

Michael
