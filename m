From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Tue, 15 Jan 2013 07:53:13 -0800
Message-ID: <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky>
 <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
 <50F40316.7010308@drmicha.warpmail.net>
 <7v1udnbmyz.fsf@alter.siamese.dyndns.org>
 <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com>
 <7vpq1755jb.fsf@alter.siamese.dyndns.org>
 <7vip6z54rh.fsf@alter.siamese.dyndns.org>
 <50F524F8.5090803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 15 16:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv8pa-0006Ei-51
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 16:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab3AOPxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 10:53:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137Ab3AOPxR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 10:53:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7614FAB45;
	Tue, 15 Jan 2013 10:53:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1GCxzYg5sDBCgkGzfumq2w2RoEQ=; b=LYLZ3S
	URzevNqxnNC/y2FJF6z54t3bdyKe5DSLJCkXU0jYp6XjbELyGGbyYYUMpcd+hkUb
	fX0bM4b5ZIHLPn1Xp0cosj/jzr2mOa90n0NofsKmo7t1jJfGrfRaG/tW3OHb4uO2
	128CK586ApDKsnpckEL0tbrZ6r+POhZAkbNEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GLoxehblf+cE7IJ5WAje1ab1sd7pA7TU
	4FMJu9ql2aN9qT1CKYXaU4b3XBjLk1/WWNR4OKUiS0fq1A8cyqKlmzNk+vIfInnq
	GK8rqdhQ+4RpnWq25Jkt8t0t4klszgvUUHOqsmKIGaC84EQUO5DjzL3+XNIjzwY/
	N7HlZjjVeLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AFECAB44;
	Tue, 15 Jan 2013 10:53:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D928AB40; Tue, 15 Jan 2013
 10:53:15 -0500 (EST)
In-Reply-To: <50F524F8.5090803@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 15 Jan 2013 10:44:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC7B5AC8-5F2B-11E2-B6A8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213640>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Also there is a conceptual confusion: pushurl is meant to push to the
> same repo using a different url, e.g. something authenticated
> (https/ssh) for push and something faster/easier for fetch.

That is not necessarily true, depending on the definition of your
"same".  Having multiple URLs/PushURLs that refer to physically
different locations, as long as "git push there" immediately
followed by "git fetch here" should work with the repositories that
are conceptually equivalent, is a supported mode of operation. In
fact, they being physically different _was_ the original motivation
of the feature. See 755225d (git builtin "push", 2006-04-29).

The definition of the "immediate" above also depends on your use; it
could be tens of minutes (you may be fetching from git.k.org that
can be reached from the general public, which may be a cname for
multiple machines mirroring a single master.k.org that k.org account
holders push to, and there may be propagation delays).  In such a
scenario, your URL may point at the public git.k.org, pushURL may
point at master.k.org, and you may have other pushURLs that point at
other places you use as back-up locations (e.g. git.or.cz or
github.com).

As long as you _mean_ to maintain their contents the same, you can
call them conceptually "the same repo" and your statement becomes
true.

> It never was meant to push to several repos.

This is false.  It _was_ designed to be used that way from day one.
(I am not saying using it in other ways is an abuse---I am merely
saying that pushing to multiple physically different repositories is
within its scope).

> That being said, I don't mind changing the behaviour of set-url.

I do not think we want to change the behaviour of set-url.  What
needs to be fixed is the output from "remote -v".  It should:

 * When there is no pushURL but there is a URL, then show it as
   (fetch/push), and you are done;

 * When there is one or more pushURLs and a URL, then show the URL
   as (fetch), and show pushURLs as (push), and you are done;

 * When there are more than one URLs, and there is no pushURL, then
   show the first URL as (fetch/push), and the remainder in a
   notation that says it is used only for push, but it shouldn't be
   the same "(push)"; the user has to be able to distinguish it from
   the pushURLs in a repository that also has URLs.

 * When there are more than one URLs, and there are one or more
   pushURLs, then show the first URL as (fetch), the other URLs
   as (unused), and the pushURLs as (push).

Strictly speaking, the last one could be a misconfiguration.  If you
have:

	[remote "origin"]
        	url = one
                url = two
                pushurl = three
                pushurl = four

then your "git fetch" will go to one, and "git push" will go to
three and four, and two is never used.

It should also be stressed that the third one a supported
configuration.  With

	[remote "origin"]
        	url = one
                url = two

your "git fetch" goes to one, and your "git push" will go to one and
two.  This is the originally intended use case of 755225d.  It is to
push to and fetch from master.k.org (think of "one" above) and in
addition to push to backup.github.com ("two").
