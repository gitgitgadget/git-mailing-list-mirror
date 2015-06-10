From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] stash: require a clean index to apply
Date: Wed, 10 Jun 2015 12:16:25 -0700
Message-ID: <xmqq616vl6gm.fsf@gitster.dls.corp.google.com>
References: <5570F094.10007@quantopian.com> <20150607124001.GA11042@peff.net>
	<CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
	<20150610185635.GA22800@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?b=C3=A4r?= <crashcookie@gmail.com>,
	Jonathan Kamens <jkamens@quantopian.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 21:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2lUH-0002tG-59
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 21:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbbFJTQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 15:16:29 -0400
Received: from mail-ie0-f196.google.com ([209.85.223.196]:36134 "EHLO
	mail-ie0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbbFJTQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 15:16:28 -0400
Received: by ierx19 with SMTP id x19so6277697ier.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 12:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nTpAhyYAy5toc5qjsjtUNXJG6uHjadJpf2w0m6O3MJo=;
        b=qtEDUdkYsMvBafgNIaJ+2r4eWVM1PSDQG2NJy8iKHHf0psH1Lhcf9P7gV3kLNr0fLA
         vFe+30IGMZu6YT6fhX5HO73fsBokazd7VIOXfgMFsz12AYZb8tZQ2dpasCCuHrKdLvcO
         4e9GX+BWQN8UldeKybA4I9zpHpgge6OSk8ux6Ik/h1ccBZFIgVvVSKP4HHk/csZBzBuX
         NbtHHl9tlPdSH18QCqIeNOO+1fR/KkhW6Gycwn7powjNKH1llHl3RR4GO1doBc7f//Mh
         A2kiBGkpLvd5rYc0a0hQEwJwOE7dCexQKhYgWv0mBZQkw5X1emH0OMnrUeH0HVOlbC56
         CX/A==
X-Received: by 10.107.9.66 with SMTP id j63mr6554583ioi.37.1433963787366;
        Wed, 10 Jun 2015 12:16:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id p196sm6577617iop.15.2015.06.10.12.16.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 12:16:26 -0700 (PDT)
In-Reply-To: <20150610185635.GA22800@peff.net> (Jeff King's message of "Wed,
	10 Jun 2015 14:56:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271347>

Jeff King <peff@peff.net> writes:

> So I am trying to figure out what the use case here is. Clearly the
> above is a toy case, but why is "stash -k" followed by a quick pop
> useful in general? Certainly I use "stash" (without "-k") and a quick
> pop all the time, and I think that is what stash was designed for.
>
> The best use case I can think of is Jonathan's original: to see only the
> staged content in the working tree, and then restore the original state.
> But stash does not currently work very well for that, as shown above.

The canonical use case for "stash -k" is to see only the content to
be committed (for testing), commit it after testing and then pop on
top of the committed result, which is the same as what you saw in
the working tree and the index when you did "stash -k".  I do not
think "stash -k && stash pop" was in the design parameter when "-k"
was added (as you demonstrated, it would not fundamentally work
reliably depending on the differences between HEAD-Index-Worktree).
