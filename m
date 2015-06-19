From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using clean/smudge filters with difftool
Date: Fri, 19 Jun 2015 10:03:31 -0700
Message-ID: <xmqqsi9naavw.fsf@gitster.dls.corp.google.com>
References: <5582BA1F.1030409@drmicha.warpmail.net>
	<CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>
	<20150618132622.GJ18226@serenity.lan>
	<CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
	<20150618141116.GK18226@serenity.lan>
	<CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>
	<20150618142852.GL18226@serenity.lan>
	<CAGA3+++LqZ8Qv6tpuoqQwi37kO5LLODwcbFQtvneorjiV4KARw@mail.gmail.com>
	<20150618160133.GO18226@serenity.lan>
	<xmqqsi9oeqhn.fsf@gitster.dls.corp.google.com>
	<20150618223927.GP18226@serenity.lan>
	<xmqqr3p8bp8l.fsf@gitster.dls.corp.google.com>
	<5583D993.4090305@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>,
	Florian Aspart <florian.aspart@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 19:03:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5zhb-0006eS-AD
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 19:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbFSRDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 13:03:35 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33722 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbFSRDe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 13:03:34 -0400
Received: by igbqq3 with SMTP id qq3so20672863igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EQ2p7wdDKsFzCUVjOneN0mPf4v+aaImd5ctIj23PloY=;
        b=E1CqTkWabB6HkYnKhwyqtuh01saiCWBln1j47mIOGIq5/lngWGpL8pop1vnBmhs8qw
         XTfzDrMbJsuvk81oH+F414VwuHGJ+hIChoq9xtBrDRIUNOEJJiWo9bal1NQyYWVG4SNL
         RGq0GVgVuEQTl7nqM8JhYv3q+iGOLOVNiTWjROhS4liByXSUR7nmOwrTK7Gmq247KQhz
         UDMGFh3gsVcDKgWUsR7kIHB3rfQUDgo3rH4dc3oVI90olN9aKxTtvT4Zh2gH3hHuzf2r
         pdc9vGLsD1QP5jEznsB9ZlZLs5+C+0hD0czW+Hj4/rlXkExaiF6wzEnQbgCNbMP3FYxF
         QmwQ==
X-Received: by 10.50.134.196 with SMTP id pm4mr5160651igb.6.1434733413525;
        Fri, 19 Jun 2015 10:03:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id p8sm2034399iga.13.2015.06.19.10.03.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 10:03:32 -0700 (PDT)
In-Reply-To: <5583D993.4090305@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 19 Jun 2015 10:57:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272167>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Now, since external diff runs on smudged blobs, it appears as if we
> mixed cleaned and smudged blobs when feeding external diffs; whereas
> really, we mix "worktree blobs" and "smudged repo blobs", which is okay
> as per our definition of clean/smudge: the difference is irrelevant by
> definition.

It does not appear to "mix cleaned and smudged" to me (even though
before Dscho's commit that John pointed out, we did mix by mistake)
to me, but you arrived at the correct conclusion in the rest of your
sentence.

We treat "worktree files" and "smudged repo blobs" as "comparable"
because by definition the latter is what you get if you did a
"checkout" of the blob.  Indeed, when we know a worktree file is an
unmodified checkout from a blob and we want to have a read-only
temporary file for a "smudged repo blob", we allow that worktree
file to be used as such.

So in that sense, the commit by Dscho that John pointed out earlier
was not something that changed the semantics; it merely made things
consistent (before that commit, we used to use clean version if we
do not have a usable worktree file).

It is a separate question which of clean or smudged an external diff
tool should be given to work on.

> I still think that feeding cleaned blobs to external diff would be less
> surprising (and should be the default, but maybe can't be changed any
> more) and feeding smudged blobs should be the special case requiring a
> special config.

Go back six years and make a review comment before 4e218f54 (Smudge
the files fed to external diff and textconv, 2009-03-21) was taken
;-).  The argument against that commit may have gone like this:

 * The current (that is, current as of 4e218f54^) code is
   inconsistent, and your patch has a side effect of making it
   consistent by always feeding smudged version.

 * We however could make it consistent by always feeding clean
   version (i.e. disable borrow-from-working-tree codepath when
   driving external diff).  And that gives us cleaner semantics; the
   internal diff and external diff will both work on clean, not
   smudged data.

 * Of course, going the "clean" way would not help your cause of
   allowing external diff to work on smudged version, so you would
   need a separate patch on top of that "consistently feed 'clean'
   version" fix to optionally allow "consistently feed 'smudge'
   version" mode to help msysGit issue 177.

And I would have bought such an argument with 97% chance [*1*].

I do not think 6 years have changed things very much with respect to
the above three-bullet point argument, except that it would be too
late to set the default to 'clean' all of a sudden.  So a plausible
way forward would be to

 * introduce an option to feed 'clean' versions to external diff
   drivers, perhaps with --ext-diff-clean=<driver> command line
   option and GIT_EXTERNAL_DIFF_CLEAN environment variable, both of
   which take precedence over existing --ext-diff/GIT_EXTERNAL_DIFF

 * optionally add a configuration variable diff.feedCleanToExternal
   that makes --ext-diff/GIT_EXTERNAL_DIFF behave as if their
   'clean' siblings were given.  Default it to false.

My gut feeling is that textconv should need a similar treatment for
consistency (after all, it goes through the same prepare_temp_file()
infrastructure).


[Footnote]

*1* The 3% reservation is that I am not entirely convinced that
"both internal and external get to work on the same 'clean'
representation gives us cleaner semantics" is always true.
