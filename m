Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA8A1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 12:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeKSWqW convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Nov 2018 17:46:22 -0500
Received: from elephants.elehost.com ([216.66.27.132]:53991 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbeKSWqW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 17:46:22 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wAJCMnJS088078
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 07:22:50 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "=?UTF-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>,
        "'Steven Penny'" <svnpenn@gmail.com>, <git@vger.kernel.org>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>        <20181118154124.GA21680@tor.lan>        <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>        <20181118171525.GA25854@tor.lan>        <xmqqsgzydj6n.fsf@gitster-ct.c.googlers.com>        <005801d47fad$345d5a70$9d180f50$@nexbridge.com> <xmqqbm6leo7g.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm6leo7g.fsf@gitster-ct.c.googlers.com>
Subject: RE: Cygwin Git with Windows paths
Date:   Mon, 19 Nov 2018 07:22:45 -0500
Message-ID: <006d01d48002$9741aa60$c5c4ff20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH41KATsX/7qhjRDEgG7Ouzkp8ghwKIVmc5AYAQD80BkHSBHgDZYg/sAYgWJscCS1RH6KS8LC3w
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 18, 2018 22:33, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> >> Torsten Bögershausen <tboegi@web.de> writes:
> >>
> >> > And it may even be that we need a special handling for the "\" to
> >> > be treated as "/".
> >>
> >> I do not do Windows, but is_dir_sep() needs to be tweaked if you want
> >> to do that.
> >
> > Heavy Cygwin user here. It is used in my environment for
> > cross-compilation. Everything should be done using / separators in
> > Cygwin, not \. So /cygdrive/c, /cygdrive/d always prefaces the path
> > rather than C:\ or D:\, which won't parse. It is, essentially, a bash
> > environment, including that git completions work properly. Backslash
> > ends up doing what it would in bash.
> 
> In short, in your opinion, the original message in this thread expresses an
> invalid wish, as C:\path\to\dir\ is not a valid way to spell the path to the
> directory, and it should be written as /cygdrive/c/path/to/dir instead?
> 
> How well does this argument work in the real world, when another claim in
> the original message
> 
>     This causes problems for any non-Cygwin tools that might call Git:
> 
>     http://github.com/golang/go/issues/23155
> 
> is taken into account, I wonder, though?

The solution to this that I ended up with is a blend of many different implementations of git (3) on my dev box. EGit in ECLIPSE, standard windows git for working in a CMD prompt, the Cygwin git in Cygwin bash. On another dev box I also have git bash and Ming, which make things easier, but I have to work in Cygwin for some subsystems. I end up using relative paths with / instead of \ in all cases, and git seems happy, except for /cygdrive/c. Absolute Windows and Cygwin paths simply do not work consistently, from my experience from Cygwin because of the way bash passes arguments to non-cygwin tools. You need to be very careful and properly escape "\" to do so, and account for cygwin drive handling otherwise. So a non-cygwin tool from Cygwin can process c:\ but Cygwin itself will not. My own expectations are that git built for Cygwin would understand this, but git built for Windows would not, and that I should account for this through my PATH, selecting Cygwin git in Cygwin and Windows git elsewhere. Reality may not reflect this, so I use relative paths in all cases (non-reality being that the git port for Cygwin is different than the git port for Windows, which it does not appear to be).

Cheers,
Randall


