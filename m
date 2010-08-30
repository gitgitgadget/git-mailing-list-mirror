From: Marcin Cieslak <saper@saper.info>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Mon, 30 Aug 2010 14:00:11 +0000
Message-ID: <alpine.BSF.2.00.1008301353260.95618@x.fncre.vasb>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com> <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com> <20100828214641.GA5515@burratino> <20100828215956.GB5515@burratino> <alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
 <20100828221655.GB5777@burratino> <AANLkTimn+-5Vys+jg=ryDfwdJ=WZfGwgZ+065M_=TF8r@mail.gmail.com> <20100829204519.GB1890@burratino> <AANLkTin4A6B9zqSYHsWQ+GLWRqLvzJWAQ0F2WC85zDqC@mail.gmail.com> <20100830134136.GA2315@burratino>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1730125533-231554474-1283176812=:95618"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:00:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq4uw-00073A-Ga
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab0H3OAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 10:00:44 -0400
Received: from k.saper.info ([91.121.151.35]:22658 "EHLO k.saper.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398Ab0H3OAn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 10:00:43 -0400
Received: from k.saper.info (localhost [127.0.0.1])
	by k.saper.info (8.14.4/8.14.4) with ESMTP id o7UE0C3g095895
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Aug 2010 14:00:12 GMT
	(envelope-from saper@saper.info)
Received: from localhost (saper@localhost)
	by k.saper.info (8.14.4/8.14.4/Submit) with ESMTP id o7UE0BGu095892;
	Mon, 30 Aug 2010 14:00:12 GMT
	(envelope-from saper@saper.info)
X-Authentication-Warning: k.saper.info: saper owned process doing -bs
In-Reply-To: <20100830134136.GA2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154804>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1730125533-231554474-1283176812=:95618
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 30 Aug 2010, Ævar Arnfjörð Bjarmason wrote:

> On Sun, Aug 29, 2010 at 20:45, Jonathan Nieder <jrnieder@gmail.com> wrote:
> A would be preferred for correctness, and with a fallback BSD printf()
> we can avoid the GNU libc bug, however that'll mean using LC_CTYPE,
> which'll have some small side-effects for the rest of the code.

The real problem is that you are probably using same functions
(locale-enable) for the user-facing side as well as for the 
backend (talking to repository). Some projects decided to use
some special encoding internally (like UCS-2 in case of Java
and Python 2.x, Unicode ordinals in Python 3.x). Otherwise
you may end up in some incompatibilities in the on-disk on 
on-network format. I don't think you want to keep telling all bug 
reporters for few years - "Can you try that again with env LANG=C,
please?" :)

Bringing Unicode onboard means that simple strlen() is no longer
what you normally think it does.

On Mon, 30 Aug 2010, Jonathan Nieder wrote:

> Ævar Arnfjörð Bjarmason wrote:
>
>> We can even keep the "Content-Type: text/plain; charset=UTF-8\n" and
>> *not* use LC_CTYPE if we add a bind_textdomain_codeset("git", "UTF-8")
>> call to gettext.
>
> Oh!  I'd personally prefer to do that for now. :)  (Not because of the
> known printf problem but because I like to reduce possible unknowns.)

Well, in this case everybody will be force to have UTF-8 in output
on-screen, not useful for people using ISO8859-*, KOI8-R and similar
things...

--Marcin
--1730125533-231554474-1283176812=:95618--
