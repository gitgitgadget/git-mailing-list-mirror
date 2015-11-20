From: Stefan Beller <sbeller@google.com>
Subject: Re: Odd issue with Git-am
Date: Fri, 20 Nov 2015 13:22:34 -0800
Message-ID: <CAGZ79kagFM9aEobUJhr3hyiH3tWjU2=HMHs=PsBMcks_FMpByw@mail.gmail.com>
References: <7df90d19cfa7e987a23a22b5cd90fe6a.squirrel@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: alan@clueserver.org
X-From: git-owner@vger.kernel.org Fri Nov 20 22:22:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzt8j-0004tk-Uk
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 22:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161914AbbKTVWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 16:22:38 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33803 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161504AbbKTVWf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 16:22:35 -0500
Received: by ykfs79 with SMTP id s79so180954993ykf.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 13:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tGDKsB0y8zJqFzd05jI419SWmYV4kUuG+Lbg2KWHBoQ=;
        b=YT4wrLMEJ+fofisuOfAqb5NW+hlcdv13fjzt0fWm0bDJJCMa1RwhZO/VymEaUFWSdY
         d3zNeEImZP51PWbOgVNY5QW6q36koyDMmmQ0VsyLq+bF0XleROKCH0Ky4uuEUuUnB0aT
         8Lrswa3qXxcjkFNWhaur0qMMTEfrKYmoKsqAtPFRr1bNV9BgTGot5HeL7PLMxG2+1kcZ
         gF/JP/Y1A2AEKZyNWYbHgg0pSpYDxXcvrGNcFRj2kV7PLrTjymxblM7sla8FvdwoBn8E
         gMoNpme3nUID1yJWJ9ZoMoc1F7xJo6cBczaGxDMvS1T7mVVlSsQzbVG9FvnJqnSwv9up
         UH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tGDKsB0y8zJqFzd05jI419SWmYV4kUuG+Lbg2KWHBoQ=;
        b=SRwhSLP5F+Gyt6m3iFxrIOl2yPgV4i6ivjtakm7hPFCL2SbLJavW4dnOcCZ8r/JA4L
         XSDBiWENyBnbs+mLoMhHua5g+9sfZGA8q/MaK8n1sIaImrH4srkCTiHiIVtdXDxxKlSv
         HfP5gTuJLMhdvkI+iR2L0D911PE1kwU1jrIc+lHwQ0QQ47DqM2qaf0rX/y2tbIOi3q2a
         +HX3mWc4bmPBM2hVr9nrEzC1Z9snhYBi7s1xzXLty/5P6n+Gz21eZtvyFHIuHeW9ILBr
         VqOGllFeZCA6Uuvy82NvUrFisuC6uKsLjqE0mWB3bOwlB0ZyCNJA43QDc5ZAR1e2o2RS
         vSeg==
X-Gm-Message-State: ALoCoQl/U5yI7bDcIz9VJNy4nmQwOCvJDvnXlsfPa3MZ0zbkkwZSIvhED/D4rC/mjemV0UdvaBj0
X-Received: by 10.13.235.135 with SMTP id u129mr16566503ywe.48.1448054554495;
 Fri, 20 Nov 2015 13:22:34 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Fri, 20 Nov 2015 13:22:34 -0800 (PST)
In-Reply-To: <7df90d19cfa7e987a23a22b5cd90fe6a.squirrel@clueserver.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281537>

On Fri, Nov 20, 2015 at 1:02 PM,  <alan@clueserver.org> wrote:
> The following describes bad behavior, but it is bad behavior that git-am
> does not flag as bad. It just drops data silently.
>
> I have a developer who has a patch that I am importing into git with
> git-am.  (Currently they have a quilt-like setup that is full of bad and
> incomplete patches.)
>
> At some point in the past, someone hand edited the patch and added two
> lines. They did not, however, change the @@ references in the patch for
> the line count.
>
> The patch added a file. The line that contained the length of the file was
> "@@ -0,0 +0,1155 @@" instead of "@@ -0,0 +0,1157 @@". The result was that
> when the patch was applied it silently dropped the last two lines of the
> file.
>
> My assumption is that it should either apply the full file and/or throw an
> error. This just drops data silently.
>
> Yes people should not be editing patches by hand. This migration is part
> of the effort to get them to stop doing that.
>
> Shouldn't git-am detect that the patch data and the meta data do not match
> and warn the user or am I just being too damn picky here?
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

CCing Paul who rewrote am recently.
CCing Junio as he explained a similar issue to me once upon a time.

Copying from a random mailing list submission:

        Subject: [PATCH 2/2] fsck: treat a NUL in a tag header as an error

        We check the return value of verify_header() for commits already, so do
        the same for tags as well.

        Signed-off-by: Rene Scharfe <l.s.r@web.de>
        ---
         fsck.c          | 3 ++-
         t/t1450-fsck.sh | 2 +-
         2 files changed, 3 insertions(+), 2 deletions(-)

        diff --git a/fsck.c b/fsck.c
        index e41e753..4060f1f 100644
        --- a/fsck.c
        +++ b/fsck.c
        @@ -711,7 +711,8 @@ static int fsck_tag_buffer(struct tag
*tag, const char *data,
                         }
                 }

        -        if (verify_headers(buffer, size, &tag->object, options))
        +        ret = verify_headers(buffer, size, &tag->object, options);
        +        if (ret)
                         goto done;

                 if (!skip_prefix(buffer, "object ", &buffer)) {
        diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
        index 6c96953..e66b7cb 100755
        --- a/t/t1450-fsck.sh
        +++ b/t/t1450-fsck.sh
        @@ -288,7 +288,7 @@ test_expect_success 'tag with bad tagger' '
                 grep "error in tag .*: invalid author/committer" out
         '

        -test_expect_failure 'tag with NUL in header' '
        +test_expect_success 'tag with NUL in header' '
                 sha=$(git rev-parse HEAD) &&
                 q_to_nul >tag-NUL-header <<-EOF &&
                 object $sha
        --
        2.6.3

        --
        To unsubscribe from this list: send the line "unsubscribe git" in
        the body of a message to majordomo@vger.kernel.org
        More majordomo info at  http://vger.kernel.org/majordomo-info.html

Here we have 2 chunks, check where the second chunk ends
(hint: it's at the line starting with --).

One of the features of patches (as by git-am) is to ignore the footers,
such as the git version or the mailing list addendum.

You don't know how such a footer looks like (this one starts with --
but that's just coincidence, not by a defined protocol).

So it's hard to specify in your case when the file ends and what is
end-of-message stuff. It's dangerous if you're not aware of the pit
fall.
