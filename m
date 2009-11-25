From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 12:52:11 -0800
Message-ID: <7viqcytjic.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:52:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDOqf-0006Gl-G3
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 21:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935038AbZKYUwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 15:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759326AbZKYUwN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 15:52:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbZKYUwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 15:52:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E84ECA1770;
	Wed, 25 Nov 2009 15:52:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O4nY1ekwQtmYa1hy2I0Hof9dbds=; b=cyo+VT
	Yg6PZSebRQjz8F50DUQauwzwHWPyijqf3ooP4ixC5NmyG0R9+vJ/scw04oqMAMz/
	lJAeNPrDYYNG6Bv4TlplGE7vX61MgnJP+8D0RulRyxfrQ5d91yZy/hDJ0KGAyGtQ
	/PsL3ob8Dupknh7NlTCGkpWycKPFIU/N4ShTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mth8yvuAbHVDmOXbSzK9v366OiqFjLQf
	+0LGTRuQBgNfsx6MlvYNM8K/Xe6tHjI6FeGKVxYS4Ojs9ORPfVsCLitk+Fdhef20
	GafFvIhgR0GxTyjxKZhxfy/aZE+lOuQtUID4mGfLhc5ya3nsqrV3JGwGjTNUylpH
	1PkijDt0CxE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C79B4A176F;
	Wed, 25 Nov 2009 15:52:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C29C2A176E; Wed, 25 Nov 2009
 15:52:12 -0500 (EST)
In-Reply-To: <20091125203922.GA18487@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 25 Nov 2009 15\:39\:23 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69D1667C-DA04-11DE-9383-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133671>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 24, 2009 at 12:56:32AM -0800, Junio C Hamano wrote:
>
>>  * In http://article.gmane.org/gmane.comp.version-control.git/111717, I
>>    once argued in the opposite way, but I think it is Ok to aim for making
>>    the default --full-tree in the longer run (cf. $gmane/127885).  This is
>>    the first step in that direction.
>
> Ironically, I argued for --full-tree behavior in the same thread, but
> have since softened my view. What I have come to realize is that (for
> me, anyway) it is very dependent on the organization of the project you
> are working on.

I was against --full-tree but wished for it when I dipped my toe into
somebody else's project and my itch lived in a directory a few levels
deep, while the infrastructure the files in the directory uses were spread
across global include directory and platform implementations [*1*].

And I agree that the preferred behaviour depends largely on both the
project and what kind of change you are currently scratching.

So I think the posted patch alone without changing anything else would be
the approach to give the most benefit with the least impact to existing
users, at least for now.

>   2. It would be useful to have a "partial-tree" middle ground. In other
>      words, if I am in "linux/subproject/t", I would find it most
>      useful if "git grep" searched all of "linux/subproject".

"git grep -e frotz .." will work in your "from linux/subproject/t look for
everywhere in linux/subproject", but if "/t" part were much longer and
variable (iow you need to chdir around inside linux/subproject to scratch
your itch) compared to "linux/subproject" part that is much shorter and
static (to your work), it may make sense to give us a mode to specify
pathspec from the top of the tree.

    $ cd linux/subproject
    $ cd foo
    $ cd bar
    $ cd baz
    $ git grep --absolute-pathspec -e frotz -- linux/subproject

As "git grep" never takes absolute paths, we _might_ be able to also do

    $ git grep -e frotz -- /linux/subproject

to achieve the same.


[Footnote]

*1* It's rockbox, if you need to know.
