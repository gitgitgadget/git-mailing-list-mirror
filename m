From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 19:30:20 -0800
Message-ID: <20090128033020.GF1321@spearce.org>
References: <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de> <20090127233939.GD1321@spearce.org> <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com> <7vvds0z1c1.fsf@gitster.siamese.dyndns.org> <7vk58gz04l.fsf@gitster.siamese.dyndns.org> <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com> <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 04:31:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS19Z-0000R7-8Q
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 04:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbZA1DaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 22:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZA1DaW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:30:22 -0500
Received: from george.spearce.org ([209.20.77.23]:46577 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbZA1DaV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 22:30:21 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 88C5338210; Wed, 28 Jan 2009 03:30:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v3af4yvmu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107462>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > PJ Hyett <pjhyett@gmail.com> wrote:
> >> 
> >> Is there any possibility to have the server code in an upcoming
> >> release account for clients running 1.6.1?
> >
> > I can't think off-hand of a way for the server to know what version
> > the client is.  There's nothing really different in the protocol
> > between a 1.6.1 client and a v1.5.5-rc0~44^2 (introduction of
> > include-tag) or later client.
> 
> Hmm, I am puzzled.
> 
> I do not know how 41fa7d2 (Teach git-fetch to exploit server side
> automatic tag following, 2008-03-03), which is about the conversation
> between fetch-pack and upload-pack, is relevant to the issue at hand,
> which is about the conversation between send-pack and receive-pack.

Oh, right, its not.  I was pointing out that the last time the
protocol changed in a way the server can infer something about the
client, which IIRC was 41fa7d2, we still don't have a way to tell
what the client is.
 
> In send-pack receive-pack protocol, the server talks first before
> listening to the client, and the .have data is in this first part of the
> conversation.

But as you rightly point out, that's the real problem.  Since the
server talks first, there's no way for the server to avoid giving
out the newer ".have" lines to a buggy client, as it knows nothing
at all about the client.  Not even its capabilities.

PJ - the short story here is, to forever work around these buggy
1.6.1 clients, you'd have to either run an old server forever,
or forever run a patched server that disables the newer ".have"
extension in the advertised data written by git-upload-pack.
There just isn't a way to hide this from the client.

Really though, I'd recommend getting your users to upgrade to a
non-buggy client.  Pasky has the same problem on repo.or.cz; if
he doesn't have it already he will soon when he upgrades...

-- 
Shawn.
