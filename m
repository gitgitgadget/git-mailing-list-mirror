From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Configuring git to for forget removed files
Date: Sat, 20 Feb 2010 11:16:01 -0800
Message-ID: <7v8wann2fi.fsf@alter.siamese.dyndns.org>
References: <4B7FBB73.70004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Benton <b3nton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 21:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiuoL-00070L-KO
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 20:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab0BTTQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 14:16:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab0BTTQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 14:16:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFA7D9B949;
	Sat, 20 Feb 2010 14:16:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DD3C097C7vSEwyAcpg40Orb0MAI=; b=WtiXst
	FHdpuAwxWHd5qymUdWH2Ojl2qP3FVP4B8P7nIpLdQpiz8/6kJ8JmVhW3MIGFlW6U
	TVDujuOHw57cJ6ufUBS95d9NFQiaPTs+TSLw4/qRrKxnVYkgU83HTL51rpqCJnom
	q4Xw2Uq1QCxfbd9SUhKLL6X2fbP+OIe+YRSNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ERp23GLY//JueiGjkgB1E/XEiUJoPdsf
	dQe61yBsm14PNiHoG8Nwhp4bqZl8nunjiOTkE1loNaA4jUfBDQGNNQFHMeGeIfxV
	KJdZcbwNqSLJVcJe35cP3/P3d02uDgyM0PGrJwP31bJYJyzRQhFpFhEIEE37lew8
	c1UIVA5X1QA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC51F9B948;
	Sat, 20 Feb 2010 14:16:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1B6F9B947; Sat, 20 Feb
 2010 14:16:03 -0500 (EST)
In-Reply-To: <4B7FBB73.70004@gmail.com> (Andrew Benton's message of "Sat\, 20
 Feb 2010 10\:37\:39 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 652473FA-1E54-11DF-B790-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140551>

Andrew Benton <b3nton@gmail.com> writes:

> I have a project that I store in a git repository. It's a bunch of source tarballs and
> some bash scripts to compile it all. Git makes it easy to distribute any changes I make
> across the computers I run. The problem I have is that over time the repository gets ever
> larger. When I update to a newer version of something I git rm the old tarball but git
> still keeps a copy and the folder grows ever larger. At the moment the only solution I
> have is to periodically rm -rf .git and start again. This works but is less than ideal
> because I lose all the history for my build scripts.
> What I would like is to be able to tell git to not keep a copy of anything that has been
> git rm. The build scripts never get removed, only altered so their history would be
> preserved. Is it possible to make git delete its backup copies of removed files?

You are either being unreasonable, or haven't thought things through.

Let's say you have your build script with a tarball of frotz-1.42.tar.gz
in the initial revision.  The script extracts from tarball and builds.

Now you update your build script once, and make a commit.

Then you add frotz-1.43.tar.gz and remove frotz-1.42.tar.gz.  You may
adjust the build script to extract frotz-1.43 instead of frotz-1.42 in the
same commit, or your script may be written loosely and extract any tarball
that matches frotz-*.tar.gz wildcard in which case the build script may
not change.

You now have three commits:

 - initial one: ships frotz-1.42 and builds it;
 - second one: ships frotz-1.42 and builds it better;
 - third one: ships frotz-1.43 and builds it in some way.

You clone it to some other machine and build the tip; everything goes well
and you are happy.  What should happen if you do:

 $ git checkout HEAD^
 $ make

Should it build frotz-1.43, or should it fail?

If you somehow obliterate frotz-1.42.tar.gz out of the history with some
magic you described, there should not be any frotz-1.42.tar.gz in the
history, so there is no way you can build frotz-1.42 out of this checkout.
Your "second" tree can only have one or two shapes:

 - It can record only build script and nothing else, in which case the
   above "make" will have to fail.

 - With some magic you described, it records your build script and
   frotz-1.43.tar.gz, and frotz-1.43 is built.

You need to realize that the magic have to adjust your build script so
that it does not require the exact version of frotz-1.42.  Namely, the
build script you wrote not only knew that the next version of tarball will
match frotz-*.tar.gz (and that is why you can extract the contents from
it), but also somehow anticipated the build infrastructure change the
upstream will make when they update from 1.42 to 1.43 and was magically
capable of building either versions.  And you did that back when you
didn't have the source to frotz-1.43 and how it would look like.

You also need to realize that nowhere in your set-up up to the point you
made three commits, you never told anybody that frotz-1.43.tar.gz replaces
frotz-1.42.tar.gz. The only thing you said was to remove frotz-1.42.tar.gz.

If you make the checkout of second one to fail to build because your
"obliterate" is not to include any tarball in the second version, then you
are being unreasonable.

If you are asking for the magic to include frotz-1.43 instead of
frotz-1.42, and further adjust your old build script to anticipate
the change between 1.42 and 1.43, you haven't described how that magic
should happen, so you haven't thought things through.

One way out would be to do it like this instead:

 - initial one: your build script, and frotz-1.42 extracted in frotz/
   directory already.  Do not ship a tarball.

 - second one: your improved build script, and the same frotz/ directory
   without any change.

 - third one: your build script, either improved or the same from the
   previous one, and frotz-1.43 extracted in frotz/ directory.

This way, the checkout from the second one will build frotz-1.42.  Also
you could see if your build scripts from the second version would build
frotz-1.43 as well by doing something like:

    $ git checkout HEAD^
    $ git checkout master -- frotz/
    $ make

You will ship both versions of frotz, but between 1.42 and 1.43 there will
be a lot of similarities, so packed result will be far smaller than
storing two compressed tarballs.  In fact, I wouldn't be surprised if it
were smaller than storing one compressed tarball.
