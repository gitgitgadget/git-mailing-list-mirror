From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Question about the revision walking API
Date: Tue, 6 Jan 2015 14:37:07 +0100
Message-ID: <CAP8UFD0mZ4tSF-ZkZh8Z=GdkW4LNQAWuKJYyhyiA4RTGPLX_+g@mail.gmail.com>
References: <20150106020230.GA28274@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 14:41:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8UJx-0002Ei-0j
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 14:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbbAFNhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 08:37:09 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:53204 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbbAFNhI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 08:37:08 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so2595162iec.10
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 05:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=flePRuSGVHro1LG954vLWpxtfaD/CdnYbS+A6hf3IdA=;
        b=D+yowt2SyajnfQgOceLjzIwI+TtX8mU/Yb3JfXgH8B/4Sd92gCQu+JyVlmZ8RaCdsV
         uxz8+x1VuOev52vfGAcpkEBXHNNNxKCSu7g4xEJbFayTavsYIzSHc9f5Ur0qDE5VFWUt
         l/nqwHwoSyq1fsJJVcrEPIzWHu9+Ox/8Fy215D1Fu5Lxhyw+28wS/rP4phkwXdfwuPkF
         H4zU9M6C50Fx8VuIFrCBuNJXEM58LdMRtnimNoLc6yaiq9XQXEdhXPNN+zyEwmEQ3k55
         oVvcC/rzI7xujLfZXI7X2SAM3so8d/yMsAmV++ee8IBRhGMIrLAE0axBiS2daPT+nP0H
         fB/g==
X-Received: by 10.107.134.212 with SMTP id q81mr82450176ioi.62.1420551427639;
 Tue, 06 Jan 2015 05:37:07 -0800 (PST)
Received: by 10.50.252.7 with HTTP; Tue, 6 Jan 2015 05:37:07 -0800 (PST)
In-Reply-To: <20150106020230.GA28274@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262064>

Hi,


On Tue, Jan 6, 2015 at 3:02 AM, Mike Hommey <mh@glandium.org> wrote:
> Hi,
>
> I would like to know if the revision walking API works as one would
> expect with a calling sequence like the following:
>
> - init_revisions
> - add_pending_object/setup_revisions
> - prepare_revision_walk
> - get_revision (repeated)
> - reset_revision_walk (I guess)
> - add_pending_object
> - prepare_revision_walk
> - get_revision (repeated)
>
> That is, do a first revision walk based on a given rev_info, then reuse that
> rev_info with additional commit objects (in my case, I want to add more
> UNINTERESTING commits) and redo a revision walk based on the modified
> rev_info (so, avoid reinitializing a rev_info and filling it from
> scratch again with the additional UNINTERESTING commits).
>
> I guess I could try and see if that works, but I'd rather have an
> informed answer than to derive my own from the fact my testcase would
> happen to work by chance.

I am not sure what you describe above would work, but something like
what is done in bisect.c should work, see check_ancestors() and
bisect_next_all(). It might not be the most efficient solution though,
so I am interested if you find something more efficient.

Best,
Christian.
