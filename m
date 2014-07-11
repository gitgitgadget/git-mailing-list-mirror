From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 3/4 v6] cache-tree: subdirectory tests
Date: Fri, 11 Jul 2014 15:46:36 -0700
Organization: Twitter
Message-ID: <1405118796.3775.27.camel@stross>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
	 <1405038686-1138-3-git-send-email-dturner@twitter.com>
	 <CAPig+cQVjy5eBtGLsX3uaTEsHyvyjhqCMFaLDn9Upueis-z1eQ@mail.gmail.com>
	 <xmqqbnsv6hmc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:46:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5jaY-000165-LL
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 00:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbaGKWqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 18:46:42 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:58003 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbaGKWql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 18:46:41 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so1594264qcv.12
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 15:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=ONodN9kI5PKibwfV7xXaZ0xq8j0VumY0LpFBRrATP6A=;
        b=crC2LZ9Hcmd+64T31S4ajrhqJ6Zn/eLGMtDAhYrF4xqcdteTuBq5LLeqJDiO5tAqA6
         kZqYPFAVFIoQPRoVQHbubu6rPw1u22an4cgXcCHm5ku+IHv8y8PiiRCEWMD1v1t5RC+2
         JraHrT9KHkYk5vPAOYesBQzxIv5EuM8DEkfHC0i++c/R2hLzSuLbiDI7jGyKch3XDrva
         5YVGvFw9Qy2jEkbZBmt1EWMQfzoSySxWMJh/gKrQObcEQAkkGlDH0df2zteQ7V+WzqRM
         5uZqFgqn6hAlPoei6b6yjmpfpiEN+cNn7ygJNJeCN9VPn8pNP8uEKVIxY5Xm0x7kc0/s
         /rAQ==
X-Gm-Message-State: ALoCoQnArdguJVsnZ/2buqkkLOg1SukX4bh/wWuN48L2JM3c+C7gxd+UpPKwWFQxlBA+jH95IzZq
X-Received: by 10.224.129.130 with SMTP id o2mr472213qas.64.1405118800905;
        Fri, 11 Jul 2014 15:46:40 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id t3sm6511798qai.28.2014.07.11.15.46.39
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 15:46:40 -0700 (PDT)
In-Reply-To: <xmqqbnsv6hmc.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253342>

On Fri, 2014-07-11 at 08:27 -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Thu, Jul 10, 2014 at 8:31 PM, David Turner <dturner@twopensource.com> wrote:
> >> Add tests to confirm that invalidation of subdirectories neither over-
> >> nor under-invalidates.
> >>
> >> Signed-off-by: David Turner <dturner@twitter.com>
> >> ---
> >>  t/t0090-cache-tree.sh | 26 +++++++++++++++++++++++---
> >>  1 file changed, 23 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> >> index 98fb1ab..3a3342e 100755
> >> --- a/t/t0090-cache-tree.sh
> >> +++ b/t/t0090-cache-tree.sh
> >> @@ -22,9 +22,10 @@ test_shallow_cache_tree () {
> >>  }
> >>
> >>  test_invalid_cache_tree () {
> >> -       echo "invalid                                   (0 subtrees)" >expect &&
> >> -       printf "SHA #(ref)  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >>expect &&
> >> -       cmp_cache_tree expect
> >> +       printf "invalid                                  %s ()\n" "" "$@" >expect &&
> 
> Hmm.  This will always expect that the top-level is invalid, even
> when $# is 0.  It is OK if you never need to use this to test that a
> cache-tree is fully valid, but is it something we want to check?

We have test_cache_tree to check that it's fully valid.

> Existing tests are mostly about "cache-tree is populated fully at a
> few strategic, well known and easy places and then it degrades over
> time", but after all your series is adding more places to that set
> of "a few places", so we may want to make sure that future breakages
> to the new code paths that "repair" the cache-tree are caught by
> these tests.

This patchset un-failed "initial commit has cache-tree", and added
"commit in child dir has cache-tree" and "partial commit gives
cache-tree".  I've just added a test for interactive commit; when you
take a look at the next patchset, you can let me know if this seems
sufficient to you.
