From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 04/10] remote: Reject remote names containing '/'
Date: Mon, 13 May 2013 08:53:10 +0200
Message-ID: <CALKQrgcry9bwmonaeWA4M7a3k36S_Q3ZQLmv7Ui5r+tdzdMr_A@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-5-git-send-email-johan@herland.net>
	<7vtxm7scn5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 08:53:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubmde-000724-Jg
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 08:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab3EMGx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 02:53:26 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:53053 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab3EMGxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 02:53:24 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UbmdP-0005fG-7N
	for git@vger.kernel.org; Mon, 13 May 2013 08:53:23 +0200
Received: from mail-ob0-f178.google.com ([209.85.214.178])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UbkaT-000FWX-MQ
	for git@vger.kernel.org; Mon, 13 May 2013 06:42:14 +0200
Received: by mail-ob0-f178.google.com with SMTP id v19so2467149obq.37
        for <git@vger.kernel.org>; Sun, 12 May 2013 23:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=+bk/DafnjlChibAAO35fa6yb0XQPp+/GrWYNlb/gz7o=;
        b=c8n4kOtosK1qR1DjTvhZKlDRa0StrN4dlngDQy1S2DYjvvbZncXfpJ3HBip0ln7diU
         9QbnGGiUD+UL1ucJ3cz0dE7OScAW093XW5wjQcyKrCJBHwSFBGf9gCfIpxU+AscwWN/L
         cegSJqlYNQvqY4CRgmV4LG2h4BuTvC4zatMmiw7PFbDNIUZsVRHKYifzthi+7Ci6Y4nh
         d99qRwodYXxbJlqm27vWA2ii/GI1jKb/ocS1f2hp/2RR8Yn/Y2BibdekY15JOorx1XrX
         D1Kgn2tcwdjdaP21DFF8EemLjDyGcgQ+rINMA8QZXlnKvpMfdv24GT5Hq6d2gYPOn/mM
         mK0w==
X-Received: by 10.60.162.70 with SMTP id xy6mr2432160oeb.117.1368427990746;
 Sun, 12 May 2013 23:53:10 -0700 (PDT)
Received: by 10.182.113.66 with HTTP; Sun, 12 May 2013 23:53:10 -0700 (PDT)
In-Reply-To: <7vtxm7scn5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224096>

On Mon, May 13, 2013 at 6:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> Although we definitely support and encourage use of multi-level branch
>> names, we have never conciously tried to give support for multi-level
>> remote names. Currently, they are allowed, but there is no evidence that
>> they are commonly used.
>>
>> Now, they do provide a source of problems when trying to expand the
>> "$nick/$name" shorthand notation (where $nick matches a remote name)
>> into a full refname. Consider the shorthand "foo/bar/baz": Does this
>> parse as $nick = foo, $name = bar/baz, or $nick = foo/bar, $name = baz?
>>
>> Since we need to be unambiguous about these things, we hereby declare
>> that a remote name shall never contain a '/' character, and that the
>> only correct way to parse "foo/bar/baz" is $nick = foo, $name = bar/baz.
>
> I know I am guilty of hinting to go in this direction in the earlier
> discussion, but I have to wonder how much more refactoring is needed
> to see if there is only one unique possibility among many.
>
> For a string with N slashes, you have only N possible ways to split
> it into $nick and $name, and if you see a ref "bar/baz" copied from
> remote "foo" but no ref "baz" copied from remote "foo/bar" (or you
> may not even have a remote "foo/bar" in the first place), the user
> is already very unambiguous. The declaration is merely being lazy.
>
> I am not saying we must implement such a back-track to disambiguate
> the user input better.  I am wondering how much more effort on top
> of this series is needed if we want to get there (provided that the
> disambiguation is a good thing to do in the first place).

I feel the problem with multi-level remote names runs a little deeper
than merely disambiguation when resolving remote-tracking refs: If you
have two remotes "foo" and "foo/bar", and they have branches "bar/baz"
and "baz", respectively, then they will (in the default current
configuration) end up clobbering eachother due to the overlapping
remote-tracking branch (refs/remotes/foo/bar/baz). Although the remote
ref namespace coincidentally resolves this by mapping the two to
"refs/peers/foo/heads/bar/baz" and "refs/peers/foo/bar/heads/baz"
respectively, you can easily create a different (although probably
even more unlikely) case where the remote ref namespace causes the
same kind of overlap: One remote "foo" with branch "heads/bar", and
another remote "foo/heads" with branch "bar" will both end up
clobbering eachother at "refs/peers/foo/heads/heads/bar"...

The disambiguation can probably be resolved, although the resulting
code will obviously be somewhat more cumbersome and ugly (and IMHO the
current code is plenty of that already...). Combine this with the
problems of clobbering of the same remote-tracking ref (describe
above), and the fact that AFAIK a multi-level remote name has never
been observed "in the wild" (none of the people I asked at the Git
Merge conference had ever observed multi-level remote names, nor did
they directly oppose banning them), I'm not at all sure it's worth
bothering about this at all. Simply disallowing multi-level remote
names seems like the simpler and naturally ambiguity-resistant
approach.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
