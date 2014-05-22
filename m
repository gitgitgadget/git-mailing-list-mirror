From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git reset for index restoration?
Date: Fri, 23 May 2014 06:33:47 +0700
Message-ID: <CACsJy8Bh+igRNsV0nCQ84EvvOh_ye3pqoTi3g_5ix_1LgX-EvQ@mail.gmail.com>
References: <1400775763.1933.5.camel@stross> <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
 <1400782642.18134.8.camel@stross> <20140522183930.GB1167@sigill.intra.peff.net>
 <1400785669.18134.21.camel@stross> <20140522190959.GA18785@sigill.intra.peff.net>
 <20140522193030.GA22383@sigill.intra.peff.net> <xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
 <1400795586.18134.40.camel@stross> <xmqqd2f5mq5h.fsf@gitster.dls.corp.google.com>
 <1400796077.18134.41.camel@stross> <xmqq61kxmphw.fsf@gitster.dls.corp.google.com>
 <xmqq1tvlmp8w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 01:34:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WncVC-0000WP-6w
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 01:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbaEVXeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 19:34:18 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34768 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbaEVXeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 19:34:18 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so7026600qgf.31
        for <git@vger.kernel.org>; Thu, 22 May 2014 16:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A3gnE5svAbiwRUemho29l8mR0T0Cr+sFtxF6JAa40a4=;
        b=VRUIhRYIR1qPp3RwxkUK7YiX2iV+iaLdcZAqVMkeK4KFV0FX/5drsqAwFi3CD0YQ2G
         bpG+WmDHEQkT2+qio7Iz3/3xPaE5SUdaI7Xs/l6Zb7NesfbCyIwjojwN+S/YlzZlyY+Z
         WhLf9N0QOWwJVU+0NONbxvp+MzJZ1whN3sq4B0ogNRosvZRn4MIdArFty/IsB6VK2EWC
         KBp0Zaz+uc8MMOZdvq+xgiIFn0g7m96kfEQD05F9FqyxLpxCNlrBbagLazLTTBm8iLKd
         WxAV1Zr881nG7gmtx/IVYtOIm5y+cBOTTsXW8lpEeNYCZ3klGbF4BzbTfDJPrECCdaNi
         CVng==
X-Received: by 10.224.138.3 with SMTP id y3mr1417548qat.78.1400801657367; Thu,
 22 May 2014 16:34:17 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Thu, 22 May 2014 16:33:47 -0700 (PDT)
In-Reply-To: <xmqq1tvlmp8w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249962>

On Fri, May 23, 2014 at 5:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ... and the "incrementally repair" Peff talks about would be to
> cover more cases where we may know (either because we have already
> computed it to write out a subtree, or we have just read from a
> known tree to populate a part of the index and we know the paths in
> the index that correspond to that subtree are exactly the same ones
> as found in the tree we read from) parts of the cache-tree can be
> updated with tree object names for subtrees, but we don't do
> anything right now.

I wanted to do this but it's hard. For "diff --cached" (which should
be where we find out and repair cache-tree), we flatten the trees in
traverse_trees() and let unpack-trees figure out the differences
against the index. The's no direct connection between a change and a
tree. Maybe I missed something. David if you are interested in "git
status" performance, this repairing thing could be important when the
worktree is large because the diff cost increases accordingly if
cache-tree is not fully populated. Empty cache-tree could cost us
nearly the same time we save with avoiding opendir/readdir..
-- 
Duy
