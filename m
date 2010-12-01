From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config
 options
Date: Wed, 01 Dec 2010 11:47:29 -0800
Message-ID: <7vvd3duvfy.fsf@alter.siamese.dyndns.org>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net> <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com> <20101201160503.GB26120@burratino> <m3aakp4g5o.fsf@localhost.localdomain> <20101201163406.GD26120@burratino> <4CF67D36.9020908@drmicha.warpmail.net> <20101201175815.GB7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 20:47:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsei-00032d-Nl
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772Ab0LATrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:47:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab0LATrq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:47:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8BA232C7D;
	Wed,  1 Dec 2010 14:48:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VNV0SIvzT5nJyHbYKd4xMWS4jp0=; b=JmQ3w6
	iO54W0c4J2Nlxw/yTj0wIY9+mEcWFD2XCinjB5qF7BNp/rl130xHvmyJ9xMGZhCM
	UppVhhFfCEN1SiWg/4J464oU0hqkI1hOP05qMOcxO66tcc/Km/B8tj2eLIHIOQu0
	Vpj7XDrfPOZdGckfFYIq31EvUR90P5kBdg8Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UiODNm7VedzUhswGEYk1pwpY90KrQcJI
	8gE2nTzGH5xCGLAA3d4RVGh665ZfpklT2nUsa/VsHp/Z5FS+DcnfrM/zkMJ01Jg8
	Nl4fjhv5b2VcHfZe2QrL5oFNvqJdrzTQieDmUbzlanWj13hUTUrNFnIRAA/hAYZn
	KiMTm3MWb0A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0ED2D2C67;
	Wed,  1 Dec 2010 14:47:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C1222C61; Wed,  1 Dec 2010
 14:47:49 -0500 (EST)
In-Reply-To: <20101201175815.GB7774@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 1 Dec 2010 12\:58\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5AC5E52-FD83-11DF-A817-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162587>

Jeff King <peff@peff.net> writes:

> If there are short config options that work, though, we should probably
> keep them. It surely can't be that hard for the perl code to accept both
> "cvsimport.r" and "cvsimport.remote" for "-r" and
> "cvsimport.generaterevisions" (or whatever) for "-R"?

I'd agree.  The current parameter set we give to GetOptions is:

    haivmkuo:d:p:r:C:z:s:M:P:A:S:L:R

and I notice that we cannot sanely access A, M, P, R, S and their
lowercase counterparts.

It shouldn't be too hard to interpret the single letter options for the
currently supported set but only for lowercase letters plus '-C <arg>' and
'-L <arg>' (because there are no lowercase ones that crash with them), and
give long config names to at least the ones inaccessible with the above.

Wouldn't that give us a regression-free solution to the immediate problem
at hand?

Supporting long options on the command line, and giving long config name
synonyms to the lowercase ones, would be a plus for consistency's sake,
but that probably is a separate topic.
