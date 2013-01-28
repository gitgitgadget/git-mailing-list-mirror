From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 04/11] t/t3511: add some tests of 'cherry-pick -s'
 functionality
Date: Sun, 27 Jan 2013 18:08:11 -0800
Message-ID: <20130128020810.GF8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-5-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:08:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tze9J-0004n1-0c
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887Ab3A1CIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:08:20 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:49786 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab3A1CIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:08:18 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so1210431pad.2
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 18:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zYyEWu1bhg6s9EyI9Rv6sn0nPbgTf/TtfIisR9ybBz0=;
        b=OQxJSTu/k71TT17vXt5srsM0oNhRC/oKeqTCxgni039qjXRRiQMzxMGrm7crpP/LG7
         DG0P/eGxPBWanRu4VXuVDVxtU5ELY3kSeJQimxtdP6oLsZqRNYE5ivSogrXaKVTTy6ag
         KTo8p8ROYFy805TwdOaVTerjIsAxGti19d/7NeTc4YB9EXwrcYw8nzJkVfJFZG/R/sFK
         Bx6wxiNaiPnUHsKFaPvrYMM6RE6A2+RUezaANC/fsnxFxGzA26PBAX2m32ebDKZYLAkO
         qTlfiNLj/68MNn+fXu1czRpubExgm5nan4PnUbhIRzKjMZhiHaQ1XHIPxE4dpimZV+C3
         Gteg==
X-Received: by 10.68.196.133 with SMTP id im5mr34294621pbc.16.1359338897943;
        Sun, 27 Jan 2013 18:08:17 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ai8sm5294941pbd.14.2013.01.27.18.08.15
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 18:08:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-5-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214784>

Brandon Casey wrote:

> --- /dev/null
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -0,0 +1,111 @@
> +#!/bin/sh
> +
> +test_description='Test cherry-pick -x and -s'
> +
> +. ./test-lib.sh
> +
> +pristine_detach () {
> +	git cherry-pick --quit &&
> +	git checkout -f "$1^0" &&
> +	git read-tree -u --reset HEAD &&
> +	git clean -d -f -f -q -x
> +}

Some day this should move to test-lib-functions.sh.  Not relevant
for this patch, though.

[...]
> +test_expect_failure 'cherry-pick -s inserts blank line after non-conforming footer' '
> +	pristine_detach initial &&
> +	git cherry-pick -s mesg-broken-footer &&
> +	cat <<-EOF >expect &&
> +		$mesg_broken_footer
> +
> +		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>

This bug is old.  When c1e01b0c (commit: More generous accepting of
RFC-2822 footer lines, 2009-10-28) added more precise parsing of the
RFC2822 footer when deciding whether to add a newline before a new
signoff, it forgot to change the "sign-off already present" case to
match.

Thanks for the test.  The rest of the tests in this file also look
good, of course.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
