From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to use @{-1} with push?
Date: Fri, 25 Mar 2016 10:45:40 -0700
Message-ID: <xmqq8u164fjv.fsf@gitster.mtv.corp.google.com>
References: <CAHd499AM-OzqiB1hOF=0BTesFxrxNj=+jr1wH6vpQXfgoXd8Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:45:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajVnx-000299-LS
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbcCYRpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 13:45:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753321AbcCYRpo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:45:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B92A84ED0F;
	Fri, 25 Mar 2016 13:45:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OlR2+zcJh/EBzMS/yVQzCHYS7oE=; b=srbiU1
	abHqhI0IeRh0hLfRYklUDlwLeXuXwWPQ7ciWKRWy+csyqUSfx+1/LPKjeNbtK0Cy
	ph1p+Q94ZLjTbYaqvA1X+D8WIj5UdAbBI4iHnL3o5mxozlkzmOZgpVcsezRSiIp3
	QcxmK5xxX7pzGuU0ps4AWaGVc+aNE2ALR0z6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rZaw9agj6OpWgympJ+kyfqKOc+wuP7O3
	DTkZf79/BpFk5DJdYrFKqZY4IH7UzgJ1ewlEILoxBnYyGdtxVJY3PJuF+25qbKHx
	cOJOtIB+Y66EVU3wookQqFUoTnsGBBVAjCEqIwna6fv1DclBacmZV3Ln0jwKO/aI
	3KgVH1wC8gI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B17354ED0C;
	Fri, 25 Mar 2016 13:45:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3BDAC4ED02;
	Fri, 25 Mar 2016 13:45:42 -0400 (EDT)
In-Reply-To: <CAHd499AM-OzqiB1hOF=0BTesFxrxNj=+jr1wH6vpQXfgoXd8Ug@mail.gmail.com>
	(Robert Dailey's message of "Fri, 25 Mar 2016 09:40:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6504A074-F2B1-11E5-B61E-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289915>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> Both should refer to the last branch, but I know that these can't be
> used verbatim in a push command because it doesn't read it as a branch
> name normally like `git checkout` would.

You can ask rev-parse to give you --symbolic-full-name, error out if
it is empty (i.e. detached HEAD), and otherwise use the result, no?

    $ git checkout next
    $ git checkout master
    $ git rev-parse --symbolic-full-name @{-1}
    refs/heads/master
    $ git checkout HEAD^0
    $ git checkout master
    $ git rev-parse --symbolic-full-name @{-1}
    $ exit

And

    $ git push origin :refs/heads/master

would be the fully-spelled out way to remove that branch.
