From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 09/23] pack v4: commit object encoding
Date: Tue, 03 Sep 2013 02:30:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309030225450.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-10-git-send-email-nico@fluxnic.net>
 <CACsJy8CnSyw2ae5BS87S8Hid51JVFB3gyLzX+5czwio+C=-VRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 08:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGk8b-0002DK-OY
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 08:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759422Ab3ICGat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 02:30:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39768 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab3ICGas (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 02:30:48 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSJ00KEGE3CY700@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Sep 2013 02:30:48 -0400 (EDT)
In-reply-to: <CACsJy8CnSyw2ae5BS87S8Hid51JVFB3gyLzX+5czwio+C=-VRQ@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233682>

On Tue, 3 Sep 2013, Duy Nguyen wrote:

> On Tue, Aug 27, 2013 at 11:25 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > This goes as follows:
> >
> > - Tree reference: either variable length encoding of the index
> >   into the SHA1 table or the literal SHA1 prefixed by 0 (see
> >   add_sha1_ref()).
> >
> > - Parent count: variable length encoding of the number of parents.
> >   This is normally going to occupy a single byte but doesn't have to.
> >
> > - List of parent references: a list of add_sha1_ref() encoded references,
> >   or nothing if the parent count was zero.
> 
> With .pack v3 it's impossible to create delta cycles (3b910d0 add
> tests for indexing packs with delta cycles - 2013-08-23) but it is
> possible with .pack v4 (and therefore at least index-pack needs to
> detect and reject them), correct? Some malicious user can create
> commit A with parent ref 1, then make the SHA-1 table so that ref 1 is
> A. The same with the new tree representation.

pack-index should validate the SHA1 of the object being pointed at.

In that case I doubt you'll be able to actually construct an object 
which contains a SHA1 parent reference and make the SHA1 of this very 
object resolve to the same value.


Nicolas
