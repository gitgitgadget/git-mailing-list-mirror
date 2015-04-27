From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about how git determines the minimum packfile for a push.
Date: Sun, 26 Apr 2015 21:39:32 -0700
Message-ID: <CAPc5daV2GmtaknNhrBc7ofMZPsKPUn81SHBVPNdHHTXJs8ubdQ@mail.gmail.com>
References: <E51394554A503C4E852F9BEE46B03E8D01E4E784@TI-ODIN.tasernet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Brad Litterell <brad@evidence.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 06:40:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymapr-0002Jb-2Q
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 06:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbbD0Ejy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 00:39:54 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36394 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbbD0Ejx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 00:39:53 -0400
Received: by oift201 with SMTP id t201so80047658oif.3
        for <git@vger.kernel.org>; Sun, 26 Apr 2015 21:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=AxvhR2K3IOt7n5m1qJKwzluB9Fcx8zpwhVdljR2Mxdk=;
        b=Vja/nv/U5kxFcCZlxfUWWt2zjgh3X3yoCkMzWT/mWoVHaDOFLS3TBrbSlvs3KKIFBi
         w4LM7fLIDSMZhIzj4BxrIIprHuKDbvu8aGWj/8IVwwSqCjTSHVlREdAWw+t9R8Zs2lLC
         3SW/AVq/Wu52Cy2KTW9PHOl1sx9gXrY7tvk2r0yRvbFOCmHjMY3bj/a4Da1AcdApSydE
         cHZHY1zzJqvuqPgxOtNAkNQcHwwD2Tvxna20Fx5VNvOn03cnsVO2wK/BMGg3uL9TWch5
         kJWua4VE8I1mTHbDf7DE0oULIfanTNdgrH65VHxlUWgc3YVYBPh4OZbH37Q9XR45AH+t
         jnUA==
X-Received: by 10.182.165.69 with SMTP id yw5mr8142347obb.5.1430109592798;
 Sun, 26 Apr 2015 21:39:52 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Sun, 26 Apr 2015 21:39:32 -0700 (PDT)
In-Reply-To: <E51394554A503C4E852F9BEE46B03E8D01E4E784@TI-ODIN.tasernet.com>
X-Google-Sender-Auth: PufEi2Unts1aiEgJL7AJC9erRB4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267844>

On Sun, Apr 26, 2015 at 5:41 PM, Brad Litterell <brad@evidence.com> wrote:
>
> Is it possible git is not computing the delta correctly?
> Or does git only look at the top-level commit objects to figure out what to
> include in the push packfile?

We walk the commit graph backwards to discover the common ancestries to
minimize the network cost when fetching, but I do not think the
reverse direction
has such smart in the protocol.

If you fetch (not "pull") first to remote tracking branches and then push, that
probably will reduce the transfer, as the side that pushes is the only one that
decides what objects are sent in "git push -> git receive-pack" direction.
