From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] completion: simplify __gitcomp*
Date: Sun, 05 Feb 2012 12:45:52 -0800
Message-ID: <7vmx8xggan.fsf@alter.siamese.dyndns.org>
References: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
 <1328214625-3576-5-git-send-email-felipe.contreras@gmail.com>
 <7vty37oedr.fsf@alter.siamese.dyndns.org> <20120204135404.GF16099@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Feb 05 21:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru8yF-0007BJ-H2
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 21:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab2BEUpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 15:45:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704Ab2BEUpy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 15:45:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EF27532A;
	Sun,  5 Feb 2012 15:45:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LvD259pWkgk3
	wEvmk3Y9C23ck0c=; b=Ybd217TwI241/AG7B6RXIRIkzPATsKsIpwZ4DtAcawXP
	jJwSeb9R/eyIExCIX4q8S3nk7w/beygN/Y+L7ehBRHjbjMGJ0TKBaMwG13ZVad8e
	6nDEMF+8xrFCFs3NOH1ahf4odrUJsUSSyteLmgLLfW8Xp0isvVaO41H4du8doGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lXGyiK
	U2zOPFHuSiLUP/LuTjr2wXQ+yDrewtLSBcs2RniWdV10yny7V8ZS6Hugq+5NM+01
	yfdSOYHpJChJSzGZJFloUOxEs4NcLnXX6qzgNaTWU+ouv6rHoNEFy5nrxTsrxegN
	MPp23OiTLfyEc9NvM9+0J416jJ4ONmnH7IQJ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F33B5329;
	Sun,  5 Feb 2012 15:45:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B72D15328; Sun,  5 Feb 2012
 15:45:53 -0500 (EST)
In-Reply-To: <20120204135404.GF16099@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of "Sat, 4 Feb 2012 14:54:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 656A7C00-503A-11E1-93CF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189956>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> And it does make a difference, it breaks the completion of a single
> word in multiple steps, e.g. git log --pretty=3D<TAB> master..<TAB>. =
 In
> such cases we pass "${cur##--pretty=3D}" and "${cur_#*..}" as third
> argument to __gitcomp() and __gitcomp_nl(), which can be empty string=
s
> when the user hits TAB right after the '=3D' and '..'.

After saying "this rewrite is wrong", I was actually wondering if I sho=
uld
have said "this rewrite is not faithful to the original".  Based on you=
r
analysis, the difference does break the callers, so the rewrite is inde=
ed
wrong.

Thanks for following up.
