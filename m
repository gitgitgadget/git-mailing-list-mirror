From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix archive format with -- on the command line
Date: Thu, 10 Dec 2009 15:31:40 -0800
Message-ID: <7vd42m8kyr.fsf@alter.siamese.dyndns.org>
References: <20091210212636.GA27722@Knoppix>
 <7v1vj2a3ik.fsf@alter.siamese.dyndns.org>
 <20091210222258.GQ4114@genesis.frugalware.org>
 <7vws0u8n99.fsf@alter.siamese.dyndns.org>
 <7vhbry8l54.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIsUI-00009V-0b
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761652AbZLJXbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 18:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761636AbZLJXbq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:31:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023AbZLJXbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 18:31:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09996A55E7;
	Thu, 10 Dec 2009 18:31:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sXbZ9Er2oPhkdUQ4Eq/OfbTSqaA=; b=FmL1YT
	LxQb/iRxFjtOsloCwYLrSSjKiOeP0n871aLOKEAH1qbXVRu83D05ih02hjM6dv89
	RVcAjWSAfoXPA6EZ9LpWWPiw9QbsFu3ojYZWnYlkeMURl5PdECUl6Dh3/t6YoltX
	7EElTQ0CZgfWtfleCqodeavHxqabotAu+6dL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=INzTc2h3PoOLnIeIalkBGCdPqGG1J9um
	kSJwnKbJl7oVpxJRRiJNJpYsW9mbz/PA84m5LXAxHU9jpqlvYmlEKxAHLhxBll/c
	ptRI9X/kTYgCr2gOUNZYIOzrFmoh5T2q6BuABy5Bo8CrEHENveLSGzav1Q59YOXP
	e6AfzZmrcJ4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C0E22A55E5;
	Thu, 10 Dec 2009 18:31:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EE420A55E4; Thu, 10 Dec 2009
 18:31:41 -0500 (EST)
In-Reply-To: <7vhbry8l54.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 10 Dec 2009 15\:27\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F59B3FA-E5E4-11DE-9600-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135050>

Junio C Hamano <gitster@pobox.com> writes:

> Giving --format from the command line, or using output file extention to
> DWIM the output format, with a pathspec that is disambiguated with an
> explicit double-dash on the command line, e.g.
>
>     git archive -o file --format=zip HEAD -- path
>     git archive -o file.zip HEAD -- path
>
> didn't work correctly.
>
> This was because the code reordered (when one was given) or added (when
> the former was inferred) a --format argument at the end, effectively
> making it to "archive HEAD -- path --format=zip", i.e. an extra pathspec
> that is unlikely to match anything.

A side note to this issue is that

    $ git add non-existing-path

complains but

    $ git archive HEAD non-existing-path

doesn't.  Is this something we should consider a bug, or a feature?
