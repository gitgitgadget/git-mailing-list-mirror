From: bdowning@lavos.net (Brian Downing)
Subject: Re: Draft release notes for v1.5.3, as of -rc1
Date: Fri, 13 Jul 2007 08:50:34 -0500
Message-ID: <20070713135034.GK19073@lavos.net>
References: <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net> <7vejl0546b.fsf@assigned-by-dhcp.cox.net> <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net> <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net> <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com> <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com> <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com> <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net> <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> <7vlkdkq00o.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 15:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9LYk-0007bg-RB
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 15:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933775AbXGMNus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 09:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935557AbXGMNur
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 09:50:47 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:5155 "EHLO
	asav14.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935499AbXGMNuq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 09:50:46 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav14.insightbb.com with ESMTP; 13 Jul 2007 09:50:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhQuACAgl0ZKhvbzRmdsb2JhbACHKYgEAQEBPg
Received: by mail.lavos.net (Postfix, from userid 1000)
	id D3031309F32; Fri, 13 Jul 2007 08:50:34 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vlkdkq00o.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52394>

On Thu, Jul 12, 2007 at 11:40:39PM -0700, Junio C Hamano wrote:
> GIT v1.5.3 Release Notes (draft)
> ========================
> 
> * New commands and options.

  - "git repack" learned a "window-memory" limit which dynamically
    reduces the window size to stay within the specified memory usage.

"git-repack -a -d -f --window=100000 --window-memory=512m" seems to be
good for those overnight make-it-smaller-damn-the-torpedoes archival
repackings.  (You can't just set --window to BIGNUM as it still
allocates an array of that size.)  Thanks to Nicolas Pitre's depth bias
patch a high --depth doesn't seem to be quite as critical anymore to
save space; it still helps, but things much much better at a lower
depth.

As a point of reference, it took around two hours to repack a repository
containing 108,440 objects, around 35,000 files (most with no history),
and my aforementioned troublesome 20MB RTF file (which uses about 60MB
per revision when sitting in the window due to the delta index cache)
with the above command.  This is on a 2GHz Core 2 Duo in 64-bit mode.

-bcd
