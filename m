From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2
Date: Wed, 07 May 2014 14:45:01 -0700
Message-ID: <xmqqeh056z6q.fsf@gitster.dls.corp.google.com>
References: <536A8FF8.7080909@fabiodalfonso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: fabio.dalfonso@fabiodalfonso.com
X-From: git-owner@vger.kernel.org Wed May 07 23:45:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi9eL-00033B-8g
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 23:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbaEGVpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 17:45:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55013 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbaEGVpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 17:45:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE1CE165C8;
	Wed,  7 May 2014 17:45:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fqTZS8z7PKy0aVbUJeA+hYpUCA8=; b=aMnrPI
	gL6skYTb6DHJWLMNfSnavkAM52lqX/+k5451LB6Rhe7VgWbQVDcbwL0tIIv0dV9T
	vRm+KOZgig59VxN7oMgeftXKWIu9tOq9vsIz95tQ92JgaMc16smqaHz20blxdvnv
	HnAloYuxB7Y/iIPd+5sCeCCWkW+PkK4ZRPXEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pj1RfQ93C/sOpB6bkNwHKdUQS8wur5rr
	mgzLOG+/YIVtiSxjPRIndz/w0fz3ot7FNWQ7zMnUpeVlDhc3PslOFc7f1iXSeAVR
	CPxzU4qcE4OQ2tf+NB+GVcBFa1LIhLudbs+/JSh7uKuXaGV6wbD7AR98BvJwo/WK
	hesBqc9hy+8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A12BB165C7;
	Wed,  7 May 2014 17:45:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BBD2165C3;
	Wed,  7 May 2014 17:45:03 -0400 (EDT)
In-Reply-To: <536A8FF8.7080909@fabiodalfonso.com> (Fabio D'Alfonso's message
	of "Wed, 07 May 2014 21:56:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D8995574-D630-11E3-93BB-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248381>

Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com> writes:

> Hi,
> I am getting this in Ubuntu, something wrong with my env?
> Thanks
>
> root@HDUBVM01:~/builds/git/t# ./t5539-fetch-http-shallow.sh
> ok 1 - setup shallow clone
> not ok 2 - clone http repository
> #
> #        git clone --bare --no-local shallow
> "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> #        git clone $HTTPD_URL/smart/repo.git clone &&
> #        (
> #        cd clone &&
> #        git fsck &&
> #        git log --format=%s origin/master >actual &&
> #        cat <<EOF >expect &&
> #    7
> #    6
> #    5
> #    4
> #    3
> #    EOF
> #        test_cmp expect actual
> #        )

Does not reproduce for me but I am on Ubuntu 12.04.2 LTS, so...

Running it with the -v option might give you more hints, and
running it as

    $ sh -x ./t5539-fe* -v

might give you more to chew.

I do not think it is wise to run tests as root, though ;-)


> #
> not ok 3 - no shallow lines after receiving ACK ready
> #
> #        (
> #            cd shallow &&
> #            for i in $(test_seq 15)
> #            do
> #                git checkout --orphan unrelated$i &&
> #                test_commit unrelated$i &&
> #                git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
> #                    refs/heads/unrelated$i:refs/heads/unrelated$i &&
> #                git push -q ../clone/.git \
> #                    refs/heads/unrelated$i:refs/heads/unrelated$i ||
> #                exit 1
> #            done &&
> #            git checkout master &&
> #            test_commit new &&
> #            git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
> #        ) &&
> #        (
> #            cd clone &&
> #            git checkout --orphan newnew &&
> #            test_commit new-too &&
> #            GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git fetch
> --depth=2 &&
> #            grep "fetch-pack< ACK .* ready" ../trace &&
> #            ! grep "fetch-pack> done" ../trace
> #        )
> #
> httpd (pid 10653?) not running
> # failed 2 among 3 test(s)
> 1..3
