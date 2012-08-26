From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Inverting the --committer option to git-log with v1.7.5.4
Date: Sun, 26 Aug 2012 15:43:06 -0700
Message-ID: <7vr4qttgud.fsf@alter.siamese.dyndns.org>
References: <CAPRhCbtfx+kA8BbPwSYcYfvg5S0b6yWP5TqJHD_LCN-CMFw75w@mail.gmail.com>
 <CAPRhCbuOsiHNOHJUTN8Na9qEqoTAbCb-G41WFscjYhDppKOLGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 00:43:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5lY7-0007jl-MN
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 00:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab2HZWnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 18:43:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab2HZWnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 18:43:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F06B98BC;
	Sun, 26 Aug 2012 18:43:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kSUM3G4Q43gBosnr/s7/KQBLp14=; b=YEpUhB
	g4WgkYlsnG0FtTWDOQQEyAa7f4jBNUYqWeHVYdfi9PN7WRm9fw57J0L+Is4h+0L7
	WZNU2HrEUSQND60nMIK6KSLbAV3+JLPoDoAU5nfoj7K4Dy7ovPyXAio56JUpsXwe
	qfjkp12yfbp9FOFbDkWTTS9+/ecyHevNyIwLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V+ji/oRp61PeUGJAwTX0Kkqc+Oqo0dFy
	/N3NRXJOD3OxlWHAOXO1XKsIN86VsXz3X87ncaSyEGltTgBXRdWLXNrgA322u8sZ
	hm9IUTROCZnL/KYRO6FFMsiY8Thcnc2QRPDXtZlWUpQNuhi1Kzk23dq0Ois08cwQ
	3/dDsJ9OhIk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C5CB98BA;
	Sun, 26 Aug 2012 18:43:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F37E598B9; Sun, 26 Aug 2012
 18:43:07 -0400 (EDT)
In-Reply-To: <CAPRhCbuOsiHNOHJUTN8Na9qEqoTAbCb-G41WFscjYhDppKOLGg@mail.gmail.com> (Todd A.
 Jacobs's message of "Sun, 26 Aug 2012 18:30:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6802064C-EFCF-11E1-B03D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204316>

"Todd A. Jacobs" <nospam+listmail@codegnome.org> writes:

> Is there currently a better way to request logs for "everyone but
> committer x" in Git? If not, is this a feature that someone who
> understands the Git source might find useful enough to add in?

No, there is not.

I wouldn't comment on the potential usefulness of such a feature,
but I do not think there is anything fundamentally wrong to enhance
the limited form of "--grep/--author/--committer" the "log" family
of commands currently support to a full "grep boolean expressions"
that is supported by "git grep" command to let you say something
like:

	git log --author=rezrov --grep=nitfol \
        	--and \( --committer=xyzzy --or	--committer=frotz \) \
		--all --not master

to grab commits from all topics that are not yet merged to 'master',
authored by rezrov and talks about nitfol, that are committed either
by xyzzy or frotz.

The command line syntax to integrate the "grep boolean expressions"
needs to be carefully thought out, as "--not" on the "log" family of
commands is already used to mean something entirely different (it is
a revision range operator), though.
