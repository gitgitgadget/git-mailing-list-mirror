From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep to operate across who repository and not just CWD?
Date: Mon, 28 Feb 2011 10:32:59 -0800
Message-ID: <7vk4gkhuw4.fsf@alter.siamese.dyndns.org>
References: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com>
 <4D6B6A8B.20709@drmicha.warpmail.net>
 <AANLkTimJWeZLJbPndTyE0EUW3R9EC=yV55jhHbpZnnJn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	David Chanters <david.chanters@googlemail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 19:33:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu7uG-0000lw-Uc
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 19:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab1B1SdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 13:33:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab1B1SdL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 13:33:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E71B4EA4;
	Mon, 28 Feb 2011 13:34:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iV/DVY2UQULXomoF54z+eL39JSg=; b=N/xV2i
	LI4kZOwInUlOiR5UmS7SnQ57wUAMdV2Z0XRqEVLchFG8ICvwoDfTuvCRJHvA92o5
	YWS6fGKS6ahwrecaua2gzsH/9BmNLtEyiJbFCC6Gco/JN2JZakKbeWil4uvhTGlV
	X1r9tRvBTjATfFT3D/qp3xREfTf206VgmlP18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QZ6KYL/CgCuUzHmjJGzYorw3Eg+xYX6/
	+RqlOHowBJt9G4S7ZbBVTwSfxBLF16q/NtO0vXoWa7MD4v1vP3PllNpVKuwA8JSu
	xNguWLt4ALUuo73ePvkD6DR/FrBWwqxIjp+q40QWTTpYvtPpbGVXD31BrAR4oMAA
	FcxRySgRWM0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D07014EA3;
	Mon, 28 Feb 2011 13:34:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8C4454E9F; Mon, 28 Feb 2011
 13:34:19 -0500 (EST)
In-Reply-To: <AANLkTimJWeZLJbPndTyE0EUW3R9EC=yV55jhHbpZnnJn@mail.gmail.com>
 (Jay Soffian's message of "Mon\, 28 Feb 2011 10\:27\:06 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5DF5EB32-4369-11E0-974A-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168131>

Jay Soffian <jaysoffian@gmail.com> writes:

> I had the crazy thought that if git had a --cdup option, then this
> would work with any command you wanted to run from the top:
>
>   git --cdup grep ...
>
> Maybe that's the best way to expose "from the top please" generically?

We tend to give --full-tree option to individual subcommands where it
makes sense to get the same effect.

One problem with a global "git --cdup" is to sensibly handle pathspecs
given from the command line.  You would likely want

	$ cd Documentation
        $ git --cdup grep -e info pu Makefile '*.txt'

to still refer to Makefile relative to Documentation/ directory (imagine
typing "Makef<TAB>" to complete while forming that command line) while
looking for '*.txt' files everywhere in the tree, but only individual
commands can tell which parameters are pathspec in argv[].  Hence the
subcommands have to be aware of the wish (--cdup or --full-tree) of the
user to affect the full tree, not limited to the current working
directory.
