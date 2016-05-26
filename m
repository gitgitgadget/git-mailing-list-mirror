From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] log: add "--no-show-signature" command line option
Date: Thu, 26 May 2016 10:22:01 -0700
Message-ID: <xmqqiny0wx8m.fsf@gitster.mtv.corp.google.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
	<20160526130647.27001-3-mehul.jain2029@gmail.com>
	<20160526163241.GC18210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mehul Jain <mehul.jain2029@gmail.com>, git@vger.kernel.org,
	Austin English <austinenglish@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 19:22:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yz7-0001Fb-81
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 19:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbcEZRWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 13:22:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752175AbcEZRWG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 13:22:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 910081E45F;
	Thu, 26 May 2016 13:22:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z5xgxw/xyWwI5Ytna5DHusDtwKc=; b=PAbtIU
	Lf/Zky0UJYEQlR+rFNS1lfEuGT/UifOc3yvMNPXOQV/vaI1VZ/RzEyTQ32IFlmDM
	3MfxjRhZU1sCQoqVzh8ErLwRIai+aps4M1aOtxnyKl3jbCdJgsFnNfb0G3N9f8sN
	U+IKDn6etrhwluqRn6yqvXCoVOSxx4Qc6Ggis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OKhyI5YFtI/g/VxndQ52gRJxdH88cWO1
	wDM/ZaGdH185TWicCU6nelGFYzb5NL3tWz2/ligjl56tT/Pulm0Fo81LrNALQjtx
	Q434uxo1rLWYxobU0C/xN7wIVSlFIEZc9LtoXhfwL6tag80yfjhSU+58DQHKCyvo
	GPtmhwp7KaM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 845AC1E45E;
	Thu, 26 May 2016 13:22:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0BDE1E45D;
	Thu, 26 May 2016 13:22:03 -0400 (EDT)
In-Reply-To: <20160526163241.GC18210@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2016 12:32:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D3E2E2E-2366-11E6-8129-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295676>

Jeff King <peff@peff.net> writes:

> On Thu, May 26, 2016 at 06:36:47PM +0530, Mehul Jain wrote:
>
>> If "log.showsignature=true", then there is no way to override it using
>> command line switch.
>> 
>> Teach "git log" and "git show" about "--no-show-signature" command line
>> option.
>
> I think this is teaching all of the revision machinery about it (which
> is a good thing).

I agree that the proposed commit log message should be updated to
say so.

Because we do not want .showsignature configuration to affect
rev-list nor format-patch, and we will not make "--show-sig" the
default for them either.  From that point of view, there is no
reason for them to know about the "--no-show-signature" option.

The only reason why teaching the "--no-show-signature" option to
these commands is a good idea is because it would help people who
create an alias with "--show-sig" in early part of the command line,
e.g.

	[alias] fp = format-patch --show-signature

by allowing them to countermand with --no-show-signature, i.e.

	$ git fp --no-show-signature ...

If we are updating the log message in the final submission of this
patch, we'd want it to be clear that the presence of this option is
not an excuse to introduce .showsignature that affects rev-list
later to make sure we do not have to waste our time rejecting such a
patch in the future.
