From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git subtree error (just how do you expect me to merge 0 trees?)
Date: Mon, 31 Dec 2012 19:16:14 -0800
Message-ID: <7v7gnxd24h.fsf@alter.siamese.dyndns.org>
References: <FBE22FDC-5800-40C8-9778-82DFD27579F6@drewcrawfordapps.com>
 <87licd3b7w.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Crawford <drew@drewcrawfordapps.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Tue Jan 01 04:22:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpsQy-0000Gl-GO
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 04:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab3AADQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 22:16:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab3AADQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 22:16:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A904BEA5;
	Mon, 31 Dec 2012 22:16:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gEj9pyNqTvvg9LX7E20Lmd2WEkA=; b=cutHA5
	YW4zhOuoJP46pmjBdST9EdSwydSP1NaBa5hfipitJA2mClT8nZvRbScIFyI3RR5B
	AXNovApTvEqQ3dT2GOI6pjlVBX3EKJStmzUXbNmmG3/rLKbtLyjjKPF7lmZxLO4u
	9rCW9NbocJ7YhS2n2sTfo3rKnJW69/QfsIfqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NX1SgzpKfvx2pFAj9l4/IrPFEP9GBi/z
	SwrxjHpxHAN3BUpCxoCqhpG3tjYJAZXKmzrrtCN5aX5wa8/PXC5M49qzpJrn/5CT
	K7eGZKwv/mt8fnQErOeiFvjtaQNZ009dN7pLDxSDGR+H+MmRdwSfVV7/ZH843jCI
	SWXvs7GR83c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F032DBEA4;
	Mon, 31 Dec 2012 22:16:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C559BEA3; Mon, 31 Dec 2012
 22:16:17 -0500 (EST)
In-Reply-To: <87licd3b7w.fsf@waller.obbligato.org> (greened@obbligato.org's
 message of "Mon, 31 Dec 2012 20:09:55 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B4D4B32-53C1-11E2-8531-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212400>

greened@obbligato.org writes:

> git-subtree add accepts either a refspec or a path to a repository and a
> refspec.

> With one positional option, git-subtree add simply assumes
> it's a refspec.  Is there an easy way to check whether a string is a
> proper refspec?  Even better would be a way to check if a string is a
> path to a git repository.

Do you literally mean "a path to a repository" in the above, or do
you mean "a remote that is like what is accepted by 'git fetch'"?
If you literary mean it is is a path to a git repository, you could
obviously use "cd $there && git rev-parse --git-dir" or something.

On the other hand, if you mean the command takes a remote and an
optional list of refspecs just like "git fetch" does, then I am not
sure it is a good design in the first place to allow "refspecs
only", if only to keep the interface similar to "git fetch" (you
cannot omit remote and give refspecs, as you cannot interpret
refspecs without knowing in the context of which remote they are to
be interpreted).

I would imagine you could disambiguate and default to "origin" or
something when you guessed that remote was omitted if you really
wanted to, with a syntacitical heuristics, such as "a refspec will
never have two colons in it", "a URL tends to begin with a short
alphabet word, a colon and double-slash", etc.
