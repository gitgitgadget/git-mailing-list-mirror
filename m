From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Why can't I push from a shallow clone?
Date: Fri, 26 Jul 2013 22:48:12 +0100
Organization: OPDS
Message-ID: <34D78815D927482897856F1C5BB2D183@PhilipOakley>
References: <CANEZYrdsCgH+3NnZnnmsn_znt=+01aNn02u4mWyb3td9XypUog@mail.gmail.com><20130726065528.GA4940@paksenarrion.iveqy.com> <CANEZYrdR3xLRSQAo6rroN3TLv48HEKp4_t95WEf6rm8-+r+2tw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Gulshan Singh" <gsingh2011@gmail.com>,
	"Fredrik Gustafsson" <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 23:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2prf-0007E8-PA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 23:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881Ab3GZVrv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 17:47:51 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:37413 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752595Ab3GZVru (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jul 2013 17:47:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AssMACzu8lFOl328/2dsb2JhbABYA4MGNYkdtQsDAYEYF3SCHwUBAQQBCAEBKAEFHgEBIQsCAwUCAQMOBwECCSUUAQQIEgYHFwYBEggCAQIDAYdtAwkKCLAUDYhejRWBOT1iEBiDBW8DiHKDZoInhneDEop9hSaDFTuBNQ
X-IPAS-Result: AssMACzu8lFOl328/2dsb2JhbABYA4MGNYkdtQsDAYEYF3SCHwUBAQQBCAEBKAEFHgEBIQsCAwUCAQMOBwECCSUUAQQIEgYHFwYBEggCAQIDAYdtAwkKCLAUDYhejRWBOT1iEBiDBW8DiHKDZoInhneDEop9hSaDFTuBNQ
X-IronPort-AV: E=Sophos;i="4.89,753,1367967600"; 
   d="scan'208";a="436034453"
Received: from host-78-151-125-188.as13285.net (HELO PhilipOakley) ([78.151.125.188])
  by out1.ip02ir2.opaltelecom.net with SMTP; 26 Jul 2013 22:47:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231209>

=46rom: "Gulshan Singh" <gsingh2011@gmail.com>
Sent: Friday, July 26, 2013 8:12 PM
> Hey Fredrick,
>
> It's good to know that work is being done on this. I still want to
> understand it though, so I guess I'll ask specific questions about
> Junio's response. He states,
>
> "If you cloned shallowly some time ago, worked without communicating
> with the other side while the other side progressed, AND if the other
> side's progress included a rewind & rebuild of the history, you would
> see a similar topology.
> The leftmost 'S' in the above picture might have been the tip of the
> branch when you shallowly cloned with depth 1, and since then the
> remote end may have discarded topmost three commits and have rebuilt
> its history that leads to the rightmost 'R'. In such a case pushing t=
o
> the remote's HEAD will fail."
>
> So as an example, if you shallow clone a branch, then someone squashe=
s
> the head commit and makes a new commit, you won't be able to push to
> HEAD because the parent has changed. But if someone does that, I don'=
t
> think you would be able to push even if it was a full clone. That's
> why it's usually not a good idea to rebase shared branches. So did I
> misunderstand the scenario?

In your example you have a sucessful failure, that is, the shallow issu=
e=20
hasn't got in the way of the normal non-ff failure on push. (asuming th=
e=20
squash is an extra commit, not a re-written top commit, so at least you=
=20
still have your common commit of your depth1 shallow clone)

=46or it to be a proper shallow failure the remote repo needs to be=20
re-written sufficiently far back that your shallow clone has nothing in=
=20
common with it. In such a case your DAG can't join onto the remote's=20
DAG.

>
>
> On Thu, Jul 25, 2013 at 11:55 PM, Fredrik Gustafsson <iveqy@iveqy.com=
>=20
> wrote:
>> On Thu, Jul 25, 2013 at 07:33:16PM -0700, Gulshan Singh wrote:
>>> I've been trying to figure out why I can't push from a shallow clon=
e
>>> (using --depth) to a repository. I've made simple examples where it
>>> works, but I've read that in doesn't work in every case. However, I
>>> can't come up with a case where it doesn't work. Googling gives thi=
s
>>> answer:=20
>>> http://stackoverflow.com/questions/6900103/why-cant-i-push-from-a-s=
hallow-clone,
>>> but I don't completely understand the explanation, so I was hoping
>>> someone could explain it.
>>
>> I can't explain it better than what Junio did in the link you just
>> provide. However there's ongoing work to allow shallow clones to be=20
>> able
>> to push. You can read about it here:
>> http://thread.gmane.org/gmane.comp.version-control.git/230612/focus=3D=
230878
>> --
>> Med v=E4nliga h=E4lsningar
>> Fredrik Gustafsson
>> tel: 0733-608274
>> e-post: iveqy@iveqy.com
> --=20
> Gulshan Singh
> University of Michigan, Class of 2015
> College of Engineering, Computer Science Major
> gulshan@umich.edu | 248.961.6317
> Alternate E-mail: gsingh2011@gmail.com
--
Philip=20
