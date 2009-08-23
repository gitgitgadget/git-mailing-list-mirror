From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: hitting home directory's parent
Date: Sun, 23 Aug 2009 11:07:39 +0700
Message-ID: <fcaeb9bf0908222107i6d999335r998a304aaa3cd405@mail.gmail.com>
References: <20090821200503.GA19660@panix.com> <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com> 
	<20090822150542.GA29507@panix.com> <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com> 
	<20090822181607.GA25823@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Convissor <danielc@analysisandsolutions.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 23 06:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf4UB-0002VH-HK
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 06:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbZHWEH6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2009 00:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbZHWEH6
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 00:07:58 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:38370 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbZHWEH6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 00:07:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so2275610and.1
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 21:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WgwtuyQcbv87OTMGqs6V2plPmSexBERkcI8oivZcyLw=;
        b=W91UKWvhF5ADd9JIIozhdSbZAFKgmBgDmhBiWTHVWzgPgvZip3kyIB+LjnFyWnxPtJ
         jWe9GII2C05ccicMvplE7ZVoWGR3kTFWOEH6UF3YHBeIh5C5BsP3K9Ul80elWBIL+ejX
         YvI2B1XVZ2d5q/l+BOBr5w2sRdTGU52Tn9ON4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=W6/jJGGc2Ckfn0l0zbGtvdrXbKTWQCHrfXMmO6Lri/c3Eg+HjVa/t+01QlWG2/nFEF
         x3QjoCSz/IIqFaXuR4GAWFQgUWUy/95FVhohcpvVTP6taTondI0MTq/uy774keiLCCNt
         iH4LWTHEiRYUUzk1bYcFnpbgezCzGYZrIIhMc=
Received: by 10.101.26.26 with SMTP id d26mr3191025anj.9.1251000479223; Sat, 
	22 Aug 2009 21:07:59 -0700 (PDT)
In-Reply-To: <20090822181607.GA25823@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126840>

On Sun, Aug 23, 2009 at 1:16 AM, Jeff King<peff@peff.net> wrote:
> On Sat, Aug 22, 2009 at 11:20:39PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> > I did read a bit farther in the manual and initialized a new repos=
itory.
>> > Issuing "git --help" once inside that new repository works. =C2=A0=
Requiring
>> > the --help command to be called from inside a repository, or even =
that
>> > it's looking for a repository at all, seems unwise. =C2=A0All it s=
hould do is
>> > display the usage information and exit.
>>
>> For simple things like --help, I agree Git should not do extra work
>> such as searching for Git repository, which is the cause. That was o=
n
>> Jeff's plan IIRC.
>
> Without looking, I would not be surprised if it is a side effect of
> git trying to look up help-related config. So I don't think it is a
> problem exactly that it checks to see if it is in a repo (which would
> impact config lookup), but that inability to find a repo is a hard
> error.
>
> Probably it is calling "setup_git_directory_gently" and ignoring an
> error return, but there is a die() inside that function. The bug
> then is that the _gently form is calling die().

It is (and should be worked around with GIT_CEILING_DIRECTORIES).
Unfortunately in my test, it could not chdir() back when it failed to
find gitdir. chdir() was called with an absolute directory, and one
directory in that path was inaccesible, leading another die("Cannot
come back to cwd"). This one is fatal and should not be ignored. I
don't know whether having an inaccesible parent directory is a real
scenario, as lots of tools would break.
--=20
Duy
