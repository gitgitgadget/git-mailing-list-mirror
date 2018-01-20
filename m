Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11521F576
	for <e@80x24.org>; Sat, 20 Jan 2018 07:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754392AbeATHlp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 20 Jan 2018 02:41:45 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55042 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeATHlb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 02:41:31 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0K7fS36014990
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 20 Jan 2018 02:41:29 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'git mailing list'" <git@vger.kernel.org>
References: <018601d391b7$8e8686a0$ab9393e0$@nexbridge.com> <xmqqinbxngra.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqinbxngra.fsf@gitster.mtv.corp.google.com>
Subject: RE: [RFE/RFC] format-patch/diff via path
Date:   Sat, 20 Jan 2018 02:41:25 -0500
Message-ID: <018c01d391c2$164eeaf0$42ecc0d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHt9eRUd5pygmp5ORmayqnnvzyYVQKo83DGozJNmrA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 20, 2018 2:15 AM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > I’m still a bit perplexed by some behaviour seen today, and am looking
> > for a clean way to deal with it that the documentation does not make
> > clear. So, I’m asking in a different way. Suppose a graph of
> >
> > A---B---C---D---E
> > \      \               /
> >   \----F—G----/
> >
> 
> An ASCII art that is not drawn for fixed-width font is by definition
> understandable only by the person who drew it X-<.  I am guessing that F is a
> child of both A and B (but I am not sure, as I do not see a reason why it
> should even be a merge to begin with, so my guess is likely to be wrong), and
> E is a merge between D and G.

My bad... outlook... and user. 
> 
> IOW, I am guessing that the below is the equivalent of what you drew for
> those who look at the picture in fixed-width font:
> 
>     A---B---C---D---E
>      \   \         /
>       .---F-------G

As unintelligible, X-<, but you are probably correct.

> > When trying to perform a format-patch from B to E, I was seeing
> > commits B-A-F-G-E rather than what I wanted B-C-D-E.
> 
> Assuming that E is a merge, format-patch output should not show E anyway
> (i.e. think in terms of "git log --no-merges --reverse", instead of fearing that
> format-patch is somehow more magical---it is not).  So if you want to show
> the comit B, C and D (meaning three patches, i.e. "diff A B", "diff B C", and
> "diff C D"), then you would do "format-patch A..D", not "format-patch A..E".
> If you meant that you are not interested in the change between A and B,
> then the range would be "B..D" instead of "A..D".  Ending the range at "E"
> means you want to see what is reachable from E, and unless you say you are
> not interested in G, you would get G, if you only say you are not interested in
> A (or B), as G is not reachable from A (or B).

While the end point, E was the same regardless of which path, I was interested in submitting the patches along B..E. A is the parent of B and F and was included in the format-patch, which then forward through F and G then E.

> It is unclear how you told format-patch when "trying to perform a format-
> patch from B to E" from your description, but if you said "format-patch
> A^..E", it is likely that you would have seen all commits in the depicted part
> of the graph except for merge commits.

That seems to be the case. I used format-patch B..E with no other args. A was not specified but got drawn in. D-E was a merge so is that why that path wasn't selected? I'd still like to be able to include merges - is that a dream?

