From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Fri, 13 Nov 2015 10:41:23 -0800
Message-ID: <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 19:41:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxJI2-0001lC-4u
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 19:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933186AbbKMSla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 13:41:30 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35490 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933087AbbKMSlX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 13:41:23 -0500
Received: by ykba77 with SMTP id a77so161348416ykb.2
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 10:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nLCAz4BtmlrPzt4S/AYQFEyx1H8EtsPoagA6Pw/oHfc=;
        b=RFXWK7z8D9f9eV7aMFjVQsxEvMLN1ybOgnY4rEwosyStQM3kH2RAeZdhyHtK5uPvDW
         GBjQKn2a+eSgsTH6Ni5XK3gBUgy8lBF71zq0TuMTdii9eO8hT2rmpzLzy4TFt+F5bw/Q
         Z67hN+WNKqX7cqMvNfyf+ZIyO1H7Qh52enH+KrQaXRNkOtwZgz3ULtr1nQtjeLCZxIiS
         cG3Du4vwUmP/jdDjmZczNDMh45Gs9fmyjR+q+A72/NCd/mw/U2WKcQHDnXzml4cDbQql
         WtBZnYWLCe5TXcKpvEC0WA5VEKZLS28+44ZMtWpieYUoLUTQu2Eo1KELcYGvihw+f8fY
         4ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nLCAz4BtmlrPzt4S/AYQFEyx1H8EtsPoagA6Pw/oHfc=;
        b=TXWYyxDi7VAlXtaKoEvyx8jmO/7JS4jUq5x/Rp9XCSK2i+8UFQ7ZZQolTEXHGtdZyx
         ynBfZaccBAtuz2NZcAP2er9AG+DxtToGeZP6/Lgv9Mkt17PM0JWg2l1JPKDtMAW0wXGN
         vFxpr+L6OJHu38wTRn+63dr3okx3fMz82SE5JUM/Ua9n4iEWRUeZKq0nfS6BxUvnIYb9
         oUahMKNwofHQBeUQrdRmvkuW2VIb+7OFbgrM8KRDieHSSBrv0wimkocEbTkhDfLnPFsy
         Jyaxrfqee+VJYq05u6QKNmu6kkXaiPAutmJwwuDp7oRRjLj1folzBnWclScX3HfFENO5
         L+yQ==
X-Gm-Message-State: ALoCoQk0x0JhIIIrC0OJVuGRNYjDLB3DEeUKZV+MA1RwNFBubn5qkOBqJ2cgOoe3KHTapCd0jDyw
X-Received: by 10.129.40.147 with SMTP id o141mr23122618ywo.199.1447440083156;
 Fri, 13 Nov 2015 10:41:23 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Fri, 13 Nov 2015 10:41:23 -0800 (PST)
In-Reply-To: <20151113053547.GD29708@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281260>

On Thu, Nov 12, 2015 at 9:35 PM, Jeff King <peff@peff.net> wrote:
>
> Hrm. Do we want to make these workarounds work correctly? Or is the
> final solution going to be that the first command you gave simply works,
> and no workarounds are needed.  If the latter, I wonder if we want to be
> adding tests for the workarounds in the first place.

I think we want to make the final solution just work. I dug into that and it is
harder than expected. I may even call it a bug. The bug doesn't occur often as
it is only triggered by things like rewriting history (forced pushes)
or a short dpeth
argument.

So if you invoke "git clone --recursive", it will internally just
delegate the submodule
handling to "git submodule update --init --recursive", which then (as
the submodule
doesn't exist yet) will delegate the cloning to "git submodule--helper
clone", which
will then call git clone for the actual cloning.

However in this whole chain of commands we never pass around the actual sha1
we need. The strategy is to clone first and then checkout the sha1, which the
superprojects wants to see. The desired sha1 was hopefully included in
the cloning,
so we can check it out.

But the sha1 may not be present if we have a very short depth argument, or if we
rewrote history. In case of a short depth argument, consider the
following history:

... <- A <- B

A is the recorded sha1 in the superproject, whereas B is the HEAD in the
remote you're cloning from. If cloning with depth=1, the most naive way
would have been to pass on the depth argument down the command chain,
but then we would end up cloning B with no further depth, and upon checkout
we cannot find A.

In case of the rewritten history, consider:

.. < - C <- B
         \
          A

whereas A is the recorded sha1 in the superproject, but on a different branch
(or even just a dangling commit. but used to be on master).
B is the master branch. In case we pass on --depth to cloning the submodule,
--single-branch is implied by --depth, so we would not clone A. In case of
A being a dangling commit, we wouldn't even clone it without the depth argument.

So I propose:
 * similar to fetch, we enable clone to obtain a specific sha1 from remote.
 * we explicitly pass the submodule sha1 as recorded in the superproject
   to the submodule fetch/clone in case we follow the exact sha1. In case of
   --remote or the branch field present in the superprojects .gitmodule file,
   we can just pass the branch name.

Thanks,
Stefan
