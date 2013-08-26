From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] write_index: optionally allow broken null sha1s
Date: Mon, 26 Aug 2013 10:35:01 -0700
Message-ID: <20130826173501.GS4110@google.com>
References: <20130824013310.GA9343@sigill.intra.peff.net>
 <20130825061500.GR2882@elie.Belkin>
 <20130825095818.GA12556@sigill.intra.peff.net>
 <20130825195412.GA2752@elie.Belkin>
 <20130826142704.GA14858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:35:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0h7-00030z-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab3HZRfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:35:07 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40519 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab3HZRfG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:35:06 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so3719977pdj.30
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ktnwF4DaXNVhKWEyHwPjPEH9zUALjdkWqjWVY2Euq0g=;
        b=C9FKCNydLtQSmAJyUx4yxe+gOkqW8C1qHC/6S0nVaARYsCmg8lI8/PaXXOJzDuuEB+
         ctemsfdYXat+10C3NOMsKeNYF9L1kPX+wXRMAqm1JySxdQ6neW5j9sArozdmNXKpGjZg
         tBHFqHnWXV/3AS4y6DPsZwfV7WvHXoC9Bu0TQHJMBZOUFe73TOEt7xcp3q5+jM6DUbYi
         Pw/Coaq5ywT4Nx/Txwm8Cpbfx1QIar+lioEIhe9ehZH9cLUMzhhPeUDlgHpNDfkR587k
         cY53DjooLavcJrsXp5+C4sHnNOlctvDLdcBs++JXGTvwty6l+/XAdqGdh4WQni9IJANq
         uFaQ==
X-Received: by 10.66.176.193 with SMTP id ck1mr15254797pac.47.1377538505336;
        Mon, 26 Aug 2013 10:35:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id lm2sm21365751pab.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 10:35:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130826142704.GA14858@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233011>

Jeff King wrote:
> On Sun, Aug 25, 2013 at 12:54:12PM -0700, Jonathan Nieder wrote:

>> [setup split across three tests]
>>
>> This is kind of an old-fashioned test, since each step of the setup is
>> treated as a separate test assertion.  I don't really mind until we
>> get better automation to make it easy to skip or rearrange tests.
>> Just for reference, I think the usual way to do this now is
>
> I don't see that splitting it up more hurts this. If we wanted more
> automatic rearranging or skipping of tests, we would need tests to
> declare dependencies on their setup. And we would need to be able to
> declare dependencies on multiple tests, since having a single setup test
> does not work in all cases (e.g., sometimes you are testing each step,
> and the final step relies on earlier steps).

Actually dependencies can already be inferred for most test scripts
using the following rule:

	Each test depends on all tests with the word "setup" or the
	phrase "set up" in their title that precede it.

And while there's no existing automation for testing that that's all
the tests rely on (by automatically skipping or reordering tests, or
running non-setup tests in separate sandboxes in parallel), in
practice it is still already useful since it makes it safe to use
GIT_SKIP_TESTS subject to the following constraint:

	In each test script, for every setup test skipped, all later
	tests are skipped as well.

I don't care as much about GIT_SKIP_TESTS as about being able to
introduce new tests in the middle of a file.

Of course splitting up the setup into 3 steps neither helps nor hurts
that.  What I was complaining about is splitting the filter-branch
from the verification that filter-branch had the right result.

Sorry for the confusion,
Jonathan
