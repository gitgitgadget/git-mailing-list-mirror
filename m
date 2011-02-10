From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Advices to imlement update hook
Date: Thu, 10 Feb 2011 14:24:49 +0100
Message-ID: <AANLkTin0p77wd3dOdF6h3+Gw7vphj=CTvn0UUtRwf5un@mail.gmail.com>
References: <AANLkTimdsCgNBAnJmnzGj3M3Q4RPb==fiWu1+ZQhWenO@mail.gmail.com>
	<4D52C2FA.2030103@viscovery.net>
	<4D52C403.30501@viscovery.net>
	<AANLkTik=Xw3b1i-AranJtfngOsfLvEDSzrMq3jKTy-Yy@mail.gmail.com>
	<20110209170535.GA5254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 10 14:24:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnWVz-0000aT-7Y
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 14:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070Ab1BJNYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Feb 2011 08:24:51 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45902 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab1BJNYu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Feb 2011 08:24:50 -0500
Received: by pwj3 with SMTP id 3so348533pwj.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 05:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dNcEs2RPUAyUezERmSv7SruEmYFjfIb1yXUOSgvcln0=;
        b=Xp9+tmZC1ZWZzR1vkmPgrlRWcNpb8+TwQpCVab6lmKHMlMSplzRcNPFQLOin+x3C3k
         XJy2Hnl2rwzFd8uTvDH0sQkJOcI7sKbu93rOKjimmP+Co9HbMPQt5M+kfNMdqIqe6Qzw
         8VpIZbgLWkLeeVkCXr94W7EPG05eFSFqkU9ek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZqWlkjJV/hYbpa/++QrAk/fdHrC3igDUYHs1OxipYv8ETuj2oXI/Fw5DsUzS6B9ZGn
         Z6efAgmTbQvL8LOKdjErqoEN/pAw1Vku5IY8yU6xcbLjl0hqg2pW0Uh1sYlh62kIRXlQ
         l+fvc6bhBBzOdUng20UsUdJtLxN/4Z23NZ4ek=
Received: by 10.142.52.5 with SMTP id z5mr8488143wfz.239.1297344289876; Thu,
 10 Feb 2011 05:24:49 -0800 (PST)
Received: by 10.142.44.3 with HTTP; Thu, 10 Feb 2011 05:24:49 -0800 (PST)
In-Reply-To: <20110209170535.GA5254@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166482>

Hello,

On Wed, Feb 9, 2011 at 6:05 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 09, 2011 at 05:51:24PM +0100, Francis Moreau wrote:
>
>> >>> =A0 =A0git diff-tree <oldref> <newref> -- ^b || exit 1
>> >>>
>> >>> but it doesn't work.
>> >>
>> >> =A0 git diff-tree --quiet <oldref> <newref> -- b
>> >
>> > should do it; it sets the exit code.
>>
>> but does that work if a commit modify b/ and another directory ?
>
> No, it just looks for commits that modified b. There is currently no =
way
> to specify a path to say "commit that did not modify b". You need to
> check the output of:
>
> =A0git rev-list | git diff-tree --stdin -m --name-only
>
> which should list all paths modified by all commits. And then you can
> either blacklist or whitelist as appropriate (note that the names can=
 be
> quoted; you might want to look at the "-z" option and do your
> list-checking in perl).
>
>> > But don't you also want to inspect all commits between oldref and =
newref?
>>
>> Yes I want to inspect all commits in the range.
>
> see above.
>
>> > Someone could have modified the directory, and then reverted the
>> > modification in a later commit. If these commits arrive in a singl=
e push,
>> > the above code wouldn't notice this.
>>
>> I agree but I thought that git diff-tree would list all changes made
>> between the 2 refs.
>
> Between the two endpoints. It won't even look at the commits in the
> middle, so as long as a later middle commit reverts the change of an
> earlier middle commit, the endpoints won't be affected.

Oh, I see. I undestand why the git-rev-list is needed now.

Thanks for your help !
--=20
=46rancis
