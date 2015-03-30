From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9814: Guarantee only one source exists in git-p4 copy tests
Date: Sun, 29 Mar 2015 20:03:13 -0700
Message-ID: <xmqqk2xzxk3y.fsf@gitster.dls.corp.google.com>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
	<1427671914-12131-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>
To: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 05:04:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcPzh-0006PX-6P
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 05:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbbC3DDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 23:03:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751936AbbC3DDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2015 23:03:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A759D45BBA;
	Sun, 29 Mar 2015 23:03:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GoMR57OlDZQHxPk1dqywTAxO0uo=; b=ocMckP
	5e47ECl4p/IM6Dq8pv2TnwRfBE3xKxhTl4uk/bPV5/ZgJrov4t/JKHtEFXm8gC3v
	q4iXVHDnRxCgRodDzYcKDaqkNwOIf2RjQNHUeM688BtkcMwRBW+jiF7HVk+y7J7S
	UcKYzD3PztnH2vxUXsigrWfYF5tqqfbBTH79s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NjlhsFXm+l5+3xo5S71hQ/tEeUn5G4CG
	SjaRbeIZmuaR/Jw8lOGATDC/YmYlUQ80sfDvwZVtM31m20OShdtEPZSF/COfx10J
	x49OvQpufQOCZT3PTcvn7w//ceH+/OCVLi6xVAVXV2IsMEz4/SvEfUqEdcqamPA2
	RmXXdnDpklk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DC4145BB9;
	Sun, 29 Mar 2015 23:03:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12F8345BB8;
	Sun, 29 Mar 2015 23:03:15 -0400 (EDT)
In-Reply-To: <1427671914-12131-1-git-send-email-vitor.hda@gmail.com> (Vitor
	Antunes's message of "Mon, 30 Mar 2015 00:31:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4EEC8E9A-D689-11E4-95D0-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266447>

Vitor Antunes <vitor.hda@gmail.com> writes:

> * Modify source file (file2) before copying the file.
> * Check that only file2 is the source in the output of "p4 filelog".
> * Remove all "case" statements and replace them simple tests to check that
>   source is "file2".
>
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
> ---

I am not a Perfoce user, so I'd like to ask Pete's and Luke's
comments on these changes.

>  t/t9814-git-p4-rename.sh |   46 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
> index 8b9c295..d8fb22d 100755
> --- a/t/t9814-git-p4-rename.sh
> +++ b/t/t9814-git-p4-rename.sh
> @@ -132,6 +132,9 @@ test_expect_success 'detect copies' '
>  		cd "$git" &&
>  		git config git-p4.skipSubmitEdit true &&
>  
> +		echo "file8" >> file2 &&

Style: please lose SP between redirection and its target, i.e.

	echo file8 >>file2 &&

The same comment applies to everywhere else.

> +		git commit -a -m "Differentiate file2" &&
> +		git p4 submit &&
>  		cp file2 file8 &&
>  		git add file8 &&
>  		git commit -a -m "Copy file2 to file8" &&
> @@ -140,6 +143,10 @@ test_expect_success 'detect copies' '
>  		p4 filelog //depot/file8 &&
>  		p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
>  
> +		echo "file9" >> file2 &&
> +		git commit -a -m "Differentiate file2" &&
> +		git p4 submit &&
> +
>  		cp file2 file9 &&
>  		git add file9 &&
>  		git commit -a -m "Copy file2 to file9" &&
> @@ -149,28 +156,39 @@ test_expect_success 'detect copies' '
>  		p4 filelog //depot/file9 &&
>  		p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
>  
> +		echo "file10" >> file2 &&
> +		git commit -a -m "Differentiate file2" &&
> +		git p4 submit &&
> +
>  		echo "file2" >>file2 &&
>  		cp file2 file10 &&
>  		git add file2 file10 &&
>  		git commit -a -m "Modify and copy file2 to file10" &&
>  		git diff-tree -r -C HEAD &&
> +		src=$(git diff-tree -r -C HEAD | sed 1d | sed 2d | cut -f2) &&
> +		test "$src" = file2 &&
>  		git p4 submit &&
>  		p4 filelog //depot/file10 &&
> -		p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
> +		p4 filelog //depot/file10 | grep -q "branch from //depot/file2" &&
> +
> +		echo "file11" >> file2 &&
> +		git commit -a -m "Differentiate file2" &&
> +		git p4 submit &&
>  
>  		cp file2 file11 &&
>  		git add file11 &&
>  		git commit -a -m "Copy file2 to file11" &&
>  		git diff-tree -r -C --find-copies-harder HEAD &&
>  		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
> -		case "$src" in
> -		file2 | file10) : ;; # happy
> -		*) false ;; # not
> -		esac &&
> +		test "$src" = file2 &&
>  		git config git-p4.detectCopiesHarder true &&
>  		git p4 submit &&
>  		p4 filelog //depot/file11 &&
> -		p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
> +		p4 filelog //depot/file11 | grep -q "branch from //depot/file2" &&
> +
> +		echo "file12" >> file2 &&
> +		git commit -a -m "Differentiate file2" &&
> +		git p4 submit &&
>  
>  		cp file2 file12 &&
>  		echo "some text" >>file12 &&
> @@ -180,15 +198,16 @@ test_expect_success 'detect copies' '
>  		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>  		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
>  		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
> -		case "$src" in
> -		file10 | file11) : ;; # happy
> -		*) false ;; # not
> -		esac &&
> +		test "$src" = file2 &&
>  		git config git-p4.detectCopies $(($level + 2)) &&
>  		git p4 submit &&
>  		p4 filelog //depot/file12 &&
>  		p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
>  
> +		echo "file13" >> file2 &&
> +		git commit -a -m "Differentiate file2" &&
> +		git p4 submit &&
> +
>  		cp file2 file13 &&
>  		echo "different text" >>file13 &&
>  		git add file13 &&
> @@ -197,14 +216,11 @@ test_expect_success 'detect copies' '
>  		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>  		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
>  		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
> -		case "$src" in
> -		file10 | file11 | file12) : ;; # happy
> -		*) false ;; # not
> -		esac &&
> +		test "$src" = file2 &&
>  		git config git-p4.detectCopies $(($level - 2)) &&
>  		git p4 submit &&
>  		p4 filelog //depot/file13 &&
> -		p4 filelog //depot/file13 | grep -q "branch from //depot/file"
> +		p4 filelog //depot/file13 | grep -q "branch from //depot/file2"
>  	)
>  '
