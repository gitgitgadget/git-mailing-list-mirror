From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 20:58:20 +0100
Message-ID: <m2lidw11yb.fsf@igel.home>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
	<20121119151845.GA29678@shrek.podlesie.net>
	<7vk3thxuj2.fsf@alter.siamese.dyndns.org>
	<20121119225838.GA23412@shrek.podlesie.net>
	<CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com>
	<7vlidxuowf.fsf@alter.siamese.dyndns.org>
	<20121120073100.GB7206@shrek.podlesie.net>
	<20121120075628.GA7159@shrek.podlesie.net>
	<CAMP44s38gTB_3Ao1rFZgMo2EAuiNb+h88-qRFcQPRMJNxo3CAQ@mail.gmail.com>
	<20121120115942.GA6132@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 20:58:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tatxy-0000Yb-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 20:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab2KTT62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 14:58:28 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:48350 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab2KTT61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 14:58:27 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Y5d5924pHz3hhVc;
	Tue, 20 Nov 2012 20:58:21 +0100 (CET)
X-Auth-Info: lqRZiJyS+tqiTr7B8vu3Ui/iJOQqBidhq2mARZnyrA0=
Received: from igel.home (ppp-88-217-118-87.dynamic.mnet-online.de [88.217.118.87])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Y5d591R7XzbbjB;
	Tue, 20 Nov 2012 20:58:21 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 934A5CA2A4; Tue, 20 Nov 2012 20:58:20 +0100 (CET)
X-Yow: I'm having a RELIGIOUS EXPERIENCE..  and I don't take any DRUGS
In-Reply-To: <20121120115942.GA6132@shrek.podlesie.net> (Krzysztof Mazur's
	message of "Tue, 20 Nov 2012 12:59:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210108>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> On Tue, Nov 20, 2012 at 11:28:39AM +0100, Felipe Contreras wrote:
>> On Tue, Nov 20, 2012 at 8:56 AM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:
>> 
>> > --- a/git-send-email.perl
>> > +++ b/git-send-email.perl
>> > @@ -925,8 +925,11 @@ sub quote_subject {
>> >  sub sanitize_address {
>> >         my ($recipient) = @_;
>> >
>> > +       my $local_part_regexp = qr/[^<>"\s@]+/;
>> > +       my $domain_regexp = qr/[^.<>"\s@]+(?:\.[^.<>"\s@]+)+/;
>> > +
>> >         # remove garbage after email address
>> > -       $recipient =~ s/(.*>).*$/$1/;
>> > +       $recipient =~ s/^(.*?<$local_part_regexp\@$domain_regexp>).*/$1/;
>> 
>> I don't think all that extra complexity is warranted, to me
>> s/(.*?>)(.*)$/$1/ is just fine.
>> 
>
> Yeah, it's a little bit too complex, but "s/(.*?>)(.*)$/$1/"

How about "s/(.*?<[^>]*>).*$/$1/"?  That will still fail on "<foo@bar>"
<foo@bar>, but you'll need a full rfc822 parser to handle the general
case anyway.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
