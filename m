Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5941F453
	for <e@80x24.org>; Fri, 22 Feb 2019 02:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfBVCqo (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 21:46:44 -0500
Received: from elephants.elehost.com ([216.66.27.132]:46285 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBVCqo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 21:46:44 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1M2kVAC070217
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Feb 2019 21:46:32 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     <git@vger.kernel.org>, "'Todd Zullinger'" <tmz@pobox.com>,
        "'Jeff King'" <peff@peff.net>
References: <004b01d4ca23$faebcad0$f0c36070$@nexbridge.com> <20190222004659.GA167507@google.com>
In-Reply-To: <20190222004659.GA167507@google.com>
Subject: RE: [Suggestion] Add Skip for t9020
Date:   Thu, 21 Feb 2019 21:46:25 -0500
Message-ID: <00ae01d4ca58$d0d8d0f0$728a72d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJBqdgbfiQrZpf2fqfaQbin5dIlnQG4mXWqpQOYF4A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 21, 2019 19:47, Jonathan Nieder  wrote:
> Randall S. Becker wrote:
> 
> > While this is a bit of a hack, it might be useful for skipping t9020
> > in environments where the svn.remote package is not installed. I can
> > make this into a patch if this style is reasonable - guessing probably
> > not and that the REMOTE_SVN test should go elsewhere if it is called
that.
> >
> > diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh index
> > 6fca08e5e3..31edf99371 100755
> > --- a/t/t9020-remote-svn.sh
> > +++ b/t/t9020-remote-svn.sh
> > @@ -12,6 +12,12 @@ then
> >         test_done
> >  fi
> >
> > +python -c "import svn.remote" 2>/dev/null >/dev/null if [ $? -eq 0 ];
> > +then
> > +       test_set_prereq REMOTE_SVN
> > +fi
> > +if ! test_have_prereq REMOTE_SVN
> > +then
> > +       skip_all='skipping remote-svn tests, python svn.remote not
> > available'
> > +       test_done
> > +fi
> 
> Interesting.  Where do we use the svn.remote package?  I did a quick grep
> and didn't find any instances.

Well, this was the remote svn test, so I figured I would be specific. We
don't have the svn package either so could restrict to that.

> Do you have output from running "./t9020-remote-svn.sh -v -i"?

Initialized empty Git repository in /home/git/git/t/trash
directory.t9020-remote-svn/.git/
expecting success:
        init_git &&
        git fetch svnsim &&
        test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master
&&
        cp .git/refs/remotes/svnsim/master master.good

Initialized empty Git repository in /home/git/git/t/trash
directory.t9020-remote-svn/.git/
fatal: error reading from fast-import: Resource temporarily unavailable
progress Imported commit 1.
fatal: error while running fast-import
not ok 1 - simple fetch
#
#               init_git &&
#               git fetch svnsim &&
#               test_cmp .git/refs/svn/svnsim/master
.git/refs/remotes/svnsim/master  &&
#               cp .git/refs/remotes/svnsim/master master.good
#


