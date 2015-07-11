From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Sat, 11 Jul 2015 17:35:29 +0530
Message-ID: <CAOLa=ZTNGV=NAXDPB3HX=fanPMQaQQc4ZpFdDFeg+LJ8SFuVOQ@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <xmqqk2u8kmre.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 14:06:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDtXi-0000xe-Dj
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 14:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbbGKMGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 08:06:00 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35050 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbbGKMF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 08:05:59 -0400
Received: by obbop1 with SMTP id op1so205706932obb.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 05:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=At9q8ph2UED7+x9TUP8pnAGbIHeFqU6cEtBChMsF/Y4=;
        b=II6dYpm3Bw3OXxmKqDuqy3c5lTJvH8qjnappaEkHBP6tR2VypcIbDek/3G7b6sQtuL
         FBVSCne8Vv3Cli+jSf+pIpn/3fHm+0P4t2SwdpGif38Fv+6UNJmlc/0/6DQIQLGVZEDm
         my/664k0Y12n6Q9k1Et9lnmME56B8YvJ6cYjB1EUSx04obGKn08PXvyvZFuAv5y3Y4ju
         BSjQiToeo9QDd4Ge4D8wAcjwRL6KRLawRF582/kpI+82AuNAYWCisRBBTvmyz6t1ZOdc
         1VQbHcXrLCLtl/G2adsDhP9y0apUPRhFHTCKT7Sh+Nv6wfyXko9WSkBW/xxOQDqBmluF
         5TLA==
X-Received: by 10.182.153.161 with SMTP id vh1mr22572292obb.34.1436616358925;
 Sat, 11 Jul 2015 05:05:58 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sat, 11 Jul 2015 05:05:29 -0700 (PDT)
In-Reply-To: <xmqqk2u8kmre.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273872>

On Fri, Jul 10, 2015 at 9:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> This may be enough to support the various existing formats that are
> offered by "git branch" and/or "git tag", but I do not think if this
> is the right approach in the longer term, or if we are painting
> ourselves in a corner we cannot cleanly get out of later [*1*].
> Will the "refname" stay to be the only thing that may want alignment
> padding appended in the future?  Will it stay true that we want to
> align only to the left?  Etc., etc.
>
> Cc'ed Duy as %< in the pretty-format was his invention at around
> a5752342 (pretty: support padding placeholders, %< %> and %><,
> 2013-04-19).
>

I kinda had the same though, my only justification was that it was only being
internally used. I'll have another look if as to see if I can make it
universal somehow.
Let's see what Duy has to suggest.

>
> When adding a new thing to an existing list, we prefer to append it
> at the end of the list, if there is no other reason not to do so
> (e.g. "the existing list is sorted in this order, and the new
> location was chosen to fit the new item to honor the existing
> ordering rule" is a valid reason to put it at the beginning, if the
> existing sorting rule dictates that the new thing must come at the
> beginning).
>

my bad, will change it!

>
> In newer code, we would want to avoid atoi() so that "foo:shortalign=1z"
> that is a typo of "12" can be caught as an error.  Either strtol_i()
> or strtoul_ui() may be better (we would need to adjust it further
> when Michael decides to resurrect his numparse thing that has been
> in the stalled bin for quite a while, though).
>

Will have a look, thanks :)

>
> What should happen when the display column width of the string is
> wider?  If a user wants to align the refs that are usually usually
> short start the next thing at the 8th column, which should she use?
>
>     "%(refname:shorta=7) %(next item)"
>     "%(refname:shorta=8)%(next item)"
>

Both your examples would start the next item at the 8th column
(starting with 0),
the only difference being :
Case 1: when the refname is 8 columns wide
"%(refname:shorta=7) %(next item)": would give us eight columns of
refname + space + next item
"%(refname:shorta=8)%(next item)": would give us eight columns of
refname + next item
Case 2: when the refname < 8 columns wide
Both would give: upto 7 columns of refname + space + next item.

Thanks for the suggestions :)

-- 
Regards,
Karthik Nayak
