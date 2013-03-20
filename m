From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Wed, 20 Mar 2013 13:00:11 -0700
Message-ID: <20130320200010.GR3655@google.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-4-git-send-email-artagnon@gmail.com>
 <20130320182830.GJ3655@google.com>
 <CALkWK0mCVb6N76QU+U3iTO_gmU4PmhrTOgU53DAMd5x1bCQEtA@mail.gmail.com>
 <20130320184157.GO3655@google.com>
 <20130320185844.GB30165@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:00:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIPBm-0000Ap-1J
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab3CTUAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 16:00:19 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:41696 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab3CTUAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 16:00:15 -0400
Received: by mail-pd0-f180.google.com with SMTP id g10so752377pdj.11
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=354P6kp2C9JSzxPaGMfgpuIvyDPXrpKxGiXcCjgHWic=;
        b=ZYotkVWvXJRECPNFfNo5IJxzCVRfdAdhB+WdZK4ooq/WLkHF6iljOc54yujcZ52ztb
         En94DhjGTtZ6L7ddz6iVW9TT1RmCrJ55PkXQYKtRaLKv9SLdt0obKE+27TrVUZCvQCJd
         0jjx1ebM6zxVOHTCvCPMLcGPn4MiwEGGFqZerDW9Lr8WME60Ny4WavCmSGP7g+rTgSgD
         cb8sVbwRVFG9IOWSvxSb+vdxDUmPbqYk4wVGmGkWBjZEphmH4yDJcXmbXXaEk18rpF2u
         S15RJW8thO05mtKWaADoaripENkAmIVCJToczkg5ePB84Si6/eHTRv57piR/MFvxkXCU
         2raQ==
X-Received: by 10.68.201.3 with SMTP id jw3mr10789717pbc.191.1363809615488;
        Wed, 20 Mar 2013 13:00:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id t1sm3383743pab.12.2013.03.20.13.00.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 13:00:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130320185844.GB30165@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218673>

Jeff King wrote:

>                                                                    I
> tend to read the tests in a top-down manner: a test is interesting
> (usually because it fails), and then I want to see what it is doing, so
> I look at any functions it calls, and so forth.
>
> What I usually find _much_ harder to debug is when there is hidden state
> leftover from other tests.

Thanks for articulating this.  I agree that keeping track of state is
the hardest part of working with git's tests.

To clarify my earlier comment, I was reading the test script from the
point of view of someone who wants to add an additional test, rather
than someone debugging an existing one.  That person has a difficult
task: she needs to understand

 * What do the existing tests in the script do?  This information
   is important in deciding whether the new test will be redundant.

 * How do I work with the particular dialect used in the script,
   including helpers?  A new test should fit in with the style of its
   surroundings to avoid contributing to an unmaintainable mess.

 * What is the intended scope of the test script?  Does my new test
   belong in this script?

 * What is the logical progression of the script?  What story does this
   script tell?  Where should I insert my test to maintain a logical
   ordering?

 * What state that later tests rely on do I need to avoid clobbering?

Generally the best way to help such a person is to make the script
very simple.  In particular, using standard helpers instead of custom
functions when appropriate and documenting helpers used to give new
readers a quick introduction to the dialect can help a lot.
