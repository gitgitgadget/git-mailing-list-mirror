From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: is gitosis secure?
Date: Mon, 15 Dec 2008 09:52:49 +0200
Message-ID: <49460CD1.70305@dawes.za.net>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm> <49460531.8010808@dawes.za.net> <alpine.DEB.1.10.0812150026570.17688@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Dec 15 08:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC8HR-0006DM-EK
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 08:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYLOHw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 02:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbYLOHw6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 02:52:58 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:58968
	"EHLO spunkymail-a14.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751668AbYLOHw5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Dec 2008 02:52:57 -0500
X-Greylist: delayed 1950 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Dec 2008 02:52:57 EST
Received: from artemis.local (unknown [41.27.142.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a14.g.dreamhost.com (Postfix) with ESMTP id 45671190E2C;
	Sun, 14 Dec 2008 23:52:53 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <alpine.DEB.1.10.0812150026570.17688@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103136>

david@lang.hm wrote:
> On Mon, 15 Dec 2008, Rogan Dawes wrote:
> 
>> david@lang.hm wrote:
>>
>>>
>>> what would I like to see in an ideal world?
>>>
>>> something that runs as the git user, does not enable tunneling, and only
>>> does the data transfer functions needed for a push. it should use
>>> off-the-shelf libraries for certificate authentication and tie into PAM
>>> for additional authentication.
>>
>> How about a git-specific deployment/configuration of ssh? You can
>> certainly run multiple copies of SSH (on different ports), by providing
>> a restricted configuration file you can disable tunneling and any other
>> functionality that you don't like.
>>
>> And if you want it to run as a non-root user, simply choose a port>1024,
>> but keep in mind that you won't be able to authenticate by password
>> (IIRC, only key auth will work when running non-root), or setuid to
>> those users when they log in. Nonetheless, this could be sufficient for
>> gitosis, since everything runs as the specified user anyway, and IIRC,
>> gitosis wants individual SSH pubkeys to allow access.
> 
> IMHO this is better then exposing a 'normal' ssh daemon to the Internet
> just to be able to do a git push. the fact that you loose authentication
> options is not a good thing, are you sure that you cannot hook into PAM
> authentication for this?

I *think* that an unprivileged user cannot invoke PAM for accounts other
than its own, and most certainly cannot change to that other user
without being setuid (or having the appropriate capability).


>> In many cases, especially if the tool is unix based, you can specify (in
>> ~/.ssh/config) a Proxy command that is executed before the SSH protocol
>> negotiation begins, which results in stdin and stdout being connected to
>> the SSH daemon at the destination. The most common variations are the
>> HTTP and Socks proxy connectors (e.g. corkscrew?), but the sky is really
>> the limit in terms of what is possible.
> 
> as I just commented, this looks like it's a per-user config option that
> is designed to be used as a proxy out of the network you are in to get
> to the Internet, not to be used at the far side of a connection to get
> to things on a remote network. as I understand it, you would need to
> change this config file for each different destination network you need
> to connect to.

That may be its original intention, but it can nonetheless be used for
other purposes. Yes, you might need a different configuration for each
network that you need to access, and quite possibly for each location
that you need to access them from. This may result in config entry
proliferation, but it is manageable, especially with the openssh
wildcard syntax in the config file.

man ssh_config:

Host
Restricts the following declarations (up to the next Host keyword) to be
only for those hosts that match one of the patterns given after the
keyword.  If more than one pattern is provided, they should be separated
by whitespace.  A single `*' as a pattern can be used to provide global
defaults for all hosts.  The host is the hostname argument given on the
command line (i.e. the name is not converted to a canonicalized host
name before matching).

e.g

Host *-home
   ProxyCommand . . . .

FWIW.

Rogan
