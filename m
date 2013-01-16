From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Wed, 16 Jan 2013 09:46:51 +0100
Message-ID: <50F668FB.5000805@drmicha.warpmail.net>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com> <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky> <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com> <50F40316.7010308@drmicha.warpmail.net> <7v1udnbmyz.fsf@alter.siamese.dyndns.org> <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com> <7vpq1755jb.fsf@alter.siamese.dyndns.org> <7vip6z54rh.fsf@alter.siamese.dyndns.org> <50F524F8.5090803@drmicha.warpmail.net> <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 09:47:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvOeP-0005Hb-Eo
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 09:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758756Ab3APIqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 03:46:53 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40591 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754226Ab3APIqw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 03:46:52 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 49A1B20BBC;
	Wed, 16 Jan 2013 03:46:51 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 16 Jan 2013 03:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=dxdZWrg1OPIF3d64ygPRdt
	tytI8=; b=BPTtuKvhUgUvBnkLZVtn3Kpf4/vDBQ32bjh0WZLQtLdILR5La9Uwgr
	ejXj4miMeXh5hthMv6R2Lx4Y/gCdRbNQDLxQX6yoBWAjDZKNRwKsKPWHYxyxrOuy
	z7/rvs7j4/pZgxHnw2cpCIHpCG8v9PiXMl7OBeLMEY0UqGyNOOAg8=
X-Sasl-enc: 7Jc+FKGMLfgeIx/6OJyreSGekGOgQbJd6EsuiM3sLfdZ 1358326010
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 717DA48247A;
	Wed, 16 Jan 2013 03:46:50 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213740>

Junio C Hamano venit, vidit, dixit 15.01.2013 16:53:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Also there is a conceptual confusion: pushurl is meant to push to the
>> same repo using a different url, e.g. something authenticated
>> (https/ssh) for push and something faster/easier for fetch.
> 
> That is not necessarily true, depending on the definition of your
> "same".  Having multiple URLs/PushURLs that refer to physically
> different locations, as long as "git push there" immediately
> followed by "git fetch here" should work with the repositories that
> are conceptually equivalent, is a supported mode of operation. In

That is my definition of "same", in the sense of "object-and-ref-same"
when "in-sync" (at least regarding all pushed refs; there may be more
there).

> fact, they being physically different _was_ the original motivation
> of the feature. See 755225d (git builtin "push", 2006-04-29).

I thought it was about unauthenticated git-protocol vs. git+ssh but was
wrong.

> The definition of the "immediate" above also depends on your use; it
> could be tens of minutes (you may be fetching from git.k.org that
> can be reached from the general public, which may be a cname for
> multiple machines mirroring a single master.k.org that k.org account
> holders push to, and there may be propagation delays).  In such a
> scenario, your URL may point at the public git.k.org, pushURL may
> point at master.k.org, and you may have other pushURLs that point at
> other places you use as back-up locations (e.g. git.or.cz or
> github.com).

Yes. That is also why we fetch from one fetch URL only, because we
assume they point at the "same" repo and don't need to check.

> As long as you _mean_ to maintain their contents the same, you can
> call them conceptually "the same repo" and your statement becomes
> true.
> 
>> It never was meant to push to several repos.
> 
> This is false.  It _was_ designed to be used that way from day one.

It is very true with me definition of "same" ;)

> (I am not saying using it in other ways is an abuse---I am merely
> saying that pushing to multiple physically different repositories is
> within its scope).
> 
>> That being said, I don't mind changing the behaviour of set-url.
> 
> I do not think we want to change the behaviour of set-url.  What
> needs to be fixed is the output from "remote -v".  It should:
> 
>  * When there is no pushURL but there is a URL, then show it as
>    (fetch/push), and you are done;
> 
>  * When there is one or more pushURLs and a URL, then show the URL
>    as (fetch), and show pushURLs as (push), and you are done;
> 
>  * When there are more than one URLs, and there is no pushURL, then
>    show the first URL as (fetch/push), and the remainder in a
>    notation that says it is used only for push, but it shouldn't be
>    the same "(push)"; the user has to be able to distinguish it from
>    the pushURLs in a repository that also has URLs.

Maybe "(fetch fallback/push)" if we do use it as a fallback? If we don't
we probably should?

>  * When there are more than one URLs, and there are one or more
>    pushURLs, then show the first URL as (fetch), the other URLs
>    as (unused), and the pushURLs as (push).
> 
> Strictly speaking, the last one could be a misconfiguration.  If you
> have:
> 
> 	[remote "origin"]
>         	url = one
>                 url = two
>                 pushurl = three
>                 pushurl = four
> 
> then your "git fetch" will go to one, and "git push" will go to
> three and four, and two is never used.

Do we fall back to two if one is unavailable? In any case, people may
use a configuration like that to keep track of mirrors and shuffle
around the fetch lines (rather than commenting/uncommenting) when one
goes offline.

> It should also be stressed that the third one a supported
> configuration.  With
> 
> 	[remote "origin"]
>         	url = one
>                 url = two
> 
> your "git fetch" goes to one, and your "git push" will go to one and
> two.  This is the originally intended use case of 755225d.  It is to
> push to and fetch from master.k.org (think of "one" above) and in
> addition to push to backup.github.com ("two").

Michael
