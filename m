From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP PATCH 1/3] git bisect old/new
Date: Thu, 4 Jun 2015 10:29:13 +0200
Message-ID: <CAP8UFD3K8NFWgiuusi47Puy4q8JZPD7X9wOj7H7yq+NYui0tsQ@mail.gmail.com>
References: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Christian Couder <chriscool@tuxfamily.org>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 04 10:29:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0QWh-0007rh-DR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 10:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbbFDI3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 04:29:19 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37468 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbbFDI3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 04:29:15 -0400
Received: by wifw1 with SMTP id w1so49716547wif.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7ZCvGhU/U5R7O0IShOwQDsgDSMRfgp7FwTPRSzBrTms=;
        b=HC9cBZGL68ikF92EmHzeYf+ZGFddzte1eOVFc0jCIo/vsiQyU0ai+pxnc8KDRuU+tE
         ni7Oxz64BxQCJsMxyIIA3ohaDG/sjspTQ5fMTSeJJ4G6+/icQ+o91Z/hhOzCePWp27wN
         vw8R7DdKi4ltIBwwfNPvw3Bhx84JTAJkFcNFJMkosU24k3swGXTMsszr3VkLo8gt1RaA
         /SKjaiKd4vxdf/BoT5Yu2mBd6F4QWcfcTGuuYlxBfeFwy2rZMEjLUcJAh27I9G1ec7rY
         0mCqQvNJjfglvL9f6eR0OGCRngr7e5rUUqxlSpRBwWVBeT8ojy1O2E5Honcunqby06BL
         IHLQ==
X-Received: by 10.180.105.38 with SMTP id gj6mr5318495wib.90.1433406553789;
 Thu, 04 Jun 2015 01:29:13 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Thu, 4 Jun 2015 01:29:13 -0700 (PDT)
In-Reply-To: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270759>

On Thu, Jun 4, 2015 at 9:59 AM, Antoine Delaite
<antoine.delaite@ensimag.grenoble-inp.fr> wrote:
> From: Christian Couder <chriscool@tuxfamily.org>
>
> When not looking for a regression during a bisect but for a fix or a
> change in another given property, it can be confusing to use 'good'
> and 'bad'.
>
> This patch introduce `git bisect new` and `git bisect old` as an
> alternative to 'bad' and good': the commits which have the most
> recent version of the property must be marked as `new` and the ones
> with the older version as `old`.
>
> The output will be the first commit after the change in the property.
> During a new/old bisect session you cannot use bad/good commands and
> vice-versa.
>
> `git bisect replay` works fine for old/new bisect sessions.
>
> Some commands are still not available for old/new:
>
>      * git bisect start [<new> [<old>...]] is not possible: the
>        commits will be treated as bad and good.
>      * git rev-list --bisect does not treat the revs/bisect/new and
>        revs/bisect/old-SHA1 files.
>      * git bisect visualize seem to work partially: the tags are
>        displayed correctly but the tree is not limited to the bisect
>        section.
>
> Related discussions:
>
>         - http://thread.gmane.org/gmane.comp.version-control.git/86063
>                 introduced bisect fix unfixed to find fix.
>         - http://thread.gmane.org/gmane.comp.version-control.git/182398
>                 discussion around bisect yes/no or old/new.
>         - http://thread.gmane.org/gmane.comp.version-control.git/199758
>                 last discussion and reviews
>
> Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
> Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
> Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
> We took account of most of the "easy" reviews that were discuted two years ago.
> We hope we didn't missed any.
> http://thread.gmane.org/gmane.comp.version-control.git/199758
>
> We corrected various issues that were not reported:
> -one that caused a "fatal ... not a valid ref" at the end of the bisection.
> -the autostart was causing issues, the following lines were working :
> git bisect new HEAD
> git bisect bad HEAD
> git bisect good aGoodCommit
>
> The hard review which we were thinking on was the issue of the maintaining
> of old/new and allow easy support of new "tags" like yes/no in the future.
> I tried to remove the maximum of bad/good and old/new which were hard wrote in
> the code but I'm not completly satisfied. This patch is clearly a v1.

Thanks for working on this. Here are some suggestions that I should
probably have told you before, but didn't:

- Take ownership of all the patches.
- Patch 3/3 renames some variables in bisect.c, do the same thing in
git-bisect.sh for consistency.
- Squash all the patches together.
- Try to find a way to break down the resulting patch into a logical
patch series which adds tests at each logical step. This might be
difficult. You might want to add features to git bisect--helper first
for example, then test those features, then add features to git bisect
and then test those features.

Best,
Christian.

> We're currently working on:
>
> * rebasing the history of the patch
> * git rev-list --bisect does not treat the revs/bisect/new and
> revs/bisect/old-SHA1 files.
> * git bisect visualize seem to work partially: the tags are displayed
> correctly but the tree is not limited to the bisect section.
> * adding tests about old/new
>
> Some other problems that might also be considerred later :
> * change/add valid terms (e.g "unfixed/fixed" instead of "old/new")
> *
> * git bisect start [<new> [<old>...]] is not possible: the commits
> will be treated as bad and good.
>
