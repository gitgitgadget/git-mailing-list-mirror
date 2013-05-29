From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/5] rebase: fix cherry-pick invocations
Date: Wed, 29 May 2013 00:57:58 -0500
Message-ID: <51a598e6e58ff_7242869e1c715bf@nysa.mail>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
 <1369747757-10192-6-git-send-email-felipe.contreras@gmail.com>
 <7vzjvewwne.fsf@alter.siamese.dyndns.org>
 <7vvc62wwea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 08:00:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZQp-0002wF-SU
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847Ab3E2GAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:00:14 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:61099 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab3E2GAN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:00:13 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so10893348oag.23
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=N9/6QmE4CVkJEI/AWHha4efUEba66FRIlVh9tD6ZWmo=;
        b=t+600UQVoe+d+QG8olSFSZ6cZwg8fbthM1UqdeW44xtpFYID5D6hPzh2QpNqb6DLLa
         mNe38AR0okZSTpQ15pu9ZF4T6k+TcdLu3UiztFN5XsDFjUQTAjVxFVt23ZnpUj5pxOBX
         gQmDQ0TD4nNzozYFblyJ8mkJ8nLFLwf+0e/nnUc6PZ3v6ScOeYPxJtSTgqftkgqVOECG
         J5ipgWpy/NpS0WnUzgjRV6BuZC5CCUPM71Dc6LBA3j/9eWnsvg5tzWIg3KW+l7CjbKjZ
         jXLgt1hRtZ4AW4k0W9uf6apTqgDpodX4yO6drhRHjA5/u/TfeyFgVnUWGcGMvOupI5Xg
         KjFQ==
X-Received: by 10.182.53.194 with SMTP id d2mr735940obp.28.1369807212742;
        Tue, 28 May 2013 23:00:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id hv3sm38653162obb.7.2013.05.28.23.00.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 23:00:11 -0700 (PDT)
In-Reply-To: <7vvc62wwea.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225748>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> So that all the tests pass.
> >>
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> ---
> >>  git-rebase--cherry.sh | 17 ++++++++++++++++-
> >>  1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
> >> index ca78b1b..c3a2ac9 100644
> >> --- a/git-rebase--cherry.sh
> >> +++ b/git-rebase--cherry.sh
> >> @@ -23,11 +23,26 @@ test -n "$rebase_root" && root_flag=--root
> >>  mkdir "$state_dir" || die "Could not create temporary $state_dir"
> >>  : > "$state_dir"/cherry || die "Could not mark as cherry"
> >>  
> >> +if test -n "$rebase_root"
> >> +then
> >> +	revisions="$onto...$orig_head"
> >> +else
> >> +	revisions="$upstream...$orig_head"
> >> +fi
> >
> > "So that all the tests pass" needs a bit more explanation to say for
> > cherry-pick codepath why and how two-dot range fails and why and how
> > three-dot variant with --right-only fixes it.  What are the problematic
> > cases?
> 
> Yikes, sorry, this was me being slow.  Walking A...B range with
> right-only and --cherry applied will filter the duplicates, which is
> wat you want, I think, and walking A..B range will not do the
> filtering for you.

That's right.

-- 
Felipe Contreras
