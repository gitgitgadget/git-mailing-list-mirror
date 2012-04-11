From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] git p4: Fixing script editor checks
Date: Wed, 11 Apr 2012 10:14:10 -0700
Message-ID: <7vpqbekx7h.fsf@alter.siamese.dyndns.org>
References: <1334157684-31402-1-git-send-email-luke@diamand.org>
 <1334157684-31402-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:14:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI17Z-0002wY-OV
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 19:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633Ab2DKRON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 13:14:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932592Ab2DKROM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 13:14:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C62F6B88;
	Wed, 11 Apr 2012 13:14:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ta/RB/4+VIbG8vKCGhlRxzR5Rck=; b=q+JEWl
	3HSyrm0TOAuTCmVK97tulxEAmlVDaHlVa8lEIddqjhdVrZn0MC0zZ4/zvsyknXvo
	xcpZrTt/oIgDOCQUc8CJpeOaAwLcO5NHhQzwdzIBdencg5Q8wD/Q7w8CZlwlicDG
	8xpYzLdtNRW5BDPEKzPQOm5u0OTY+HKiq/B0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KcunxTmrdO6G+tF2uPUVKHWJLNSqeLhK
	9oZ+IHX/iTOshuPsQzRcsVwyYW3Cs106TyKQs4I7aTJ2ObgJtEHVbBlAg8izohNU
	JoC6fhFU7IhabG/TWJYGqAtGnFuLS/GwDQjV5/SDZNR27nUKK6KAYbaj9cH9B616
	L8ZS5vMQLx0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 538176B87;
	Wed, 11 Apr 2012 13:14:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A0DD6B86; Wed, 11 Apr 2012
 13:14:11 -0400 (EDT)
In-Reply-To: <1334157684-31402-2-git-send-email-luke@diamand.org> (Luke
 Diamand's message of "Wed, 11 Apr 2012 17:21:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C18C403E-83F9-11E1-A6B7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195218>

Luke Diamand <luke@diamand.org> writes:

> If P4EDITOR is defined, the tests will fail when "git p4" starts an
> editor.

Is that a problem specific to tests, or should "git p4" itself unset that
environment?  If it is a problem specific to tests, would it be a better
fix to add "P4EDITOR=:" like we do for EDITOR in t/test-lib.sh?

>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  t/t9800-git-p4-basic.sh |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 13be144..b2f0869 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -335,7 +335,7 @@ test_expect_success 'detect renames' '
>  	test_when_finished cleanup_git &&
>  	(
>  		cd "$git" &&
> -		git config git-p4.skipSubmitEditCheck true &&
> +		git config git-p4.skipSubmitEdit true &&
>  
>  		git mv file1 file4 &&
>  		git commit -a -m "Rename file1 to file4" &&
> @@ -394,7 +394,7 @@ test_expect_success 'detect copies' '
>  	test_when_finished cleanup_git &&
>  	(
>  		cd "$git" &&
> -		git config git-p4.skipSubmitEditCheck true &&
> +		git config git-p4.skipSubmitEdit true &&
>  
>  		cp file2 file8 &&
>  		git add file8 &&
