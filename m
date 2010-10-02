From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/7] Re: [PATCH] memory leak reported by valgrind
Date: Sat, 2 Oct 2010 03:27:52 -0500
Message-ID: <20101002082752.GA29638@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 10:31:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1xUv-0002Rc-Nl
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 10:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab0JBIbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 04:31:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54164 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab0JBIbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 04:31:05 -0400
Received: by iwn5 with SMTP id 5so4735762iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/IewAzOqXT7EblD/lIiq1oa3kF5je3/pl3FSaG9m2F4=;
        b=ZDG8hqO8vz22FkI7NMMxCTkW6gsemrGbEP5b8Hvkz6jmePs8ArWfR5/gw+IrerSjIM
         qiR2OzomszWdjZZ6+v+HJaz+kHw7TnHftw1RMYCDtKkEYB/boiU1p+UTuB6d/r6Gjmk5
         QB4CnDcKFO/Sr543rgMqYyTejA5xmi+uAw5vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xSBWvh8705FNY2FgTbNDFpry8vBZ6CEeQnOnKLEtyRexZOr0PvFyFwUvkH5G7z3tcB
         O6Tw6BxzFBT7PI+azcxr0a3JhOzTQeeCo+MVmJvvYWnSnmjfBKluDQroec8rTv/NYrCe
         Hl2IpLagMKMt492yKh1sXrz/6ByDJ5bxkA4Xw=
Received: by 10.231.152.78 with SMTP id f14mr6961907ibw.60.1286008264289;
        Sat, 02 Oct 2010 01:31:04 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n20sm2223400ibe.5.2010.10.02.01.31.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 01:31:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100810032647.GA2386@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157795>

Jonathan Nieder wrote:

>                       Could something like leaky() be used to insert
> an artificial stack frame at allocation time to make suppressions
> simpler to write?

Yes, I think it could.

Thanks to Pierre Habouzit for the initial idea and David Barr for
advice on the execution.

Thoughts?  Bugs?  Improvements?

Jonathan Nieder (7):
  init: plug tiny memory leak
  lockfile: introduce alloc_lock_file() to avoid valgrind noise
  environment.c: remove unused variable
  setup: make sure git dir path is in a permanent buffer
  Introduce malloc/strdup/pathdup variants for permanent allocations
  environment: use alloc_permanent() for computed git_dir and co
  commit-tree: free commit message before exiting

 Documentation/technical/api-lockfile.txt |    9 ++++++++
 builtin/commit-tree.c                    |   12 ++++++----
 builtin/init-db.c                        |   32 +++++++++++++++++------------
 builtin/update-index.c                   |    4 +--
 cache-tree.c                             |    7 +-----
 cache.h                                  |    3 ++
 config.c                                 |    2 +-
 environment.c                            |   14 ++++++------
 git-compat-util.h                        |    2 +
 lockfile.c                               |    6 +++++
 path.c                                   |   10 +++++++++
 t/valgrind/default.supp                  |   25 +++++++++++++++++++++++
 wrapper.c                                |   14 +++++++++++++
 13 files changed, 105 insertions(+), 35 deletions(-)

-- 
1.7.2.3
