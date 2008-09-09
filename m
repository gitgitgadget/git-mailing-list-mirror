From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: git apply vs. renamed files index mismatch
Date: Tue, 9 Sep 2008 19:14:46 +0400
Message-ID: <20080909151446.GA10395@oksana.dev.rtsoft.ru>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com> <1220900995-11928-2-git-send-email-becky.bruce@freescale.com> <48C57A92.6060608@freescale.com> <20080908212717.GA21338@oksana.dev.rtsoft.ru> <7vej3ucf6y.fsf@gitster.siamese.dyndns.org> <20080909100628.GA15298@oksana.dev.rtsoft.ru> <7vtzcp8jk0.fsf@gitster.siamese.dyndns.org>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Scott Wood <scottwood@freescale.com>,
	Becky Bruce <becky.bruce@freescale.com>,
	linuxppc-dev@ozlabs.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 17:20:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd4wh-0001jw-Ts
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 17:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbYIIPOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 11:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbYIIPOv
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 11:14:51 -0400
Received: from rtsoft3.corbina.net ([85.21.88.6]:11720 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751442AbYIIPOu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 11:14:50 -0400
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 8D75B8826; Tue,  9 Sep 2008 20:14:46 +0500 (SAMST)
Content-Disposition: inline
In-Reply-To: <7vtzcp8jk0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95398>

On Tue, Sep 09, 2008 at 07:45:19AM -0700, Junio C Hamano wrote:
> Anton Vorontsov <avorontsov@ru.mvista.com> writes:
> 
> > Now consider the following patch (modified by hand: it should say
> > +foo, but I changed it to +bar).
> > ...
> > The "index ..." stuff says that there are no changes and it is
> > pure rename, but obviously there is a change.
> 
> Ah, I see what you mean.  But in general, it is not obvious at all.
> 
> If you have the identical preimage (recorded on the LHS of the index line)
> or the patch reproduces the postimage in full (i.e. "create a new file"),
> you *could* notice.  It's an interesting idea from git person's point of
> view (i.e. "would be fun to implement"), but I doubt it would be useful in
> practice, because:
> 
>  (1) You often do not have the identically matching preimage;
> 
>  (2) More importantly, it is not unusual for people to *edit* the patch in
>      their MUA (think of typofixes), after getting it out of git.

Not for rename patches...

>  (3) Even more importantly, even if you notice there is some difference,

Just noticing that there is a difference is enough.

As for implementing, isn't this as simple as this pseudo code:

if (index_deleted_file == index_new_file)
	if (deleted_file != new_file)
		printk("warning\n");

In the git-apply?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
