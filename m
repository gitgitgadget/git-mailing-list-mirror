From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in
 .git/info/exclude
Date: Mon, 21 Nov 2011 09:27:48 -0800
Message-ID: <7vfwhhgzcb.fsf@alter.siamese.dyndns.org>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
 <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
 <7vsjlhhq33.fsf@alter.siamese.dyndns.org>
 <CACsJy8AgDKYhyJ2CD0Y7trGrT63bUuYAS0DadD9khyqEYpguew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 18:27:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSXev-0006kA-85
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 18:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab1KUR1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 12:27:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab1KUR1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 12:27:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B10D55DD2;
	Mon, 21 Nov 2011 12:27:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z1xi6Di36y8GjKKQnZVNPD8c8yw=; b=K/udnU
	q7PcdNw0hjVCj+WxO8UVk7MU8V/S40+bgXXj/DJEitlZUchNIQ/tzQrAcP3VRj0b
	fCKEZtuenZD37soMIDd5aeVc4qhwTc5gJ0AwFSA4B6dfDtqY1HRqDy1qZUDlyn8K
	dLPT8y+vg9Mew6CKT7PWvqTfXIxDXiGAEHX6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dHAqBASQ6qv0CDaaD2uenwHAPxfJJzJ0
	hBGNh8FdNyv44/XMalqoJ0Q40JWtRPS7r74kD21f+1zzfTUaGyV5S/8Tepz2QUpI
	Gjk+2pdGLYLCapwbID1iuxA3l90hP0nJOmRfk/PreCCvbk3/VZOvhbtLF+NMAqD/
	Bf0H/xz8g9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6DBF5DD1;
	Mon, 21 Nov 2011 12:27:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1309C5DD0; Mon, 21 Nov 2011
 12:27:49 -0500 (EST)
In-Reply-To: <CACsJy8AgDKYhyJ2CD0Y7trGrT63bUuYAS0DadD9khyqEYpguew@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 21 Nov 2011 15:52:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22CD0076-1466-11E1-97F8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185752>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> It dated back to f8a9d42 (read-tree: further loosen "working file will
> be lost" check. - 2006-12-04) when you introduced --exclude-per-directory
> to read-tree, but not --exclude-from to explicitly add .git/info/exclude.

That one together with 1127148 (Loosen "working file will be lost" check
in Porcelain-ish, 2006-12-04) complets the picture. Thanks for digging
this out.

> I guess it's time to add "read-tree --exclude-from".

Perhaps, also --exclude-standard to match?

> We may add an option to checkout to skip
> either .git/info/exclude or .gitignore, or both.

I do not think we want to go that route, because it is not just "checkout"
but is an issue shared across users of unpack-trees machinery.

When a merge result loses build/ directory and replaces it with a regular
file "build", with the current ignore semantics, build/*.o will go but if
you had an untracked and ignored build/TODO, the file will also go, for
example. If we want to have "precious", we should either make "ignored" to
mean "precious", or introduce a "precious" as a new category
(cf. $gmane/185746)
