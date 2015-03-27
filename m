From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-p4: Fix copy detection test
Date: Fri, 27 Mar 2015 15:23:16 -0700
Message-ID: <xmqq619mw04r.fsf@gitster.dls.corp.google.com>
References: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
	<1427418269-3263-3-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 23:23:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybcf4-00069B-4J
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbbC0WXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:23:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751046AbbC0WXY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:23:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A692E43E2E;
	Fri, 27 Mar 2015 18:23:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j4SX4Vd+U+zrio1K0NQ5K3IF6hE=; b=VhVJd/
	1cjmb8lmVpTLxdxlUspPGsfqP29o1UXrKJ/DtkcOVT6LY7Yvaci+W6l1XNjm4whm
	hsT/SKINAb1Ui36AAc7wvnBNE0f0Mx6DJlGfbyxM8nEAhbaaLq54EZI6Nt4PkAda
	64Jf/K9PCzffzOaTN0JADKvvWrOI3aUNoiGJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gdCh1l7s+cd73i7a7sV1ar8tU5WpRXUC
	K2eFoxEzE64Vv5oEZxBsXWoPbMEnd1abgnn2qPQ2YJz6eCHI+tjxy4n3ONOwC7+s
	L2yLNxzwnljsiH/jHlmJgrkmKjPNZPgcTro118/P4B5PAVAAsQA4jx+rzSpdTL2W
	zPjwV+WFZ68=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E85A43E2D;
	Fri, 27 Mar 2015 18:23:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1990C43E2C;
	Fri, 27 Mar 2015 18:23:18 -0400 (EDT)
In-Reply-To: <1427418269-3263-3-git-send-email-vitor.hda@gmail.com> (Vitor
	Antunes's message of "Fri, 27 Mar 2015 01:04:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE51F284-D4CF-11E4-BA52-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266393>

Vitor Antunes <vitor.hda@gmail.com> writes:

> File file11 is copied from file2 and diff-tree correctly reports this file as
> its the source, but the test expression was checking for file10 instead (which
> was a file that also originated from file2). It is possible that the diff-tree
> algorithm was updated in recent versions, which resulted in this mismatch in
> behavior.
>
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>

Pete, these tests blame to your 9b6513ac (git p4 test: split up big
t9800 test, 2012-06-27).  I presume that you tested the result of
this splitting, but do you happen to know if we did something to
cause the test to break recently?

> ---
>  t/t9814-git-p4-rename.sh |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
> index 24008ff..018f01d 100755
> --- a/t/t9814-git-p4-rename.sh
> +++ b/t/t9814-git-p4-rename.sh
> @@ -156,14 +156,14 @@ test_expect_success 'detect copies' '
>  		git diff-tree -r -C HEAD &&
>  		git p4 submit &&
>  		p4 filelog //depot/file10 &&
> -		p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
> +		p4 filelog //depot/file10 | grep -q "branch from //depot/file2" &&
>  
>  		cp file2 file11 &&
>  		git add file11 &&
>  		git commit -a -m "Copy file2 to file11" &&
>  		git diff-tree -r -C --find-copies-harder HEAD &&
>  		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
> -		test "$src" = file10 &&
> +		test "$src" = file2 &&
>  		git config git-p4.detectCopiesHarder true &&
>  		git p4 submit &&
>  		p4 filelog //depot/file11 &&
