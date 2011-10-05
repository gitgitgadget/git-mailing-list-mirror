From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: pack-object poor performance (with large number of objects?)
Date: Wed, 5 Oct 2011 10:48:25 +0200
Message-ID: <CAA01CsoZVhbZHQgCsbk=XV833oQCbw-SVv9FuPQ05DFu49c0sQ@mail.gmail.com>
References: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
	<CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
	<CAA01CsppPf_6Zp5UPYBsxa1JEwLGF-FqacRa7kBJ45Ges2ujrw@mail.gmail.com>
	<7v62k5g988.fsf@alter.siamese.dyndns.org>
	<CAA01CsoSTsBLNcbv5o6Jx6YrjG4g8T=yodX811ymBLXg7sjDJQ@mail.gmail.com>
	<20111004110702.GA18599@sigill.intra.peff.net>
	<CAA01CsodyUQJOnj5vV0LdVEWpkvwSW2TAONzyY9J82o9VwC6Ag@mail.gmail.com>
	<20111004124502.GB30162@sigill.intra.peff.net>
	<CAA01Csp2rouKk4jvCH0Wu+0gc3+cvyH__d-yw8EHEkeZhRpX1Q@mail.gmail.com>
	<20111004180829.GB31671@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 05 10:48:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBN9T-0001ZN-Mi
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 10:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933184Ab1JEIs0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 04:48:26 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53841 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659Ab1JEIsZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 04:48:25 -0400
Received: by ggnv2 with SMTP id v2so639346ggn.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jwe1iAF4yZArdnQ13jix60vFLy3d/9ptwNfHWLha+Eg=;
        b=J5wNkKvPRazRTWk4UgcZel8BPt8HMugXGxChsPH1V2adYMb2x6FkgVkpXS4+/Wp540
         wTdqkHj6K8QMlZ6qE1vmS7ZWwilO3OCJ9ZPTA4EuxHlCGYzkk/yiUsZsPp2qLlA/YxMg
         S6tbAWaaNu33FxVgXAcbVhONEaQAuz9W3jVME=
Received: by 10.150.138.2 with SMTP id l2mr1927100ybd.344.1317804505216; Wed,
 05 Oct 2011 01:48:25 -0700 (PDT)
Received: by 10.150.196.1 with HTTP; Wed, 5 Oct 2011 01:48:25 -0700 (PDT)
In-Reply-To: <20111004180829.GB31671@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182838>

On Tue, Oct 4, 2011 at 8:08 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2011 at 03:21:24PM +0200, Piotr Krukowiecki wrote:
>
>> I have 4GB ram + 4GB swap. Is it possible the RAM is the problem if =
I
>> always have free RAM left and my swap is almost not used?
>> For example at the moment repack finished counting objects ("Countin=
g
>> objects: 1742200, done."):
>>
>> $ free -m
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0total =A0 =A0 =A0 used =A0 =A0 =A0 free =A0=
 =A0 shared =A0 =A0buffers =A0 =A0 cached
>> Mem: =A0 =A0 =A0 =A0 =A03960 =A0 =A0 =A0 3814 =A0 =A0 =A0 =A0146 =A0=
 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0441 =A0 =A0 =A0 =A0215
>> -/+ buffers/cache: =A0 =A0 =A0 3157 =A0 =A0 =A0 =A0803
>> Swap: =A0 =A0 =A0 =A0 6143 =A0 =A0 =A0 =A0694 =A0 =A0 =A0 5449
>
[...]
> I have no idea if this will actually go faster for you. But it might =
be
> worth trying, instead of just redoing the svn import with auto-gc tur=
ned
> on.

I've left it to run over night and it finished (took almost 12 hours),
so hopefully I'm not going to run into this problem anymore.

$ time git repack -a -d -f
Counting objects: 1742200, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (1291909/1291909), done.
Writing objects: 100% (1742200/1742200), done.
Total 1742200 (delta 1094325), reused 39192 (delta 0)
Removing duplicate objects: 100% (256/256), done.

real	704m3.477s
user	65m35.960s
sys	9m50.880s

$ du -sh .git/objects/pack
3.9G	.git/objects/pack

$ git count-objects -v
count: 0
size: 0
in-pack: 1742200
packs: 1
size-pack: 4078245
prune-packable: 0
garbage: 0


--=20
Piotr Krukowiecki
