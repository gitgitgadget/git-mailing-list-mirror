From: Junio C Hamano <gitster@pobox.com>
Subject: Re: smudge/clean filters and SHA1 hashes
Date: Fri, 02 May 2014 15:02:10 -0700
Message-ID: <xmqqeh0balgd.fsf@gitster.dls.corp.google.com>
References: <CADsUFkQLtUDpoiSqj-UYeyz1a-WZPh9vN+RW4ti8ut=22QwL4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Sat May 03 00:02:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLX9-0004St-5u
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbaEBWCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:02:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53860 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbaEBWCP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 18:02:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 684AF12EB5;
	Fri,  2 May 2014 18:02:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i2VWFoVFVPQHWki8Xm7Azge1M38=; b=G2VAj8
	e3Ar4VsjZI4hGk+bjUnjjSZaA1/IFBsIC5bmyldrmWN+nn4qIgYurB7hpqygxdPg
	rw6aSdiRAqz/na1QZYUq+Y3+SDmBRYPXi+B3m7WiCXyIgGf2wNPq6QoZDpHLAVLk
	3H1xeQxjZJJFctBcyTdLHd1FmBMQLhIPGDhbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O3Kf8A2GCp+7gGEGq8rCysJ79Vnm2y6u
	QVohBMYDpsR99X9xncc1HkeUoQihX8XT3tsW+dwMbDsxrzYXxwwtcxQ2pxCI7bBm
	fFUdlaDBW2NkbvadvoBUr3DK/KHD+w/Xr8FNSEqc9MxZPMgvEB6jImFpmzu/KfCN
	kpUf9t0A+Cw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E65B12EB4;
	Fri,  2 May 2014 18:02:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2283912EAB;
	Fri,  2 May 2014 18:02:12 -0400 (EDT)
In-Reply-To: <CADsUFkQLtUDpoiSqj-UYeyz1a-WZPh9vN+RW4ti8ut=22QwL4g@mail.gmail.com>
	(Leo Razoumov's message of "Fri, 2 May 2014 17:05:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 69D72F2E-D245-11E3-911B-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247989>

Leo Razoumov <slonik.az@gmail.com> writes:

> In presence of smudge/clean filters which SHA1 hash
> (clean content or smudged content) gets stored in the repository?

You are cleaning cruft in the contents before the contents are
hashed to compute the object name.  The point is to keep clean
objects in the object database, protected from dirty reality in the
working tree (which you instanciate by applying the smudge filter to
dirty the clean object in the ideal world).

The crlf conversion works exactly the same way. For portability, you
keep a version terminated with LF in the object database and that is
what is hashed to compute the blob object name, but we export with
CRLF line endings for a working tree that wants files whose lines
are terminated that way.
