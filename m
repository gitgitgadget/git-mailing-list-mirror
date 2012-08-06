From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 06/16] t3700: sleep for 1 second, to avoid
 interfering with the racy code
Date: Sun, 05 Aug 2012 18:43:32 -0700
Message-ID: <7vsjc023sr.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-7-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:44:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyCMi-0002Nz-M8
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab2HFBng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:43:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286Ab2HFBnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:43:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4843B8E5F;
	Sun,  5 Aug 2012 21:43:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6hVEOlM7iIcMiBO4sI84TfAQGrw=; b=Pqvq0v
	XXmJkNplZCwJShxT2N6elQWqdbK/wcCJmh4ZEW113BZLJt5vEPguKR2qW8PmCnX4
	rEdSyqbfhlKWUB1kzMllh6G9nXREG3GmAnxTEibdyJj0PU+fVuLKQBQS4XNm/LVL
	MpquCvbT1eZK8lYHOc3DCcI2pV9x57jTvhD34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U+Mvqvv6uUtsVRky0TI3uELkITFWY7tN
	l/X/GRYyh80O8obJvhBRfLWDAdoOGr871pLPToc4eMP0OPGG82mKPELdfUoeHQSq
	ZTb259A5PoyaPdMkv9ioRoER3UkwoPJyT/5s5CohMHieeWZKqSyXT3qEjFJh4z22
	EU3ryXoSaAk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3780A8E5E;
	Sun,  5 Aug 2012 21:43:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84B478E5D; Sun,  5 Aug 2012
 21:43:34 -0400 (EDT)
In-Reply-To: <1344203353-2819-7-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Sun, 5 Aug 2012 23:49:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 227501DC-DF68-11E1-8B2A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202947>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> The new git racy code uses the mtime of cache-entries to smudge
> a racy clean entry, and loads the work, of checking the file-system

-ECANTPARSE.

> if the entry has really changed, off to the reader. This interferes
> with this test, because the entry is racily smudged and thus has
> mtime 0. We wait 1 second to avoid smudging the entry and getting
> correct test results.

Mild NAK, especially it is totally unclear why you even need to muck
with racy-git check in the current format of the index in the first
place, and even if it were necessary, it is unclear why this cannot
be done with test-chmtime.

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  t/t3700-add.sh |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 874b3a6..4d70805 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -184,6 +184,7 @@ test_expect_success 'git add --refresh with pathspec' '
>  	echo >foo && echo >bar && echo >baz &&
>  	git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
>  	echo "100644 $H 3	foo" | git update-index --index-info &&
> +	sleep 1 &&
>  	test-chmtime -60 bar baz &&
>  	>expect &&
>  	git add --refresh bar >actual &&
