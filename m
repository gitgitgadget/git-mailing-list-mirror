From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Tue, 30 Oct 2012 05:39:22 +0100
Message-ID: <CAMP44s2a40Bx2X3QfbtCZFDR71W5puadfpSRQSy9kjbkm_f-sA@mail.gmail.com>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
	<20121030042850.GA23263@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 05:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3c0-000126-7P
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab2J3EjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:39:23 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:57420 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2J3EjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:39:23 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5450841oag.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=82nplwL0eywTwz1EV35uZO2LBmF8BTEORHI8UeEjsE4=;
        b=mxhF0BAOQZcoQCTh3b0lUt2cVNUrRxniMhXzut7t5HEr6tx8JR8tYIL6TSk4Hj/cpg
         XfFIFIAYEVxBOWu/b7/R7M3QGOmV0Ex8A6ZNkbi4zUQHh0fyU9WFyIRcu/MjjSQjcwz2
         TwVCJFbFEGRTXGydpE1Dz0rUEVnW2KUAQiV/zGKYBWTVvlQXe0Q++s5GZI5r/TVFVJOD
         WssJkdfg3j5rwDptzAmEs5VWbcT649WfSzYxYuxHG66lfc7i72pyBBnl3CSyDjGh8ISj
         6g+GKScOSGKHtMxeohYzVL2NXEaK2Hr3E0nWxO5PMd9MqAi6daF2885Fm2f4hABBWoWq
         5Cog==
Received: by 10.182.52.105 with SMTP id s9mr26785882obo.25.1351571962327; Mon,
 29 Oct 2012 21:39:22 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Mon, 29 Oct 2012 21:39:22 -0700 (PDT)
In-Reply-To: <20121030042850.GA23263@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208678>

On Tue, Oct 30, 2012 at 5:28 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 30, 2012 at 05:12:57AM +0100, Felipe Contreras wrote:
>
>> No reason to use the full path in case this is used externally.
>
> I think it is not just "no reason to", but it is actively wrong to use a
> full path, as we do not take care to "mkdir -p" the intervening path
> components.
>
> However, this never comes up in practice, because all of the test
> scripts assume you are running them from the test directory (i.e.,
> they will fail otherwise because they will not find ./test-lib.sh).
>
> Is this in support of putting remote-hg tests in contrib/? I had
> expected you to just put
>
>   export TEST_DIRECTORY="$(pwd)/../../../t"
>   . "$TEST_DIRECTORY/test-lib.sh"

If there was a single script and we didn't want reports, sure, but
this is not too bad:

TESTS := $(wildcard test*.sh)

export T := $(addprefix $(CURDIR)/,$(TESTS))
export MAKE := $(MAKE) -e
export PATH := $(CURDIR):$(PATH)

test:
	$(MAKE) -C ../../t $@

$(TESTS):
	$(MAKE) -C ../../t $(CURDIR)/$@

.PHONY: $(TESTS)

I just sent the new remote-hg patch series with that.

Cheers.

-- 
Felipe Contreras
