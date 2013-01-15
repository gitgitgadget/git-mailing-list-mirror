From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Mon, 14 Jan 2013 22:39:30 -0800
Message-ID: <7vip6z54rh.fsf@alter.siamese.dyndns.org>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky>
 <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
 <50F40316.7010308@drmicha.warpmail.net>
 <7v1udnbmyz.fsf@alter.siamese.dyndns.org>
 <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com>
 <7vpq1755jb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jardel Weyrich <jweyrich@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 07:39:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv0Be-0006ob-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 07:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab3AOGjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 01:39:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab3AOGjd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 01:39:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 963766221;
	Tue, 15 Jan 2013 01:39:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NqNMn6xY8o+GTWeq6/yEVFreT2c=; b=cNqHz3
	Of0VmtM7EPUaZpvZ7o2mB0kpaX4eBgQopVZiN4sFCmG6AYlvrsC9Vp8ccb5mCG9Y
	ABIOgmZ4RF0vOSgxk2cwcJ3WHRmnN308GOAWoFaCr2pcIrA1VIVe0Dq2nLnlCrah
	UUIjafUJvGXCBG07FaqCrKMNHYqXfoAvMISOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=unisgYFlenvoDTEymRu9qO4KIcXLjNnP
	FuZdb+t5+LZy6KwxrGZrfBkeopgzsUyr7tjMpw8wv9pfcxcNBY9eKl9j0PskvNaj
	kZPfClaG/0OGpfGrSMtksh8oB4FAIEvAdaUwD1O4MVPGpT0Qq1UtlUXsGmzw7jue
	JAk3RJ3yQ1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87A116220;
	Tue, 15 Jan 2013 01:39:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B951E621F; Tue, 15 Jan 2013
 01:39:31 -0500 (EST)
In-Reply-To: <7vpq1755jb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 14 Jan 2013 22:22:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5180A03A-5EDE-11E2-AC52-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213599>

Junio C Hamano <gitster@pobox.com> writes:

> Jardel Weyrich <jweyrich@gmail.com> writes:
>
>> If you allow me, I'd like you to forget about the concepts for a minute, and focus on the user experience.
>> Imagine a simple hypothetical scenario in which the user wants to push to 2 distinct repositories. He already has cloned the repo from the 1st repository, thus (theoretically) all he needs to do, is to add a new repository for push. He then uses `remote set-url --add --push <2nd-repo>` (which I personally thought would suffice). However, if he tries to push a new commit to this remote, it would be pushed _only_ to the 2nd-repo.
>
> The primary reason behind push-url was that
>
>  (1) usually you push to and fetch from the same, so no pushUrl is
>      ever needed, just a single Url will do (this is often true for
>      cvs/svn style shared repository workflow); and
>
>  (2) sometimes you want to fetch from one place and push to another
>      (this is often true for "fetch from upstream, push to my own
>      and ask upstream to pull from it" workflow), and in that case
>      you want pushUrl in addition to Url.  Most importantly, in this
>      case, you do *NOT* want to push to Url.  You only push to
>      pushUrl.
>
> Setting *one* pushURL is a way to say "That URL I fetch from is
> *not* the place I want to push (I may not even be able to push
> there); when I say 'push', push there instead".  Your proposed
> semantics will make it impossible to arrange such an asymmetric
> setting.

Now I think I finally see where that misunderstanding comes from.
It is "remote -v" that is misdesigned.

    $ git clone ../there here
    $ cd here
    $ git remote -v
    origin /var/tmp/there (fetch)
    origin /var/tmp/there (push)

This is totally bogus.  It should report something like this:

    $ git remote -v
    origin /var/tmp/there (fetch/push)

Then after running "git remote set-url --push origin ../another" we
should see

    $ git remote -v
    origin /var/tmp/there (fetch)
    origin /var/tmp/another (push)

which would make it clear that the original fetch/push came from the
(1) usuall you push and fetch from the same place so there is only
one setting, and the two lines came from the (2) sometimes you need
a separate places to fetch from and push to.

At this point, if you say "set-url --push origin ../third", then
"another" will disappear and gets replaced by "third"; if you
instead say "set-url --add --push origin ../third", then we will see
two (push) lines, in addition to one (fetch), making it clear that
you are still in (2) above, fetching from and pushing to different
places, and having two places to push to.

I misread your response

    From: Jardel Weyrich <jweyrich@gmail.com>
    Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
    Date: Sat, 12 Jan 2013 06:09:35 -0200
    Message-ID: <CAN8TAOvP_HX6BEK86aYoX-kVqWDmsbyptxTT2nk+fx+Ut1Tojg@mail.gmail.com>

where you showed that there was only remote.origin.url (and no
pushurl) in the first step, and somehow thought you had a
remote.origin.pushurl in the first place.
