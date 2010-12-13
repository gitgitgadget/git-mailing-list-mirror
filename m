From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull gitk.git master branch
Date: Sun, 12 Dec 2010 19:11:57 -0800
Message-ID: <7v7hfe74ea.fsf@alter.siamese.dyndns.org>
References: <20101212063135.GA7677@brick.ozlabs.ibm.com>
 <7vwrne8tow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Alexandre Erwin Ittner <alexandre@ittner.com.br>
X-From: git-owner@vger.kernel.org Mon Dec 13 04:13:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRyqf-0003Ii-0F
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 04:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628Ab0LMDMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 22:12:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab0LMDMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 22:12:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F5753FBA;
	Sun, 12 Dec 2010 22:12:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xzmnqe57s351l8wBsO/mvjWSjSE=; b=BTUWPq
	LdImQrpGydwRot/ZtC2KjdntalsGEjOq1oxyUwwhwNNOboD7XDDBMs+ip55fRgPh
	DXNe1iEML4PBxmv3jjjcwjYoVDYJaHVswI6cD+FzYE68+4T+HYAgftG77O9sfEEp
	LIP8bTJbJqapbU8ywo17e/xThkI2/DIyWea44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bLa+udngSeZz2oOBL+AZEHiawlpAKxEk
	GrxMO4OuGbIOOoY+hsfiq5xyWCQQ3i6UPIWcEmlnYNOTJgMJEqV5Zyd1zAxBexdu
	2zaAO0iHmnL3UFPVxUeOxypcMkgpXvZrcar3ptm4d5duyxZ29+Ejux2kmjzRygsq
	tPxv9qVVbNA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B3393FB9;
	Sun, 12 Dec 2010 22:12:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 31C783FB5; Sun, 12 Dec 2010
 22:12:24 -0500 (EST)
In-Reply-To: <7vwrne8tow.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 12 Dec 2010 15\:20\:15 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D198D954-0666-11E0-868A-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163509>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks, pulled (not yet pushed out).

Yikes.

Paul, has this ever been install-tested before you accepted the "pt-BR"
patch to your repository?

"msgfmt --tcl" produces po/pt_br.msg for me, but the Makefile wants to
install po/pt_BR.msg and fails.  Perhaps the poor-man's po2msg.sh does not
have this glitch and produces po/pt_BR.msg, but I don't think that is an
excuse for not checking with both that script and the real msgfmt before
the change gets this far.

Using the -o option on the msgfmt command line to force the command to
generate pt_BR.msg fails with:

    msgfmt: --tcl and --output-file are mutually exclusive

Combined with this and the fact that msgfmt produces po/pt_br.msg out of
the input po/pt_BR.po makes me suspect that Tcl runtime enviornment does
not actually expect pt_BR.msg but want to see the country part downcased.
In which case we may need to fix po2msg.sh to match that behaviour.

An workaround would be to rename po/pt_BR.po to po/pt_br.po but I don't
know if there are unexpected side effects if we did that.

I'd like to see this glitch sorted out before I push out the result of the
merge, so it is likely there won't be a pushout tonight.  We need to know:

 * Is this "downcase the country part for --tcl" a bug in the particular
   version of msgfmt I happen to have (it is 0.17 from GNU gettext on
   Debian), or is it the filename convention expected by the Tcl i18n
   runtime environment to have both language and country in lowercase?

 * What is the recommended best practice in Tcl i18n community for naming
   lang_COUNTRY.po file?  Do people typically spell the COUNTRY in
   uppercase and let "msgfmt --tcl" downcase, and deal with the filename
   case issues in the Makefile themselves?  This feels yucky, as it means
   that we cannot use '%.msg : %.po' dependency pattern, but need to list
   the dependencies by hand.  Or do they spell country part in lowercase
   to avoid this whole issue?

My _preferred_ outcome is to see that naming the input "po/pt_br.po" and
using the output "po/pt_br.msg" is the BCP, but I'd like somebody to find
out what the accepted practice would be in the Tcl land first.
