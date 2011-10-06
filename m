From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH WIP 0/3] git log --exclude
Date: Fri, 7 Oct 2011 08:47:45 +1100
Message-ID: <CACsJy8C9O-dGo=Y6HfQ5iYtsD8SMuiWB8y5ab=C+vT4Z01F+ag@mail.gmail.com>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
 <7vhb3n8ie9.fsf@alter.siamese.dyndns.org> <20111006143441.GA21558@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 23:48:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBvnk-0002d4-Iv
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 23:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759313Ab1JFVsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 17:48:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41769 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759260Ab1JFVsR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 17:48:17 -0400
Received: by bkbzt4 with SMTP id zt4so3999268bkb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=88EsMIiHf+AIs4uVv1APC4RPUTG2oLrJKGrfDFY+btU=;
        b=fb283UJlBBAo8L+44Lz4cBbAPn8LAD+7Z8fdkG8qpHvZelF8JIaf3OsxrhrHfvxytv
         AV0Jvll9a1GrYbwCQWpLPQ+tK6Gv6anbJ3/XBHIBUjcXohWuw6FsqT5BnI35xI6C8esk
         lDCl2Vsp9GPGgQNs+iqxfaJnQI4ptWIUQX2EM=
Received: by 10.204.137.72 with SMTP id v8mr814068bkt.43.1317937695112; Thu,
 06 Oct 2011 14:48:15 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Thu, 6 Oct 2011 14:47:45 -0700 (PDT)
In-Reply-To: <20111006143441.GA21558@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183039>

2011/10/7 Jeff King <peff@peff.net>:
> I'm really just a bystander on this topic, and haven't given it too much
> thought. But one stumbling block I see for narrow clone is how narrow
> repositories will interact with object transfer from other repositories.
>
> For example, if I have a narrow git.git that omits Documentation, and I
> do a "git fetch" from a non-narrow repository, then how do we tell the
> non-narrow remote that we don't have blobs in Documentation, and that
> they should not be used as delta bases for any objects that are sent?

Pretty much how shallow cloned repos interacts. In shallow clone we
send depth info. In narrow clone, we send width info, in terms of
(restricted) pathspec. With pathspec (possibly plus exclude rules but
this possibility is getting smaller), I can express "fetch this
directory only", or "fetch this directory, but not this subdirectory
(because I already have it)".

We can prohibit certain use cases at client side just like shallow clone.

> The current protocol relies on certain repository properties on the
> remote end that narrow clone will violate. I don't see a way around that
> without a protocol extension to communicate the narrowness. What will
> that extension look like?

Something like this

http://thread.gmane.org/gmane.comp.version-control.git/155427/focus=155613
-- 
Duy
