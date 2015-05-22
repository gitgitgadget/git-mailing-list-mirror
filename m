From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 14/14] pull --rebase: error on no merge candidate cases
Date: Fri, 22 May 2015 16:14:26 +0200
Organization: gmx
Message-ID: <632335d05ab160ea935c920249f62970@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-15-git-send-email-pyokagan@gmail.com>
 <CAGZ79kbhA2+AJ1Vtz6khX5uEBCCUBUuXhpBezZApZsC_txhewA@mail.gmail.com>
 <5fcd2fa185fab4c64939ad09eb10e6d5@www.dscho.org>
 <xmqqoalg8re2.fsf@gitster.dls.corp.google.com>
 <CACRoPnR=ajnzvX42jwSpaYE1fgd2J-Ph7+_s=ch=OQJf5FRpQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 16:14:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvnif-0005OT-K8
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 16:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756729AbbEVOOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 10:14:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:59328 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756700AbbEVOOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 10:14:32 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Li0dC-1ZYw6L3lru-00nB6H; Fri, 22 May 2015 16:14:27
 +0200
In-Reply-To: <CACRoPnR=ajnzvX42jwSpaYE1fgd2J-Ph7+_s=ch=OQJf5FRpQQ@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:6EA7GgA/lIBoYelnfKtjPj1ZmbFVPeqaNq0zvbZmVYrV8lA3GY3
 h32En2JYVNukpob3AIDbKOsb0v0RJpzTupks/nDiZ7vMxhioJWr9d2ctrefK407oC8+ZV61
 Yt0VwpLE42k2Ix563W/b1xJZKrXKjm7WAvji8puPWkygxmwOO/rr6b6RfS3Tcr2URiXKQMY
 uK46prp5thjgIwAkhWs5w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269718>

Hi Paul,

On 2015-05-22 15:48, Paul Tan wrote:
> On Wed, May 20, 2015 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>>>> -               fprintf(stderr,
>>>>> -                       _("There are no candidates for merging among the refs that you just fetched.\n"
>>>>> -                       "Generally this means that you provided a wildcard refspec which had no\n"
>>>>> -                       "matches on the remote end.\n"));
>>>>> +               if (opt_rebase)
>>>>> +                       fputs(_("There is no candidate for rebasing against among the refs that you just fetched."), stderr);
>>>>
>>>     The puts() function appends a <newline> while fputs() does not.
>>
>> Yup, so this update makes the command spew unterminated lines, which
>> not something intended...
> 
> Ugh >< Will put the "\n" back.
> 
> And yes, I used fputs() because it seems wasteful to use fprintf()
> which will scan the string looking for any '%' formatting units, when
> we know there aren't.
> 
> I will also update 05/14 to use fputs() as well where appropriate.

I believe the common thinking is that consistency beats speed in error messages, so it would be easier to read and maintain the code if all of those error messages were just using `fprintf(stderr, ...);`. It's not as if we spit out hundreds of thousands of error messages per second where that `%s` parsing would hurt ;-)

Ciao,
Dscho
