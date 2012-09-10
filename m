From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: respect "core.ignorecase"
Date: Mon, 10 Sep 2012 14:38:08 -0700
Message-ID: <7vtxv5lfsv.fsf@alter.siamese.dyndns.org>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
 <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
 <20120910161325.GB9435@sigill.intra.peff.net>
 <7vvcflmxis.fsf@alter.siamese.dyndns.org>
 <20120910203442.GA968@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:38:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBgR-0004xB-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab2IJViM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:38:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36670 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794Ab2IJViL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 17:38:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAB6C80B0;
	Mon, 10 Sep 2012 17:38:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SDVEM2i2/kwK05POl3T7mdF9C3Q=; b=FTYl+p
	QOsLrUAEI5GvgctFcI+ZxT+u9Z+atYA8Pba142T6rJpVJGnMyZUq5UQvUIXsVP1p
	P/d3duOQZV1aX8JnJt0fQPK/z4aaugCsb0nq7x34oDx0lUhSwe3lVOCQ+L5hiNHD
	cPy9GwHjke9d5+VRLeWCQDXzVjkNDXXW1YWv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vaEUgZ0cD4qEszbQDqQUdSWAZ5CrGlOM
	HEHfDclSUuT0BEFnclBgocA9SE7Z/ucf/Ifyw8c8NMd3KZGeb0vtoTQTefY38Eph
	5Gavqigs5GvlcIInT0Wgg4kFSLM6YSDWGij2GO0bMdSprL9vfYxAUjh8GlJkWA6U
	3MW60J62nWE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8C7C80AF;
	Mon, 10 Sep 2012 17:38:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3009080AE; Mon, 10 Sep 2012
 17:38:10 -0400 (EDT)
In-Reply-To: <20120910203442.GA968@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 10 Sep 2012 16:34:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0EF095E-FB8F-11E1-9B0C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205194>

Jeff King <peff@peff.net> writes:

> On Mon, Sep 10, 2012 at 01:30:03PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > If the proposal were instead to add a certain type of pathspec that is
>> > case-insensitive[2], that would make much more sense to me. It is not
>> > violating git's case-sensitivity because it is purely a _query_ issue.
>> > And it is a feature you might use whether or not your filesystem is case
>> > sensitive.
>> > ...
>> > [2] I did not keep up with Duy's work on pathspec magic-prefixes (and I
>> >     could not find anything relevant in the code or documentation), but
>> >     it seems like this would be a logical feature to support there.
>> 
>> I think it mostly is in setup.c (look for "Magic pathspec").
>
> Thanks, that helped. I got excited when I saw the "icase" in the
> comments and thought it might already be implemented. But it looks like
> it is still to be done. :)

Yeah, some are tongue-in-cheek (e.g. I do not know what "recursive
pathspec" even means), but "noglob" probably is an urgent need from
correctness point of view for people who are writing Porcelain and
want to interact with a history that records funny filenames.
Currently you can "git <cmd> 'foo\*'" to match a path that is
exactly 'foo*' (because it matches) but you also have to hope there
is no other paths that happens to match that pattern.  A script that
grabs paths out of ls-files output and then tries to use them as
pathspec would want to have a way to say "This is literal. Do not
honor globs in it".
