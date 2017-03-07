Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D3C20133
	for <e@80x24.org>; Tue,  7 Mar 2017 00:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbdCGA1H (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 19:27:07 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:57564 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753781AbdCGA01 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 19:26:27 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89_RC6)
        (envelope-from <mh@glandium.org>)
        id 1cl2ax-0003Qk-RB; Tue, 07 Mar 2017 09:03:15 +0900
Date:   Tue, 7 Mar 2017 09:03:15 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     David Lang <david@lang.hm>, git@vger.kernel.org,
        sbeller@google.com, bmwill@google.com, jonathantanmy@google.com,
        peff@peff.net, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Another proposed hash function transition plan
Message-ID: <20170307000315.6cywmnx35ip7ftmc@glandium.org>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <nycvar.QRO.7.75.62.1703050258200.6590@qynat-yncgbc>
 <20170306234030.GB26789@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170306234030.GB26789@aiede.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2017 at 03:40:30PM -0800, Jonathan Nieder wrote:
> David Lang wrote:
> 
> >> Translation table
> >> ~~~~~~~~~~~~~~~~~
> >> A fast bidirectional mapping between sha1-names and sha256-names of
> >> all local objects in the repository is kept on disk. The exact format
> >> of that mapping is to be determined.
> >>
> >> All operations that make new objects (e.g., "git commit") add the new
> >> objects to the translation table.
> >
> > This seems like a rather nontrival thing to design. It will need to
> > hold millions of mappings, and be quickly searchable from either
> > direction (sha1->new and new->sha1) while still be fairly fast to
> > insert new records into.
> 
> I am currently thinking of using LevelDB, since it has the advantages of
> being simple, already existing, and having already been ported to Java
> (allowing JGit can read and write the same format).
> 
> If that doesn't work, we'd try some other key-value store like Samba's
> tdb or Kyoto Cabinet.

FWIW, I'm using notes-like data to store mercurial->git mappings in
git-cinnabar, (ab)using the commit type in tree items. It's fast enough.

Mike
