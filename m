From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] t9500-*.sh: Fix highlight test hang on Linux Mint
Date: Sat, 07 Sep 2013 09:23:21 -0700
Message-ID: <xmqqmwnovbwm.fsf@gitster.dls.corp.google.com>
References: <522A51A5.9090905@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, hvoigt@hvoigt.net
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Sep 07 18:23:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VILIG-0006ox-UM
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 18:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121Ab3IGQXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 12:23:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043Ab3IGQXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 12:23:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE7E33F2F8;
	Sat,  7 Sep 2013 16:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RmCEKm81R+/Y7+AF+H489aq1FDU=; b=Y07HTM
	vj0Ue0Fj19qylo5FFKEVCH8UUDsZW1mCy/BaXgHCVpXKLW2S8B1DzdZTDlyZeQs1
	Gy7rC4YnwjSJjyFiadyAeBlfzD2R5DOA/h5+3PfE4PORpxY1Rq55Nto+tdXxZQG2
	QEGSMSPClQ74KK2unDmjWw3sDWX9DvFWcyxUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d337j5TklCqIVk1sVebLA4mOCIt0khvc
	tZL2Es1vCWE9dyDxAsMwErjLzpnxV6Jya7uszWe8P/pTJE5Lm1c6ENERbDeLiLcS
	IHyglqbx4H7FEvloN96tLVrLUYpruFsky+oN9a2OFDt0WR2kDWP8V7RW25qeOkGI
	cLyI5oAZv0A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B62653F2F7;
	Sat,  7 Sep 2013 16:23:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 178E33F2F3;
	Sat,  7 Sep 2013 16:23:23 +0000 (UTC)
In-Reply-To: <522A51A5.9090905@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Fri, 06 Sep 2013 23:05:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0E22AD8-17D9-11E3-A731-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234138>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In order to allow the user to specify the correct tool, introduce
> the GIT_TEST_HIGHLIGHT_BIN variable. Also, add '</dev/null' to the
> command line of the highlight invocation; this avoids hanging the
> test if the filter script is used nonetheless.

gitweb/Makefile seems to have a rule to set this to a custom
location, though.  Why do we need a special test-only location?  If
the user wants the right one during the test, wouldn't the final
build and install also want to use the same "right one" that is not
just a generic 'highlight' that does not say which path it resides
at?

So I think forcing the testers to say the same thing twice like this
patch does is a good way forward.  Add a mechanism to allow outside
world to ask which "highlight" gitweb/Makefile was told to use, use
that mechanism to learn the value of HIGHLIGHT_BIN to check if the
binary is usable for the test, or something perhaps?

The killing of the input is independently a good idea, I think.
