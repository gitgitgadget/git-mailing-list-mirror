From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Tue, 25 Jun 2013 16:03:52 -0700
Message-ID: <1372198415-sup-2114@pimlott.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net> <87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net> <1371278908-sup-1930@pimlott.net> <7vk3lvlmat.fsf@alter.siamese.dyndns.org> <87ip1e2tzx.fsf@hexa.v.cablecom.net> <7v7ghtjwbb.fsf@alter.siamese.dyndns.org> <8738shi2ht.fsf@linux-k42r.v.cablecom.net> <7vwqpshkxj.fsf@alter.siamese.dyndns.org> <1372190294-sup-1398@pimlott.net> <7v61x127bw.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 01:04:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrcHL-0007sC-2O
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 01:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab3FYXD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 19:03:59 -0400
Received: from pimlott.net ([72.249.23.100]:37779 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697Ab3FYXD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 19:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Cc:Content-Type; bh=yweKnrfJUhESh8EnQSjl4BafFiRZbvam69yxvDOw6XU=;
	b=L+setIATtjDftuznfLW7llSFlLYqFtAIZtbOKeWdxl20kigkjXnGUMSbU8p7eSFr50iJ4/bMPupYDmIIjG0YiqCYavuV31MQktoiJzxaNo6LlH7twHEU9inRwAV4f+vd1Fw0EvTy/3lq1RFI8jKKnD52q0SnQ9QQ0Nt0hDiizis=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UrcHA-0004Xn-At; Tue, 25 Jun 2013 16:03:52 -0700
In-reply-to: <7v61x127bw.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229013>

Excerpts from Junio C Hamano's message of Tue Jun 25 14:45:07 -0700 2013:
> After all, autosquash will give the user an opportunity to eyeball
> the result of automatic rearrangement.  If the user did this:
> 
>     git commit -m original
>         git commit --fixup original ;# obviously fixing the first one
>         git commit --fixup '!fixup original' ;# explicitly fixing the second
>     git commit --fixup original ;# may want to fix the first one
> 
> and then "git rebase --autosquash" gave him this:
> 
>     pick d78c915 original
>         fixup 0c6388e original
>         fixup d15b556 !fixup original
>         fixup 1e39bcd original

I assume you mean:

    pick d78c915 original
    fixup 0c6388e fixup! original
    fixup d15b556 fixup! fixup! original
    fixup 1e39bcd !fixup! original

The current master code tries to keep the original commit message
intact.  I assume you would preserve that behavior, so you would want to
see "fixup! fixup!"

> it may not be what the user originally intended, but I think it is
> OK.
> 
> As long as "!fixup original" message is kept in the buffer, the user
> can notice and rearrange, e.g.

Thomas's patch didn't do this: fixup! or squash! after the first is
simply discarded, so you see:

    pick d78c915 original
    fixup 0c6388e fixup! original
    fixup d15b556 fixup! original
    fixup 1e39bcd !fixup! original

But it will be a simple change to keep all the fixup!s and squash!s.  I
will do this (and try to make up for the carelessness of my previous
patch).

Andrew
