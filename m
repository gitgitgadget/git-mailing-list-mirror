From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] commit walk machinery is dangerous !
Date: Mon, 14 Jul 2008 14:55:00 -0700
Message-ID: <7vbq10f7wr.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0807141641110.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 23:56:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIW1k-0006Fd-JH
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 23:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbYGNVzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 17:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbYGNVzM
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 17:55:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbYGNVzM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 17:55:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 80CFA26AFF;
	Mon, 14 Jul 2008 17:55:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D6FDA26AFD; Mon, 14 Jul 2008 17:55:07 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807141641110.12484@xanadu.home> (Nicolas
 Pitre's message of "Mon, 14 Jul 2008 16:54:24 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 879B7EDE-51EF-11DD-B334-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88471>

Nicolas Pitre <nico@cam.org> writes:

> However this time a corruption turned up and exposed what I think is a 
> major flaw in git's error checking.  To demonstrate it, I created the 
> following test case.  Turning the error() into a die() on line 772 of 
> commit.c makes this test pass but I don't know if this is the 
> appropriate fix (e.g. some attempt to parse non existing commits could 
> be valid usage, etc.).  Note this is critical only for git versions 
> later than commit 8eca0b47ff15.

Which probably means we should revert that commit as faulty?  IIRC, before
that commit we did check and error out correctly but you loosened the
check to introduce "a major flaw" with that commit.

$ for b in maint master next pu
  do
      echo -n $b; git cat-file blob $b:commit.c | wc -l
  done
maint 672
master 672
next 779
pu 789

Hmph...
