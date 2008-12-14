From: david@lang.hm
Subject: Re: is gitosis secure?
Date: Sat, 13 Dec 2008 21:40:24 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 05:40:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBimc-0003sP-VX
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 05:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbYLNEjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 23:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbYLNEjT
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 23:39:19 -0500
Received: from mail.lang.hm ([64.81.33.126]:46670 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbYLNEjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 23:39:18 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBE4dEsC028202;
	Sat, 13 Dec 2008 20:39:14 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <gi1qsl$22p$1@ger.gmane.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103049>

this is really a reply to an earlier message that I deleted.

the question was asked 'what would the security people like instead of 
SSH'

as a security person who doesn't like how ssh is used for everything, let 
me list a couple of concerns.

ssh is default allow (it lets you run any commands), you can lock it down 
with effort.

ssh defaults to establishing a tunnel between machines that other network 
traffic can use to bypass your system. yes I know that with enough effort 
and control of both systems you can tunnel over anything, the point is 
that ssh is eager to do this for you (overly eager IMHO)

ssh depends primarily on certificates that reside on untrusted machines. 
it can be made to work with tokens or such, but it takes a fair bit of 
effort.

sshd runs as root on just about every system

people trust ssh too much. they tend to think that anything is acceptable 
if it's done over ssh (this isn't a technical issue, but it is a social 
issue)


what would I like to see in an ideal world?

something that runs as the git user, does not enable tunneling, and only 
does the data transfer functions needed for a push. it should use 
off-the-shelf libraries for certificate authentication and tie into PAM 
for additional authentication.

the authentication would not be any better than with SSH, but the rest 
would be better. I was very pleased to watch the git-daemon development, 
and the emphisis on it running with minimum privilages and provide just 
the functionality that was needed, and appropriately assuming that any 
connection from the outside is hostile until proven otherwise.


what would I do with current tools?

I would say that developers working from outside should VPN into the 
company network before doing the push with SSH rather than exposing the 
SSH daemon to the entire Internet.

in the medium term, if the git-over-http gets finished, I would like to 
see a seperate cgi created to allow push as well. http is overused as a 
tunneling protocol, but it's easy to setup a server that can't do anything 
except what you want, so this tunneling is generally not a threat to 
servers (it's a horrible threat to client systems)

David Lang
