From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Migrating away from SHA-1?
Date: Thu, 14 Apr 2016 19:18:53 -0700
Message-ID: <xmqq37qnehrm.fsf@gitster.mtv.corp.google.com>
References: <570D78CC.9030807@zytor.com>
	<CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
	<1460502934.5540.71.camel@twopensource.com>
	<20160414015324.GA16656@thunk.org>
	<1460654583.5540.87.camel@twopensource.com>
	<71A5D062-FCCD-42E5-80A8-AA9D8DE20604@zytor.com>
	<20160414224051.GD16656@thunk.org>
	<20160415021327.GC22112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Theodore Ts'o <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
	David Turner <dturner@twopensource.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:19:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqtLY-0006qp-MK
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 04:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbcDOCS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 22:18:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752095AbcDOCS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 22:18:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA5BE14E82;
	Thu, 14 Apr 2016 22:18:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SkJ8TpKeJHldF0ZHW0vs8yEQA/w=; b=JVCdhM
	ukCKgXZGRnnf74KtuGvgWu1aksOcJ8x/JE+emSUjsmk1z2HR18U3C5sqSpvYfC7u
	5Hek2cno4JiY+7OM62aZqqHXQiXlsfdU5uICBP4QYkVh8/exIfSXR80mF8RB0WnV
	+yXSFHtmvKbDNDJLpjgYQpP4BaHFi85Stn+1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UHHUsz08NTALc4es8jlWdSYcb8qVVoVn
	v7JWccEkkTnZDzNkpZ4ra2kjrsbmlqvTmftxgEICLqJEg6GSIhha2hiOaBGW1GZe
	rQuSytM7UmyGlUBUeMWduljgb/ZPtfVczuLiqe/lZwwSPT9u41ZAMYdDc1MsXhCr
	HsY2EdRR8mU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF59214E81;
	Thu, 14 Apr 2016 22:18:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4392F14E80;
	Thu, 14 Apr 2016 22:18:54 -0400 (EDT)
In-Reply-To: <20160415021327.GC22112@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Apr 2016 22:13:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66CCD804-02B0-11E6-A182-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291596>

Jeff King <peff@peff.net> writes:

> [2] Somewhere in the list archive is my patch to find partial
>     collisions like "git commit --sha1=31337", and I did in fact use
>     that micro-optimization. That, along with multi-threading, made it
>     feasible to do 6-8 character prefixes, as I recall.

In our testsuite, we have a test that uses many objects, all of
which have object names that begin with 10 '0' characters.
