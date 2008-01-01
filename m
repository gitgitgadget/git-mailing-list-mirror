From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Tue, 1 Jan 2008 21:23:52 +0100
Message-ID: <20080101202352.GA4295@efreet.light.src>
References: <477822C3.9060002@gbarbier.org> <alpine.LNX.1.00.0712302145500.13593@iabervon.org> <47791F90.8030302@pobox.com> <20080101113301.GC9214@efreet.light.src> <477A26FD.7020408@gbarbier.org> <m3myrpo1p0.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?R3LDqWdvaXJl?= Barbier <gb@gbarbier.org>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 21:24:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9nf5-0000vR-6e
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 21:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbYAAUYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2008 15:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754794AbYAAUYF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 15:24:05 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:53560 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708AbYAAUYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 15:24:04 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 723E157271;
	Tue,  1 Jan 2008 21:24:02 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id EaUtUdyg0eil; Tue,  1 Jan 2008 21:23:59 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id E377657405;
	Tue,  1 Jan 2008 21:23:57 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1J9neS-0001My-T3; Tue, 01 Jan 2008 21:23:52 +0100
Content-Disposition: inline
In-Reply-To: <m3myrpo1p0.fsf@roke.D-201>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69445>

On Tue, Jan 01, 2008 at 10:12:28 -0800, Jakub Narebski wrote:
> Gr=C3=A9goire Barbier <gb@gbarbier.org> writes:
>=20
> > I think that real HTTP support is better than all workarounds we
> > will be able to find to get through firewalls (when CONNECT is not
> > available, some awful VPNs that send Etherne over HTTP may work
> > ;-)).  That's why I'm ok to work several hours on git code to
> > enhance real HTTP(S) support.
>=20
> There was also an idea to create a CGI program, or enhance gitweb
> to use for pushing. I don't know if it would be better way to pursue
> to work around corporate firewalls, or not...

It is what bzr and mercurial do and I think it would be quite good way =
to go
for cases like this. Eg. while our corporate firewall does allow anythi=
ng
through connect on 443 (so I can use ssh that way), it does *not* suppo=
rt
web-dav in non-ssl mode. So I eg. can't even get from public subversion
repositories at work.

I have also thought about optimizing download using CGI, but than I tho=
ught,
that maybe there is a way to statically generate packs so, that if the =
client
wants n revisions, the number of revisions it downloads is O(n) and the
number of packs it gets them from (and thus number of round-trips) is
O(log(n)). Assuming the client always wants everything up to the tip, o=
f
course. Now this is trivial with linear history (pack first half, than =
half
of what's left, etc., gives logarithmic number of packs and you always
download at most twice as much as you need), but it would be nice if so=
mebody
found a way (even one that satisfies the conditions on average only) to=
 do
this with non-linear history, it would be very nice improvement to the =
http
download -- native git server optimizes amount of data transfered very =
well,
but at the cost of quite heavy CPU load on the server.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
