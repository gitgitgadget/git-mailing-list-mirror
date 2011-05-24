From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 07/10] pack-objects: Allow --max-pack-size to be used
 together with --stdout
Date: Tue, 24 May 2011 03:15:06 +0200
Message-ID: <201105240315.06549.johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-8-git-send-email-johan@herland.net>
 <7vlixxrmbr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 03:15:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOgDK-0004K6-Ut
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 03:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948Ab1EXBPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 21:15:09 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39311 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab1EXBPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 21:15:08 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO008JDE57GS30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 03:15:07 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 7BCB31799885_DDB069BB	for <git@vger.kernel.org>; Tue,
 24 May 2011 01:15:07 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E5EC517969F2_DDB069AF	for <git@vger.kernel.org>; Tue,
 24 May 2011 01:15:06 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO00K8SE56F930@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 03:15:06 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7vlixxrmbr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174307>

On Tuesday 24 May 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Currently we refuse combining --max-pack-size with --stdout since
> > there's no way to make multiple packs when the pack is written to
> > stdout. However, we want to be able to limit the maximum size of the
> > pack created by --stdout (and abort pack-objects if we are unable to
> > meet that limit).
> > 
> > Therefore, when used together with --stdout, we reinterpret
> > --max-pack-size to indicate the maximum pack size which - if exceeded
> > - will cause pack-objects to abort with an error message.
> 
> I have to say that I am not very fond of this approach.
> 
> Imagine that in the future we may want to allow 32-bit receivers to say
> "I want you to transfer data but I cannot handle very large packs
> locally, so please send the packs in less-than-1GB chunks to make it
> easier for me to store them in separate packfiles" (obviously this
> involves a new protocol extension). The underlying machinery the sending
> side would use would naturally want to say
> 
> 	git pack-objects --max-pack-size=1GB --stdout
> 
> and you would see the data for the first pack, followed by the data for
> the second pack, etc. on the standard output.  Such a receiver might also
> want to say "You are not allowed to send more than 3GB at once to me" to
> the sending side. What should the "pack-objects" command line look like?
> 
> I think you should keep the two concepts separate. max-pack-size should
> stay the limit of each packfile "git pack-objects" is allowed to produce,
> and there should be another option to specify the total pack data to be
> produced, perhaps named --max-total-pack-size or something.

Ok. I will separate the concepts in the next iteration.

> That would make your earlier "count" thing --max-total-commit-count; it
> is perfectly fine that we do not plan to have the --max-commit-count
> option that is per packfile.

Agreed.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
