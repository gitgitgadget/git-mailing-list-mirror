From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 8 Jun 2010 17:44:25 -0300
Message-ID: <AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>
	<AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>
	<20100608053507.GB15156@coredump.intra.peff.net>
	<AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>
	<4C0E5103.7030501@viscovery.net>
	<AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
	<4C0E6810.3070301@viscovery.net>
	<AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
	<4C0E932B.3010702@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 22:44:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5ey-0005te-9d
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297Ab0FHUo1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 16:44:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51553 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab0FHUo1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 16:44:27 -0400
Received: by bwz11 with SMTP id 11so1303925bwz.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RKDtaATTBAaGvyrlrMOwndv1DZ3kIY5Mkw0oHCQFjDc=;
        b=fDoNbBEFFfqjEVotlyiuSPqdGymwuWM9Z4B7gJU92vvEmbyavGsu1JHr7RNSJxb3qa
         4NFNMEzwJnhexexyycwo82XjkCcFTGQ1E/8PRGGdzjfdZysx8Uj//SYrwtC+WV3h/Boh
         +URjOepdMw8G/FMHeyJtixfiB+ryLZ7CMcs60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uxV9sMpkyBo12cMzL432+fnik7WDQWSO6ZKUNHCuR3XK12zrTgvKG14pvwR0PeWIey
         QZRgUQVFMGtTwVYHY5Axaf0bLMeVd68pdx2gJgGZwmKS2/Dsnmx1ZePQaVtMSLKNkwJH
         ZLz3ufL0nepnvqSwjMXvGbNgwugohDGYSiy3I=
Received: by 10.204.74.2 with SMTP id s2mr8219130bkj.28.1276029865292; Tue, 08 
	Jun 2010 13:44:25 -0700 (PDT)
Received: by 10.204.46.80 with HTTP; Tue, 8 Jun 2010 13:44:25 -0700 (PDT)
In-Reply-To: <4C0E932B.3010702@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148712>

On Tue, Jun 8, 2010 at 3:59 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Your repository has only 2 commits and its git log output is less tha=
n 1kB,
> i.e., sufficiently small to fit in a pipe's buffer.
>
> git log calls start_command to fork() the pager. The OS's scheduler d=
oes not
> run the newly forked process immediately; rather, git log goes on wit=
h its
> own business, writing output to the pipe that connects to the pager. =
Because
> your repository is so small, git log never has to wait that the pager=
 drains
> the pipe. git log finally reaches exit(0). At this time, an atexit() =
handler
> (wait_for_pager()) finally calls finish_command() to wait for the pag=
er.
>
> This is the first time that the forked child process can run. Only no=
w it
> turns out that the pager cannot be run. The child process closes the =
pipe
> and exits with an error, but it is too late: wait_for_pager() drops t=
he
> error return code of finish_command() to the floor. The parent proces=
s (git
> log) can complete with the exit code that it was given earlier, 0.
>
> Repeat your experiment with ./git log in git.git itself to see the
> difference.
>
> -- Hannes
>

Capisco & touch=E9, with much more than 1k of info, git show ends with =
a
"Broken Pipe"... seems hard to detect for little, recently started
projects since I added more than 60k of scripts and I need to do 'git
show' to understand that the problem is a broken pipe.

Now, let me think about it... do we need the pager_preexec function? I
mean... it works fine without it, and the function is there because of
a faulty 'less'.

My problem is obvioulsly solved by adding PAGER=3Dmore in my default
environment, but I think this could be a litle bit embarrassing for a
new user, mostly in environments such this AIX :P

Cheers,
Dario
