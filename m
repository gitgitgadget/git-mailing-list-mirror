From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 00/48] Use ref transactions
Date: Mon, 14 Jul 2014 08:03:10 -0700
Message-ID: <CAL=YDWmqXke8rt_x109NLaZU1S2d3dgpPK+kZSF9DfNxm0ECGQ@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<53BC1C53.9030203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 14 17:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6hme-0002Xf-7f
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 17:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712AbaGNPDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 11:03:12 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:58400 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbaGNPDL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 11:03:11 -0400
Received: by mail-oa0-f52.google.com with SMTP id o6so2421058oag.11
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=49GluYbfHsxv8K83n3zwVXm4utn/JRWDk4bXpz2twIs=;
        b=QqneXCb1KNCO3L6yS1yQCps1U6au1Tlol/ovbI6e4F4hlvw24+7OaFXQK+Ai5YONKG
         AQSBvlgxj0EBkzfpC55EzM4E6muGOwtlYflh4vmjjREuR5SRon0KGpLTTBTrkrdbca64
         mk6v6KQi/p6TtU+T39dzvQtq35sDR4ahX9KjPW90Zz0yPFGBuvohIM4dZzscRynyYw6z
         sUcV7TweVrcImHIxRBC+tE1tmgxZjXoMKFLHdWUQZC+epXDFec+f24M5p53nMrt9R/DI
         Ldbg80tIeUEfy3JkzpMcZhsA/WBFrUR8JVsZ8qg6W/SzKuWvte7Zuf6zhxu5ki14K+B8
         VcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=49GluYbfHsxv8K83n3zwVXm4utn/JRWDk4bXpz2twIs=;
        b=K1GFZaEzQLQtvEMHMRr83BUAqrMgaEVNVtpmEyrdzLZgxAyrAQWv7NAUb8MiAgk5UL
         djhSgy1OaT4pWPzguNX/liDE5mbaLrYQWo2RRcgSURdbunA3oskV4PyYdUZcO2cwY48A
         d8ax+zonJInr2OWwzay6CRYI3MA9t+NMcKuiYS0I38mWXxieHPXc9HXE0JE2EGOKV/pa
         oC0KUyhKF3cnnnmUe5JCvhKSXDnoWAcUlppF0Uzi4cxyxzCUXvwlg/njpCDNNymsjLmG
         wXKYQn/eLBJfQLz3hwYXlfpB/S8Ym0XSO3JAX0d25WIcUb6oP9dn4pEt0CfEnHvTknih
         JwEA==
X-Gm-Message-State: ALoCoQmm1earR1qkVDRF/l5jhiA+F2lIPQynEhx8k+HdJAB25CyZ6bvEbOBpnec5gbUNWzd3yM2K
X-Received: by 10.182.246.101 with SMTP id xv5mr18566758obc.15.1405350190739;
 Mon, 14 Jul 2014 08:03:10 -0700 (PDT)
Received: by 10.182.32.73 with HTTP; Mon, 14 Jul 2014 08:03:10 -0700 (PDT)
In-Reply-To: <53BC1C53.9030203@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253494>

On Tue, Jul 8, 2014 at 9:29 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:42 PM, Ronnie Sahlberg wrote:
>> This patch series can also be found at
>> https://github.com/rsahlberg/git/tree/ref-transactions
>>
>> This patch series is based on current master and expands on the transaction
>> API. It converts all ref updates, inside refs.c as well as external, to use the
>> transaction API for updates. This makes most of the ref updates to become
>> atomic when there are failures locking or writing to a ref.
>>
>> This version completes the work to convert all ref updates to use transactions.
>> Now that all updates are through transactions I will start working on
>> cleaning up the reading of refs and to create an api for managing reflogs but
>> all that will go in a different patch series.
>>
>> Version 20:
>>  - Whitespace and style changes suggested by Jun.
>
> I spent most of the day on reviewing this patch series,

Thanks!


>but now I'm out
> of time again.  Here is a summary from my point of view:
>
> Patches 01-19 -- ACK mhagger
> Patches 20-42 -- I sent various comments, small to large, concerning
> these patches
> Patch 43 -- Needs more justification if it is to be acceptable
> Patch 44 -- Depends on 43
> Patches 45-48 -- I didn't quite get to these, but...
>
> Perhaps it would be more appropriate for the rules about reference name
> conflicts to be enforced by the backend, since it is the limitations of
> the current backend that impose the restrictions.  Would that make sense?
>
> On the other hand, removing the restrictions isn't simply a matter of
> picking a different backend, because all Git repositories have to be
> able to interact with each other.
>
> So, I don't yet have a considered opinion on the matter.

I think for compatibility I would prefer to keep the same rules for
name conflicts as for the current files implementation.
But we could have a configuration option to disable these checks, with
the caveat that this might mean that some users will
no longer be able to access pull all the branches anymore.


>
>
> I think it would be good to try to merge the first part of this patch
> series to lock in some progress while we continue iterating on the
> remainder.  I'm satisfied that it is all going in the right direction
> and I am thankful to Ronnie for pushing it forward.  But handling
> 48-patch series is very daunting and I would welcome a split.

Will do.

>
> I'm not sure whether patches 01-19 are necessarily the right split
> between merge-now/iterate-more; it is more or less an accident that I
> stopped after patch 19 on an earlier review.  Maybe Ronnie could propose
> a logical subset of the commits as being ready to be merged to next in
> the nearish term?
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
