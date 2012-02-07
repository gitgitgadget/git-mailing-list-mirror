From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Mon, 06 Feb 2012 22:10:22 -0800
Message-ID: <7v1uq741ip.fsf@alter.siamese.dyndns.org>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com>
 <7vwr7z653f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 07:10:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RueGR-0007lp-2o
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 07:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab2BGGKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 01:10:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45253 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829Ab2BGGKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 01:10:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DC387247;
	Tue,  7 Feb 2012 01:10:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zTP1XtkIHvvUJU/0JyKb7M9/Vqw=; b=tpFFtf
	uSuwd6vOcLEBKoFokOYkJphlrqRAhOrEHFqXL698PDtoc4mg+jObI4tQSdhOTLKI
	JVhsqL+DfRwkr4SzbrP33vxuibx2qprg2JQ7gLjl3ajLldU5x5rjWL+EifN3tEFS
	DtgNKk3pf7xxSN9EdQ4O4NE85tODgFsp+zkT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DX0O88HpU9q80ojlslE1z2x0cUtYIoYB
	EHY2zN0Q2bePQvpT8qSuPaYDCDPTnEk6mS28KyAaP4Y2XoSATVTRqdxlYCW+J6h+
	DjXyvqZr9ly+QIP4KoItqQYzKmHBxK1slED95/gPir9V2FFaWZfrxUtfvpheyV4t
	y0HzXRv4cz8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73C1C7246;
	Tue,  7 Feb 2012 01:10:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D53A37244; Tue,  7 Feb 2012
 01:10:23 -0500 (EST)
In-Reply-To: <7vwr7z653f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 06 Feb 2012 13:10:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BFED458-5152-11E1-9438-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190143>

Junio C Hamano <gitster@pobox.com> writes:

> It still is not clear to me how best to sell this change to the end-user
> community.

OK, sorry for wavering.

Unless you are doing "commit -a" or "commit pathspec", you are responsible
for adding all contents you want to have in the commit before you run the
"git commit" command (and for the purpose of this statement, "add -N" to
tell Git to keey an eye on a path does _not_ add contents). A change to
the file in the working tree that is left unadded is what you decided to
deliberately leave out of the commit, be it a change to a path already in
HEAD, or a path marked with "add -N".  Forgetting to add modified file and
forgetting to add a file you earlier used "add -N" amount to the same kind
of risk, and "git status" is the way to make sure your partial commit has
exactly what you want (if you are not worried about partial commit, you
would be doing "commit -a", so the "safety" is a moot point).

I was worried too much about backward compatibility and was blind to the
above, and was mistakenly defending a false "safety" that did not exist at
all.  Sorry for wasting everybody's time.

So let's bite the bullet and admit in the Release Notes that the current
behaviour was a UI mistake based on the misguided assumption that we can
give some kind of "safety" by committing when there are "add -N" entries
in the index, which is untrue, and we are fixing it in the new release.
We do not need configuration nor command line options.

Let me try to reroll your patch tomorrow (unless you beat me to it) and
see if I can come up with an easy-to-understand explanation to it.

Thanks.
