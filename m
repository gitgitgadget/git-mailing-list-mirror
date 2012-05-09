From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Large repo and pack.packsizelimit
Date: Wed, 9 May 2012 17:50:55 +0700
Message-ID: <CACsJy8BhSn+PB5tXME-w_cq4DVd2BULNRNLV-vk1_6yWKy+fNg@mail.gmail.com>
References: <37267143.413194.1336046278583.JavaMail.ngmail@webmail07.arcor-online.net>
 <20120508203137.GA15707@sigill.intra.peff.net> <alpine.LFD.2.02.1205081709010.21030@xanadu.home>
 <20120508212012.GA20044@sigill.intra.peff.net> <alpine.LFD.2.02.1205081751011.21030@xanadu.home>
 <loom.20120509T113505-740@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Wed May 09 12:51:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS4UW-00045J-Cc
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 12:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab2EIKv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 06:51:28 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41826 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab2EIKv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 06:51:27 -0400
Received: by wgbdr13 with SMTP id dr13so135611wgb.1
        for <git@vger.kernel.org>; Wed, 09 May 2012 03:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xu+xmi05HfSu15b44e78fo767QEtLeKIt8+dWO3w6/0=;
        b=xytZI9moh6YX8Hbuqu4SxJds9vfYQHxBw4em6hPfdiH0DFRu7+JzWf84TkvcvxZPkv
         1TuNs5ohnzXM7HGZsf4pprRGEStj/qB0wzq9ZWoP346DO6V7XFbOHAh2+Mh/+Lm6F5bj
         lIqiExs4UQBpmfl+VPzMmFTqMkydRLbdMhDbNj5Wz0vNLk/l1SISd38negmR59i/2mdI
         qUpM5I0Q9Sa+T23yjqN+PLGa7IUpbGvuWqU/k7WM+P1MaoBmmZDZQyJ8GJTugr92fiKo
         MUpkx34GIq8oRuzn8ARQtFoB+GBwcTuKk6515QTRpEpfDWy74e833yWzoxHq9kUml9O5
         UQaw==
Received: by 10.180.81.166 with SMTP id b6mr5870461wiy.0.1336560686329; Wed,
 09 May 2012 03:51:26 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Wed, 9 May 2012 03:50:55 -0700 (PDT)
In-Reply-To: <loom.20120509T113505-740@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197466>

On Wed, May 9, 2012 at 4:36 PM, Thomas <th.acker66@arcor.de> wrote:
> To be exact I did the clone locally on the same machine and so the clone itself
> worked
> but I got the OOM during the first fetch. I "fixed" this by setting
> transfer.unpacklimit=100000
> which caused only loose objects to be transfered.
> So in this case I think the OOM was on the remote side. But there is another OOM
> if I try to repack locally.
> It seems to me that neither pack-objects nor index-pack respekt
> pack.packsizelimit and always
> try to pack all objects to be transferred resp. all local loose objects in one
> pack.
> I could live wth the transfer.unpacklimit=100000 but the local OOM stops me from
> using the cloned repo.

I have some patches to make index-pack work better with large blobs
but they're not ready yet. I think pack-objects works fine with large
blobs as long as they are all in packs. Are there any loose objects on
the source repo?

It's strange that you chose "256mb" as the upper limit for small
objects in your first mail. Do you have a lot of >=10mb files? By
default, files smaller than 512mb will be put in memory for delta. A
lot of big (but smaller than 512mb) files can quickly consume all
memory. If it's the case, maybe you can lower core.bigFileThreshold

Also maybe try remove the 1.2GB file from the source repo and see if
it works better. That could give us some hints where the problem is.
-- 
Duy
