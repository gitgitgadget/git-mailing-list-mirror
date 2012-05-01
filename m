From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie grief
Date: Mon, 30 Apr 2012 18:32:01 -0700
Message-ID: <7vr4v4d6um.fsf@alter.siamese.dyndns.org>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Robertson <in-gitvger@baka.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Tue May 01 03:32:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP1wp-0003w5-CA
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 03:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab2EABcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 21:32:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab2EABcE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 21:32:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81BB07DF6;
	Mon, 30 Apr 2012 21:32:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=54gY9ZQ6hM6nuAj4cd9c9Gd4YWs=; b=f+e4T5
	jeEB9jod3/oy//bFRIIcNxZftQq/uUOgjeBO1NOwuKhNjJtBY2aTAxmVpl4K3mPv
	jJv/IdGKo1mX6w1NLNmSK+JB9kRfcDzKJ2emAh02xEopL4OlFwPbf17UjldR/7bv
	J17UXaeqiPNG0Kw5TB2nGiRjmd8s5lhSH5gs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mr/kSlvwJSDksGdq4Zz6CVx/i6cjjDdr
	efj1AOmAY3/Ui3d6qxivr9Nlfw5YO5xOLtmxszvF0/E15xMLkRV8ASlOfxse9WHq
	HhPJ2S1VwQW9XaqiL1l6xxM+56wqnxr3unTtE1lzTLflgpD/b7hcLdrBtCXztD0I
	/27GYcgKQcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70CF47DF5;
	Mon, 30 Apr 2012 21:32:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3D957DF4; Mon, 30 Apr 2012
 21:32:02 -0400 (EDT)
In-Reply-To: <4F9F3919.6060805@palm.com> (Rich Pixley's message of "Mon, 30
 Apr 2012 18:15:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 740A73B0-932D-11E1-A7DB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196642>

Rich Pixley <rich.pixley@palm.com> writes:

>> Git tracks your version of master separately from each other remote's
>> master.  This is exactly dual/multiple heads.
>
> No, it isn't at all.
>
> Multiple heads are the idea that a single commit can "branch" in the
> repository and that both commits can be HEADS of the same branch at
> once in a single repository.  This allows a potential collision to
> exist in the repository and to be pushed and pulled through multiple
> repositories.

I think your "not at all" thinking is a bit tainted by your knowing very
well how Hg does things, but I do not think there is much fundamental
difference between what we do.  Git just tends to be a bit more explicit
and encourages users to be also be more explicit.

When you integrate from the other side (say, "origin") by pulling, instead
of splitting the 'master' branch into two (i.e. ours and origin's), we
store what came from the origin in remotes/origin/master and let the user
merge it into his heads/master.  Essentially, the same name 'master' is
split into two, between remotes/origin/ and heads/ namespace.  We are just
more explicitly about the split.

Similarly, when pushing, you could follow the same model by pushing your
change into remotes/pixley/master, instead of pushing directly to the
"master" branch, i.e. heads/master, and then merge the former to the
latter after push succeeds.

Needless to say, you do not have to limit the splitting just to two.
Since everything is named, you can tell where each 'master' came from by
looking at the namespace (obviously this requires people to establish and
follow the naming convention).
