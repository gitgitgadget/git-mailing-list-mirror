From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for
 prompting passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Tue, 03 Jan 2012 16:10:49 -0800
Message-ID: <7v39bws4xi.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de>
 <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com>
 <7vboqks8la.fsf@alter.siamese.dyndns.org> <4F038EC8.505@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Wed Jan 04 01:11:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiERV-0002cO-2D
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 01:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab2ADAKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 19:10:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697Ab2ADAKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 19:10:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5319771F1;
	Tue,  3 Jan 2012 19:10:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QCiaVOMgLk3CvfqlirwHQavNKeA=; b=ef90nP
	xO7AVdM5hU5F6nJNVpOCHloE32rH7bpH87P/aculbP7pYr5KYmfbQqZdK47LXzgD
	/czCvesqKO79qtAImpuxtuvGKTZWRzV6AFAz3+GvGulMm4YOD9vlAMnJ4MdYHYkP
	JIPYLWkb6jzL/baNZjAtrUW7qSOfFkDCYnt/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hcxT4SCIQIFp2u80QwAhr+HVUvN49s8o
	blsiOg/ruTj76RYjvBZbsO6Hiz37e/9Z5Cqv2fnel2WRgXJNuyCvVXE7DachKVf1
	OGau493WFSthdkpwp5jTgz2BVR7u+6rNfTfDhPclwj4yLb3LEsIxCkVy20YCFNhf
	L6UygV/uF9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A13971F0;
	Tue,  3 Jan 2012 19:10:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE5F271EF; Tue,  3 Jan 2012
 19:10:50 -0500 (EST)
In-Reply-To: <4F038EC8.505@tu-clausthal.de> (Sven Strickroth's message of
 "Wed, 04 Jan 2012 00:27:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F6C74F4-3668-11E1-9CCF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187907>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Am 03.01.2012 23:51 schrieb Junio C Hamano:
>> Sven, does it look agreeable? And more importantly, does it still work? ;-)
>
> Works for me :)
>
> I also updated my second patch minutes ago to fit onto the new patch
> (w/o the filename stuff).

Thanks.

For the second patch, I have a feeling that Peff's earlier suggestion to
give precedence to the terminal interaction over SSH_ASKPASS iff we can
open terminal, but I think the first one is OK for 1.7.9.

I'll queue both of them in 'pu' for now just in case others spot silly
mistakes I made while rewriting the first one, though.
