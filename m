From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Massive testsuite failure on !(Linux || Solaris 8+)
Date: Mon, 26 Apr 2010 02:44:11 -0500
Message-ID: <20100426074411.GA31428@progeny.tock>
References: <20100316100917.GA27121@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 09:43:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6IyW-0001ob-4J
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 09:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549Ab0DZHnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 03:43:23 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40509 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab0DZHnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 03:43:22 -0400
Received: by pvg2 with SMTP id 2so12157pvg.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Hi0JU9JhL9g0hkU9vXMf4Zj/qinl7Y911rbu3e1fxZs=;
        b=ScuG3dvWQUHllKaDb6x4NCswzQ2bB9KewFmMeUUrwWgVgH4oEywg/vS1tpknQHwqpf
         pTsW1KZ3Gm+jChjyABLzjZfKPREJG3HnD5UhFPeI9xMYOj5UqKvP+QRX2x5XseQieNcz
         kn1QRF9hy5dAppAKyiNjlwiNjhuQJU/dL4VVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q+93GV1SldoUTY9VYj6+hCfHb5cF6+46Zh51iGUzPT/PY1eBU8demjVqpOxu/ClG0l
         MsBoG60ig2N4JC3Q7aingNXhn7iVYUi4Xk4K6JPsu2hGXg4xIZSNjskiJgfPhJIv0vTC
         oSxoUZl97hWsxL8A5PfRjW1pqjKWxTxxxedwo=
Received: by 10.141.89.3 with SMTP id r3mr3102991rvl.31.1272267801862;
        Mon, 26 Apr 2010 00:43:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2927076iwn.0.2010.04.26.00.43.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 00:43:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100316100917.GA27121@thor.il.thewrittenword.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145795>

Hi Gary,

Gary V. Vaughan wrote:

> I have full logs on all hosts, up until t9300 test 120, which hangs (I
> left it overnight to be sure since some of these machines are quite
> old and slow) the testsuite until SIGINT.  The logs are, obviously,
> huge so I won't post them here,

What tends be most useful is output from

  GIT_TEST_OPTS='-v -i' gmake test

This way you can see the actual output from the failing commands, and
you only have to worry about the first test that fails (no doubt the
later ones are similar).  Certainly if any tests from t0000-basic.sh
are failing, it is useless to worry about problems in later tests.
Options for use when invoking tests are documented in t/README.

Also, if you would like to investigate, you might find it useful to
use

  sh -x relevant-test.sh

Based on the list of failing tests, though, it seems that your
test_cmp is not working correctly.  You should make sure that the
GIT_TEST_CMP environment variable is set to point to some command that
will exit with status 0 if the two files are identical and with nonzero
status if they differ.  I imagine patches to the Makefile and
t/Makefile to set this up appropriately for your platforms (without
ruining the nice diff output for overone else) would be welcome.

Hope that helps,
Jonathan
