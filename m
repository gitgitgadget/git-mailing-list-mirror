From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Tue, 28 Jul 2009 14:29:48 -0700
Message-ID: <7vljm84htf.fsf@alter.siamese.dyndns.org>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:30:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVuFN-0004tB-Vc
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 23:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbZG1V34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 17:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbZG1V3z
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 17:29:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbZG1V3z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 17:29:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16B8215F2C;
	Tue, 28 Jul 2009 17:29:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0B23015F2A; Tue, 28 Jul 2009
 17:29:50 -0400 (EDT)
In-Reply-To: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Tue\, 28 Jul 2009 23\:00\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA4A914A-7BBD-11DE-833F-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124283>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> @@ -205,6 +209,9 @@ running `git apply --directory=modules/git-gui`.
>  Configuration
>  -------------
>  
> +apply.ignore-whitespace::
> +	Set this boolean configuration flag if you want to ignore whitespace
> +	differences to be ignored by default.

That's a strange sentence.

	When set to true, changes in amount of whitespace are ignored.

I am not happy with the name --ignore-whitespace.

Perhaps --ignore-space-change, to be consistent with a "git diff" option,
would be more appropriate.  Doing so has an added benefit of leaving the
door open to add --ignore-all-space option to the patch application side
later.

> +		/*
> +		 * Skip whitespace inside. We check for whitespace on
> +		 * both buffers because we don't want "a b" to match
> +		 * "ab"

		 * but that is only true when --ignore-space-change
                 * is in effect.
		 *
                 * If you want to match "if(a > b)" with "if (a > b)",
                 * please add --ignore-all-space option and use it.

    ;-)

If I am reading the patch correctly, use of this option always disables
checks and corrections of whitespace errors.  I personally feel that
somebody who is willing to accept a patch that has whitespace breakages
that needs this option would not care, but the documentation should warn
about it at the minimum.

Needless to say, a lot better option is not to disable the checks and
corrections at all.  After all, this "ignore space change" option is about
matching the common context lines and replaced/removed contents before the
change, and checks and corrections are about added/replaced contents after
the change.  They should be orthogonal.
