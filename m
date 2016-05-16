From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 14:18:32 -0700
Message-ID: <xmqqlh391z2v.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	<CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
	<xmqqh9dx3nsf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZyPvAFG1TjSm76LuDLpch=7iuL_-8LYqysSESFQj-YjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 16 23:18:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2PuT-0006Bc-GK
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbcEPVSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:18:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750964AbcEPVSg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:18:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEC7B1C975;
	Mon, 16 May 2016 17:18:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AggoC8K3NmeQ+DDl/ypqrDnpA4U=; b=rOWAy1
	N6Gt6BOjPgzT3IPtWmlkxoYTReNLDujKIaO57P9Jme/TiM2BIagGgxIXXl3p/XSy
	aAWWaRv3idCHrtQVUdUsBxR0hgQuN1TpumVtTEqtCi/CCKM6LGPwuRUUG/G/1ytx
	b+j6LOgDOcrqiLEHSAv8ek+4YjqrQQN2CZhOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NWRhK9110irCTrAf8pqg/p68UQfwJAEE
	4XYhnvb13MzUftIsnlEQG/MTLuygRpoCyNVw7dwKB6WpidSY/O7BFUMLZDhj3yGc
	CQJWsDrCDzRLcvAP/3kSkVL00YOC46eR2oZgTAmoNnwnmc7m5Y49jjQGAEvta4cW
	WZ9N/G0GiDA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4C0E1C974;
	Mon, 16 May 2016 17:18:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51DEB1C973;
	Mon, 16 May 2016 17:18:34 -0400 (EDT)
In-Reply-To: <CAGZ79kZyPvAFG1TjSm76LuDLpch=7iuL_-8LYqysSESFQj-YjQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 16 May 2016 10:48:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BF4C504A-1BAB-11E6-8CF0-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294798>

Stefan Beller <sbeller@google.com> writes:

> This is another case for using ':' instead of '='.
> So I think ':' is better for this future enhancement.
>
> Also this future enhancement may ask for
>
>       git ls-files ":(attr:label=foo)"
>
> or
>
>       git ls-files ":(attr:-label)"
>
> so the user can circumvent the warn and ignore strategy. :(

That is exactly what we want, I would say, if we want to accept
"arbitrary set of attributes with their states".

The "warn and ignore" comes only from "with '(:label=X Y Z)', we
inspect attributes X, Y and Z and insist them to be set to true; it
is a configuration error to set the label to anything but a string",
and accepting "arbitrary set of attributes with their states" makes
it moot (as I said earlier in $gmane/294776).

So are we leaning towards ":(attr:<state>)", where <state> is one of

    var=value
    var
    -var
    !var

now?  It makes the pathspec magic parser a bit more complex (and I
am not sure if we have to worry too much about quoting "value" part
to allow arbitrary sequence of bytes), though.
