From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: How do I run tests under Valgrind?
Date: Sat, 22 Sep 2012 15:03:58 +0200
Message-ID: <505DB73E.2020108@gmail.com>
References: <20120917172022.GA1179@sigill.intra.peff.net> <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com> <20120917173531.GB1179@sigill.intra.peff.net> <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com> <20120917174439.GD1179@sigill.intra.peff.net> <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com> <20120917182957.GF1179@sigill.intra.peff.net> <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com> <CALkWK0kWvrirPjXXzBBBQxKDcwpd_+nQ2eeT6SE8gDFW5T7WFQ@mail.gmail.com> <505CCA55.6030609@gmail.com> <20120921204907.GA22977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 22 15:05:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFPOL-0002aE-VM
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 15:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab2IVNEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 09:04:11 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63041 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2IVNEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 09:04:09 -0400
Received: by bkcjk13 with SMTP id jk13so159166bkc.19
        for <git@vger.kernel.org>; Sat, 22 Sep 2012 06:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=eo1V+nLHnxVUr10aIy7+J68PqTppslrDcXbVHiak9DM=;
        b=rZEq7n7uYCM+wTX2G6KVNwfbqnsNucdWLY/mgqwiZM2WyGWzmlDGd0Rc0ZeEojqLbF
         6pA7DETNEWvDsYMnmMVr7B68/j5bY9FsyBi6MC31XfEXb4pY7fqHidRDTvuw2iHf1vTM
         VULycPRiJDGU/DcY0DZgFynn8eQDc7jMh8ZljP2GZ4cZfwp/nRV8kccH4qqdG3inEi68
         Bb6cEj9WJFP/11EMr0rE4erJcZkFmRjJREyL6hxnf28y0mSS9Zuq9c4UOE+0ssy43XfQ
         GBRp48gpnZJzrhdIUGsyxACMiQtloGmR7Z88W+s+uOfq5VM1RRbxjZJVFTfQRqNLCvSA
         hSMw==
Received: by 10.204.10.92 with SMTP id o28mr3274501bko.39.1348319048274;
        Sat, 22 Sep 2012 06:04:08 -0700 (PDT)
Received: from [192.168.178.21] (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id d13sm6903493bkw.12.2012.09.22.06.04.06
        (version=SSLv3 cipher=OTHER);
        Sat, 22 Sep 2012 06:04:07 -0700 (PDT)
In-Reply-To: <20120921204907.GA22977@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206204>

On 09/21/2012 10:49 PM, Jeff King wrote:
>
> Oh. It sounds like setting $SHELL to zsh is really the problem, then. If
> it is not Bourne-compatible when called as "zsh", then it really should
> be called in a way that turns on compatibility mode (bash will do this
> when called as "sh", but you can also do it with "bash --posix").
>
AFAIK, if Zsh is called as "sh", it too will run in Bourne compatibility
mode; not sure how to force this compatibility from the command line though
(albeit I'd guess there is some way to do so).

As further reference, here is the trick autoconf uses to (try to) put Zsh
in Bourne compatibility mode after it has been invoked:

    if test -n "${ZSH_VERSION+set}" && (emulate sh) >/dev/null 2>&1; then
       emulate sh
       NULLCMD=:
       # Pre-4.2 versions of Zsh do word splitting on ${1+"$@"}, which
       # is contrary to our usage.  Disable this feature.
       alias -g '${1+"$@"}'='"$@"'
       setopt NO_GLOB_SUBST
    fi

You might think to use something like that in 't/test-lib.sh' (and other "shell
libraries" of the testsuite), but sadly that would not be enough; this excerpt
from the Automake suite shows why:

   # If Zsh is not started directly in POSIX-compatibility mode, it has some
   # incompatibilities in the handling of $0 that conflict with our usage;
   # i.e., $0 inside a file sourced with the '.' builtin is temporarily set
   # to the name of the sourced file.  Work around that.  The apparently
   # useless 'eval' here is needed by at least dash 0.5.2, to prevent it
   # from bailing out with an error like "Syntax error: Bad substitution".
   # Note that a bug in some versions of Zsh prevents us from resetting $0
   # in a sourced script, so the use of $argv0.  For more info see:
   #  <http://www.zsh.org/mla/workers/2009/msg01140.html>
   eval 'argv0=${functrace[-1]%:*}' && test -f "$argv0" || {
     echo "Cannot determine the path of running test script." >&2
     echo "Your Zsh (version $ZSH_VERSION) is probably too old." >&2
     exit 99
   }

Since I see that '$0' is used in (at least) 't/perf/perf-lib.sh' and
't/test-lib.sh', you'd need to copy the snippet above (or write an
equivalent one) in those files, and change them to use '$argv0' instead
of '$0' in few (but not all) places.  Not sure whether it's worth it
though -- given that you seems to have solved the issue already with a
simpler change, I'd say it's not.

Regards,
  Stefano
