From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Setting file timestamps to commit time (git-checkout)
Date: Mon, 09 Dec 2013 12:35:38 -0800
Message-ID: <xmqqsiu1yd7p.fsf@gitster.dls.corp.google.com>
References: <20131209112528.GA5309@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: vogt@linux.vnet.ibm.com
X-From: git-owner@vger.kernel.org Mon Dec 09 21:35:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7YR-0004s5-Ta
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537Ab3LIUfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:35:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932216Ab3LIUfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:35:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1AB6599E5;
	Mon,  9 Dec 2013 15:35:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K+kWhhyOsrdARh0MGTD7uLZWGI8=; b=fX9z4n
	Wc6QoX54K6xqSwNBKupQfc8WMoX1CN/z7By/Ebp1SN7vsfaBp6fUZen8iGSEskOz
	Gqy4IwPzsLf1m+lEFvKw2ltMwTY7fh9lABRFYnUwq2l9TLU1JfMzPn0saVEL/Xy9
	NZj2XB3RtzQMfP5V0gDG4dCOgPOqY5gTInbaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cf62Y87pYEZW+mFWvFdbvMxxPlFQ0mEA
	DZv7dNEM2nLtTO+GkciANvfpJ7nZa6uNawxqqrOPVUIR/FUI/51SCsTlHSpT06CO
	rY4jrZ2eaz9A6f9M/wqdgkf7qrbJVujqbPt61jqnjswdpQQ/hGXOoIAkigbJOj/I
	PiyADHlBDfI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEFED599E4;
	Mon,  9 Dec 2013 15:35:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1DEF599E2;
	Mon,  9 Dec 2013 15:35:41 -0500 (EST)
In-Reply-To: <20131209112528.GA5309@linux.vnet.ibm.com> (Dominik Vogt's
	message of "Mon, 9 Dec 2013 12:25:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 78C882BC-6111-11E3-8ACD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239089>

Dominik Vogt <vogt@linux.vnet.ibm.com> writes:

> Me and some colleagues work on gcc in lots of different branches.
> For each branch there is a separate build directory for each
> branch, e.g. build-a, build-b and build-c.  Let's assume that all
> branches are identical at the moment.  If a file in branch a is
> changed that triggers a complete rebuild of gcc (e.g.
> <target>.opt), rebuilding in build-a takes about an hour.  Now,
>  when I switch to one of the other branches, said file is not
> identical anymore and stamped with the _current_ time during
> checkout.  Although branch b and c have not changed at all, they
> will now be rebuilt completely because the timestamp on that files
> has changed.

I am not quite sure I follow your set-up.  Do you have three working
trees connected to a repository (via contrib/workdir/git-new-workdir
perhaps), each having a checkout of its own branch?  And in one
working directory that has build-a checked out, a new commit touches
one file, <target>.opt, to make a new commit:

Before:

    ---o---o---X
               ^ refs/heads/build-a
                 refs/heads/build-b
                 refs/heads/build-c

After:
                   v refs/heads/build-a
    ---o---o---X---Y
               ^ refs/heads/build-b
                 refs/heads/build-c

Because you said that branch b and c hasn't changed at all, I do not
see how your build-b and/or build-c directories become dirty.
