From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] don't use default revision if a rev was specified
Date: Sun, 14 Mar 2010 00:19:19 +0100
Message-ID: <4B9C1D77.3080007@lsrfire.ath.cx>
References: <4B9C086D.10004@lsrfire.ath.cx> <1268520425-31889-1-git-send-email-cxreg@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Vladimir Panteleev <vladimir@thecybershadow.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 00:19:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqacD-0005a4-QT
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 00:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab0CMXTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 18:19:22 -0500
Received: from india601.server4you.de ([85.25.151.105]:44391 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab0CMXTW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 18:19:22 -0500
Received: from [10.0.1.100] (p57B7E76C.dip.t-dialin.net [87.183.231.108])
	by india601.server4you.de (Postfix) with ESMTPSA id C58E12F8045;
	Sun, 14 Mar 2010 00:19:20 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <1268520425-31889-1-git-send-email-cxreg@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142122>

Am 13.03.2010 23:47, schrieb Dave Olszewski:
> If a revision is specified, it happens not to have any commits, don't
> use the default revision.  By doing so, surprising and undesired
> behavior can happen, such as showing the reflog for HEAD when a branch
> was specified.
> 
> Signed-off-by: Dave Olszewski <cxreg@pobox.com>
> ---
>>> I was testing a patch along the lines of
>>> what Vladimir proposed, which was simply to not set the default rev if a
>>> valid user-specified argument was found, whether or not it contains
>>> commits.
>>
>> Sounds more like it.  How did the tests go?  Does it result in empty
>> output (which is what I would expect from an empty reflog, now that I
>> stopped and thought about it for a second)?
> 
> It seems to work ok(tm)
> 
>  revision.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Thanks.  And here's an updated, squash-able test.

diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index c18ed8e..ba25ff3 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -64,4 +64,13 @@ test_expect_success 'using --date= shows reflog date (oneline)' '
 	test_cmp expect actual
 '
 
+: >expect
+test_expect_success 'empty reflog file' '
+	git branch empty &&
+	: >.git/logs/refs/heads/empty &&
+
+	git log -g empty >actual &&
+	test_cmp expect actual
+'
+
 test_done
