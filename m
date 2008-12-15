From: david@lang.hm
Subject: Re: is gitosis secure?
Date: Mon, 15 Dec 2008 00:37:09 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812150026570.17688@asgard.lang.hm>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm> <49460531.8010808@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 08:37:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC81B-0002yg-D8
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 08:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbYLOHgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 02:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbYLOHgH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 02:36:07 -0500
Received: from mail.lang.hm ([64.81.33.126]:54592 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784AbYLOHf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 02:35:59 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBF7ZtPS004340;
	Sun, 14 Dec 2008 23:35:55 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <49460531.8010808@dawes.za.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103135>

On Mon, 15 Dec 2008, Rogan Dawes wrote:

> david@lang.hm wrote:
>
>>
>> as a security person who doesn't like how ssh is used for everything,
>> let me list a couple of concerns.
>>
>> ssh is default allow (it lets you run any commands), you can lock it
>> down with effort.
>>
>> ssh defaults to establishing a tunnel between machines that other
>> network traffic can use to bypass your system. yes I know that with
>> enough effort and control of both systems you can tunnel over anything,
>> the point is that ssh is eager to do this for you (overly eager IMHO)
>>
>> ssh depends primarily on certificates that reside on untrusted machines.
>> it can be made to work with tokens or such, but it takes a fair bit of
>> effort.
>>
>> sshd runs as root on just about every system
>>
>> people trust ssh too much. they tend to think that anything is
>> acceptable if it's done over ssh (this isn't a technical issue, but it
>> is a social issue)
>>
>>
>> what would I like to see in an ideal world?
>>
>> something that runs as the git user, does not enable tunneling, and only
>> does the data transfer functions needed for a push. it should use
>> off-the-shelf libraries for certificate authentication and tie into PAM
>> for additional authentication.
>
> How about a git-specific deployment/configuration of ssh? You can
> certainly run multiple copies of SSH (on different ports), by providing
> a restricted configuration file you can disable tunneling and any other
> functionality that you don't like.
>
> And if you want it to run as a non-root user, simply choose a port>1024,
> but keep in mind that you won't be able to authenticate by password
> (IIRC, only key auth will work when running non-root), or setuid to
> those users when they log in. Nonetheless, this could be sufficient for
> gitosis, since everything runs as the specified user anyway, and IIRC,
> gitosis wants individual SSH pubkeys to allow access.

IMHO this is better then exposing a 'normal' ssh daemon to the Internet 
just to be able to do a git push. the fact that you loose authentication 
options is not a good thing, are you sure that you cannot hook into PAM 
authentication for this?

>> the authentication would not be any better than with SSH, but the rest
>> would be better. I was very pleased to watch the git-daemon development,
>> and the emphisis on it running with minimum privilages and provide just
>> the functionality that was needed, and appropriately assuming that any
>> connection from the outside is hostile until proven otherwise.
>
> In another mail, David wrote:
>
>> 1. if you are running multiple different applications that all want
>> to be exposed via port 22 (like git for 'git push') then you may need
>> to expose numerous machines. tools that use SSH don't tend to have the
>> ability to use a gateway box before they start executing commands,
>> they assume that you will SSH directly into the destination box.
>
> In many cases, especially if the tool is unix based, you can specify (in
> ~/.ssh/config) a Proxy command that is executed before the SSH protocol
> negotiation begins, which results in stdin and stdout being connected to
> the SSH daemon at the destination. The most common variations are the
> HTTP and Socks proxy connectors (e.g. corkscrew?), but the sky is really
> the limit in terms of what is possible.

as I just commented, this looks like it's a per-user config option that is 
designed to be used as a proxy out of the network you are in to get to the 
Internet, not to be used at the far side of a connection to get to things 
on a remote network. as I understand it, you would need to change this 
config file for each different destination network you need to connect to.

David Lang
