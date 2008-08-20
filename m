From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] mailinfo: avoid violating strbuf assertion
Date: Wed, 20 Aug 2008 14:34:59 -0400
Message-ID: <20080820183459.GA26052@redhat.com>
References: <20080819172824.GA9886@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 20:37:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVsYO-00010C-C5
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 20:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbYHTSf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 14:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYHTSf6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 14:35:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41779 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbYHTSf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 14:35:57 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m7KIZDMd027019;
	Wed, 20 Aug 2008 14:35:13 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7KIZ0xd022409;
	Wed, 20 Aug 2008 14:35:11 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m7KIZ0SK013100;
	Wed, 20 Aug 2008 14:35:00 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m7KIZ0R3004931;
	Wed, 20 Aug 2008 14:35:00 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m7KIZ0xm004930;
	Wed, 20 Aug 2008 14:35:00 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <20080819172824.GA9886@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93010>

On Tue, Aug 19, 2008 at 01:28:24PM -0400, Jeff King wrote:
> In handle_from, we calculate the end boundary of a section
> to remove from a strbuf using strcspn like this:
> 
>   el = strcspn(buf, set_of_end_boundaries);
>   strbuf_remove(&sb, start, el + 1);
> 
> This works fine if "el" is the offset of the boundary
> character, meaning we remove up to and including that
> character. But if the end boundary didn't match (that is, we
> hit the end of the string as the boundary instead) then we
> want just "el". Asking for "el+1" caught an out-of-bounds
> assertion in the strbuf library.
> 
> This manifested itself when we got a 'From' header that had
> just an email address with nothing else in it (the end of
> the string was the end of the address, rather than, e.g., a
> trailing '>' character), causing git-mailinfo to barf.

Odd, I just ran into this myself today too.  Wonder if we share the same
culprit.. :-)

Tested-by: Don Zickus <dzickus@redhat.com>
