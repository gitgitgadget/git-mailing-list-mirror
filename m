From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/6] rebase: prepare to write reflog message for checkout
Date: Thu, 13 Jun 2013 23:35:13 +0530
Message-ID: <CALkWK0k3Wr7x_4NAHzY0xEg7sQG6qLe2cr2tJusGZBNHEtPNHg@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-3-git-send-email-artagnon@gmail.com> <7vbo79vqzm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:06:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBuJ-0006sJ-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757415Ab3FMSF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:05:56 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:50127 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab3FMSFz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:05:55 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so11257543iej.15
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+gPGLIJLAPoGgUbGdBoQ+74ggnlzzJ3vfLTyfJ2Qr0E=;
        b=h0RuNUE34fATZVU8JbxH79EIe/2T3sWg8Uiu2nz/MDSyv07Uk/i34VctJW02bGVJvD
         cxXMplkV4xZ2083o+NTs6h1FyhDF8aYP4gI8lBwGfETMPI+c75mkmm1PH235pj5K9L1w
         RwOqoUmoNmYnMoNh3yIm8cvMLsgOkpA24mMHX6tsm37tGWOzxAXyW51jjRLIrceGbkEb
         89AqcVPX2hbEeX55WATcAfLsEB2IuZRx0jNYYNZWb0ScrNzlpy+AOstD+1BcZOKivn7d
         sjgzc0F2aykRPkDKvbU+JGzWaLXZ6IlLHeZtzyBMVLVvQr/kuS2N06VawOfH/DJ0tSdg
         ATJA==
X-Received: by 10.50.25.194 with SMTP id e2mr840443igg.111.1371146754907; Thu,
 13 Jun 2013 11:05:54 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 13 Jun 2013 11:05:13 -0700 (PDT)
In-Reply-To: <7vbo79vqzm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227759>

Junio C Hamano wrote:
> [...]

Will fix those.

> I suspect doing 6/6 before this patch may make more sense.

Yeah, I'd done it like that in the original (early preview thing).
Allow me to explain why I flipped the ordering.

The problem I am facing is that 6/6 causes very major breakages, and
5/6 attempts to minimize that fallout and make life for 6/6 easier.
The problem with putting this patch (and the rebase -i) after those
two is simple: it calls set_reflog_action, but never explicitly
indicates that it wants to set the reflog message for checkout.  As a
result, the reflog messages are merely accidental and will look like:

  rebase
  rebase -i (start)

in both the critical patches (5/6 and 6/6).  This was an absolute
debugging disaster for me, and I didn't know what wt-status was trying
to tell me with its cryptic "detached HEAD to" and "detached HEAD
from" messages.

Makes sense?
