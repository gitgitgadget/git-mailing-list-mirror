From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv4] tag: add --points-at list option
Date: Wed, 8 Feb 2012 14:15:31 -0800
Message-ID: <20120208221531.GI6264@tgrennan-laptop>
References: <20120208185750.GA22220@sigill.intra.peff.net>
 <1328731972-13137-2-git-send-email-tmgrennan@gmail.com>
 <20120208205857.GA22479@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 08 23:15:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvFnh-00021l-Ay
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 23:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309Ab2BHWPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 17:15:37 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:51424 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764Ab2BHWPg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2012 17:15:36 -0500
Received: by obcva7 with SMTP id va7so1377418obc.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 14:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DcA4IZHGodz6ZbspRCA3Qy+6Dxh+nLKu6KLVtzsgf3I=;
        b=JqLXNFK9mP8Arb4x8tjbZ9uZqwU9qUB3z9lJLIOOIE3ZmTjHtx/fgxEe0zqNxLAztf
         xtjbzOC6Kiymeem+fu1KckC0LC50iuA4t3Co/4wA7Q508wzu9zTwqgwAyFl3JUi1vRXz
         Nblr4R/JgBTtgRFOeT3Rk8TkD+MwHyy6qZOe0=
Received: by 10.182.109.106 with SMTP id hr10mr27758104obb.27.1328739335502;
        Wed, 08 Feb 2012 14:15:35 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id q9sm563405obk.4.2012.02.08.14.15.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Feb 2012 14:15:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120208205857.GA22479@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190260>

On Wed, Feb 08, 2012 at 03:58:57PM -0500, Jeff King wrote:
>On Wed, Feb 08, 2012 at 12:12:52PM -0800, Tom Grennan wrote:
>
>> This filters the list for tags of the given object.
>> Example,
>> 
>>    john$ git tag v1.0-john v1.0
>>    john$ git tag -l --points-at v1.0
>>    v1.0-john
>
>And probably "v1.0", as well, in this iteration. :)

Yep.

>The patch content itself looks good to me, except:
>
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -12,7 +12,7 @@ SYNOPSIS
>>  'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
>>  	<tagname> [<commit> | <object>]
>>  'git tag' -d <tagname>...
>> -'git tag' [-n[<num>]] -l [--contains <commit>]
>> +'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>>  	[--column[=<options>] | --no-column] [<pattern>...]
>
>What's this "column" stuff doing here? The nd/columns topic is still in
>"next", isn't it? Did you base this on "next" or "pu"?
>
>Usually topics should be based on master, so they can graduate
>independently of each other. In this case, it might make sense to build
>on top of jk/maint-tag-show-fixes (d0548a3), but I don't think that is
>even necessary here (my fixes ended up not being too closely related, I
>think).

Yes, it's no longer related to jk/maint-tag-show-fixes.
I've prepared a rebase patch to master and will add these tests.

Thanks,
TomG

>Other than that, I think the patch is fine. There are no tests, so
>perhaps these should be squashed in:
>
>diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>index e93ac73..f61e398 100755
>--- a/t/t7004-tag.sh
>+++ b/t/t7004-tag.sh
>@@ -1269,4 +1269,43 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
> 	test_must_fail git tag -v -s
> '
> 
>+# check points-at
>+
>+test_expect_success '--points-at cannot be used in non-list mode' '
>+	test_must_fail git tag --points-at=v4.0 foo
>+'
>+
>+test_expect_success '--points-at finds lightweight tags' '
>+	echo v4.0 >expect &&
>+	git tag --points-at v4.0 >actual &&
>+	test_cmp expect actual
>+'
>+
>+test_expect_success '--points-at finds annotated tags of commits' '
>+	git tag -m "v4.0, annotated" annotated-v4.0 v4.0 &&
>+	echo annotated-v4.0 >expect &&
>+	git tag -l --points-at v4.0 "annotated*" >actual &&
>+	test_cmp expect actual
>+'
>+
>+test_expect_success '--points-at finds annotated tags of tags' '
>+	git tag -m "describing the v4.0 tag object" \
>+		annotated-again-v4.0 annotated-v4.0 &&
>+	cat >expect <<-\EOF &&
>+	annotated-again-v4.0
>+	annotated-v4.0
>+	EOF
>+	git tag --points-at=annotated-v4.0 >actual &&
>+	test_cmp expect actual
>+'
>+
>+test_expect_success 'multiple --points-at are OR-ed together' '
>+	cat >expect <<-\EOF &&
>+	v2.0
>+	v3.0
>+	EOF
>+	git tag --points-at=v2.0 --points-at=v3.0 >actual &&
>+	test_cmp expect actual
>+'
>+
> test_done
>-- 
>1.7.9.rc2.14.g3da2b
>
