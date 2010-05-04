From: Junio C Hamano <gitster@pobox.com>
Subject: Re: update-index --really-refresh unsets assume-unchanged bit
Date: Tue, 04 May 2010 15:45:20 -0700
Message-ID: <7v39y7mglb.fsf@alter.siamese.dyndns.org>
References: <20100501092512.GA15941@localhost>
 <20100501092720.GB15941@localhost> <20100504085722.GA32217@localhost>
 <z2h32541b131005040941m79724daq4cd8b0c427bb218a@mail.gmail.com>
 <20100504194136.GA19300@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed May 05 00:45:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Qry-0003B8-HC
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 00:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934448Ab0EDWpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 18:45:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934370Ab0EDWpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 18:45:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34F28B0B69;
	Tue,  4 May 2010 18:45:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u6Xxl9g+WfbwjWz9hqJUsioZ+F0=; b=bWvCLC
	6iEYyp95h/kFMjVO32IEdntbRxbVE+II+slT9cu8/23lZ4pcP2hf6dHFco7kCB/t
	9WTVtFSefYCWFkd0ihChH5Pl60PM0VXtp1rPyxums6acjcv7DVysFb7Q5sVbWw0G
	F1UOisoFw0NAilnVXrz+aXr1EQSWJYk2TArz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xLnmvPkInaFVCc6Yan/jH3RoFb6xNuq5
	fY1aK1GEheKXw9JOoM5bq6jW9tsfW4sNhltccfK1WzWA4eZSTe54mC/9d8uja+UN
	jMuvqu4XPXLE//bJS6IhcGSvG96Rmnt3EFIUgRzeVx9nrMBad/QsYA5lBUTFqFyy
	/iWBYzbSaZU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04062B0B68;
	Tue,  4 May 2010 18:45:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5130DB0B64; Tue,  4 May
 2010 18:45:22 -0400 (EDT)
In-Reply-To: <20100504194136.GA19300@localhost> (Clemens Buchacher's message
 of "Tue\, 4 May 2010 21\:41\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BB30EDA6-57CE-11DF-95A4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146353>

Clemens Buchacher <drizzd@aon.at> writes:

> On the contrary. I _want_ git to assume the file is unchanged, even though I
> know it changed. This is an intended and documented use case (from the
> git-update-index manpage):

The intended use of *really* one is to ignore the assume unchanged bit and
make the bit reflect reality.  The bit was originally invented back when
the machinery was too lstat(2) heavy so that people on slow filesystems
can say "I haven't changed these paths, and I promise I won't, so you can
trust this and assume that the working tree file exactly matches what is
recorded in the index."  Obviously we needed to give such users an way to
tell git that they broke their promise, and that is what *really* refresh
meant to give.

Note that the promise is _different_ from telling "I may or may not have
changed the work tree files, but don't bother telling me that I did".  The
promise you make by "assume unchanged" bit allows git to read from the
working tree file when it needs the contents of blob recorded in the index
and the bit is set, as you promised that you will never change it.
