From: Junio C Hamano <gitster@pobox.com>
Subject: Re: clean bug on ignored subdirectories with no tracked files?
Date: Sat, 19 Nov 2011 11:23:20 -0800
Message-ID: <7vy5vbj4rb.fsf@alter.siamese.dyndns.org>
References: <CAG+J_Dxw00e_cr7i3R9DAbTrqZvJHYk2yeUa=xGKh+Zqqmp-SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 20:23:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRqVd-0004wU-0z
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 20:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402Ab1KSTXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 14:23:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab1KSTXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 14:23:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6F374B74;
	Sat, 19 Nov 2011 14:23:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xDTOxyOQqKhAwg9S4OdMjQGdoUg=; b=fGeor/
	II1zW8G9p5rEooUpYZpz2f+pRxwylrxEzQptez92LpBT+fPgBv8FAtobepvqlBEd
	8RvyGWFA47J+0YNq52sMLWjfq3eNlp+mZA/vAOBJrXt3tJzLA0TIDa6DFJcgsh37
	FxXdx++JR2vSzwdp64D4ryQjR3GRr3rPz+XiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VNblVicz4awe2CRJpG2ogyyZ4pcTcHK4
	5G17viwFdZIXkMlO5O24JYhWEWBMe7uzxf5Is6rOwWgPjUtN+aisn29ceYLPwLj/
	VgYGYEcA4chyy8Zh07meJzqghCryauMgke195py5ZsoSu8/7WCjpvOneFhewIubN
	RpA7+Qr792k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEC314B73;
	Sat, 19 Nov 2011 14:23:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52AE94B72; Sat, 19 Nov 2011
 14:23:22 -0500 (EST)
In-Reply-To: <CAG+J_Dxw00e_cr7i3R9DAbTrqZvJHYk2yeUa=xGKh+Zqqmp-SA@mail.gmail.com> (Jay
 Soffian's message of "Sat, 19 Nov 2011 00:38:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1EC3DA6-12E3-11E1-A350-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185698>

Jay Soffian <jaysoffian@gmail.com> writes:

> git init test_repo &&
> cd test_repo &&
> mkdir -p foo/bar &&
> echo baz > foo/bar/baz &&
> echo /foo/bar > .gitignore &&
> git add .gitignore &&
> git clean -n -d
>
> Initialized empty Git repository in .../test_repo/.git/
> Would remove foo/
>
> Seems surprising.

You said "everythingthing in foo/bar is uninteresting and can be cleaned",
you have one untracked file in "foo/bar" hierarchy, and you have nothing
else in "foo/" hierarchy.

Removing the uninteresting cruft as your .gitignore instructs Git makes
the entire "foo/" hierarchy devoid of any contents. I would *expect* Git
to clean "foo" in this case.

I've seen some "surprising" behaviour in "git clean" (which I do not use
myself, I do not consider part of "my code", and I am not surprised if it
has many bugs), but I fail to see what is surprising in your transcript.

It would be a different issue if you had ">foo/other" before your "clean".
Then "foo/" has "foo/clean" that is not declared to be uninteresting.
