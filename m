From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] git-mailinfo: Fix getting the subject from the body
Date: Mon, 14 Jul 2008 23:13:56 -0400
Message-ID: <20080715031356.GQ16127@redhat.com>
References: <4876820D.4070806@etek.chalmers.se> <7v3amfxx3a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 05:18:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIb43-0000yp-4z
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 05:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652AbYGODR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 23:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbYGODR4
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 23:17:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbYGODRz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 23:17:55 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m6F3DvDm023431;
	Mon, 14 Jul 2008 23:13:57 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m6F3DvFK017968;
	Mon, 14 Jul 2008 23:13:57 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m6F3DumA003395;
	Mon, 14 Jul 2008 23:13:56 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m6F3DuxO022339;
	Mon, 14 Jul 2008 23:13:56 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m6F3Dusl022338;
	Mon, 14 Jul 2008 23:13:56 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7v3amfxx3a.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88510>

On Sat, Jul 12, 2008 at 02:36:57AM -0700, Junio C Hamano wrote:
> Another thing I noticed and found puzzling is the handling of ">From "
> line that is shown in the context below.  check_header() is supposed to
> return true when it handled header (i.e. not part of the commit message)
> and return false when line is not part of the header.  As ">From " is part
> of the commit log message, shouldn't it return zero?
> 
> Don, this part was what you introduced.  Has this codepath ever been
> exercised in the real life?

Heh.  Most emails I deal with usually wind up causing the code to stop
looking for header info (still_looking=0).  So I never ran into that
scenario.  And I never really tried to rely on inbody stuff.

I thought I was mimicing the original code, guess not.

Now that I think about it, I did run into a situation last year where
git-mailinfo parsed the '>From' as an inbody header instead of a commit
msg.  I just put a stupid hack in my scripts to work around, thinking it
was my scripts.

Anyway if it returns zero, wouldn't it be better to just remove the check
to begin with?  I kinda forgot why it is there in the first place (my
changes just copied it from somewhere else).

Cheers,
Don
