From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [SIGNED-OFF] remotes-hg: bugfix for fetching non local remotes
Date: Wed, 24 Jul 2013 08:20:47 -0700
Message-ID: <7v7ggg6l2o.fsf@alter.siamese.dyndns.org>
References: <1374615616-4730-1-git-send-email-dev@joernhees.de>
	<CALWbr2zRsCk1N5xUUDQeWX6CbvLHYWnxiYpea+etoWvXHNhPEA@mail.gmail.com>
	<F0461ED2-7B5F-4657-B0D4-3CBBE15FDD48@joernhees.de>
	<CALWbr2wDqo29kRJ2eHsozRCN_fT3tumYz23pQa5P-9dm27OL6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?J=C3=B6rn?= Hees <dev@joernhees.de>,
	git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 17:20:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V20s3-0005nS-AC
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 17:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab3GXPUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 11:20:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35729 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031Ab3GXPUu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 11:20:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5497310CD;
	Wed, 24 Jul 2013 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7zt4WKICcdNv
	E/neAldWVhwhg/k=; b=EH7nVW2ZacdGoDUWRJk8l20caQbX0kh4GVG2AOCND2ZH
	0PITAaEGaNewnVgvH6qkiAMhlnHR3saxnGPP88I3xqhYhS1+RKoBTMnSWj4H39MT
	H7H+k+tae6Xh6sNgNsyBUBnjx2GmfYcAsZBuA4GEncKVwPz6roD2yglKZG21zIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AGc9Ku
	xnOK74CI+JJ/nAg4PP+QkyaY1CaBdkJkA48BnzxtsKsCEogobRSMHmTXhRgjjQYp
	NB2nEux8Qs3EgpmR4OOmjevIa+nyE4/ZcvMIB2gK1+qAZyiUv95knSK5PSMde9Pq
	PGflGCnxNXToGLmTLSq8r2nnHMtr++YA0/OfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4B95310CC;
	Wed, 24 Jul 2013 15:20:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C646B310CB;
	Wed, 24 Jul 2013 15:20:48 +0000 (UTC)
In-Reply-To: <CALWbr2wDqo29kRJ2eHsozRCN_fT3tumYz23pQa5P-9dm27OL6A@mail.gmail.com>
	(Antoine Pelisse's message of "Wed, 24 Jul 2013 15:14:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E92D4A2-F474-11E2-836D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231103>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Wed, Jul 24, 2013 at 11:59 AM, J=C3=B6rn Hees <dev@joernhees.de> w=
rote:
>> On 24.07.2013, at 10:52, Antoine Pelisse <apelisse@gmail.com> wrote:
>>> I think the best way would be to create the shared repository in
>>> .git/hg/$share, with $share being a path that can't be a remote nam=
e
>>> (so that it doesn't conflict with remote directories),
>>
>> Maybe ".git/hg/.share"?
>
> According to Documentation/git-check-ref-format.txt, I'm not sure if
> we should start with a dot, or end with it.

What are in these directories under .git/hg?  Surely they cannot be
refs in Git's sense, as that hierarchy is not known to anything and
will not be protected from "git gc".

Puzzled...

	Goes and looks...

OK, the tracking branches for these are created under refs/hg/*
using the same name.

A refname shouldn't begin or end with a dot, because the range

	master...share

will become ambiguous if you allowed ".share" as a refname
shorthand.  It could mean either one of these:

	master..refs/heads/.share
        master...refs/heads/share

The same for the trailing dot "share."; the range "share...master"
becomes ambiguous.
