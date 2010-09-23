From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] git-gui: Work around freeze problem with dialogs in Mac OS X
Date: Thu, 23 Sep 2010 09:39:06 +0200
Message-ID: <1jp9mb7.wvga2l1g48z3oM%lists@haller-berlin.de>
References: <7vocbpsivd.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, dsteffen@apple.com (Daniel A Steffen),
	das@users.sourceforge.net (Daniel A. Steffen)
To: gitster@pobox.com (Junio C Hamano)
X-From: git-owner@vger.kernel.org Thu Sep 23 09:39:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OygOj-0003wn-5n
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 09:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab0IWHjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 03:39:12 -0400
Received: from mail.ableton.net ([62.96.12.115]:34024 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656Ab0IWHjL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 03:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=uqSurIH7q8R2gSQlWqVyKSj+yDqG/N1uZa5yRc0Iujs=;
	b=cVtiupDXs0p+KgRZFW6cy35CNeM9/95VTrUEf5QXI5hrYZyMkzHSLueKoRtRZlqeaXEEQLJMib6cAfm5ZkX3ur++rQIFMtVnIkg0WeV2HvlD5FoIZWdJW+T2IeH8mL4SM9zqTFNvZ/leSseVak6kSOb94tYa9sm1AmkxKwQOv6U=;
Received: from dslb-088-073-104-214.pools.arcor-ip.net ([88.73.104.214] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OygOY-0005DC-MW; Thu, 23 Sep 2010 09:39:06 +0200
In-Reply-To: <7vocbpsivd.fsf@alter.siamese.dyndns.org>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156857>

Junio C Hamano <gitster@pobox.com> wrote:

> lists@haller-berlin.de (Stefan Haller) writes:
> 
> > Tk 8.5 on Mac OS X has a bug whereby a dialog opened from a key
> > binding will hang; see issue 3044863 in the Tk issue tracker.
> > <http://sourceforge.net/tracker/?func=detail&aid=3044863&group_id=12997&atid=112997>
> >
> > To work around this, we perform commands that open a dialog after
> > a brief delay; 150 ms seems to be a good compromise between short
> > enough as to be not annoying, and long enough to reliably work
> > around the issue.
> >
> > Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> 
> Is 150ms applicable no matter how fast or slow your Mac is, or is Mac so
> monoculture that everybody's machine has more or less the same performance
> characteristics?  IOW does this need to be autoadjusted?

To be honest, I don't know.  I was hoping that Daniel could shed some
light on whether this is dependent on the machine's performance, or why
the delay is needed at all (i.e. why a simple "after idle" won't do, as
one would have expected).

> I see a lot of wrapping around foo::dialog; without knowing much about
> Tcl, I wonder if it would be simpler, less error prone and more future
> proof to add the wrapping logic around something commonly used from them,
> e.g. class::make_dialog.

I need to wrap the top-level entry points of the command handlers,
because we want the delay only when the command is invoked from a key
binding, not when a menu item is selected with the mouse, or a button is
pushed.  Inside the functions, at the place where the dialog is created,
I can't tell from where we were called.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
