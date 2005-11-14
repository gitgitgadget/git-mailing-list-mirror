From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Balanced packing strategy
Date: Mon, 14 Nov 2005 11:24:35 +0100
Message-ID: <200511141124.35429.Josef.Weidendorfer@gmx.de>
References: <W4340426396265721131944586@webmail12>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Craig Schlenter" <craig@codefountain.com>,
	"Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Nov 14 11:26:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbbW0-0003bP-5G
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 11:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVKNKYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 05:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVKNKYk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 05:24:40 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:61061 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751044AbVKNKYk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 05:24:40 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id F179027E6;
	Mon, 14 Nov 2005 11:24:36 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <W4340426396265721131944586@webmail12>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11784>

On Monday 14 November 2005 06:03, Craig Schlenter wrote:
> Hi
> 
> > From: Josef Weidendorfer [mailto:Josef.Weidendorfer@gmx.de]
> > [snip]
> > AFAICS, the git native protocol (which is nothing more than a pack itself
> > for each transfer) even has this problem, too: If you are updating every
> > day via git native, the sum of transfered bytes in a month will be a
> > multiple of one git transfer for all the month's changes.
> 
> Interesting ... is this because in a bigger pack the compression will
> be better as there is probably more stuff to "delta" against?

No, it is because of the self-containment of git packs: Deltas (storing
differences instead of full file content) are only allowed to other
objects in the same pack. The self-containment is a safety measure: you
do not want to have dependencies to the outside, because this would
destroy the contents of a pack by changing/removing another file.

So if the changes of a day are 100 oneliners to different files, the pack
has to contain the full content of the 100 files. With incremental
packing, you would probably add only the 100 oneliners (ie. deltas) at end
of the pack, because the full file contents have to be in the pack if there
was a change to them recorded in the pack previously. And this probability
is higher if the pack contains a larger history of the project.

Back to the example: By doing a git transfer every day, you always will
transfer the full contents of files which where changed on this day, because
git protocol transfers self-contained packs.

Josef
