From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: How do I run tests under Valgrind?
Date: Fri, 21 Sep 2012 22:13:09 +0200
Message-ID: <505CCA55.6030609@gmail.com>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com> <20120917172022.GA1179@sigill.intra.peff.net> <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com> <20120917173531.GB1179@sigill.intra.peff.net> <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com> <20120917174439.GD1179@sigill.intra.peff.net> <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com> <20120917182957.GF1179@sigill.intra.peff.net> <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com> <CALkWK0kWvrirPjXXzBBBQxKDcwpd_+nQ2eeT6SE8gDFW5T7WFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:13:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF9bL-00030x-3k
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 22:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778Ab2IUUNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 16:13:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61034 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411Ab2IUUNO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 16:13:14 -0400
Received: by bkuw11 with SMTP id w11so1020707bku.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=5bHWXu2sSRP4lUc8TtiYXD1PB5dxmKGlgrOHV2KYZ+g=;
        b=DvUY3C6BJ6P3rIedXvPAz6X1LVt/x97nnk07qRMFtUz/e1/xcT2d5bamQCGDzHTuS6
         QPV5mTPCjQKQsOYHgvsuOdWzU3cuqYbXB4C8/K0v1+HjMelmD7WTo0gf+OmtYAsnGLxX
         5m4MtSY3cA3PYvW06iI+Iwn3aa4HPf15vehIGvlALW9Lpgj9BmOhuoMJl9dKknEcDpSK
         Zgw7n88apxwiXuKEAWSHCB0CkNbGeEnwAcBDZKnrHuK1J3WxnIVShR9hfKs3Ih+AeW26
         By015/ufqV2ZnCgpVaE3YCPM9+I41TspMZ0arlCZccGuyzZUYzTjWgaybaBUb1ib0MsQ
         zMZA==
Received: by 10.204.148.86 with SMTP id o22mr2846567bkv.59.1348258392591;
        Fri, 21 Sep 2012 13:13:12 -0700 (PDT)
Received: from [192.168.178.21] (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id d13sm6315317bkw.12.2012.09.21.13.13.11
        (version=SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 13:13:11 -0700 (PDT)
In-Reply-To: <CALkWK0kWvrirPjXXzBBBQxKDcwpd_+nQ2eeT6SE8gDFW5T7WFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206157>

On 09/21/2012 09:58 PM, Ramkumar Ramachandra wrote:
> Hi again,
> 
> Ramkumar Ramachandra wrote:
>> I was able to reproduce the problem on all my machines, and I consider
>> this very disturbing.  However, I was successfully able to corner the
>> issue. I have an overtly long $PATH that's not getting split properly
>> by `IFS=:` in one corner case -- in other words, this shell script
>> fails to execute properly when called with `--tee` (just set a really
>> long $PATH and try):
> 
> Oops.  Looks like it has nothing to do with an overtly long $PATH.  It
> has something to do with $SHELL being zsh though, because other shells
> work.  Looking deeper into this.
> 
Zsh doesn't do word-splitting by default on variable expansions:

    $ zsh -c 'v="1 2 3"; for x in $v; do echo "$x"; done'
    1 2 3

unless you set the SH_WORD_SPLIT option, or put Zsh in Bourne-compatibility
mode somehow:

    $ zsh -o SH_WORD_SPLIT -c 'v="1 2 3"; for x in $v; do echo "$x"; done'
    1
    2
    3

    $ zsh -c 'emulate sh; v="1 2 3"; for x in $v; do echo "$x"; done'
    1
    2
    3

More info at: <http://zsh.sourceforge.net/FAQ/zshfaq02.html>

HTH,
  Stefano
