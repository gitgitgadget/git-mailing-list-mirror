From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 15/16] config: add core.noshallow to prevent turning a repo into a shallow one
Date: Tue, 23 Jul 2013 20:44:39 +0100
Organization: OPDS
Message-ID: <3791504D7BB44F5BB08DC5AC34E1CE0E@PhilipOakley>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com> <1374314290-5976-1-git-send-email-pclouds@gmail.com> <1374314290-5976-16-git-send-email-pclouds@gmail.com> <BF5D998BFA5241938531635E1D8B79DF@PhilipOakley> <CACsJy8Ddac5r7opAgtk-CAkc=jwmBmmOs7FU6DziysCZ=992dQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 21:44:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1iVd-0005Eb-6W
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 21:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934035Ab3GWTo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jul 2013 15:44:29 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:38679 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933618Ab3GWTo2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jul 2013 15:44:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvYNAKfb7lFZ8YYB/2dsb2JhbABbgwaEDoU+uBABAwGBEhd0gh8FAQEFCAEBGQ8BBR4BASELAgMFAgEDDgMEAQEBAgIFIQICFAEECBIGBw8IBhMIAgECAwGHbQMTpmSIZw2IXoEoi2qBVC1qDYJZM24Djn+Gd44QhSaBW4E6Ow
X-IPAS-Result: AvYNAKfb7lFZ8YYB/2dsb2JhbABbgwaEDoU+uBABAwGBEhd0gh8FAQEFCAEBGQ8BBR4BASELAgMFAgEDDgMEAQEBAgIFIQICFAEECBIGBw8IBhMIAgECAwGHbQMTpmSIZw2IXoEoi2qBVC1qDYJZM24Djn+Gd44QhSaBW4E6Ow
X-IronPort-AV: E=Sophos;i="4.89,729,1367967600"; 
   d="scan'208";a="435606287"
Received: from host-89-241-134-1.as13285.net (HELO PhilipOakley) ([89.241.134.1])
  by out1.ip02ir2.opaltelecom.net with SMTP; 23 Jul 2013 20:44:27 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231054>

=46rom: "Duy Nguyen" <pclouds@gmail.com>
Sent: Tuesday, July 23, 2013 2:28 AM
> On Tue, Jul 23, 2013 at 2:23 AM, Philip Oakley <philipoakley@iee.org>=
=20
> wrote:
>> From: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com=
>
>> Subject: [PATCH v2 15/16] config: add core.noshallow to prevent=20
>> turning a
>> repo into a shallow one
>>
>> Surely this should be the default now that it is possible to corrupt=
=20
>> a
>> golden repo by pushing/fetching a shallow repository to it and it=20
>> then
>> becomes shallow, and all the followers become shallow as well, with
>> consequent problems (IIUC) [PATCH v2 05/16].
>>
>> It would be just as easy to change the config to core.allowshallow=20
>> which
>> then must be enabled by the user, and can be mentioned in the shallo=
w=20
>> clone
>> option's documentation.
>
> Clarification, it's not really "corrupt". If you have full history
> from a ref "A", fetching from another shallow clone does not touch th=
e
> history of ref A at all

>   (that is if you do _not_ specify --depth).

I hadn't appreciated this conditional.
> It
> may add a a shallow ref B, which is the reason the whole repo becomes
> shallow.
I had read the initial commit message (in 05/16) as implying that it wa=
s=20
possible to fool someone into pulling a shallow repo and that would mak=
e=20
their repo just as shallow (that's without a --depth argument to the=20
command). Had that been the case then it would have been possible to=20
loose some data from deep in the DAG. Glad to hear I was mistaken.=20
Perhaps if your comment above is included in the commit message to=20
ensure that clarification is there.

>The same goes for push. This is not implemented, but I'm
> thinking of adding "clean .git/shallow" to git repack -ad. Then if yo=
u
> delete ref B and repack -ad, the repo could become full again.
>
> But yeah, maybe defaulting to no shallow is better. Will do so in the
> reroll unless someone objects.
> --
> Duy
> --
Philip=20
