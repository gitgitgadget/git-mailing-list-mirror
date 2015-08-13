From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 3/4] refs: make refs/worktree/* per-worktree
Date: Thu, 13 Aug 2015 16:32:26 -0400
Organization: Twitter
Message-ID: <1439497946.8855.22.camel@twopensource.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
		 <1439416645-19173-3-git-send-email-dturner@twopensource.com>
		 <CAPig+cRM-J-5SHJ9JVsHPR+B2Y05nwFrRQWsd0M56pm9jS-mTQ@mail.gmail.com>
	 <1439487708.8855.2.camel@twopensource.com> <55CCFB32.30608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Jacob Keller <jacob.keller@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:32:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPzAv-0003rK-P7
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 22:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbbHMUc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 16:32:29 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34393 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbHMUc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 16:32:29 -0400
Received: by qgeg42 with SMTP id g42so39691801qge.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 13:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Pkh0ykZOlavng4YydYKTefiRPcWXUK+lLN8958S1TjA=;
        b=JCCSNgS+k0iSWeimp4ZX84tsjRLw/4ABaJjCl9KTiRJjPK+j78I4Hx9ke9OIUx5MS9
         FMRUqCZVwBE/S8Cd75j3hnpK5dhZINjuqQJ+Ec47EXP/U4XfBkSf4M4paFOFWCAHLMZq
         WuQ4nNtGX0TlxmPWXfbT4IGZvh8kCGCZrTWI87Z2eXc31gboIDx6Dxc8p1Tgnieu7tPJ
         00zph3wgDgJ5jn1V726Mg4Q/KihYL6TvAvKigM4tfXVam0bVKvGDKqJBrqc9P0WotVF2
         mgIMSqRIJ1np/0DL3yowCG1/GHWNwlsXQqmh4oTWC0xmBsMiQWAO9g9r2nrKWY/vg2SA
         GdOA==
X-Gm-Message-State: ALoCoQnxNne77VtXcWYM4KAlwtSps4jHn7IJY8ejL+jMXf3QSNGylkFVbkB7OAGAxp8H688hwYO8
X-Received: by 10.140.217.138 with SMTP id n132mr8870873qhb.96.1439497948129;
        Thu, 13 Aug 2015 13:32:28 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h49sm1744379qgh.43.2015.08.13.13.32.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 13:32:27 -0700 (PDT)
In-Reply-To: <55CCFB32.30608@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275893>

On Thu, 2015-08-13 at 22:16 +0200, Michael Haggerty wrote:
> On 08/13/2015 07:41 PM, David Turner wrote:
> > On Thu, 2015-08-13 at 13:15 -0400, Eric Sunshine wrote:
> >> On Wed, Aug 12, 2015 at 5:57 PM, David Turner <dturner@twopensource.com> wrote:
> >>> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> >>> index 93605f4..28e6dff 100755
> >>> --- a/t/t0060-path-utils.sh
> >>> +++ b/t/t0060-path-utils.sh
> >>> +test_expect_success 'handle per-worktree refs in refs/worktree' '
> >>> +       git commit --allow-empty -m "initial commit" &&
> >>> +       git worktree add -b branch worktree &&
> >>> +       (
> >>> +               cd worktree &&
> >>> +               git commit --allow-empty -m "test commit"  &&
> >>> +               git for-each-ref | test_must_fail grep refs/worktree &&
> >>
> >> s/test_must_fail/!/
> >>
> >> From t/README:
> >>
> >>    On the other hand, don't use test_must_fail for running regular
> >>    platform commands; just use '! cmd'.  We are not in the business
> >>    of verifying that the world given to us sanely works.
> > 
> > When I make that change, my test fails with:
> > 
> > FATAL: Unexpected exit with code 2
> > 
> > Apparently, you can't use ! in pipelines like that.  So that's why I
> > used test_must_fail.
> 
> You would have to negate the whole pipeline, like
> 
>     ! git for-each-ref | grep refs/worktree
> 
> The result of a pipeline is taken from the last command.

Yes, but that would pass if for-each-ref fails, which I do not want.  

Jacob's suggestion of parentheses around (! grep refs/worktree) seems to
work.
