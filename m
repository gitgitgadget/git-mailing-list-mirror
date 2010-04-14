From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git log of remote repositories.
Date: Wed, 14 Apr 2010 21:45:52 +0200
Message-ID: <20100414194552.GA5178@dualtron.lan>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com>
 <slrnhsba0k.h9q.heipei@dualtron.heipei.net>
 <x2q3abd05a91004141208x6e154385l8b7ce6488d65f21b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 21:45:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O28Wa-0006sl-Lt
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 21:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510Ab0DNTpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 15:45:17 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:52495 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486Ab0DNTpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 15:45:16 -0400
Received: from u-7-245.vpn.rwth-aachen.de ([137.226.103.245]:39811 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1O28WP-00057b-SQ; Wed, 14 Apr 2010 21:45:14 +0200
Content-Disposition: inline
In-Reply-To: <x2q3abd05a91004141208x6e154385l8b7ce6488d65f21b@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 137.226.103.245
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144898>

On 14/04/10 15:08, Aghiles wrote:
> It seems to me like a major restriction! Especially that I am tracking
> a remote branch ... No possibilities to do a diff or a log without fetching?
> Very sad. :(

Major restriction? Have you understood how git works, internally? The
first thing you'd have to do is to get the data (i.e. your version or
their version) on one of the sides then do the diff there. Now, that
either means you have to upload your non-matching objects or they have
to upload their non-matching objects. Next up, you might not even have
the authority (or technical possibility) to put data on that server
(think http), so obviously the diff will have to be done at your side.

So, what will be transmitted? Data the server already has but you don't.
git determines this data and then packs it into an efficient format and
sends it to you. Which is what? A diff of your version vs. theirs.
Except we don't transmit plain diffs but pack them up nicely so the data
is smaller and (because you now effectively fetched it) can be reused
any time after that initial diff.

If you're worried you might be downloading GBs of data in the process
you can always interrupt a running fetch.

Now, one might think of some very limited form of log. Like "git
remote-log master..master@origin" (syntax made up). This would be
something which could only be used with smart protocols and would
display a log (which you couldn't trust because you can't verify the
integrity and still has not much metadata). And it would be a heap of
new functionality to implement for something that doesn't fit into the
workflow of a git user. For the user it would probably take the same
amount of time as simply fetching everything new in most cases.

Or you can use SVN and have real online-diffs with real speed ;)

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0xD47A7FFC
GPG-Fingerprint: 5441 D425 6D4A BD33 B580  618C 3CDC C4D0 D47A 7FFC
