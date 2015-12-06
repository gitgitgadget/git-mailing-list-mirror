From: David Ware <davidw@realtimegenomics.com>
Subject: Re: git subtree bug produces divergent descendants
Date: Mon, 7 Dec 2015 11:18:15 +1300
Message-ID: <CAET=KiXr6nQj13j725FOa0oAbFFdC_zGt-Zyj=EU3+_wOY1A8w@mail.gmail.com>
References: <CAET=KiVReZMyJmPMMB8eVSqYP9ZF2td-9qdB5KQRTrJSoUt9Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 23:18:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5hdM-0007r0-SH
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 23:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbbLFWSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 17:18:16 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34759 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbbLFWSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 17:18:16 -0500
Received: by vkbs1 with SMTP id s1so92646330vkb.1
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 14:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=MvGesul6ALNGI6p3jk/XHRRaqUO78iNu35otnwvSIZE=;
        b=qrPNIfEmV/olfPJbH94GNCEmg+mu2ylMRBy+35bW0eyhCHExrbqAgEIDzXccFrBE42
         Fs+7hoRGeey119jB/mcY3OT+DEQ23GzY/e7hqiH6nvCgj1xqQSv0wC0kENmakZXZzrTj
         lZdYM9bHw/IECd+LuFr6mQ1pjl70J4NWrs42Wjf+8DLoblrl8UO42E5kyTP1Lmj4Wwx/
         QBOPLs1V9AYpQmcixKqRLA4yWaKnFpjU/19yKlhdk17AnQANwl/crLNbH+YMuyJzysOo
         A+wpotOjUq7jkinHcsA64jwnKvEoKWTvYZdSLEd2QXQBi7Hd+wf8uxc1dNkrU0BFDMrk
         r9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=MvGesul6ALNGI6p3jk/XHRRaqUO78iNu35otnwvSIZE=;
        b=hYZDVOpbAPMNKNSH5g/ZCLyRFF/NATILqu+JLE2aQXwOTAKOg+yWXDYJpaJCfy/C0Z
         FqjdUkKiu9EGBu/IOYs2wd6Yr7O/3H83kfckjLELDE1p5TMoIrwfAqzMCO0uIpa6E5y9
         mJvvKE3rBRgQ+ySOdcnk82dpUNgBopJvopwtydTkFC/5116LC3X6rnkU0jLp4ol4tqCK
         owxnFtul/uvmQbEdxJO8+AUx5MQDzyHYAPgzjTwWUrwcqmSw4qQv4YAqcZ9K2GYGSRvW
         gK5vOl9avRdBbz0ivGMzxdtmt1uuMqglsYljIPTCHgZNcLQwZPif31OSLVkaACke9SZY
         kEVg==
X-Gm-Message-State: ALoCoQk+QPM76OHzFSNR4dsobKIxbtHuNhSWkHNmwwZ5OddIwzI2vgbpdJFGZm7dN/H2wL3nPBf3
X-Received: by 10.31.2.67 with SMTP id 64mr19320140vkc.22.1449440295388; Sun,
 06 Dec 2015 14:18:15 -0800 (PST)
Received: by 10.31.236.4 with HTTP; Sun, 6 Dec 2015 14:18:15 -0800 (PST)
In-Reply-To: <CAET=KiVReZMyJmPMMB8eVSqYP9ZF2td-9qdB5KQRTrJSoUt9Bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282070>

Sorry for the double post, I received a mail blocking notification
message (due to the attached .sh file) and erroneously thought this
message had been blocked from the entire list. My later one includes
the test case as part of the attached patch.

Cheers,
Dave Ware

On Mon, Dec 7, 2015 at 9:41 AM, David Ware <davidw@realtimegenomics.com> wrote:
> My group has run into a bug with "git-subtree split". Under some
> circumstances a split created from a descendant of another earlier
> split is not a descendant of that earlier split (thus blocking
> pushes). We originally noticed this on v1.9.1 but have also checked it
> on v2.6.3
>
> When scanning the commits to produce the subtree it seems to skip
> creating a new commit if any of the parent commits have the same tree
> and instead uses that tree in its place. This is fine when the cause
> is a branch that did not cause any changes to the subtree.  However it
> creates an issue when the cause is both branches ending up with the
> same tree through identical alterations (or more likely, one of the
> branches has just a subset of the alterations on the other, such as a
> branch just containing cherry-picks).
>
> The attached bash script (makerepo.sh) reproduces the problem. To use
> create an empty directory and run the script in it. The resulting
> 'master' branch has had the latest commits on the 'branch' branch
> merged into it, so it follows that a subtree on 'folder/' at 'master'
> should contain all the commits of a subtree on 'folder/' at 'branch'.
> (These subtrees have been produced at 'subtree_tip' and
> 'subtree_branch' respectively.)
>
> The attached patch (against v2.6.3) fixes the issue for the cases
> we've encountered, however since we're not particularly familiar with
> git internals we may not have approached this optimally. We suspect it
> could be improved to also handle the cases where there are more than 2
> parents.
>
> Cheers,
> Dave Ware
