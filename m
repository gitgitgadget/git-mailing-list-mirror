From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Add tests for filesystem challenges (case and unicode normalization)
Date: Tue, 26 Feb 2008 00:34:56 +0100
Message-ID: <FBFBA30A-0D44-4A2A-A693-EFF79218FCEB@zib.de>
References: <7vlk5vjpi4.fsf@gitster.siamese.dyndns.org> <1203873549507-git-send-email-prohaska@zib.de> <7voda4hikx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mitcht.git@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 00:34:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTmqU-0000Ku-BU
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 00:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbYBYXeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 18:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbYBYXeQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 18:34:16 -0500
Received: from mailer.zib.de ([130.73.108.11]:41922 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450AbYBYXeP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 18:34:15 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m1PNY1mY023979;
	Tue, 26 Feb 2008 00:34:01 +0100 (CET)
Received: from [192.168.178.21] (brln-4db96367.pool.einsundeins.de [77.185.99.103])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m1PNY0e9014116
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 26 Feb 2008 00:34:00 +0100 (MET)
In-Reply-To: <7voda4hikx.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75092>


On Feb 25, 2008, at 9:44 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> Unfortunately, I had no time to start the real work of fixing the
>> issues that are tested below.
>
> That's fine.  We are not in a hurry.

Well, I am, ... kind of.  git constantly stumbles over a filename
whose case changed.  But fortunately I do not need to wait much
longer until history will eventually have grown sufficiently such
that the rename will no longer surface ;-)


>> But at least the tests should be in
>> good shape now and could be applied.
>
> I do not think we would want to see "FIXED" on systems that
> already behave sanely, so we would want a fix-up like this on
> top of your patch, and it would be a good to go.
>
> I do not have a handy way to test this, though, so can you try
> it out and make sure test_case and test_unicode are set to
> test_expect_failure correctly on problematic filesystems?

This is a sensible way of handling this.  It works for me,
except for ...


> --
>
>  t/t0050-filesystem.sh |   38 ++++++++++++++++++++++++++++++++------
>  1 files changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index a0ab02e..b395c22 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -4,6 +4,34 @@ test_description='Various filesystem issues'
>
>  . ./test-lib.sh
>
> +auml=`perl -CO -e 'print pack("U",0x00E4)'`
> +aumlcdiar=`perl -CO -e 'print pack("U",0x0061).pack("U",0x0308)'`
> +
> +test_expect_success 'see if we expect ' '
> +
> +	test_case=test_expect_success
> +	test_unicode=test_expect_success
> +	mkdir junk &&
> +	echo good >junk/CamelCase &&
> +	echo bad >junk/camelcase &&
> +	if test "$(cat junk/CamelCase)" != good
> +	then
> +		test_camel=test_expect_failure

test_case (instead of test_camel).

		Steffen
