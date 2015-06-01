From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] silence missing-link warnings in some cases
Date: Mon, 01 Jun 2015 08:03:05 -0700
Message-ID: <xmqqmw0j8o9i.fsf@gitster.dls.corp.google.com>
References: <556C0BAD.80106@atlas-elektronik.com>
	<20150601081450.GA32634@peff.net>
	<556C1A95.9010704@atlas-elektronik.com>
	<20150601085226.GA20537@peff.net> <20150601095410.GA16976@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 17:03:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzRFC-0000JS-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbbFAPDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 11:03:10 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34173 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbbFAPDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 11:03:08 -0400
Received: by ieczm2 with SMTP id zm2so111086044iec.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fAJwNJrPxEfZGxGJJ2e6FlJ3yWdWzwx1ozIP7h+5RVU=;
        b=eg3L6PCCZU9h0DmxMUo1KDPO1OOo8Ab1BjZoHwPX2Fun/Ofoswz+DSGvZyHhPivvjV
         m1gjubnkKmX+WTf74qR/4IJWkzBs+Csfula3mCD20Br1mQqemMDFk6wt6UaObrh3Zn42
         CbSJlauF/3bu8rc37qdlyf3uHY339sL/3WB4ppL82jE/KTZCepRi/s69yTPQGDiQLYO9
         FglQ6flh40WKUh1w9gZ5/ep9RrJ0BDwwRr+hkXZXxZ/dPKuX3/GxSrG2HR03eqSabFvs
         CxtkhJyV7hduIoyMo4ukFoUp/RTdJ9kxb4vzUEUegqWV9Rr2uPVWTjb5CxfbLo2up+cR
         AWTA==
X-Received: by 10.50.59.180 with SMTP id a20mr13976124igr.23.1433170988170;
        Mon, 01 Jun 2015 08:03:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id q78sm10569441ioe.9.2015.06.01.08.03.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 08:03:06 -0700 (PDT)
In-Reply-To: <20150601095410.GA16976@peff.net> (Jeff King's message of "Mon, 1
	Jun 2015 05:54:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270421>

Jeff King <peff@peff.net> writes:

> Stefan noticed that running "git gc" with a recent version of git causes
> some useless complaints about missing objects.
>
> The reason is that since git d3038d2 (prune: keep objects reachable from
> recent objects, 2014-10-15), we will traverse objects that are not
> reachable but have recent mtimes (within the 2-week prune expiration
> window). Because they are not reachable, we may not actually have all of
> their ancestors; we use the revs->ignore_missing_links option to avoid
> making this a fatal error. But we still print an error message. This
> series suppresses those messages.

Nice finding.  One of us should have thought of this kind of fallout
when we discussed that change, but we apparently failed.

The fixes make sense to me (I haven't carefully read the
implementation, but design/approach explained in the proposed log
messages are very sound), and I think 3/3 is a good thing to do,
too, in the new world order after d3038d2.

Thanks, both.
