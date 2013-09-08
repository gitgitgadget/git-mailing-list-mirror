From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] t: branch: improve test rollback
Date: Sun, 8 Sep 2013 00:56:06 -0400
Message-ID: <20130908045606.GF14019@sigill.intra.peff.net>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
 <1377923511-20787-5-git-send-email-felipe.contreras@gmail.com>
 <xmqqwqmxr9a7.fsf@gitster.dls.corp.google.com>
 <CAMP44s2BU86zZ_KE78BPYpsjBZJ7Mj0MJqM4Lj28AKxYfeLVDQ@mail.gmail.com>
 <xmqqtxi1o6kf.fsf@gitster.dls.corp.google.com>
 <CAMP44s1Q6YjVnVz3OnT=cE+ozUddBxFzM1r_WT5QoR7sP6-9Sg@mail.gmail.com>
 <xmqq61ugo67v.fsf@gitster.dls.corp.google.com>
 <CAMP44s2PFVAKRUkEyN8BAH8C5UUMn21ou9hNkcOXaCsXscywHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIX2l-00010w-Dk
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab3IHE4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:56:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:42276 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab3IHE4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:56:10 -0400
Received: (qmail 388 invoked by uid 102); 8 Sep 2013 04:56:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Sep 2013 23:56:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 00:56:06 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2PFVAKRUkEyN8BAH8C5UUMn21ou9hNkcOXaCsXscywHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234181>

On Sat, Sep 07, 2013 at 10:02:59PM -0500, Felipe Contreras wrote:

> 'git checkout -' works perfectly fine, and it's the closest we have to
> my suggested test_checkout() which I think would be ideal, but I'm not
> going to work on.

I do not think it works perfectly fine if the checkout itself fails. For
example, after your patch, one of the tests reads:

  test_when_finished "git checkout -" &&
  git checkout HEAD^{} &&
  test_must_fail git branch --set-upstream-to master

The cleanup is undoing what happened on the second line. So if we fail
on the third line, it does what we want. If we fail on the second line,
then what branch are switching to?

I think you would at least want to reverse the order as:

  git checkout HEAD^{} &&
  test_when_finished "git checkout -" &&
  test_must_fail git branch --set-upstream-to master

so that you know you are actually going to the pre-test state.

-Peff
