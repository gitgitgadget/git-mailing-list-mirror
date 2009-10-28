From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add support for p4merge
Date: Wed, 28 Oct 2009 02:52:28 -0700
Message-ID: <76718490910280252n7a2c41baj5e220c784f1f3617@mail.gmail.com>
References: <1256721087-72534-1-git-send-email-jaysoffian@gmail.com>
	 <76718490910280221u4e1d3e78me7f9b0b45f590e56@mail.gmail.com>
	 <20091028093655.GC90780@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 10:53:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N35Dc-0006oV-R9
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 10:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbZJ1Jw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 05:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbZJ1Jw0
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 05:52:26 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:44617 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbZJ1JwY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 05:52:24 -0400
Received: by iwn10 with SMTP id 10so457265iwn.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hx7EsgAeUBmCtaTJL67DQPb0iHXf4LTQB35Ebr+PKKo=;
        b=E732tWYYHEdjw8F/iM4aTf018JRMkVOrwWZyexbK1HK9hWjUXVfqorziloNcR818L2
         ggvdXZBE/18mu4tsdCqVnQqUAJWgOQDNy6RXuROeDH5esvNvLwAHU6sVu4i045YJb+nY
         rrTa5mqRuy64JGe2/2B80wPWNum8keSdXvSbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L9t8b3dxQmsz/Ubb9aPGaW5eJ6Tfs3o3ZxSFQ5bRTXEpV7O78koibOXC/KMFb6iDrR
         3hVyQFzQnamEDzXWNhGNSU6IK3TcC7nj2W/8ZZR2lRdy8y54tDVdR5y4+5Jn4Ok/QGQx
         cULwbaU8wqoxGQqDUKRPCmV0HVc2rZmI7zh1U=
Received: by 10.231.126.104 with SMTP id b40mr757281ibs.30.1256723548892; Wed, 
	28 Oct 2009 02:52:28 -0700 (PDT)
In-Reply-To: <20091028093655.GC90780@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131443>

On Wed, Oct 28, 2009 at 2:36 AM, David Aguilar <davvid@gmail.com> wrote=
:
> I tested on 10.5, so there's definitely some difference in
> behavior since difftool.p4merge.path is all that was needed here
> (with an absolute path as I mentioned).

There are two issues here:

1) Is it necessary to use launchp4merge, or is calling p4merge directly=
 okay:

Calling p4merge directly works, but the advantage of calling
launchp4merge instead is that it works a little more elegantly:

- If p4merge is already running, using launchp4merge opens a new
window inside the running instance, instead of  launching p4merge
anew.

- After performing the merge, it is sufficient to just close the merge
window, as opposed to having to quit the p4merge application (which
you have to do if you run p4merge directly).

2) Does p4merge/launchp4merge require absolute paths for its arguments.

I found that it does. So I wonder whether possibly you tested with
difftool, which uses absolute arguments, as opposed to mergetool,
which uses relative arguments. You'd only see the issue with
mergetool.

> We've stayed away from hard-coding any platform-specific paths
> in mergetool--lib in the past. =C2=A0It's a practicality thing --
> trying to guess all of the possible installation locations is
> simply untenable.
>
> Here's an old thread where we talked about this in the context
> of ecmerge:
>
> http://thread.gmane.org/gmane.comp.version-control.git/118125/focus=3D=
118182
>
> Let me know what you think.

Disagree with the conclusion of that thread. On Linux, PATH is very
likely to have the merge/diff binary in it. On OS X, this is highly
unlikely, but there are two very common/likely locations we can look,
/Applications and $HOME/Applications.

j.
