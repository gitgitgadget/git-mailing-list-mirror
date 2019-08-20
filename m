Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755921F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfHTSMJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:12:09 -0400
Received: from elephants.elehost.com ([216.66.27.132]:62793 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfHTSMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:12:09 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7KIC4hk058546
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Aug 2019 14:12:05 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Pratyush Yadav'" <me@yadavpratyush.com>,
        "'Leam Hall'" <leamhall@gmail.com>
Cc:     <git@vger.kernel.org>
References: <477295c5-f817-e32b-04fd-a41ddfbbac0a@gmail.com> <20190820174640.n3elekpi6l4vwamp@localhost.localdomain>
In-Reply-To: <20190820174640.n3elekpi6l4vwamp@localhost.localdomain>
Subject: RE: Only track built files for final output?
Date:   Tue, 20 Aug 2019 14:11:59 -0400
Message-ID: <01b601d55782$c5e19d00$51a4d700$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGVuhvii6CmQEwiHqoGNd3MevSRHgHoetH2p3RKndA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 20, 2019 1:47 PM, Pratyush Yadav
> On 20/08/19 08:21AM, Leam Hall wrote:
> > Hey all, a newbie could use some help.
> >
> > We have some code that generates data files, and as a part of our
> > build process those files are rebuilt to ensure things work. This
> > causes an issue with branches and merging, as the data files change
> > slightly and dealing with half a dozen merge conflicts, for files that
> > are in an interim state, is frustrating. The catch is that when the
> > code goes to the production state, those files must be in place and
current.
> >
> > We use a release branch, and then fork off that for each issue.
> > Testing, and file creation, is a part of the pre-merge process. This
> > is what causes the merge conflicts.
> >
> > Right now my thought is to put the "final" versions of the files in
> > some other directory, and put the interim file storage directory in
> .gitignore.
> > Is there a better way to do this?
> >
> 
> My philosophy with Git is to only track files that I need to generate the
final
> product. I never track the generated files, because I can always get to
them
> via the tracked "source" files.
> 
> So for example, I was working on a simple parser in Flex and Bison. Flex
and
> Bison take source files in their syntax, and generate a C file each that
is then
> compiled and linked to get to the final binary. So instead of tracking the
> generated C files, I only tracked the source Flex and Bison files. My
build
> system can always get me the generated files.
> 
> So in your case, what's wrong with just tracking the source files needed
to
> generate the other files, and then when you want a release binary, just
clone
> the repo, run your build system, and get the generated files?
> What benefit do you get by tracking the generated files?

The benefit of putting final release packages into git is based on the
following set of requirements in highly regulated industries:

1. The release artifacts can never change from the point in time at which
they are certified as working (a.k.a. passed tests) to the point when they
are replaced with other artifacts (a subsequent release). Recompiling is not
sufficient as the compilers themselves may change or be compromised. This is
an audit requirement.
2. The source commit(s) used to create the release artifacts must be
immutable so that the origins of the release artifacts are always known.
This is also an audit requirement in regulated industries.
3. Disconnecting the source from the object (as is common in artifact
repositories) breaks #2 and allows malicious code injection in
after-the-test code reproduction. Variant of #2 but from the security
perspective.
4. Metadata on the origin of the release artifacts (the clone URL, the
parent commit, the branch, signed commits), are required for forensic
analysis of code in a compliance environment.

There are other related variants of the above, but those are the essential
ones that are generally accepted in financial, insurance, medical device,
and industrial applications. Increasingly, food production and distribution
sectors are realizing that they are also subject to the above. I sadly
cannot cite specific internal regulations or policies for NDA reasons, but
hope that others are able to do that.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



