From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Thu, 3 Jan 2008 22:47:01 +0100
Message-ID: <200801032247.02323.jnareb@gmail.com>
References: <477822C3.9060002@gbarbier.org> <477D3401.2010005@gbarbier.org> <20080103211521.GA4225@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Gr=C3=A9goire_Barbier?= <gb@gbarbier.org>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jan 03 22:47:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAXua-0001RW-VK
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 22:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbYACVrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2008 16:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYACVrL
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 16:47:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:21538 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbYACVrK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 16:47:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2708385ugc.16
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 13:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=99cl52hwF7e+FZh6CDX32QC53DO60mu5FtNValPIo2M=;
        b=WwDzRX8yVzc/Ed+XW0Zlki9cBxteDYcNbhBJ3WkMCXsrktmKtdkg53hZpnChcbdrDmTnNrHImVHriN+nnswVt5iYbFkqDqJgoV9emzw79RmSJUuw6jPl/z7LMbVWHP07UdtO1At430kqKZFf3YHnKHL00JG/A/hTOHmokrGQL9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=w+eWDJJzXPz9A3CgDAZnTbGhKXs/KCeBrD38kH5Px6HHB5j1UbH2zKy1NBThGKD5/hBoCQrwcK8te8HRrvLDCEimXAglLZMOPUPVeVZNpo3fQcEFkc/8u+HVl6fZriysrEn9gVy5zXacWd1D18bFRUBsWliafpdrF22FEbkWhsI=
Received: by 10.67.116.11 with SMTP id t11mr15569075ugm.61.1199396825100;
        Thu, 03 Jan 2008 13:47:05 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.189.34])
        by mx.google.com with ESMTPS id x37sm16914317ugc.76.2008.01.03.13.47.02
        (version=SSLv3 cipher=OTHER);
        Thu, 03 Jan 2008 13:47:03 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080103211521.GA4225@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69540>

Jan Hudec wrote:
> On Thu, Jan 03, 2008 at 20:14:09 +0100, Gr=C3=A9goire Barbier wrote:
>
> > I had a quick look on bzr and hg, and it seems that bzr use the eas=
y way=20
> > (walker, no optimizations)
>=20
> That's not quite true -- bzr has both dumb (walker over plain HTTP) a=
nd smart
> (CGI) methods. But their CGI is really just tunelling their custom pr=
otocol
> over HTTP and that protocol will not be anywhere near what we want fo=
r git
> because of vastly different design of the storage.

Perhaps we could also simply tunnel git protocol over HTTP / HTTPS?
=20
> > and hg a cgi (therefore, maybe optimizations).=20
> > By quick look I mean that I sniff the HTTP queries on the network d=
uring a=20
> > clone. I need to look harder...
>=20
> Yes, mercurial uses a CGI. But I am not sure how similar their approa=
ch is to
> anything that would make sense for git, so looking at the details mig=
ht or
> might not be useful.
>=20
> > BTW I never looked at the git:// protocol. Do you think that by tun=
neling=20
> > the git protocol in a cgi (hg uses URLs of the form=20
> > "/mycgi?cmd=3Dmycommand&...", therefore I think "tunnel" is not a b=
ad=20
> > word...) the performance would be good?
>=20
> It would be pretty hard to tunnel it and it would loose all it's nice
> properties. The git protocol, for pull, basically works like this:
>=20
>  - server sends a list of it's refs
>  - client tells server which ones it wants
>  - client starts listing revisions it has, newest to oldest
>  - server tells client whenever it finds common ancestor with one of =
the
>    heads desired
>  - client restarts the listing from next ref
>  - server starts sending the data when client runs out of refs to lis=
t
>=20
> The main point about the protocol is, that the client is listing the =
refs, as
> fast as it can and server will stop it when it sees a revision it kno=
ws.
> Therefore there will only be one round-trip to discover each common a=
ncestor.
>=20
> However, you can't do this over HTTP, because response won't be start=
ed until
> the request is received. You could be sending a lot of smallish reque=
sts and
> quick, often empty, responses to them. However, that will waste a lot=
 of
> bandwidth (because of the HTTP overhead) and loose much of the speed =
anyway.
> Also the HTTP protocol is stateless, but this is inherently stateful,=
 so you
> would have to work that around somehow too. Therefore a different app=
roach is
> preferable on HTTP.

Perhaps we could use AJAX (XMLHttpRequest for communication, plain HTTP=
 or
IFRAMES for sending data) or something like this for git protocol tunne=
ling?

--=20
Jakub Narebski
Poland
