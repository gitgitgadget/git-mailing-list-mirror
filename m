From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ls-files -X option is relative to repo root
Date: Fri, 13 Feb 2015 12:42:03 -0800
Message-ID: <xmqqmw4hmtlw.fsf@gitster.dls.corp.google.com>
References: <CAG4vEKM-2sy0z3=YLS+rgH99w6ukdcNBode9CAh4C4t9eSa02A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Daniel Finnie <dan@danfinnie.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 21:42:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMN40-0008W9-QC
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 21:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbbBMUmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 15:42:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752772AbbBMUmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 15:42:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1303124E16;
	Fri, 13 Feb 2015 15:42:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qNWpGULCfWWzcGMtrpjpHfvtaaM=; b=e/Ix0E
	K3wqrp8ZrmlJ+UzCXSg6fVj3As1CHhBuIdioe4TZgp/+2QSElcx+fdQFL7CAPLBW
	dz5wBuiyrWfJSZ1OMFrYToTmxBjr3tYXMcqgpLwZooWZDQ9lgqtRClbrZHeNhv7I
	JPOLnm7SE4U8YA4xsDNr6r02DpdcZFK8XR5Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hg76cSB8aBE0XEDaVYnSD6i7kpcdXCES
	mLaESlovdpM2pT3MKp51+1J5PYeplIIG/AnyeES0XEtSlfuXj3xW8/38pz+/dd70
	klOZoBQpA2sIJBP/iW+ksoDaVq1iskZpDtpZObZGuK/J8Zl7qpkQEMDi1/jIDdVi
	CBImTv1LPGM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 098AC24E15;
	Fri, 13 Feb 2015 15:42:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7035B24E14;
	Fri, 13 Feb 2015 15:42:04 -0500 (EST)
In-Reply-To: <CAG4vEKM-2sy0z3=YLS+rgH99w6ukdcNBode9CAh4C4t9eSa02A@mail.gmail.com>
	(Daniel Finnie's message of "Fri, 13 Feb 2015 14:23:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4CB59A2-B3C0-11E4-877F-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263832>

Daniel Finnie <dan@danfinnie.com> writes:

> My question deals with the --exclude-from option to git-ls-files.

You will be fine if you remember that these plumbing commands work
by first cd'ing to the top-level of the working tree (and adjust the
paths given from the command line by prefixing the prefix to them).

The input lines that come from --exclude-per-directory should go
through the prefixing, but -X=<file> makes that single file affect
the whole operation.  It does not make sense to allow where you are
to affect behaviour of the command, i.e. in these two invocations of
ls-files:

	git ls-files -X /var/tmp/exclude -i
        cd example && git ls-files -X /var/tmp/exclude -i

if the same line in /var/tmp/exclude meant completely different
things, it would be crazy.
