From: Sam Vilain <sam@vilain.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Tue, 11 Jan 2011 10:07:46 +1300
Message-ID: <4D2B7522.9050400@vilain.net>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com> <alpine.LFD.2.00.1101061552580.22191@xanadu.home> <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com> <alpine.LFD.2.00.1101062221480.22191@xanadu.home> <20110107052207.GA23128@sigill.intra.peff.net> <20110107053119.GA23177@sigill.intra.peff.net> <20110107185218.GA16645@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org,
	Shawn Pearce <sop@google.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Joshua Roys <roysjosh@gmail.com>,
	Nick Edelen <sirnot@gmail.com>, Jonas Fonseca <fonseca@diku.dk>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Jan 10 22:36:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcPPU-0006ss-25
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 22:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab1AJVgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 16:36:12 -0500
Received: from mx7.orcon.net.nz ([219.88.242.57]:50870 "EHLO mx7.orcon.net.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754926Ab1AJVgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 16:36:09 -0500
X-Greylist: delayed 1668 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jan 2011 16:36:09 EST
Received: from Debian-exim by mx7.orcon.net.nz with local (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PcOyR-0005rZ-F9
	for git@vger.kernel.org; Tue, 11 Jan 2011 10:08:19 +1300
Received: from [60.234.254.246] (helo=mail.utsl.gen.nz)
	by mx7.orcon.net.nz with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PcOyR-0005rR-5c
	for git@vger.kernel.org; Tue, 11 Jan 2011 10:08:19 +1300
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id E09332E09B; Tue, 11 Jan 2011 10:08:18 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on naos.lan
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.83] (arcturus.lan [192.168.1.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 2CA0C2E094;
	Tue, 11 Jan 2011 10:07:47 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20110107185218.GA16645@LK-Perkele-VI.localdomain>
X-Enigmail-Version: 1.1.2
X-DSPAM-Check: by mx7.orcon.net.nz on Tue, 11 Jan 2011 10:08:19 +1300
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Tue Jan 11 10:08:19 2011
X-DSPAM-Confidence: 0.6192
X-DSPAM-Probability: 0.0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164897>

On 08/01/11 07:52, Ilari Liusvaara wrote:
> Ability to contact multiple servers in sequence, each time advertising
> everything obtained so far. Then treat the new repo as clone of the last
> address.
>
> This would e.g. be very handy if you happen to have local mirror of say, Linux
> kernel and want to fetch some related project without messing with alternates
> or downloading everything again:
>
> git clone --use-mirror=~/repositories/linux-2.6 git://foo.example/linux-foo
>
> This would first fetch everything from local source and then update that
> from remote, likely being vastly faster.

Coming to this discussion a little late, I'll summarise the previous
research.

First, the idea of applying the straight BitTorrent protocol to the pack
files was raised, but as Nicolas mentions, this is not useful because
the pack files are not deterministic.  The protocol was revisited based
around the part which is stable, object manifests.  The RFC is at
http://utsl.gen.nz/gittorrent/rfc.html and the prototype code (an
unsuccessful GSoC project) is at http://repo.or.cz/w/VCS-Git-Torrent.git

After some thought, I decided that the BitTorrent protocol itself is all
cruft and that trying to cut it down to be useful was a waste of time. 
So, this is where the idea of "automatic mirroring" came from.  With
Automatic Mirroring, the two main functions of P2P operation - peer
discovery and partial transfer - are broken into discrete features.

I wrote this patch series so far, for "client-side mirroring":

http://thread.gmane.org/gmane.comp.version-control.git/133626/focus=133628

The later levels are roughly discussed on this page:

http://code.google.com/p/gittorrent/wiki/MirrorSync

The "mirror sync" part is the complicated one, and as others have noted
no truly successful prototype has yet been built.  Actually the Perl
gittorrent implementation did manage to perform an incremental clone; it
just didn't wrap it up nicely.  But I won't go into that too much. 
There was also another GSoC program to look at caching the object list
generation, the most expensive part of the process in the Perl
implementation.  This was a generic mechanism for accelerating object
graph traversal and showed promise, however unfortunately was never merged.

The client-side mirroring patch, in its current form, already supports
out-of-date mirrors.  It saves refs first into
'refs/mirrors/hostname/...' and finally contacts the main server to
check what objects it is still missing.  So, if there was a regular
bittorrent+bundle transport available, it would be a useful way to
support an incremental clone; the client would first clone the (static)
bittorrent bundle, unpack it with its refs into the 'refs/mirrors/xxx/'
namespace, making the subsequent 'git fetch' to get the most recent
objects a much more efficient operation.

Hope that helps!

Cheers,
Sam
