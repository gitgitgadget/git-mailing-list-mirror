From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Why doesn't git-fetch obey -c "remote.origin.url" on the command-line?
Date: Mon, 16 Jun 2014 13:48:02 +0100
Organization: OPDS
Message-ID: <24CCEC485B8B4C65B7785462369CBFF0@PhilipOakley>
References: <CACBZZX4MyaOKkCvTSKhZtyRMFvpBMiMGz2ix3OxMz_s=P-=p=w@mail.gmail.com> <20140613075110.GH7908@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Tanay Abhra" <tanayabh@gmail.com>
To: "Jeff King" <peff@peff.net>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, "Robert Clausecker" <fuz@fuz.su>
X-From: git-owner@vger.kernel.org Mon Jun 16 14:48:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwWKo-0000Tc-BS
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 14:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbaFPMsU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2014 08:48:20 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:48098 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752558AbaFPMsT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 08:48:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjEsABbnnlMCYJ7h/2dsb2JhbABagw1SEQOCaUmFO7psAQECAQEMgQUXdYN+BQEBBAEIAQECFw8BBR4BASELAgMFAgEBAg4HAwICBSECAhQBBBoGBxcGARIIAgECAwGIKQwJlHScJIZ+lyiBKo1MNYJJNoEWBIRjAot6hVWFUpIVg0E8LwEB
X-IPAS-Result: AjEsABbnnlMCYJ7h/2dsb2JhbABagw1SEQOCaUmFO7psAQECAQEMgQUXdYN+BQEBBAEIAQECFw8BBR4BASELAgMFAgEBAg4HAwICBSECAhQBBBoGBxcGARIIAgECAwGIKQwJlHScJIZ+lyiBKo1MNYJJNoEWBIRjAot6hVWFUpIVg0E8LwEB
X-IronPort-AV: E=Sophos;i="5.01,486,1400022000"; 
   d="scan'208";a="462723050"
Received: from host-2-96-158-225.as13285.net (HELO PhilipOakley) ([2.96.158.225])
  by out1.ip04ir2.opaltelecom.net with SMTP; 16 Jun 2014 13:47:52 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251713>

=46rom: "Jeff King" <peff@peff.net>
> On Fri, Jun 13, 2014 at 09:37:07AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason
> wrote:
>
>> On a git built from the master branch just now:
>>
>>  $ ./git config remote.origin.url
>> https://code.google.com/p/git-core/
>> $ ./git -c
>> remote.origin.url=3Dgit://git.sourceforge.jp/gitroot/git-core/git.gi=
t
>> config remote.origin.url
>> git://git.sourceforge.jp/gitroot/git-core/git.git
>> $ GIT_TRACE=3D1 ./git -c
>> remote.origin.url=3Dgit://git.sourceforge.jp/gitroot/git-core/git.gi=
t
>> fetch 2>&1 | head -n 2
>> trace: built-in: git 'fetch'
>> trace: run_command: 'git-remote-https' 'origin'
>> 'https://code.google.com/p/git-core/'
>>
>> I'd expect this to try to fetch from the remote.origin.url I
>> specified
>> on the command-line, but for some reason fetch doesn't pick that up.
>> Isn't this a bug?

If anything, given Peff's clarification below, it's a bug in the way th=
e
documentation has (not) communicated this trap for the unwary.

The question would then become "What warning should be given and where
should it/they be placed?" It should go within the documentation where=20
folk
look to check that the command innvocations were as expected. (It may
also be a 'common knowledge' issue [2]).

I already see that the git(1) man page for the '-c' option doesn't cove=
r
the mult-value config option case.

The config-api suggests the common priority order where later values
override newer values.

I've done a little documentation patch to cover the current situation.

I've also copied in Robert (fuz) (from [1]) and Tanay (updating the
reading of config files).

>
> I think this is an alternate version of the report in [1].
>
> The short answer is: remote.*.url is a multi-valued config option, an=
d
> you can only append to (not override) such options with "git -c". Try
> using insteadOf.
>
> -Peff
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/250427
> --
[2] "It ain't what you don't know that gets you into trouble. It's what
you know for sure that just ain't so." Mark Twain=20
