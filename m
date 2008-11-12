From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in	packs
 with a .keep file
Date: Wed, 12 Nov 2008 11:30:26 -0600
Message-ID: <NRnq_JA3Ngz2v6EUhSwtVu5zewgvJgLsW85zZZqzrYE@cipher.nrlssc.navy.mil>
References: <20081103161202.GJ15463@spearce.org> <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil> <20081112080909.GA29176@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:31:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0JZP-0006iR-3g
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbYKLRan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbYKLRan
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:30:43 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43037 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbYKLRam (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:30:42 -0500
Received: by mail.nrlssc.navy.mil id mACHUR99018119; Wed, 12 Nov 2008 11:30:27 -0600
In-Reply-To: <20081112080909.GA29176@coredump.intra.peff.net>
X-OriginalArrivalTime: 12 Nov 2008 17:30:27.0165 (UTC) FILETIME=[5A1DE8D0:01C944EC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100777>

Jeff King wrote:
> On Mon, Nov 03, 2008 at 02:37:05PM -0600, Brandon Casey wrote:
> 
>> This version replaces the use of 'head -n -1' with a grep, and should work on
>> all platforms.
> 
> Hmm. I'm not sure what happened, but the version in 'next' has "head -n
> -1" in it.

Well, there were so many revisions, I probably should have re-rolled the
whole series. I wasn't sure this was going to go in as is, based on the
[Dropped] message in the "What's Cooking" email and Junio's last email about
reconciling --unpacked and --incremental. I have been working through
the --unpacked code path, but I'm not to the point where I can suggest
a change there.

But, I think it's worse than just the wrong t7700.

These two:

   packed_git: convert pack_local flag into generic bit mask
   packed_git: add new PACK_KEEP flag and haspackkeep() access macro

should have been replaced by:

   packed_git: convert pack_local flag into a bitfield and add pack_keep

which uses a struct bitfield rather than a bitmask.

And then this

   pack-objects: honor '.keep' files

was replaced by this

   pack-objects: new option --honor-pack-keep
   repack: don't repack local objects in packs with .keep file

if that's the way we want to go. I'm not partial to the phrase honor-pack-keep,
but I don't think ignore-pack-keep is appropriate, and it's the best I've come
up with.

So,

   31d92611e45d1286b805e362dbc451936af24121
   7c335327be664751fa4c04e81b2fe3bfedceaada
   77b5a5478a77cc04b674891b542db1ba1a1bf4f7
   13e7f5d2f1da42619bd545590d0044b30d00ce4b

should be reverted, and replaced by the series to follow.

-brandon
