From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Fri, 04 Sep 2015 17:54:11 -0700
Message-ID: <xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 02:54:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY1kH-0006x5-HJ
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 02:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbbIEAyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 20:54:14 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32795 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934318AbbIEAyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 20:54:13 -0400
Received: by pacex6 with SMTP id ex6so38735735pac.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9DI/lu/v4bF90zOPg4MweFEUo7VEFxM+jJ4NqIpHtsA=;
        b=iHJF7AbQKjOKXtjEiA4KQcE2/VdwC8iK56dmH4G2MJykG2G1zRjGN+xZy/Ak6lB+2C
         q7BY33aLvy4gQRYwKvl0gvftGueEGOWJ2jh61ZHu81sovwHnHTQ3nwMxlGkOauY65Ibd
         Q7mkDOLObU1BBPSVUJTQKGVK9FtTeKQroobqbFzOqxwk96gOQM/4gWCEtgIggb02s3mp
         BJx/eLX8qGYEhmhovZ2v4BkAj2/iL5o4thr8+PlfgfSAY4tp0QYFss/ODkrCnV2s/+Eq
         vkKsm6WejdTEtvw5PIKovJRfka8v/GRRDof3G20mHESA0+fR/8gXXvCUiy64KIwMMW5b
         CRuQ==
X-Received: by 10.66.100.168 with SMTP id ez8mr14263438pab.142.1441414452884;
        Fri, 04 Sep 2015 17:54:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id x3sm3865161pdr.43.2015.09.04.17.54.11
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 17:54:12 -0700 (PDT)
In-Reply-To: <CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 4 Sep 2015 16:52:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277353>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I think that logic should basically be extended to saying
>
>  - if any line in the last chunk has a "Signed-off-by:", set a flag.
>
>  - at the end of the loop, if that flag wasn't set, return 0.

I am reluctant to special case S-o-b: too much, even though this is
about "am -s" and by definition S-o-b: is special, as that is what
we are adding after all.

How about a bit looser rule like this?

    A block of text at the end of the message, each and every
    line in which must match "^[^: 	]+:[      ]" (that is,
    a "keyword" that does not contain a whitespace nor a colon,
    followed by a colon and whitespace, and arbitrary value thru
    the end of line) is a signature block.
