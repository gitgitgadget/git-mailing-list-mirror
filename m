From: Jim Meyering <jim@meyering.net>
Subject: Re: Clarifying "invalid tag signature file" error message from git filter-branch (and others)
Date: Fri, 12 Dec 2008 12:02:44 +0100
Message-ID: <87zlj1hd0r.fsf@rho.meyering.net>
References: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com>
	<P7E-5meNX4tXFurN9mnRguFHdJG1jaZYTn6WxFFpECSJ68KyYT3wqQ@cipher.nrlssc.navy.mil>
	<c5df85930812111434m879f1faq80c64286714c3a1f@mail.gmail.com>
	<LhfS_uc2B_Gje7rXd1882RMsQfSRjOEsBT24Z1Yza_bWhgl9lI-ZhQ@cipher.nrlssc.navy.mil>
	<c5df85930812111559p287ea6afk54a9759302288d5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: "James Youngman" <jay@gnu.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 12:04:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB5op-0006y3-N5
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 12:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbYLLLDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 06:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbYLLLDI
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 06:03:08 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:54219 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbYLLLDH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 06:03:07 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id B939919794;
	Fri, 12 Dec 2008 12:03:03 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 51DD819761;
	Fri, 12 Dec 2008 12:02:53 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A954038304; Fri, 12 Dec 2008 12:02:44 +0100 (CET)
In-Reply-To: <c5df85930812111559p287ea6afk54a9759302288d5e@mail.gmail.com>
	(James Youngman's message of "Thu, 11 Dec 2008 23:59:29 +0000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102894>

"James Youngman" <jay@gnu.org> wrote:
> On Thu, Dec 11, 2008 at 11:13 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>
>>> Before conversion:
>>> $ git cat-file tag FINDUTILS-4_1-10
>>> object ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
>>> type commit
>>> tag FINDUTILS-4_1-10
>>> tagger Kevin Dalley
>>
>> The tagger field is missing an email address, a timestamp, and a timezone. It
>> should look something like:
>>
>>  tagger Kevin Dalley <kevin.dalley@somewhere.com> 1229036026 -0800
>>
>> git-mktag prevents improperly formatted tags from being created by checking
>> that these fields exist and are well formed.
>>
>> If you know the correct values for the missing fields, then you could
>
> Yes for the email address.      But as for the timestamp, it's not in
> the tag file; that only contains the sha1.
> There is a timestamp in the object being tagged, is that the timestamp
> you are talking about?
>
> $ git show --pretty=raw  ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
> commit ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
> tree 752cca144d39bc55d05fbe304752b274ba22641c
> parent 9a998755249b0c8c47e8657cff712fa506aa30fc
> author Kevin Dalley <kevin@seti.org> 830638152 +0000
> committer Kevin Dalley <kevin@seti.org> 830638152 +0000
>
>     *** empty log message ***
>
> diff --git a/debian.Changelog b/debian.Changelog
> index e3541eb..d0cd295 100644
> --- a/debian.Changelog
> +++ b/debian.Changelog
> @@ -1,5 +1,7 @@
>  Sat Apr 27 12:29:06 1996  Kevin Dalley
> <kevin@aplysia.iway.aimnet.com (Kevin Dalley)>
>
> +       * find.info, find.info-1, find.info-2: updated to match find.texi
> +
>         * debian.rules (debian): update debian revision to 10
>
>         * getline.c (getstr): verify that nchars_avail is *really* greater
>
>
>
>
>
>> recreate the tags before doing the filter-branch. If they are unknown, it
>> seems valid enough to use the values from the commit that the tag points
>> to.
>>
>> i.e.
>>
>>  tagger Kevin Dalley <kevin@seti.org> 830638152 -0000
>>
>> What tool was used to convert this repository to git? It should be corrected
>> to produce valid annotated tags. Especially if it is a tool within git.
>
> I don't know, Jim Meyering will know though, so I CC'ed him.

I used parsecvs, probably with git-master from the date of
the initial conversion (check the archives for actual date).
That was long enough ago that it was almost certainly before
git-mktag learned to be more strict about its inputs.

James, since you're about to rewrite the history, you may want to
start that process from a freshly-cvs-to-git-converted repository.

I'm not very happy about using cvsparse (considering it's not
really being maintained, afaik), so if the git crowd
can recommend something better, I'm all ears.
