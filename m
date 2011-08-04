From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Wed, 03 Aug 2011 19:25:32 -0700
Message-ID: <7vwret6hgj.fsf@alter.siamese.dyndns.org>
References: <1312409879.97173.YahooMailClassic@web29501.mail.ird.yahoo.com>
 <20110804014143.GA32579@sigill.intra.peff.net>
 <7v62me6ism.fsf@alter.siamese.dyndns.org>
 <20110804020054.GA1947@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>, git@vger.kernel.org,
	rene.scharfe@lsrfire.ath.cx
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 04:25:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoncy-0003LB-G4
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 04:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016Ab1HDCZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 22:25:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37716 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018Ab1HDCZf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 22:25:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B3235026;
	Wed,  3 Aug 2011 22:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zq288FHzq4JfCruzKlF2lBMDKSI=; b=MfImRX
	IRW4EpA8eOn9K/Yt4+F0G9NfhFIUo/UbUmOlp3J4wo1mCk4Tl7KwtYNlPo5uBls+
	Vs7M+/1vtk4SQBHyTV0RtBK7Fdflm0tQLptRtsnlG3xHL0rqQzWR8QLEpD91HiYD
	9T00CnP+lagok8C/7oIjugKSah4Ij0RgiB/d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CaFFIIG7xPY2tljQIUrwGtCuQnNK94xZ
	FkdhtRWVJNqrW5hPZN0hmK03tXk+o0SzqAzV651MHekBYNuPWnmPyujt9mfeSQIF
	10Q4BsBmbdIOd3O/88X9258+t/8yLxi2OGlKMuniEUbkRsuNL+gSRYr8kVtuK6gZ
	JNaaEAxpikU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62C2B5025;
	Wed,  3 Aug 2011 22:25:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6F585024; Wed,  3 Aug 2011
 22:25:33 -0400 (EDT)
In-Reply-To: <20110804020054.GA1947@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 3 Aug 2011 20:00:54 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 081FCF36-BE41-11E0-AF6D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178657>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 03, 2011 at 06:56:41PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > It might be a bit more obvious to find if we actually had a
>> > --no-pax-header option, though.
>> 
>> Yeah, we would need to make sure that --no-pack-header causes a barf
>> for other backends, though. "struct archiver_args" right now seems to have
>> compression_level but I think it should just have "const char **" that is
>> interpreted by backends.
>
> Actually, it is relevant for zip, too. The option should really be
> called "--no-commit-id" or something similar. I don't think it's as big
> a deal with zip (because there is no compatibility issue), but you may
> want to omit the header for other reasons (e.g., because you know it
> doesn't point to a commit that is public).

Hmm, perhaps. It indeed is an implementation detail of the tar backend
that the commit object name is stored in pax header, so --no-commit-id
might make sense from "git" point of view, but from the point of view of
OP that started this thread, he wouldn't care what that extra information
is --- it can be a commit object name or it can be phase of the moon when
the archive was made --- he just wants the extra header dropped.

So I dunno.
