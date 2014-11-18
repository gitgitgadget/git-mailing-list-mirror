From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 12:22:51 -0800
Message-ID: <20141118202250.GK6527@google.com>
References: <Pine.LNX.4.44L0.1411181354320.4374-100000@iolanthe.rowland.org>
 <20141118194129.GI6527@google.com>
 <xmqqzjbouv0y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Stern <stern@rowland.harvard.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:22:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqpId-0007Ta-4A
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbaKRUWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:22:51 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:48369 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbaKRUWu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:22:50 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so4812386iec.10
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 12:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xEmRyXJ4AqvYVM8IfiCSEOFfBrHwdWrgodykbdRUq4o=;
        b=MAQO0xFBdS/5L6tjBPZBuGej8oh1snZHukQObFMTJBwmWbdpvNMlaLWPRAo0SmH9xM
         w3+cWBtGoU3ARfQOo/KHfpQW3oHFxOz9YIO82ZJuOY9MBQ2Zk9l61HPzBnmy79W4JHYm
         tLwK/vwHe3YRX3QOlME3QChp2cqm/o/hQVxXA3ip8tGSeqyFTZF8GoiTVXMU07sOC44v
         dugogVQX959P3TbmtCeOb2rdlgtwO8mCfF2e3h+Ui8UiFmZW+TaUxWyi0PfSKu0fPtz4
         sK56iLTpUtMlqfuxomqC3AwR8GE735cO/ShBZOhWFPUyReR5LY01zq+wt19kvX8sssZV
         OvMg==
X-Received: by 10.107.172.68 with SMTP id v65mr12793611ioe.60.1416342169696;
        Tue, 18 Nov 2014 12:22:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id o8sm120333igh.18.2014.11.18.12.22.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 12:22:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqzjbouv0y.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> --ancestry-path is my current favorite tool for walking-forward needs.
>
> Curious.  I often want to answer this question:
[...]
> And my experiments with --ancestry-path has been less than ideal.

Thanks for an example.  I've found it works okay interactively, less
so for scripted use (so I wish there were something better, though I
haven't sketched out what that something better would look like).

>     Commit 982ac87 was reported to be faulty.  What topic was it on
>     and at which point was it merged to 'master'?

 $ git log --graph --ancestry-path 982ac87^..origin/master
[...]
 * | commit f30366b27a91dbc18328bccf3067cdfad4f0cfbc
 |/  Merge: 97fefaf efa5f82
 |   Author: Junio C Hamano <gitster@pobox.com>
 |   Date:   Wed Apr 3 09:34:04 2013 -0700
 |
 |       Merge branch 'jc/directory-attrs-regression-fix'
 |
 |       Fix 1.8.1.x regression that stopped matching "dir" (without
 |       trailing slash) to a directory "dir".
 |
 |       * jc/directory-attrs-regression-fix:
 |         t: check that a pattern without trailing slash matches a directory
 |         dir.c::match_pathname(): pay attention to the length of string parameters
 |         dir.c::match_pathname(): adjust patternlen when shifting pattern
 |         dir.c::match_basename(): pay attention to the length of string parameters
 |         attr.c::path_matches(): special case paths that end with a slash
 |         attr.c::path_matches(): the basename is part of the pathname
[...]
 |
 * commit 982ac87316a1cf5126888157bdcbfa32268ebe47
   Author: Jeff King <peff@peff.net>
   Date:   Thu Mar 28 17:47:47 2013 -0400

       dir.c::match_pathname(): adjust patternlen when shifting pattern

>      - What is the 'bottom' of the topic, that is, the commit
>        reachable from the faulty commit that was already on 'master'
>        when the faulty commit was written the first time?

 $ git tag the-merge f30366b27a91dbc18328bccf3067cdfad4f0cfbc
 $ git merge-base 982ac87 the-merge^
 9db9eecfe5c2490d17c0d4bd5452e4cb1d0948c5

>      - What is the 'top' of the topic, that is, were there more
>        commits made on top to build on the faulty commit on the
>        topic before the whole thing was merged to 'master'?

 $ git log --oneline 982ac87..the-merge^2
 efa5f82 t: check that a pattern without trailing slash matches a directory
 ab3aebc dir.c::match_pathname(): pay attention to the length of string parameters

>      - Were there follow-up fixes and enhancements on the topic
>        after the topic was merged to 'master' (this is harder)?

There's only one line coming out of the-merge^2 in the ancestry-path
graph, so there were no such follow-up fixes.

Jonathan
