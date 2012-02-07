From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 7 Feb 2012 14:08:06 -0800
Message-ID: <20120207220806.GD6264@tgrennan-laptop>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
 <20120207160527.GC14773@sigill.intra.peff.net>
 <20120207190228.GB6264@tgrennan-laptop>
 <20120207191202.GA496@sigill.intra.peff.net>
 <20120207192135.GC6264@tgrennan-laptop>
 <20120207193632.GC32367@sigill.intra.peff.net>
 <7v1uq61jkz.fsf@alter.siamese.dyndns.org>
 <20120207213012.GA5846@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 23:08:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RutD1-0008He-DL
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 23:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757087Ab2BGWIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 17:08:14 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47021 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757076Ab2BGWIL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 17:08:11 -0500
Received: by obcva7 with SMTP id va7so8868910obc.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 14:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R6jsR4hYEO8R2DUOleEwtVcnOl6yRttbsjZgwCXTZos=;
        b=l2c5K7M+bx0E+HkMdMXwViBJHRTDOGONH+YcJ/FiQcbxOSyGjqhzYUuNrk5X/JPAVf
         sLcwcV/SYvI0djqBloE8J9IWAfia01yvc/aUZUAZYS5mJdIO+qX0Hg2b6nxEL28qmFqe
         45/Ig56o+arnlae7HeQ5oJZnGoOoEM0m04cpY=
Received: by 10.182.119.73 with SMTP id ks9mr22860232obb.45.1328652491158;
        Tue, 07 Feb 2012 14:08:11 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id n1sm25754911obm.11.2012.02.07.14.08.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 14:08:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120207213012.GA5846@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190214>

On Tue, Feb 07, 2012 at 04:30:12PM -0500, Jeff King wrote:
>On Tue, Feb 07, 2012 at 12:20:44PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> I think the following would show the pointed at tag too.
>> >>   $ git tag my-v1.7.9 v1.7.9
>> >>   $ ./git-tag -l --points-at v1.7.9
>> >>   my-v1.7.9
>> >>   v1.7.9
>> >> 
>> >> vs.
>> >> 
>> >>   $ ./git-tag -l --points-at v1.7.9
>> >>   my-v1.7.9
>> >> 
>> >> I found that I had to filter matching refnames.
>> >
>> > Ah, so you are trying _not_ to show lightweight tags (I thought you
>> > meant you also wanted to show them)? But I still don't see why the code
>> > I posted before wouldn't work in that case. The "object" field of v1.7.9
>> > is not the sha1 of the v1.7.9 tag object, but rather some commit, so it
>> > would not match.
>> 
>> I think he is trying to avoid saying "v1.7.9 points at itself", and wants
>> to know not just the value of $(rev-parse v1.7.9) but the refname.
>
>Hmm. I read his example again, and now I'm even more confused.
>
>If I give an object name to --points-at, should or should not a
>lightweight tag pointing to that object be found?
>
>If not, then I don't see how "git tag --points-at v1.7.9" would find
>v1.7.9. Because we would use get_sha1 to parse "v1.7.9", returning the
>sha1 of the tag object. And then when trying to match, we would look at
>each tag object, find its "object" line, and compare that. In the case
>of considering whether to show the v1.7.9 tag, we would be comparing the
>sha1 of the commit that it points to to the actual tag sha1 itself, and
>not match.
>
>But in that case, nor would we match "my-v1.7.9" above, as it is a
>lightweight tag that also points to v1.7.9's tag object.
>
>If we _do_ want to match lightweight tags, then in the matching phase we
>look for both the sha1 contained in the tag ref, as well as the sha1 of
>the thing the tag points to (_if_ it is a tag object). In that case, we
>would find both v1.7.9 and my-v1.7.9.
>
>So I am not sure which is preferable. But I don't see how you could or
>would want to distinguish the two tags above. They are functionally
>identical, in that they are both refs pointing to the exact same tag
>object. If the example had started with "git tag -s my-v1.7.9 v1.7.9"
>then it would make more sense to me.

v1 and v2 wouldn't list lightweight tags of the points-at objects.
Both versions behave like this:
  $ git tag my-lw-v1.7.9 v1.7.9
  $ git tag my-a-v1.7.9 v1.7.9
  $ git tag my-s-v1.7.9 v1.7.9
  $ git tag -l --points-at v1.7.9
  my-a-v1.7.9
  my-s-v1.7.9

While addressing Junio's comments I realized that by first matching the
sha's and not refnames like the following will show LW tags too.
So, v3 will act like this:

  $ git tag my-lw-v1.7.9 v1.7.9
  $ git tag my-a-v1.7.9 v1.7.9
  $ git tag my-s-v1.7.9 v1.7.9
  $ git tag -l --points-at v1.7.9
  my-lw-v1.7.9
  my-a-v1.7.9
  my-s-v1.7.9

Note, w/o strcmp(pa->refname, refname), this shows the points-at too:

  $ git tag my-lw-v1.7.9 v1.7.9
  $ git tag my-a-v1.7.9 v1.7.9
  $ git tag my-s-v1.7.9 v1.7.9
  $ git tag -l --points-at v1.7.9
  my-lw-v1.7.9
  my-a-v1.7.9
  my-s-v1.7.9
  v1.7.9

Which I don't think we'd want.

static struct points_at *match_points_at(struct points_at *points_at,
					 const char *refname,
					 const unsigned char *sha1)
{
	struct object *obj;
	struct points_at *pa;
	const unsigned char *tagged_sha1;

	/* First look for lightweight tags - those with matching sha's
	 * but different names */
	for (pa = points_at; pa; pa = pa->next)
		if (!hashcmp(pa->sha1, sha1) && strcmp(pa->refname, refname))
			return pa;
	obj = parse_object(sha1);
	if (!obj || obj->type != OBJ_TAG)
		return 0;
	tagged_sha1 = ((struct tag *)obj)->tagged->sha1;
	while (points_at && hashcmp(points_at->sha1, tagged_sha1))
		points_at = points_at->next;
	return points_at;
}

-- 
TomG
