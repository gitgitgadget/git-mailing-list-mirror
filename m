From: =?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
Subject: Re: GIT get corrupted on lustre
Date: Wed, 23 Jan 2013 09:50:27 -0500
Message-ID: <50FFF8B3.4070909@calculquebec.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil> <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil> <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com> <87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org> <87r4lejpx8.fsf@pctrast.inf.ethz.ch> <50FF051D.5090804@giref.ulaval.ca> <878v7keuh3.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>, git@vger.kernel.org,
	kusmabite@gmail.com,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 23 15:51:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty1g4-0006YH-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 15:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374Ab3AWOv1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2013 09:51:27 -0500
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:57600 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224Ab3AWOv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2013 09:51:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AisCAG6Zu09FpcD8/2dsb2JhbAANN4F7tTMBAQEBAgEyAQUuCAoBBQsLDgoJAxMPCQMCAQIBRQYNAQUCAQGIBboOkEQDiEKfUA
X-IronPort-AV: E=Sophos;i="4.75,637,1330923600"; 
   d="scan'208";a="213373719"
Received: from 69-165-192-252.cable.teksavvy.com (HELO [192.168.1.106]) ([69.165.192.252])
  by ironport2-out.teksavvy.com with ESMTP; 23 Jan 2013 09:51:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <878v7keuh3.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214325>

[I forgot to subscribe to the git mailing list, sorry for that]

On 01/22/2013 05:14 PM, Thomas Rast wrote:
> Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:
>
>> So, hum, do we have some sort of conclusion?
>>
>> Shall it be a fix for git to get around that lustre "behavior"?
>>
>> If something can be done in git it would be great: it is a *lot*
>> easier to change git than the lustre filesystem software for a clust=
er
>> in running in production mode... (words from cluster team) :-/
>
> I thought you already established that simply disabling the progress
> display is a sufficient workaround?  If that doesn't help, you can tr=
y
> patching out all use of SIGALRM within git.
>

In git (9591fcc6d66), I have found these SIGALRM signal handling:

builtin/log.c:268:    sigaction(SIGALRM, &sa, NULL);
builtin/log.c:285:    signal(SIGALRM, SIG_IGN);
compat/mingw.c:1590:        mingw_raise(SIGALRM);
compat/mingw.c:1666:    if (sig !=3D SIGALRM)
compat/mingw.c:1668:            error("sigaction only implemented for S=
IGALRM");
compat/mingw.c:1683:    case SIGALRM:
compat/mingw.c:1702:    case SIGALRM:
compat/mingw.c:1706:            exit(128 + SIGALRM);
compat/mingw.c:1708:            timer_fn(SIGALRM);
compat/mingw.h:42:#define SIGALRM 14
perl/Git/SVN.pm:2121:            SIGALRM, SIGUSR1, SIGUSR2);
progress.c:56:    sigaction(SIGALRM, &sa, NULL);
progress.c:68:    signal(SIGALRM, SIG_IGN);


I suppose that compat/mingw.{h,c} and SVN.pm can be ignored as our patc=
h to work
around this problem won't be pushed upstream because the real problem i=
s not in git, right ?

If I understand correctly, some VFS system calls get interrupted by SIG=
ALRM, but when
they resume (via SA_RESTART) they return EINTR. Thomas said that these =
failed calls may need to be retried,
but that open(O_CREAT|O_EXCL) is still tricky around this case.


progress.c SIGALRM code paths are for progress and therefore are requir=
ed, right ?

builtin/log.c SIGALRM code paths are for early output, and the comments=
 in the code say that

    "If we can get the whole output in less than a tenth of a second, d=
on't even bother doing the
     early-output thing."


So where do I start for the patch ?

> Other than that I agree with Junio, from what we've seen so far, Lust=
re
> returns EINTR on all sorts of calls that simply aren't allowed to do =
so.
>


--=20
---
Sp=E9cialiste en granularit=E9 (1 journ=E9e / semaine)
Calcul Qu=E9bec / Calcul Canada
Pavillon Adrien-Pouliot, Universit=E9 Laval, Qu=E9bec (Qu=E9bec), Canad=
a
