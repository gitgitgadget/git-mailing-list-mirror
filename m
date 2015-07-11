From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Git Smart HTTP with HTTP/2.0
Date: Sat, 11 Jul 2015 21:26:57 +0300
Message-ID: <20150711182657.GA8589@LK-Perkele-VII>
References: <BLU403-EAS33258611CF3B5B553B1C996A09E0@phx.gbl>
 <20150711070055.GA4061@LK-Perkele-VII>
 <CAJo=hJs21m1C6+rdvCid311-TapK=QKLkqrH8aUZmzHH7CpVug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: ForceCharlie <fbcharlie@outlook.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 11 20:27:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDzUP-0000L5-Qc
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 20:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbbGKS1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 14:27:00 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:53293 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbbGKS07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 14:26:59 -0400
Received: from LK-Perkele-VII (a91-155-194-207.elisa-laajakaista.fi [91.155.194.207])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id B888618878D;
	Sat, 11 Jul 2015 21:26:57 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <CAJo=hJs21m1C6+rdvCid311-TapK=QKLkqrH8aUZmzHH7CpVug@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273876>

On Sat, Jul 11, 2015 at 10:23:09AM -0700, Shawn Pearce wrote:
> On Sat, Jul 11, 2015 at 12:00 AM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> > On Sat, Jul 11, 2015 at 11:10:48AM +0800, ForceCharlie wrote:
> >
> >> Frequently used Git developers often feel Git HTTP protocol is not
> >> satisfactory, slow and unstable.This is because the HTTP protocol itself
> >> decides
> >
> > Note that there are already two versions of HTTP transport, the old "dumb"
> > one and the newer "smart" one.
> >
> > The smart one is difficult to speed up (due to nature of the negotiations),
> > but usually is pretty reliable (the efficiency isn't horrible).
> 
> The negotiation in smart-HTTP actually has some bad corner cases. Each
> round of negotiation requires a new POST resupplying all previously
> agreed upon SHA-1s, and a batch of new SHA-1s. We have observed many
> rounds where this POST is MiBs in size because the peers can't quite
> agree and have to keep digging through history.

Oh yeah that... Well, that is artifact of HTTP semantics.

> > Now, the old "dumb" protocol is pretty unreliable and slow. HTTP/2 probably
> > can't do anything with the reliability problems, but probably could improve
> > the speed a bit.
> >
> > Websockets over HTTP/2 (a.k.a. "websockets2") has not been defined yet.
> > With Websockets(1), it would probably already be possible to tunnel the
> > native git smart transport protocol over it. Probably not worth it.
> 
> Another option is to tunnel using gRPC (grpc.io). libcurl probably
> can't do this. And linking grpc.io library into git-core is crazy. So
> its probably a non-starter. But food for thought.

Wouldn't it link into git-remote-http (and on the server side, one
could use pipes to talk to git)?

But supporting websockets in git-remote-http could get annoying,
especially for wss:// (https://). Dunno how bad gRPC would be.



-Ilari
