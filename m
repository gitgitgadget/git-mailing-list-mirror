From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] combine-diff: coalesce lost lines optimally
Date: Sun, 17 Mar 2013 13:10:13 -0700
Message-ID: <7vhak9rdne.fsf@alter.siamese.dyndns.org>
References: <7vboalw6lt.fsf@alter.siamese.dyndns.org>
 <1363525436-21667-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 21:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHJum-0004aD-HJ
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 21:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588Ab3CQUKR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 16:10:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500Ab3CQUKQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 16:10:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2738CA6FB;
	Sun, 17 Mar 2013 16:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Bhj2WYOwiJGs
	SCMtlg84F5Xb/ak=; b=LMnqcKMnECxggktlA9k9Wd0rzTN32CogBfHVN8AoXvt+
	AZ2rOqW1K/byJMH8eH1d/Ai5MxW70BCHq0onRHM0FUk9nQB6Ca/UdjIqB1qFHvbO
	J5IHeIQIShgvylC9Z2iK9fSsBdJ6pD034ZsnPfBlARtAKSh8ZVIjFj9a/Nu0y3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=voxdop
	iRw2K8b2DWvk3cxlkn8fPy/FjgWCign/fp1bch6Ss/6xEUwmv82CL6jXyNPHn0Rw
	10a66JQ1Jfpt5RS4k+haxWtd+jUi9SzVLyva2ZnoYmdHJRrrhODRF+fhDdYZpUrv
	cQI+uy2pZqiAghLdmtD0+OR8DWoH0QnMphcmo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D629A6FA;
	Sun, 17 Mar 2013 16:10:16 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EDD6A6F8; Sun, 17 Mar 2013
 16:10:15 -0400 (EDT)
In-Reply-To: <1363525436-21667-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sun, 17 Mar 2013 14:03:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE9A1EF0-8F3E-11E2-BDB4-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218371>

Antoine Pelisse <apelisse@gmail.com> writes:

> This replaces the greedy implementation to coalesce lost lines by usi=
ng
> dynamic programming to find the Longest Common Subsequence.
>
> The O(n=C2=B2) time complexity is obviously bigger than previous
> implementation but it can produce shorter diff results (and most like=
ly
> easier to read).
>
> List of lost lines is now doubly-linked because we reverse-read it wh=
en
> reading the direction matrix.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> Hi,
> This is a very first draft for improving the way we coalesce lost
> lines. It has only been tested with the two scenarios below.
>
> What is left to do:
> - Test it more extensively
> - Had some tests scenarios
>
> I'm also having a hard time trying it with more than two parents. How=
 I
> am supposed to have more than two parents while octopus merge refuses=
 if
> there are conflicts ?

9fdb62af92c7 ([ACPI] merge 3549 4320 4485 4588 4980 5483 5651 acpica
asus fops pnpacpi branches into release, 2006-01-24) is one of the
amusing examples ;-)  Cf.

    http://thread.gmane.org/gmane.comp.version-control.git/15486
