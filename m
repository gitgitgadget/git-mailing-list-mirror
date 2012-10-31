From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Tue, 30 Oct 2012 18:27:30 -0700
Message-ID: <20121031012730.GY15167@elie.Belkin>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
 <20121030044609.GA10873@elie.Belkin>
 <CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:27:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTN5x-0008Ry-0I
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 02:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626Ab2JaB1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 21:27:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41053 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab2JaB1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 21:27:35 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so586543pbb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 18:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a7KqqMkDCwdLeT/MtYpPYv8T2h79WLYX8IUp9RR4V4A=;
        b=d5yAq6TxXol9bjfG00vZk5caGTxfDIk1jZ5fpqQoP0T9f78RUmy2Ljni4c060IJXsU
         hbwmnplwmcL9sW6MK+8DwfG0QrBw6Lz7MzAfxS+lWmbunZ2toomgCF1Q3w6CubAH13Uq
         /wPuelhT5Wg7CCdFxG1zoqr5xcH2LjuHFHK6z4V0HCn+Bye8EWJGvGg/DOaUshOLblFi
         pcIUcgIqzlXd9PpGT37XavuSS0s5zxtSNqRUt/ByK8m7FlJQIXV7lcxLZ8s87LwDOMsW
         VN2OtnaAaq5vD1LU+sgK3DI7MTq13E3sfKg+nXYzaSkZSQQAYhtF8m1WB7W6szrVm2JO
         OnUQ==
Received: by 10.66.80.166 with SMTP id s6mr89342068pax.21.1351646854814;
        Tue, 30 Oct 2012 18:27:34 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id o10sm1253150paz.37.2012.10.30.18.27.33
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 18:27:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208778>

Felipe Contreras wrote:
> On Tue, Oct 30, 2012 at 5:46 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Felipe Contreras wrote:

>>> No reason to use the full path in case this is used externally.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> "No reason not to" is not a reason to do anything.  What symptoms does
>> this prevent?  Could you describe the benefit of this patch in a
>> paragraph starting "Now you can ..."?
>
> ./test-lib.sh: line 394:
> /home/felipec/dev/git/t/test-results//home/felipec/dev/git/contrib/remote-hg/test-21865.counts:
> No such file or directory

Ok, so a description for this patch is

	test: use test's basename to name results file

	Running a test using its full path produces an error:

		$ ~/dev/git/contrib/remote-hg/test-21865.sh
	[...]
		./test-lib.sh: line 394: /home/felipec/dev/t/\
		test-results//home/felipec/dev/git/contrib/remote-hg/\
		test-21865.counts: No such file or directory

	In --tee and --valgrind modes we already use the basename
	to name the .out and .exit files; this patch teaches the test-lib
	to name the .counts file the same way.

That is still not enough to tell if it is a good change, though.
Should the test results for contrib/remote-hg/test-* be included with
the results for t/t*.sh when I run "make aggregate-results"?

Before 60d02ccc, git-svn had its own testsuite under contrib/, with
glue in contrib/git-svn/t/lib-git-svn.sh to use test-lib --- maybe
that code could provide some inspiration for questions like these.

Hope that helps,
Jonathan
