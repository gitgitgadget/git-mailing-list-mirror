From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/2] add "ok=sigpipe" to test_must_fail and use it to fix flaky tests
Date: Tue, 1 Dec 2015 10:05:21 +0100
Message-ID: <990EBE4C-C71F-4F3F-933F-A070D69C94B0@gmail.com>
References: <1448615714-43768-1-git-send-email-larsxschneider@gmail.com> <1448615714-43768-3-git-send-email-larsxschneider@gmail.com> <20151128171004.GC27264@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 10:05:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3gsa-0005CF-QO
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 10:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbbLAJFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 04:05:31 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35367 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484AbbLAJFY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 04:05:24 -0500
Received: by wmuu63 with SMTP id u63so163552653wmu.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 01:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=znZaPuze4JNO3RENkjGcIQyiYhVPwL0V9aZ4rVCxwIA=;
        b=CCYIZBSiXwPR1ap2u2cLYJ4JbSTvMQC94IIrPEm/zcThsRLF7jKz6y5W3jMLXZmnoK
         pOCvYNlCHaTutLLOhBPT8PjFvQPYi2m7P/gm8Hk44AeeJ3oFKIndQk7rpFWCzQOUQoH7
         fFUyhOkaqvmsF3DStG1R/1oFwMKDMxV9sormzlQvBzr2D6eH8AhmGXVQUUpNlSrk3r/a
         ch9+KQ5+tY4PMdfHr2IpnU2VRcZzx8QgWqThKs9bt0hrwzfOaHqDBA3BgGsxvQUB0P6j
         adrTWn6bh3gHYGsYio+fPAz/VEV3x6UA+ZRTwSWD8bh7z/yCVtVtbVaLC4z2TdJB7jqJ
         57FA==
X-Received: by 10.28.189.5 with SMTP id n5mr35473128wmf.76.1448960723337;
        Tue, 01 Dec 2015 01:05:23 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB7751.dip0.t-ipconnect.de. [93.219.119.81])
        by smtp.gmail.com with ESMTPSA id b84sm25144075wmh.15.2015.12.01.01.05.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 01:05:22 -0800 (PST)
In-Reply-To: <20151128171004.GC27264@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281835>


On 28 Nov 2015, at 18:10, Jeff King <peff@peff.net> wrote:

> On Fri, Nov 27, 2015 at 10:15:14AM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> t5516 "75 - deny fetch unreachable SHA1, allowtipsha1inwant=true" is
>> flaky in the following case:
>> 1. remote upload-pack finds out "not our ref"
>> 2. remote sends a response and closes the pipe
>> 3. fetch-pack still tries to write commands to the remote upload-pack
>> 4. write call in wrapper.c dies with SIGPIPE
>> 
>> t5504 "9 - push with transfer.fsckobjects" is flaky, too, and returns
>> SIGPIPE once in a while. I had to remove the final "To dst..." output
>> check because there is no output if the process dies with SIGPUPE.
> 
> s/PUPE/PIPE/ :)
> 
> I think it would be nice for future readers to understand a bit better
> _why_ this is flaky, and why the fix is to the test suite and not to git
> itself. I added this paragraph in between the two above:
> 
>    The test is flaky because the sending fetch-pack may or may not have
>    finished writing its output by step (3). If it did, then we see a
>    closed pipe on the next read() call. If it didn't, then we get the
>    SIGPIPE from step (4) above. Both are fine, but the latter fools
>    test_must_fail.
> 
Sounds good! Thank you :-)

- Lars
