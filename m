From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git branch -a now reports 'remotes/foo' rather than 'foo'?
Date: Mon, 11 May 2009 01:26:02 -0400
Message-ID: <76718490905102226w4cda3a75l5062e1956129dc87@mail.gmail.com>
References: <87skjcpeno.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Pittman <daniel@rimspace.net>
X-From: git-owner@vger.kernel.org Mon May 11 07:26:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3O1k-000527-Us
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 07:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbZEKF0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 01:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbZEKF0E
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 01:26:04 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:35372 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbZEKF0B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 01:26:01 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1561382yxj.1
        for <git@vger.kernel.org>; Sun, 10 May 2009 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vys7IYwNZbWga2cpmWoTVlDrzGFxn7MuqG5oKKFrV0k=;
        b=dCycMW3TnhXMwCIvmYhLKRN05+S8etj3ZM8d26W0+od4RdpvKTR3WQfs9gAE5VO8Wf
         vQv0G9LGPXcfnXqk7Vxpi2tnatvNrn5zyUSUwSES9uziyO+k50KXJFdjB/VQx9HRWwFk
         RQRjq0KDE6pptAMUoMSEV7xWfl9J9wa57lMyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OosqXxbi+/t5+/E67r609knmFAxhYswCFb+SrQ/+E4EEpgPbxiGdD92qLePSJjCKwj
         dGfNfg1/h6e01QhdF2bEApPV0JAixz8mu4LPorRixDaDflUnDb7joS5zbvnS1wT4Tj0Q
         yMBZGwwAEe5YBCf90oztGYuGcJGxN+Ccfd3I0=
Received: by 10.151.150.13 with SMTP id c13mr12397933ybo.94.1242019562233; 
	Sun, 10 May 2009 22:26:02 -0700 (PDT)
In-Reply-To: <87skjcpeno.fsf@rimspace.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118774>

On Sun, May 10, 2009 at 10:16 PM, Daniel Pittman <daniel@rimspace.net> =
wrote:
> The front-end I am using looks for a 'trunk' branch by name in the
> output of 'git branch -a', which historically worked. =C2=A0Now, thou=
gh, it
> shows that fully qualified.
>
> Looking at the release notes it looks like this was a deliberate chan=
ge,
> from this entry:
>
> * "git-branch -r" shows HEAD symref that points at a remote branch in
> =C2=A0interest of each tracked remote repository.
>
> However, that isn't unambiguously clear about the change, and is pret=
ty
> light on the "why" parts. =C2=A0Worse, the only discussion I can find=
 about
> the change suggests that this was noticed, and there wasn't real clar=
ity
> about the background.
>
> (See Jeff King under "[PATCH 1/2] add basic branch display tests" at =
[1]
> =C2=A0for the details.)
>
>
> I confess, to me, that having 'git branch -a' and 'git branch -r' emi=
t
> different values doesn't make much sense, but I suppose the upstream
> code can be adapted.
>
> I wanted to confirm that this was a deliberate change before I went t=
o
> the trouble or rewriting the front-end code however.

Yes, the change was deliberate. Commit 209d336 (builtin-branch:
improve output when displaying remote branches, 2009-02-13) has more
details:

    When displaying local and remote branches, prefix the remote branch
    names with "remotes/" to make the remote branches clear from the lo=
cal
    branches. If displaying only the remote branches, the prefix is not
    shown since it would be redundant.

When you fix your front-end, I suggest you stop parsing git branch's
output. It is a so-called porcelain command, as opposed to a  plumbing
command, and so its output is subject to change. You probably want to
use the for-each-ref command instead.

j.
