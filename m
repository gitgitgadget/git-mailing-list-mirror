From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Mon, 07 Sep 2009 00:10:19 -0700
Message-ID: <7vocpn44dg.fsf@alter.siamese.dyndns.org>
References: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
 <0016e6470f36315b8a0472bc75a8@google.com>
 <20090904212956.f02b0c60.rctay89@gmail.com>
 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
 <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Tom Preston-Werner <tom@mojombo.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 09:10:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkYN4-0001R4-LT
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 09:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbZIGHK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 03:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbZIGHK3
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 03:10:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbZIGHK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 03:10:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8E0C28954;
	Mon,  7 Sep 2009 03:10:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=EtYHrJKWteXkAhVMvjmfpi5CJj4=; b=DDn+JEyrStEaHbSZGmFJwfp
	5wNO0FXGeKQJwKDTVMZr9YWQWM8w0GUp6AMPmvy5OcaUoApqGUPJtaOZSowox6+k
	FwgC3/zq2sdIcRnG0/QTQWr+TCPYzePyJH5HZRy4sS0OFmfvRXLuTrVKo/1yTngE
	xl08fIxXYqp/pVnH8mbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=l2Hgl9kTJGQhOHemuLY1TVAX1EBo07aitZP38JLYFSw2ev2N6
	P0efQ/KsT3iDVvAB+DgvNx0EYxOEWnApuN9C9UVzHiK62PolngKVk2s7pb1GM0Zs
	/tz8RJtEqjvblsG47PGN+IJ13ptOmiPt9end6ate/4Ko8Lgq21kEa2VG3A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83D5528953;
	Mon,  7 Sep 2009 03:10:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C6AA28952; Mon,  7 Sep
 2009 03:10:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84931FE8-9B7D-11DE-A6A7-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127892>

Tay Ray Chuan <rctay89@gmail.com> writes:

> We should only be interested in the MISSING_TARGET error, because it
> tells us that the pack file is indeed not available. We aren't
> interested in other errors, like being unable to perform the request
> (HTTP_START_FAILED), or, say, a 401 (Unauthorized) error, or even a
> 500; we simply move along and we tell the user we couldn't perform the
> check.

We couldn't perform the check, and then what happens?  We continue as if
everything is peachy, assuming that the *.idx file we thought we were
going to get describe what objects are in the corresponding pack, and barf
when we try to read the *.idx file that we failed to download even though
the server said we should be able to get it?

> You're right to say that git before 39dc52c would have failed. It did,
> but no one had the chance to break anything, because 39dc52c was part
> of my http patch series that only went wild in v1.6.4.
>
> We can trace this back to 48188c2 ("http-walker: verify remote
> packs"), which copied the "feature" from http-push.c to http-walker.c.

Ahh, v1.6.3 ships with fetch_index() that checks CURLE_OK and returns an
error(), but that is about .idx file, and it did not have the "do they
have the corresponding .pack file?" check introduced by 48188c2
(http-walker: verify remote packs, 2009-06-06), which is what makes the
server give us 500 error.  Before that check, we ignored a request to
fetch_index() if we already had one.

Why do we even call fetch_index() when we have one?  After all, we are
talking about "git clone" here, so it is not about "we failed once and the
previous attempt left .idx files we fetched".  Why

should we even have .idx file to begin with, that would have protected
v1.6.3 clients from getting this error?

Unless we are calling fetch_index() on the same .idx file twice from our
own stupidity, that is.

The same logic now is in fetch_pack_index(), which is called from
fetch_and_setup_pack_index().  I do not still see how we end up calling
the function for the same .idx file twice, though.

The repository in question http://github.com/tekkub/addontemplate.git/
return one liner file when asked for $URL/objects/info/packs.

Which means that it is not like that the loop in http_get_info_packs() is
calling the fetch_and_setup_pack() twice because the server lists the same
pack twice.  But if your patch matters, somebody is causing us to call the
function twice for the same .idx file, and I do not see where it is.

There definitely is something else going on.

Having said all that, after digging some more, I came to the conclusion
that I'd rather not see us proceed with bug hunting, based on the failures
we see with the current github repositories over http.  Read on for the
reasons.

The github's URL responds to request for $URL/HEAD and tells us that it
points at refs/heads/master, but requests for $URL/packed-refs and
$URL/refs/heads/master go to somewhere completely unrelated to the
request, without giving any failure indication.

In order to support fetch/clone over HTTP, a server at least must respond
to requests to the follwoing locations sensibly, meaning that it gives us
back the data without frills if they exist, and give us Not found if they
don't.

 - $URL/objects/info/refs

   This must list all the refs available in the repository and must be
   up-to-date.  We do not run PROPFIND, nor parse $URL/refs/index.htm, but
   trust this file's contents and start from there.

 - $URL/objects/info/packs

   This must list all the packs in the repository and must be up-to-date.
   We do not run PROPFIND, nor parse $URL/objects/pack/index.htm, but
   trust this file's contents.  If the repository does not have any pack,
   request to this file must give us Not found.

 - $URL/packed-refs

   This may be a valid packed-refs file left after "git pack-refs".  If
   the repository's refs are not packed, the file may not exist, and that
   is Ok, but in that case, the request must give us Not found.

 - $URL/objects/pack/pack-*.pack and pack-*.idx

   If the repository lacks what we asked for , the request must result in Not
   found.

 - $URL/objects/[0-9a-f][0-9][a-f]/*

   Loose objects.  If the repository lacks what we asked for, the request
   must result in Not found.

It appears that github always redirects the request to some random project
page when Not found response is expected, which is very broken from the
point of view of git-fetch/git-clone.

I cannot tell offhand if it is just this "addontemplate.git" repository,
or if the way github arranges the URL space is fundamentally broken and
all of their repositories are unusable in exactly the same way (their URL
space seems to overlay UI pages meant for browsers over output meant to be
read by git-fetch/git-clone).

In either case, cloning over http from that "addontemplate" URL is not
expected to work right now, and the primary reason is that the server is
utterly misbehaving.

Hopefully that is a temporary breakage something github folks can promptly
fix.  Tom, could you have your server folks in touch with the git mailing
list, so that we can figure out what is going on?  Or are they already on
top of this issue and we can just wait (hopefully not for too long)?

In the meantime, I do not think it is a good idea to loosen the error
checking on our side to accomodate a server in such a (hopefully
temporary) broken state, however popular it is.
