From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] combine-diff: respect textconv attributes
Date: Mon, 23 May 2011 15:47:40 -0700
Message-ID: <7vwrhht4oj.fsf@alter.siamese.dyndns.org>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523203105.GE6298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 00:48:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOdup-0002MC-8G
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 00:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757647Ab1EWWrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 18:47:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757629Ab1EWWrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 18:47:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 65ED04915;
	Mon, 23 May 2011 18:49:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x53/Dsz8CMM0v+t2YcOqQCTsoLM=; b=DHYE6q
	Y6MRO54wOIYZDZl5VDHP/ZGKCTg4wn6rfOAoqQb4L7YdEEwYwswLi3nHKmT6vWk9
	bJTN9WW2kiMaEGnOmtKw96z2CE0267Kmb7B2IoZDLwezWBOrhiB2j1CEuaFZYCH/
	DcOycW9Bc6CB1hlewEjtjdx0CL59pa9gz9dZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YvmbujtOrZLfClZfQS9YWbPIEfQRh7Qa
	xa+hC6rLY4Ou2Z81wXFioqqSjJ1nTH3ICLCLJMvLYaFyRmsaTs9RVrrlvV0vAwyg
	ce/tDMCGTYqMYWGBXa/sBDcodvxACWxkx5UUGr6EmmPlaJ/hZF5VP4HshP4QTCHB
	aheddfokqkk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E345490B;
	Mon, 23 May 2011 18:49:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB5E8490A; Mon, 23 May 2011
 18:49:49 -0400 (EDT)
In-Reply-To: <20110523203105.GE6298@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 May 2011 16:31:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA26FF70-858E-11E0-A41F-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174284>

Jeff King <peff@peff.net> writes:

> +	} else if (textconv) {
> +		/* yuck, the textconv code is linked heavily with
> +		 * filespecs */
> +		struct diff_filespec *df = alloc_filespec("");
> +		fill_filespec(df, sha1, mode);
> +		*size = fill_textconv(textconv, df, &blob);

I thought your 4/5 talked something about not requiring filespec for
textconv handling...?  Is it still yuck?
