From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Adding a challenge-response authentication method to
	git://
Date: Wed, 13 Aug 2008 17:57:23 -0700
Message-ID: <20080814005723.GM3782@spearce.org>
References: <20080813162644.GC12200@cuci.nl> <20080813164038.GE3782@spearce.org> <20080813173757.GE12200@cuci.nl> <20080813180857.GH3782@spearce.org> <20080814001029.GA14939@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Aug 14 02:58:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTRAZ-0003pB-A5
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 02:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbYHNA5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 20:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbYHNA5Y
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 20:57:24 -0400
Received: from george.spearce.org ([209.20.77.23]:56014 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbYHNA5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 20:57:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 725F038375; Thu, 14 Aug 2008 00:57:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080814001029.GA14939@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92302>

"Stephen R. van den Berg" <srb@cuci.nl> wrote:
> I'm not trying to solve all management problems, I'm just trying to
> offer a simple solution for the small-user-base-central-repository case
> without a lot of code-bloat on the git side.
> If it doesn't fit ones needs, use ssh or something else; but it does
> have its merits for the simple centralised setups.

OK, then my final two cents, and I'll shutup.

- Add to git-daemon a new service command, "git-authenticate-user".
- Clients request "git-authenticate-user 'repository'".
- The auth_user routine:
	enters 'repository' ('ala upload-pack)
	execs "git-authenticate-user ."

- git-authenticate-user:
	send pkt-line challenge
	recv pkt-line username
	recv pkt-line SHA-1(username + password + challenge)
	
	read gitconfig for "auth.passwordfile"
	read passwordfile for entry $username
		("user:pass:upload-pack,receive-pack")
	verify response

	send pkt-line ok/fail
	recv pkt-line "git-$service '.'"
	check $service is allowed
	exec git-$service .

-- 
Shawn.
