From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 7 Feb 2012 17:45:15 -0800
Message-ID: <20120208014515.GE6264@tgrennan-laptop>
References: <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
 <20120207160527.GC14773@sigill.intra.peff.net>
 <20120207190228.GB6264@tgrennan-laptop>
 <20120207191202.GA496@sigill.intra.peff.net>
 <20120207192135.GC6264@tgrennan-laptop>
 <20120207193632.GC32367@sigill.intra.peff.net>
 <7v1uq61jkz.fsf@alter.siamese.dyndns.org>
 <20120207213012.GA5846@sigill.intra.peff.net>
 <20120207220806.GD6264@tgrennan-laptop>
 <20120208002554.GA6035@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 08 02:45:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuwbA-0007d8-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 02:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858Ab2BHBpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 20:45:22 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:50553 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756453Ab2BHBpU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 20:45:20 -0500
Received: by obcva7 with SMTP id va7so95659obc.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 17:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5Evy4U8mPyPhkl0MaHyvkhSDH7uEL/lVDio+1GU286c=;
        b=xEz0iecQCK5I28kmC+906KJ+tnRv++waEKwejfOHecsZUQoiLC4HsDMn6URRUrcEkb
         hqLzLRIuEmAWwv3RRudK9a231+6edeLzvum2YX2xcdI/qC2Cpqy85SQjtkaEUyZzGG7w
         wUn5/3XFgviyxRyWPwMoKtl/W/1adzxNJgkMA=
Received: by 10.182.155.105 with SMTP id vv9mr18238912obb.6.1328665520072;
        Tue, 07 Feb 2012 17:45:20 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id m2sm14664916obu.3.2012.02.07.17.45.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 17:45:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120208002554.GA6035@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190217>

On Tue, Feb 07, 2012 at 07:25:54PM -0500, Jeff King wrote:
>On Tue, Feb 07, 2012 at 02:08:06PM -0800, Tom Grennan wrote:
>
>> v1 and v2 wouldn't list lightweight tags of the points-at objects.
>> Both versions behave like this:
>>   $ git tag my-lw-v1.7.9 v1.7.9
>>   $ git tag my-a-v1.7.9 v1.7.9
>>   $ git tag my-s-v1.7.9 v1.7.9
>>   $ git tag -l --points-at v1.7.9
>>   my-a-v1.7.9
>>   my-s-v1.7.9
>
>I assume the 2nd and 3rd line should be:
>
>  $ git tag -a my-a-v1.7.9 v1.7.9
>  $ git tag -s my-s-v1.7.9 v1.7.9

Yes

>> static struct points_at *match_points_at(struct points_at *points_at,
>> 					 const char *refname,
>> 					 const unsigned char *sha1)
>> {
>> 	struct object *obj;
>> 	struct points_at *pa;
>> 	const unsigned char *tagged_sha1;
>> 
>> 	/* First look for lightweight tags - those with matching sha's
>> 	 * but different names */
>> 	for (pa = points_at; pa; pa = pa->next)
>> 		if (!hashcmp(pa->sha1, sha1) && strcmp(pa->refname, refname))
>> 			return pa;
>
>OK, I see what you are trying to accomplish here. But I really don't
>like it. Two complaints:
>
>  1. Why is the name of the tag relevant? That is, if you are interested
>     in lightweight tags, and you have two tag refs, "refs/tags/a" and
>     "refs/tags/b", both pointing to the same tag object, then in what
>     situation is it useful to show "a" but not "b"?

Yes, I suppose this is more "tags or aliases of <object>" rather than
"tags that point at <object>".

>     It seems to me you would either want lightweight tags or not. And I
>     thought not, because the point of this was to reveal signatures or
>     annotations about a tag. Your my-lw-v1.7.9 says neither. Why do we
>     want to show it?

Initially I didn't care about listing these lightweight tags (aliases)
but now I see that this could be useful to find turds in refs/tags.
  $ git tag my-v.1.7.9 v1.7.9
  ...
  $ git tag -l --points-at v1.7.9
  my-v.1.7.9
Oops

>     Also, it's not symmetric. What if I say "git tag
>     --points-at=my-lw-v1.7.9"? Then I would get your signed and
>     annotated tags (even though they're _not_ saying anything about
>     ny-lw-v1.7.9), and I would get v1.7.9 (even though it's not saying
>     anything about it either; in fact, it's the opposite!).

Huh?  As you noted, the lightweight tag is just an alternate reference,
so why wouldn't want to see the annotated and signed tags of that common
object?

  $ ./git-tag -l --points-at tomg-lw-v1.7.9 
  tomg-annotate-v1.7.9
  tomg-signed-v1.7.9
  v1.7.9
  $ ./git-tag -l --points-at v1.7.9 
  tomg-annotate-v1.7.9
  tomg-lw-v1.7.9
  tomg-signed-v1.7.9

>  2. I thought --points-at was about providing an object name. But it's
>     not. It's about providing a particular string. So with this code,
>     "git tag --points-at=v1.7.9" and "git tag --points-at=$(git
>     rev-parse v1.7.9)" are two different things. Which seems odd and
>     un-git-like to me.

Yep,
  $ ./git-tag -l --points-at $(git rev-parse v1.7.9)
  tomg-annotate-v1.7.9
  tomg-lw-v1.7.9
  tomg-signed-v1.7.9
  v1.7.9

>     Your documentation says "Only list annotated or signed tags of the
>     given object", which implies to me that --points-at is an arbitrary
>     object specifier, not a specific tagname.

Yes, I changed that in the patch that I've prepared but will revert this
if you'd rather not list these lightweight tags.

>It seems like your rationale is just avoiding a mention of v1.7.9
>because, hey, it was obviously on the command line and the user isn't
>interested in it.

Yes, exactly.

>But I don't think that's true. The user asked for every tag pointing to
>v1.7.9's object, and v1.7.9 is such a tag. It is no more or less true
>for v1.7.9 than it is for my-lw-v1.7.9.

My reaction when I tested this was, "don't tell me what I already know."
But consistency with $(git rev-parse ...) seems more important.
And as you noted, a sha1_array would save code and to me, less code is
always better.

Thanks,
TomG
