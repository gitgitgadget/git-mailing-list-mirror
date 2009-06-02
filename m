From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: gitosis question: identifying/logging remote user
Date: Tue, 2 Jun 2009 18:49:22 +0530
Message-ID: <2e24e5b90906020619o1bef150k43eba2870ff4fc4e@mail.gmail.com>
References: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com>
	 <robbat2-20090602T062332-128740789Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, tv@eagain.net
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 15:19:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBTuA-0000WP-6x
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 15:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbZFBNTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2009 09:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbZFBNTX
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 09:19:23 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:13927 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbZFBNTW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 09:19:22 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1699140wah.21
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cy1NAEauf1GmKQPRnIkBfk7feQER/e7lsvyybTkS4kA=;
        b=HYlnWxBY2YwsMBOsgihoJ6lFvke5aUcLVOdjjRSsc74LxBjcg56eK3L0uiNUF0+W8R
         lQ1RvpvHrOJqlmq7NMeUdzBTg6fuUaYk7oLo8IwjDG2NDCG70MrpZXeDsX6rOp/WFd1V
         K3ENd35NroowNzMh7P/fvG+0NXMvQsvzKJKc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZThV+5saGBFL1+4Dy2xDl0te6NX9hevY+wZDKq99kR9Z4QVOKghick9bYIjZ9zRU0f
         v6w537dRBUiXP/LPhkEttXqVnZ4avrtke+Hm+VgtAtYIeL3WYuHujdPDnRYQYhmS6CU0
         U4jXJRR91fIpUgPltJf1Ymfa6MFvk6VfS/RtQ=
Received: by 10.115.46.10 with SMTP id y10mr6117217waj.121.1243948763854; Tue, 
	02 Jun 2009 06:19:23 -0700 (PDT)
In-Reply-To: <robbat2-20090602T062332-128740789Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120509>

On Tue, Jun 2, 2009 at 12:01 PM, Robin H. Johnson <robbat2@gentoo.org> =
wrote:
> On Tue, Jun 02, 2009 at 09:32:40AM +0530, Sitaram Chamarty wrote:
>> I want to be able to log the information that the post-receive hook
>> receives, but I *also* want, along with that, the name of the pubkey
>> that was used in this particular "push".
> I've got a partial patch that I never finished for using this with th=
e
> gitosis-gentoo fork that powers git.overlays.gentoo.org. It needs
> re-implementation from scratch, but here's the design notes:
> 1. Use the username to open the file in keydir again.

This is the directory that contains all the *.pub files, so ok...

> 2. At the top, look for RFC822 headers with a leading "# " as padding=
:
> =A0 Examples from my own patch:
> =A0 # Full-Name: "Robin H. Johnson (robbat2)" <robbat2@gentoo.org>
> =A0 # cia-vc-username: robbat2

Hmmm... is this a significantly different gitosis?  The files in my
keydir mostly contain just one line (some have two, for people who
work from different machines), looking like this:

ssh-rsa [long series of base64 type characters]=3D=3D some.one@company.=
com

> =A0 The headers are followed by a blank line then further text is fre=
e-form
> =A0 and not parsed. Continuation lines are NOT supported.
> 3. The header field names are transformed to enviornoment variable na=
mes
> =A0 as follows:
> =A0 - y/[[:lower:]]/[[:upper:]]/g
> =A0 - s/-/_/g
> 4. Export the environment variables, named per above, with the full
> =A0 content of the rest of the line.
>
> (We need to export the CIA.vc data, and also send off a commit mail).

Nope, I'm completely lost.  Perhaps I failed miserably in explaining
what I want... !

----------

I'm thinking along the lines of a simple change to this:

    TEMPLATE=3D('command=3D"gitosis-serve %(user)s",no-port-forwarding,=
'
              +'no-X11-forwarding,no-agent-forwarding,no-pty %(key)s')

(in function generateAuthorizedKeys of gitosis/ssh.py) to generate an
additional ssh directive in the authorized_keys file:

    environment=3D"REMOTEUSER=3D%(user)s"

I haven't tested it yet, but I'm expecting that this will pass on the
name of the user (like "sitaram" in my case) as an env var so that I
can do whatever I want with it in the hooks.

Thanks,

Sitaram
