From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git clone fails during pre-commit hook due to GIT_WORK_TREE=. (regression 2.5 -> 2.6)
Date: Mon, 30 Nov 2015 12:16:32 -0800
Message-ID: <xmqqwpsz6y5b.fsf@gitster.mtv.corp.google.com>
References: <CA+dzEB=2LJXiLSTqyLw8AeHNwdQicwvEiMg=hVEX0-_s1bySpA@mail.gmail.com>
	<CA+dzEB=XiGVFg+AhuJM-jUCPmgZKCJHTp3sinrFt8yzXeC_63Q@mail.gmail.com>
	<CAGZ79kY=t9SeoXjgeJjfCMD2=6g3JJxDxcnY6JeJCpUqaN+eOA@mail.gmail.com>
	<CACsJy8C7xoV9faGpbn_5XGt-CmCj--fgXaCFR-ngs=-pWUnrCA@mail.gmail.com>
	<CACsJy8Ciuirgk9D_fbQ5pgo-8u1AnM+zBdKUHcz_HLfRqM9QxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Anthony Sottile <asottile@umich.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 21:16:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3UsJ-0005st-Ve
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 21:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbbK3UQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 15:16:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751771AbbK3UQf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 15:16:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 724432CB26;
	Mon, 30 Nov 2015 15:16:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tUrNxNDdMc2E9AL3Z08S81NjvyU=; b=G+TpOS
	VYA6Ig3looGFk2f1goMAgAk36/7rXo5tJrpvW3PgU2u40OdvtDzVTAILWC5V1JU/
	bDJzRgMQcqhK5ho0fN/w0KSKYg+7lUEZ7Oq4xxMrTY8R52BlNoaTsXHkIk3u7JCe
	9kQ9tAng1U2qRkXFbhmBUA3ds58ONvq81qBHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ePDz1ed/y0UqR5oDjSshqedbh6StEFcj
	zSRePbA2nZYw3aX4EUhmhsmZQen59jAwgYW8Y7KLGxP4GH0E/BiSkNui4aJnP84j
	sbVLZBU0+pIO9Ymc1kNY7V+NilwuJKOlGjsa/X3g16PIH/qNXt2lGSxXD/eLvt+5
	f89jcqH5qzg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6A7E12CB25;
	Mon, 30 Nov 2015 15:16:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E3F442CB24;
	Mon, 30 Nov 2015 15:16:33 -0500 (EST)
In-Reply-To: <CACsJy8Ciuirgk9D_fbQ5pgo-8u1AnM+zBdKUHcz_HLfRqM9QxQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 30 Nov 2015 20:01:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4053D08C-979F-11E5-8447-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281820>

Duy Nguyen <pclouds@gmail.com> writes:

> I was wrong, GIT_WORK_TREE support was added in git-clone many years
> ago in 20ccef4 (make git-clone GIT_WORK_TREE aware - 2007-07-06). So
> my change accidentally triggers an (undocumented) feature. We could
> add a hack to ignore GIT_WORK_TREE if GIT_DIR is set too, but I don't
> think people will like it. I don't really like reverting d95138e
> (setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR -
> 2015-06-26) because another bug reappears.

> So I'm out of options..

Perhaps d95138e can be reverted and then the bug it tried to fix can
be fixed in a different way somehow?

(I am not quite up to speed yet, so the above may turn out to be
infeasible--take it with a large grain of salt please).
