From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] Allow emails with boundaries to work again
Date: Wed, 13 Aug 2008 21:56:04 -0400
Message-ID: <20080814015604.GD24172@redhat.com>
References: <1218667559-26618-1-git-send-email-dzickus@redhat.com> <7vtzdogyx6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 03:57:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTS5c-0007ga-JJ
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 03:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYHNB4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 21:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbYHNB4V
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 21:56:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbYHNB4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 21:56:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m7E1u5qf019915;
	Wed, 13 Aug 2008 21:56:05 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7E1u4dt030655;
	Wed, 13 Aug 2008 21:56:04 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m7E1u4q6014209;
	Wed, 13 Aug 2008 21:56:04 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m7E1u4NZ013897;
	Wed, 13 Aug 2008 21:56:04 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m7E1u4aX013896;
	Wed, 13 Aug 2008 21:56:04 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7vtzdogyx6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92306>

On Wed, Aug 13, 2008 at 06:36:53PM -0700, Junio C Hamano wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> > Recent changes to is_multipart_boundary() caused git-mailinfo to segfault.
> > The reason was after handling the end of the boundary the code tried to look
> > for another boundary.  Because the boundary list was empty, dereferencing
> > the pointer to the top of the boundary caused the program to go boom.
> >
> > The fix is to check to see if the list is empty and if so go on its merry
> > way instead of looking for another boundary.
> 
> Hmm, at this point !*content_top means that we are at the outermost level
> and we have just seen --boundary-- which is the terminating one, haven't
> we?  Shouldn't we be simply returning?

That's what I originally did, but then I realized the rest of the
handle_boundary() reads the next line of text, which is needed to continue
processing in handle_body().  :-)

Cheers,
Don
