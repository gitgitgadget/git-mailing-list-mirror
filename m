From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 1/2] mergetool: don't skip modify/remove conflicts
Date: Mon, 14 Feb 2011 22:30:55 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102142204240.7843@debian>
References: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297570198-21103-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297570198-21103-2-git-send-email-martin.von.zweigbergk@gmail.com> <7v1v3aqfqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 04:31:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpBdJ-0001t5-Dv
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 04:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab1BODbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 22:31:05 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44045 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab1BODbD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 22:31:03 -0500
Received: by vxb37 with SMTP id 37so3146560vxb.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 19:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=WzYrVbPnB7ZRPaIF2tAwCNmn6KbgDoHMVcmeiktgHRE=;
        b=G2YIsN9VScgAUTwrflWMhaRZgnNMNAFHzFplFFG+iYsWCLbH3DYUdCUmwSorGrPeOW
         ZQGGvMDgH4YGbgjDGWNHtBiM1CqMHgU7zbkf+SKa8m5qNmUOjbIOOnthMz1imS9fLhgG
         MQrqPmLbdEnsjJzYzOnFo77viNdwjSNWO34SU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=CPJTteT3DkoSVcShtgKl6bhtU/OKgoZM6NPo3rJh/sF1Fo/vzmN1k4axyuTm+SYc1f
         QrcDVuOPhU0mp/haqJrOe292FFRNTgprFz2DHTjN9S+bsLNVoFSwrfx/uR5fHXXvgqBg
         iZtxfDTFIyRWv9eKae4LPhyYVDrsWgUkHwBWY=
Received: by 10.220.192.135 with SMTP id dq7mr168283vcb.233.1297740662527;
        Mon, 14 Feb 2011 19:31:02 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id n13sm1086068vcr.17.2011.02.14.19.31.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 19:31:01 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7v1v3aqfqm.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166809>

On Mon, 14 Feb 2011, Junio C Hamano wrote:

> But shouldn't you also revert the parts of my patch to do_plain_rerere()
> and rerere_forget() that have similar special cases?

Yep, done in patch 2/2.

Your changes in find_conflicts() are still there after patch 1/2 and
since do_plain_rerere() and rerere_forget() call find_conflicts(), I
think they need to check for the punted paths. Only the callers of
setup_rerere() no longer need to care.

In patch 2/2, I refactored a bit more, so that find_conflicts()
behaves the way it did before your first patch, and then the checks
for punted paths are removed from the callers.

If you think the second one is good, it could easily be squashed with
the first one.  I left it separate because I wasn't quite sure. For
example, could the interface to check_one_conflict() be improved? As
you said, part of the changes from your patch are now undone, so I
guess all three patches could even be squashed.


/Martin
