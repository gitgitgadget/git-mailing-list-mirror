From: Shawn Pearce <spearce@spearce.org>
Subject: Re: In tree object, Must the
Date: Mon, 9 Apr 2012 14:03:06 -0700
Message-ID: <CAJo=hJsh6DyUA3gV1Yiho5bwCdi99aMkBHepy-VVnFwJPeWYOg@mail.gmail.com>
References: <CAFT+Tg-+s5=pFNwY7ZMxem4z6YHu53kyOs0B_rkmphq=mEtpTg@mail.gmail.com>
 <7vobr0wyml.fsf@alter.siamese.dyndns.org> <CAJo=hJv==GrxLH6U9MAwckcEXiYtKeMEpEMNVTJLcSKro2QV_w@mail.gmail.com>
 <7vhawsvffn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: semtlenori@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 23:03:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHLkM-000584-JC
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 23:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757413Ab2DIVD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 17:03:29 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:41722 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab2DIVD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 17:03:28 -0400
Received: by dake40 with SMTP id e40so5704821dak.11
        for <git@vger.kernel.org>; Mon, 09 Apr 2012 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PkFZ4UCF08WdEft7pLBlBt0xF4JdQZZo/ey0LfvCmvE=;
        b=V+xftGxTANbGdAZjO4AWiwxypSOxs7ueNo1RBEPE3SjjVJfhOI9n9tNjpHMwNnvcHB
         7iJL1EfB+7LYgYHsxlaRRZ1ly1YpB70GFKvXJl55Gsitu3grntJboUthKFHVIXg5pGnG
         puSEaxc+plpVW0SJmt/pEfpo7DxSJg4sHIj4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=PkFZ4UCF08WdEft7pLBlBt0xF4JdQZZo/ey0LfvCmvE=;
        b=H6oXRFBDeIA0sF6JeleD2C6r4hrXcXdr5TWLWTCcNBOq/I83TLsQSsJow4FHaMrUUg
         8vspfITztAWG3QY3BQ1LHHW4UElkuoLYgZHbKIJRbadQmXxOgZlEMeY8o2x/8Aa6DO6R
         ym8iUc5Da0NJmf9ZHOT+a87fz1NyP0W2D43RNkwMP8/RRizX8LvsQnP4ajDMK99GURfv
         RwjnHBC2k4n+q7XxbxxweMbifdfT6SUESI9YZ8X/9wWsDawxuLMg7rvq1WcOrRYCC/yG
         hem7RYteZgeblDJp7gYMZug6WXCJ3tKZn2Rgx3ndmGLzC2fWjvjMlEPSaMqXqMwL7wd6
         /JqQ==
Received: by 10.68.222.7 with SMTP id qi7mr1701883pbc.2.1334005407863; Mon, 09
 Apr 2012 14:03:27 -0700 (PDT)
Received: by 10.68.55.68 with HTTP; Mon, 9 Apr 2012 14:03:06 -0700 (PDT)
In-Reply-To: <7vhawsvffn.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQnVE97x6EUyWsSg9+CLrKGUSZ4ncJrAxyaGvKLBtZpAdKWBSg/BEc46xoR5BqOBax8DjwmV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195039>

On Mon, Apr 9, 2012 at 13:05, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> ... And that niggly bit about subtrees sorting as
>> though their names end in '/' even though they don't really matters.
>
> Yeah, in older and buggier unpack-trees it might have made the code
> simpler while walking the index and the tree in parallel, but when we have
> to deal with D/F conflicts, we have to find a entry with matching name
> anyway, so it turned out not to be a win at all.

JGit still waks the trees in parallel. We handle the D/F conflict
stuff using a small amount of look-ahead and sometimes rescan back
from the start. In practice that works out really well, it catches
most forms of D/F conflict with little overhead, and almost no
overhead when there is no D/F conflict, which is common.
