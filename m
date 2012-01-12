From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff <file> HEAD^:<file> error message
Date: Wed, 11 Jan 2012 18:26:30 -0800
Message-ID: <7vr4z54pwp.fsf@alter.siamese.dyndns.org>
References: <20120111111831.GB15232@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jan 12 03:26:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlANC-0004S0-1U
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 03:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab2ALC0d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 21:26:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54957 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab2ALC0c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 21:26:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E04BD643F;
	Wed, 11 Jan 2012 21:26:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2FngCIr4PBsS
	YpKWbLiSZZka12E=; b=drKlC1huEC5+vYM2TVbx0ZhgW8rfL6tXQsUyOHdyKZcp
	iBl7Rc/5yiGXLGFvl5dPVY0WPl8a3EeikLrCZCbiGxiHrO+sgmQq/fH6sa7GOG2O
	wQzGH1Z0FkAYTazagTIqqYMeqtNCPLyIyeTPu+O0NFTBQdiSNn6HR6g7TVdRgeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Sx9rk9
	4PLQKBDqEwOjpe5Y1LiU6N/FDdQPS1Ue/HK6qvN2TCWuTWyFDZkw3dhv848+5ybc
	pPRdWHmh5mBcB9jGfsB5gEmN6r6Tko6HR+BJ2Fs1i2V2RUSelQuHm29W9AxO4e9N
	KfHWtIWLW4lHEjE0aBQQDcoLH8rSYakteI+nE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8413643E;
	Wed, 11 Jan 2012 21:26:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 687B5643D; Wed, 11 Jan 2012
 21:26:31 -0500 (EST)
In-Reply-To: <20120111111831.GB15232@beez.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 11 Jan 2012 12:18:31
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6E48256-3CC4-11E1-9FAD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188414>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> I was trying to figure out why running
>
>    git diff HEAD^:RelNotes RelNotes
>
> gives the expected output (on maint it tells me that the stable
> version changed from 1.7.8.3 to 1.7.8.4) but swapping the arguments
> doesn't.
>
>    git diff RelNotes HEAD^:RelNotes
>
> doesn't show the opposite patch ...

That comes from the general argument parsing rules of Git, namely, glob=
al
options (e.g. --paginate) first, then subcommand name, followed by dash=
ed
options, revs and finally the paths. Once you give "RelNotes", which
cannot be a rev, you cannot give a rev.

We _could_ special case the rule for "diff", but we simply didn't bothe=
r,
as the resulting code (and the implications of special casing) would be
too ugly to live to support such a corner case usage, especially when y=
ou
could always say "-R" to reverse the output.
