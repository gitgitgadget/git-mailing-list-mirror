From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-smart-http reject push
Date: Thu, 31 May 2012 13:52:23 -0700
Message-ID: <CAJo=hJvH7YuCyNU9rGRQUQy3ccE+v3o99=MkX-k3dHGkTZA1nA@mail.gmail.com>
References: <4FC7D6CE.30802@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Tajti_=C1kos?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Thu May 31 22:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaCMT-0008LS-Ck
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 22:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758254Ab2EaUwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 16:52:44 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36189 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142Ab2EaUwn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 16:52:43 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1970850pbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vJZB8Lj1m5qhAkK3ity3t9/PvYLoQGlOXNH0XtNjns0=;
        b=cWVRLxuJ9PTR9osuSstociV1SD8F3bR4HMOEaOLzfMeQpAA8zF4+YdWnpWHpMRPav3
         Ce7G8RVWxcsGT5cUsCbDzA2sKCRqLxQps28Gz/o5PAIwaJnw/O6DyYlnMLCX4elO2Q94
         I74KugMKD8mhTtyTiCl+X+ZApwEChwwEv4GSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=vJZB8Lj1m5qhAkK3ity3t9/PvYLoQGlOXNH0XtNjns0=;
        b=nILT+nVGUcbppt4E6ZMuVu4zovB62bByaQOiDCLF3na7jh5n2+WNq8pc3xv0oWRGUW
         +WBpuEBA41jaKZEoFXFDXcSCQTWOOZ+JYQ99B+RPJlStvQK7LbxoHbq+aaZ5BSGhrAIl
         T/G6ywIwn/WNsYK8sWDU0GquKLyfTcCUjNnc86MSrVjpWivCYK7OhQMMeMmM95Ns7ktd
         NN8ziQiwAVnCvAHYt3PZJghSa2qNE2CT+MR5O4I9m1ghI6nt1iTPoyrFd2Ph1E7bKID1
         6NWRQhBjTJrDhdzbFu8gj+P4a6YM4O5fiwKHTz9iot3TX4D5qoyINB2Lc7HwfnPRZvQV
         5qzg==
Received: by 10.68.202.136 with SMTP id ki8mr3850141pbc.65.1338497563258; Thu,
 31 May 2012 13:52:43 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Thu, 31 May 2012 13:52:23 -0700 (PDT)
In-Reply-To: <4FC7D6CE.30802@intland.com>
X-Gm-Message-State: ALoCoQnKpnWp5AJBx+VWvtY5nT9y/ZsFuaFeXfATeZaU9LUN/3IXkRVCMsJ8d2Qr/Csw61MFYtzx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198948>

On Thu, May 31, 2012 at 1:38 PM, Tajti =C1kos <akos.tajti@intland.com> =
wrote:
> we wrote a servlet that is basically a proxy for git-http-backend. We=
 want
> to control who can create a new branch. Is there a way to reject a pu=
sh that
> would create a new branch (without using hooks)?

Not easily. Is the servlet in Java? You might want to consider just
embedding JGit[1] and using that. JGit will let your servlet install
an implementation of its PreReceiveHook interface where you can
inspect the parsed protocol data, decide what to do, and reject it or
allow it through.

To reject before it makes it to git-http-backend you need to parse the
incoming data stream, decode the commands, and then forward the
unparsed stream to git-http-backend. If you are in Java you might be
able to reuse some of the JGit classes to help you parse the protocol.
Maybe. Those classes weren't really built to be used on their own.

[1] http://www.eclipse.org/jgit/
