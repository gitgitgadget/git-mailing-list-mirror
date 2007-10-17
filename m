From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Wed, 17 Oct 2007 21:27:26 +0200
Message-ID: <8c5c35580710171227o45c6b113ve10f293a4505bab5@mail.gmail.com>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com>
	 <118833cc0710170739i179e7389k1e44f70086ca88be@mail.gmail.com>
	 <DC3D43FD-F03D-4E0A-9C2B-DE56F9C16D60@silverinsanity.com>
	 <8c5c35580710170839l4b31a4fao5b41efafc5a83883@mail.gmail.com>
	 <8B2F7666-DCEB-4D58-ACFE-F40587CD415D@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Morten Welinder" <mwelinder@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:27:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiEYS-0004uz-5K
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760284AbXJQT12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 15:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759887AbXJQT12
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:27:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:38364 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbXJQT11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 15:27:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2892143wah
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qtigjrfLBnNFJF7tj56hhZiL/DMbFabxW/PqQ4xaoX0=;
        b=p+wkXIZJuDcr0E8od5HEPW3YpfK1vsY3Pvd/4fvF/3cNSduNthxv1cVZLt8UHyg5OHsUhR8XBnzOLwrhnHL/rDHUXAo3s6ya1mRAkseBsS8pusnBEQscOqe46Q/FcxYYhKrTmVBVGoTj7VDZmZaHQ17Tuvdn4XBgMClEsp5JlT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B/8DQt7fWXgayDIY351jKi0HUca1Do7uOmNZlv1FfCgeKX7JkfjUhFQyCAnowHulwgXWQhXfRx9CG9FGBLxOF/fzYd8cbuIzQP154U6MHN2dVRP2YTbj4uOdzc70G+k9Q9A/3J1t9e+sb+Tqpcw0ARSlJTClmJQ73TUQCivwYKw=
Received: by 10.114.77.1 with SMTP id z1mr10257349waa.1192649246149;
        Wed, 17 Oct 2007 12:27:26 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 17 Oct 2007 12:27:26 -0700 (PDT)
In-Reply-To: <8B2F7666-DCEB-4D58-ACFE-F40587CD415D@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61414>

On 10/17/07, Brian Gernhardt <benji@silverinsanity.com> wrote:
> I wish I got this much attention the first time I tried to get this
> problem fixed.  ;-)
>
> On Oct 17, 2007, at 11:39 AM, Lars Hjemli wrote:
>
> > This makes me wonder: what about all the other instances of die() in
> > git-cvsserver? Or in any of the other perl scripts, for that matter?
> > Should they all be fixed, or is it this particular test that is wrong?
>
> The reason this comes up is because t/test-lib.sh:test_expect_failure
> () thinks codes > 128 (or negative values if you want to look at it
> that way) are bad tests.  I believe this is because many shells use
> these codes to indicate things like "command not found" or other
> probably unexpected failures.
>
> Other than that, does it matter what die() returns, as long as it's
> non-zero?

My point exactly ;-)

If the test is changed to use 'test_expect_success' in the same way as
'req_Root failure (relative pathname)' does it, the test no longer
depends on the exact exit-code returned by die().

IMHO this is much better future-proofing than replacing die() with
print()/exit 1 whenever one of these tests fails.

--
larsh
