From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Mon, 30 Nov 2015 10:11:06 -0800
Message-ID: <xmqqio4j8iit.fsf@gitster.mtv.corp.google.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 19:11:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3Sv2-0005EW-6A
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 19:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbbK3SLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 13:11:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751484AbbK3SLO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 13:11:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C53A2F6B7;
	Mon, 30 Nov 2015 13:11:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i/T9uDDVhoQx4i0ZcN6a9OTUM6w=; b=mgYGbZ
	9ZXahOTFkBAYR3axtUeEw4O5UiGI1FV7G3P5mWd3GVjmqih+OJVahMWER4/41LSi
	sWT3iPDWh6YdHjXONquAwggEqbKhmpmEV2WekkwSR+/jUV4TFZir/YKkzSBvb6y/
	8DcmX57AGaEBeoB2KIyN8BCiVWAC/uf5XQLu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I3bb1lHX89Du0mkdt2aqszzNWss8t7W9
	bNOBQIT4h0dGfH/d055tQ/czcxViYpOMkAASqEz6XP92Q9vVG0RJivfVnc5U66NS
	Q83HdIOXJSBHysBPbg58FEcQI8a2hoBdExjDYYE1hkA4TiV946Q4UdXZ0vvlkqRf
	mnRo/GERhww=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 934D02F6B6;
	Mon, 30 Nov 2015 13:11:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 11A072F6B5;
	Mon, 30 Nov 2015 13:11:07 -0500 (EST)
In-Reply-To: <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 13 Nov 2015 15:16:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA901CAA-978D-11E5-B974-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281806>

Stefan Beller <sbeller@google.com> writes:

> +cc Junio, Duy
>
> So cloning from an arbitrary SHA1 is not a new thing I just came up with,
> but has been discussed before[1].
>
> Junio wrote on Oct 09, 2014:
>> This is so non-standard a thing to do that I doubt it is worth
>> supporting with "git clone".  "git clone --branch", which is about
> "> I want to follow that particular branch", would not mesh well with
>> "I want to see the history that leads to this exact commit", either.
>> You would not know which branch(es) is that exact commit is on in
>> the first place.
>
> I disagree with this. This is the *exact* thing you actually want to do when
> dealing with submodules.

Yup, I know, but I do not think the above disagrees with you (read
again ;-).  It merely says "--branch" option to "clone" is not a
good place to add a new "clone at this single commit" mode of
operation.

In order to propagate "--single-branch" thru "--recurse-submodules",
I suspect that you would need to teach "clone" a new option that is
different from "--branch" that allows you to clone the history
starting from the commit recorded in the tree of the superproject in
the submodule.  That would be orthogonal to "--depth $n", of course,
in other words, a top-level "--single-branch --recurse-submodules"
clone should trigger the "history reachable from a specified commit"
mode of clone in submodules, and if the top-level one specified the
"--depth" option, the lower-level ones can limit the depth
accordingly.
