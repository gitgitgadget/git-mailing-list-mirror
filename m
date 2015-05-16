From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sh -x -i -v with continuous integration, was Re: [PATCH 1/4] t7601: test for pull.ff=true overrides merge.ff=false
Date: Sat, 16 May 2015 12:07:23 -0700
Message-ID: <xmqq1tigfij8.fsf@gitster.dls.corp.google.com>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
	<1431510740-9710-2-git-send-email-pyokagan@gmail.com>
	<2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
	<xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
	<81926313e0a131cd7224f0f6f8984dd2@www.dscho.org>
	<xmqqh9rf84we.fsf@gitster.dls.corp.google.com>
	<20150516152858.GA19269@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 16 21:07:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YthQw-00063U-La
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 21:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbbEPTH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2015 15:07:27 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35824 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbbEPTH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2015 15:07:26 -0400
Received: by igbyr2 with SMTP id yr2so21341350igb.0
        for <git@vger.kernel.org>; Sat, 16 May 2015 12:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4EV0ALaGpfiyCp44yfPnmtQTcHPm/I+TYrGFmBC5/QU=;
        b=QK61IJYKgHLQLuyW7HrxW83evpxa0BCpmSlQ+tnZjsGVQ0aCpUxCRlUo8xES2NBdy6
         iEknbBVHf3gQuJIgPZQsQe1ngfMHLqNFbeoGILEs/G8beckchU/TgQZlF/19VgvxxCJr
         6GlGOMvTshCXX/NwsZzgRQJ+y1taDvn4Q9z8gaZ+gt1FOxKcgRFwRdFP136H6138yCIj
         YkCI//rl7nLsC2FPex08E3JX+C7qUirOWSlFFp4ru2eAK+Oky5AaNSxzHb26qVNlNEKl
         yWMM3/rJyKpY14fV4sg46sTcLvM+1bQp+OwBNeb1d6Gd5tljMdHkcdsBfFRZNsartXXM
         mqwg==
X-Received: by 10.50.79.228 with SMTP id m4mr5559371igx.42.1431803245108;
        Sat, 16 May 2015 12:07:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c15a:d232:e950:b701])
        by mx.google.com with ESMTPSA id c16sm3996292ioj.29.2015.05.16.12.07.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 16 May 2015 12:07:24 -0700 (PDT)
In-Reply-To: <20150516152858.GA19269@peff.net> (Jeff King's message of "Sat,
	16 May 2015 11:28:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269200>

Jeff King <peff@peff.net> writes:

> Do we object to having to sprinkle the "verbose" throughout the test
> scripts?

Yes.  

An unconstrained "verbose" that applies to anything would make
people less careful to come up with more useful abstractions,
e.g. test_line_count, which I view as a bigger problem.

"verbose test", regardless of how it is spelled, either as two words
"verbose test", a "verbose_test" helper, or a helper function that
overrides "test", share the same issue, as their unconstrained-ness
comes from the fact that test is too broad a command.  I'd rather
want to see us move more in the direction of encouraging things like
test_line_count, which makes it easier to write new tests with less
mistakes (e.g. by hiding the BSD wc pitfall "$(wc -l <file)", in
test_line_count's case).
