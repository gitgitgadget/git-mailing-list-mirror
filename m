From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-clone and unreliable links?
Date: Wed, 7 Nov 2012 07:54:53 -0800
Message-ID: <CAJo=hJtJPnQFjvz8AAQjf5Rze-_99vF_tYi9CqJ7fiW245Dv1w@mail.gmail.com>
References: <20121107153519.GI28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Josef Wolf <jw@raven.inka.de>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:55:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TW7yX-0001GZ-Mf
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 16:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab2KGPzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 10:55:16 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:61674 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab2KGPzO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 10:55:14 -0500
Received: by mail-qa0-f46.google.com with SMTP id n12so551289qat.19
        for <git@vger.kernel.org>; Wed, 07 Nov 2012 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=TdvCs36o0djASycmbMv9N2dp6VaGxWu2bLVvpb8ftVY=;
        b=Cg/WCa0x5Q+LIjzdyPF3WI0wgJrTlMtH8JStKhgdiKXvkcj0n5hzoNuUKPKCRYk5FS
         uCapuoRCEhu8T1Xi+DgWYfzK+jWwWNsZmXmoPacmHn3P3X7a0svdnpBMnj3We+Pgwf89
         QIgbcQTkWXM5zL4ebfgTyUZUKzKQ54XOcgdBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:x-gm-message-state;
        bh=TdvCs36o0djASycmbMv9N2dp6VaGxWu2bLVvpb8ftVY=;
        b=eKrvcixi/a2y2pulH+ajRd3z6BerI7kFPqxCkxqALfNIWd/AsOt8WVMSZ2IxXFngqu
         x/1QUc6UrhJapYNAztzyyG8j77syPR/0HyfYlOnaqDd9WLGCBm/n3kIr7HiPqXsMuqkj
         53pi/jpz+9gu++UkkfSJH3ILrxgEB2bCXA/x960hSIx57HgymGJMg4SSapXh5f34+KQN
         9KAGvfisU2SSiVPT+QETFDUHy80aBD0V2AgA23lWaQqVUAo+YpKrpxOC0xpAUaZ0WeBW
         KpK9bwfSBprad57bTietLQj1nJGRdySlFbdWew/JrVl2XeHUr3aRbcEfoOsX76PTnmK7
         6TpQ==
Received: by 10.224.185.79 with SMTP id cn15mr7539944qab.14.1352303713976;
 Wed, 07 Nov 2012 07:55:13 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Wed, 7 Nov 2012 07:54:53 -0800 (PST)
In-Reply-To: <20121107153519.GI28437@raven.wolf.lan>
X-Gm-Message-State: ALoCoQmMqCbc9I9Vek02ZT/JT/BSl1I44BH4ufrcQoV/H08mFBle+ouMllxzLYcruD9xvFyGsy6+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209135>

On Wed, Nov 7, 2012 at 7:35 AM, Josef Wolf <jw@raven.inka.de> wrote:
> When using git-clone over an unreliable link (say, UMTS) and the network goes
> down, git-clone deletes everything what was downloaded. When the network goes
> up again and you restart git-clone, it has to start over from the
> beginning. Then, eventually, the network goes down again, and everything is
> deleted again.
>
> Is there a way to omit the deleting step, so the second invocation would start
> where the first invocation was interrupted?

No, because a clone is not resumable.

The best way to obtain a repository over an unstable link is to ask
the repository owner to make a bundle file with `git bundle create
--heads --tags` and serve the file using standard HTTP or rsync, which
are resumable protocols. After you download the file, you can clone or
fetch from the bundle to initialize your local repository, and then
run git fetch to incrementally update to anything that is more recent
than the bundle's creation.
