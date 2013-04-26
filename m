From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug report
Date: Fri, 26 Apr 2013 10:24:51 -0700
Message-ID: <7vli85xl0c.fsf@alter.siamese.dyndns.org>
References: <CANWD=rVdAVP0KSdai-tQf9VtVj7bOLMrENiG_fx-mD_R2f8SnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Pierre-Fran=C3=A7ois?= CLEMENT <likeyn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 19:25:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVmOJ-0000GR-Gg
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 19:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285Ab3DZRYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 13:24:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092Ab3DZRYy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 13:24:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EC0F19880;
	Fri, 26 Apr 2013 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z376UlllD8WT
	YDHdGnaaiPn97wU=; b=ZPHtqoPBbLi0+iMB/IUvn4aWSPcUnh+873QI6RqVn17B
	pCLptdtrXMco71UL3sJqD3Cw+iptPTz5e+UhbJ8OZvOQbJsCrII6vetFJu1HVP4Q
	Rx6nnVR3Yc4lYoL5/7RViDSC7Uc8Hcu+iNO8neLBA1Od+w8Svd1K262+cEBQp/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w8sKZ/
	F3LS3qi1la98itiwHaE6d1GzFO1AqtulzSawD6wI/f9sn++dANm6iOx/gfOO8azX
	vtAWiweXyUJ4KJZryqVotWYCXML6A2LlXUQhW5uJMSkN8pSxpyXCSFUThBeuZeVc
	KDHT90iwUHfm15QXAfYu4dU67tIjTJpbnrkOA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 052751987F;
	Fri, 26 Apr 2013 17:24:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 617241987D;
	Fri, 26 Apr 2013 17:24:53 +0000 (UTC)
In-Reply-To: <CANWD=rVdAVP0KSdai-tQf9VtVj7bOLMrENiG_fx-mD_R2f8SnQ@mail.gmail.com>
	(=?utf-8?Q?=22Pierre-Fran=C3=A7ois?= CLEMENT"'s message of "Fri, 26 Apr
 2013 16:59:26
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 351F1FAE-AE96-11E2-B006-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222543>

Pierre-Fran=C3=A7ois CLEMENT <likeyn@gmail.com> writes:

> As you can see, the --cumulative lines seem to be duplicated, though
> the computed stats aren't exactly the same... It appears when you
> combine the --cumulative option with either --stat, --numstat or
> --shortstat (but not --dirstat) ...

Thanks for a report.

I do not think the deprecated --cumulative command line option was
ever designed to be used with anything but --dirstat.

It was a UI mistake to make it look like an independent option,
which was corrected with 333f3fb0c530 (Refactor --dirstat parsing;
deprecate --cumulative and --dirstat-by-file, 2011-04-29) and the
fix shipped back in v1.7.6. Since that release we do not even
mention the option in the manual.

These days, the right way to spell it is as an option parameter to
the --dirstat option itself (e.g. --dirstat=3Dcumulative).

The parser to parse --cumulative as a command line argument was kept
so that people who were used to "--dirstat --cumulative" do not have
to see an error from the command line parser.  We could have made
"--cumulative" with other kind of "stat" an error back then, but we
didn't. I suspect that we thought it would be sufficient to not
document --cumulative as a standalone option, but I do not recall
the details.
