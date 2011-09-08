From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git push output goes into stderr
Date: Thu, 8 Sep 2011 11:12:48 +0530
Message-ID: <CAMK1S_gro=THLkc_wrHSLwUVaJp9k-zRDuFDQpOGaiyBTHiDnQ@mail.gmail.com>
References: <CAPgpnMQuck_aPU0ciaGgj-C8rno7jbzZ7wZ4unU8CqA0eaiYQw@mail.gmail.com>
	<7v8vq3ztym.fsf@alter.siamese.dyndns.org>
	<20110906074916.GC28490@ecki>
	<20110907215716.GJ13364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>,
	Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 08 07:42:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1XO2-00034S-SP
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 07:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523Ab1IHFmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Sep 2011 01:42:50 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:38868 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756432Ab1IHFmt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 01:42:49 -0400
Received: by vws10 with SMTP id 10so662306vws.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 22:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=A85hqfzJEHKnb/k2z6M6vN4ooO7OQSn1kpRs9BjlWU0=;
        b=jGCli88Z2n8WH2xVe58A/V/ZXKLiStwyenRA72YElG38tXrYcxgHwBSU/odkLxTjpd
         jITWDgaANrwAPheTPTGK4d8A3JSx2Poi7rfEMIEuyAskJH0yB6RQ827dtbUP5VwbimeJ
         FP+5TXoHxknVxzAK9D7cvu7dAkocp6fjTl9ME=
Received: by 10.52.172.174 with SMTP id bd14mr266110vdc.246.1315460568466;
 Wed, 07 Sep 2011 22:42:48 -0700 (PDT)
Received: by 10.52.161.197 with HTTP; Wed, 7 Sep 2011 22:42:48 -0700 (PDT)
In-Reply-To: <20110907215716.GJ13364@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180941>

On Thu, Sep 8, 2011 at 3:27 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 06, 2011 at 09:49:16AM +0200, Clemens Buchacher wrote:
>
>> On Sun, Sep 04, 2011 at 05:57:53PM -0700, Junio C Hamano wrote:
>> > Lynn Lin <lynn.xin.lin@gmail.com> writes:
>> >
>> > > When I create a local branch and then push it to remote. I find =
that
>> > > the output without error goes into stderr, is this expected?
>> >
>> > Progress output are sent to the stderr stream.
>>
>> But it's not only progress output that goes to stderr in case of
>> git push. Even the summary written in tranport_print_push_status
>> goes to stderr, unless we specify git push --porcelain. Can't we
>> let that part of the output go to stdout unconditionally?
>
> We could, though it makes more sense on stderr to me.
>
> Stdout has always been about "the main program output" and stderr abo=
ut
> diagnostic messages. With a program whose main function is to generat=
e
> output (e.g., "git tag -l", it's very easy to know that the list of t=
ags
> is the main program output (which you don't want to pollute with
> anything else), and any problems or even general chattiness goes to
> stderr.
>
> But with a program whose main function is to perform an action, like
> "git push", I think there are really two ways to look at it:
>
> =C2=A01. There is no main output; any progress or status update is ju=
st
> =C2=A0 =C2=A0 diagnostic chat, and should go to stderr.
>
> =C2=A02. The main output is the status report; it goes to stdout, and
> =C2=A0 =C2=A0 progress updates go to stderr.

I always thought if you write stuff to stdout the remote client gets
confused because it is executing to a defined protocol and suddenly
sees unexpected input in the middle.

Bit if *you* are saying this (output random stuff to STDOUT) can
happen if we want it to, clearly I was wrong...

> I think both are equally valid mental models, and both are consistent
> with the philosophy above. If we switch, I wouldn't be surprised to s=
ee
> somebody say "why is this going to stdout, it should be on stderr". I=
n
> fact, I seem to recall that we've had this discussion before on the
> list.
