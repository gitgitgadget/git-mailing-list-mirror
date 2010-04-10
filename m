From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Sat, 10 Apr 2010 18:10:53 -0400
Message-ID: <h2x76c5b8581004101510hc1d15f42u7e48dafbc275c998@mail.gmail.com>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
	 <20100410042609.GA24295@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:18:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0j02-0000gT-UY
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab0DJWRu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 18:17:50 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62199 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab0DJWRt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 18:17:49 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2010 18:17:48 EDT
Received: by bwz19 with SMTP id 19so82295bwz.21
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 15:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LzpAA/OibyY/WSrElhWqqDK5pYIGzjEuv6BJFxZ9lEc=;
        b=OHwHFF2rY+7LRqDn/9o0882F36hE8kIMrQ7WuRXXZS5jDggDFSTQ/sXXhDmm5/7T0S
         wPWc+GZo80hIECGcINbFcUmuLssKAmWKCNhG3A3I91ETCEBhnAnldTUAWLOgJ0FE1u26
         HyyRDJiSSyLHqonKdQ4BHWdicv9Y5QvruHBHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QRmGeuW4PXuQJu3Ru1sydFbkDtFiqjrGsHaTpkGlYi5bFbzoVUN2seMkjq3JWRbcBg
         GcFThDhlS0dw/EvW6QtG+1vUZJXFcN6Wi4h8DR70bQDYLyP6jWyC/hLnQ0D2hGMVH7zK
         Qz0JwAlm10kDmJ44tku2IVMDhXoiws8qF9Zwc=
Received: by 10.204.97.202 with HTTP; Sat, 10 Apr 2010 15:10:53 -0700 (PDT)
In-Reply-To: <20100410042609.GA24295@coredump.intra.peff.net>
Received: by 10.204.81.145 with SMTP id x17mr2217584bkk.31.1270937453485; Sat, 
	10 Apr 2010 15:10:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144601>

On Sat, Apr 10, 2010 at 12:26 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 09, 2010 at 03:35:42PM -0400, Eugene Sajine wrote:
>
>> In case of this situation
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0master
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0B =C2=A0next
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C =C2=A0topic
>>
>>
>> $ git rebase --onto master topic
>> First, rewinding head to replay your work on top of it...
>> fatal: Not a range.
>> Nothing to do.
>>
>> Which is OK.
>
> I think this doesn't do quite what you thought. It's true there is
> "nothing to do" as in "nothing to apply", but it _did_ in fact rewind
> topic back to "master".
>
> You seem to be thinking that
>
> =C2=A0git rebase --onto master topic
>
> means "rebase everything from master to topic onto master". It doesn'=
t.
> That would be:
>
> =C2=A0git rebase master topic
>
> or, if you are already on topic, just
>
> =C2=A0git rebase master.
>
> The "--onto" option takes an argument, which says "put the commits on
> top of here, even though it was not the upstream base otherwise
> specified". So what your command does is say "using the current branc=
h
> (which is topic), take everything built on top of topic (which is
> nothing), and rebuild it on top of master".

Actually no, i was not thinking about what you think i was;). What i
was trying to understand with this command (git rebase --onto master
topic) is the
behavior of the system when the topic branch is indirect descendant of
the master and the direct parent of topic (next) is omitted, skipped.

In this situatiion

git rebase master topic

does not work (see thread "git rebase command and docs questions") p1.

So, once again i think that the interface in this case worked properly:

as topic is not direct descendant, master option value goes to --onto
and there is no range defined properly.
Therefore the command worked ok, when it refused to do anything.

Now the problem i have is that:

git rebase -i --onto master topic

actually worked and did something, what i would not expect it to do.

So, the problem is: non-interactive rebase DOES NOT execute the
command, interactive DOES execute.

>
> So no, it's not a bug. Yes, it's a terrible interface. There is reall=
y
> no reason IMHO for rebase to take a "which branch to operate on"
> argument at all. It should just operate on HEAD, like merge does. If =
you
> want to merge on a different branch, you "git checkout" that branch
> first.

The bug is in the fact that rebase works differently in interactive
and non-interactive variants.

Thanks,
Eugene
