From: Andreas Ericsson <ae@op5.se>
Subject: Re: Useless error message?
Date: Thu, 22 Apr 2010 11:59:37 +0200
Message-ID: <4BD01E09.8080504@op5.se>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com> <20100421221953.GA25348@progeny.tock> <7vwrw0573t.fsf@alter.siamese.dyndns.org> <20100422094153.GA504@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Aghiles <aghilesk@gmail.com>,
	git list <git@vger.kernel.org>, Kim Ebert <kd7ike@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 11:59:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4tCI-0002kZ-Ta
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 11:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0DVJ7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 05:59:43 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:40427 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752473Ab0DVJ7n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 05:59:43 -0400
Received: from source ([209.85.218.211]) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS9AeDIYUV+beHQvWtTY3mU2HNQS9euvc@postini.com; Thu, 22 Apr 2010 02:59:42 PDT
Received: by mail-bw0-f211.google.com with SMTP id 3so7701320bwz.11
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 02:59:40 -0700 (PDT)
Received: by 10.87.15.35 with SMTP id s35mr7958346fgi.12.1271930380446;
        Thu, 22 Apr 2010 02:59:40 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d4sm1466690fga.20.2010.04.22.02.59.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 02:59:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <20100422094153.GA504@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145514>

On 04/22/2010 11:42 AM, Jonathan Nieder wrote:
> Junio C Hamano wrote:
>=20
>> The true story is a bit different.
>>
>> To avoid information leak to git-daemon clients, we deliberately cho=
ose
>> not to give detailed error messages, so that you cannot tell if an e=
rror
>> means a user "u" does not exist or "u" does but ~u/repo.git reposito=
ry
>> does not exist.
>=20
> Thanks for the clarification.  As I see it, these are two different
> classes of problem:
>=20
> 1. The git daemon is very quiet, usually for good reason, as you
>     mentioned [1] [2].
>=20
> 2. The git daemon and protocol helpers do not always send the datum =E2=
=80=9Ca
>     controlled fatal error occured=E2=80=9D by writing some message (=
any
>     message) to side band 3.
>=20
> [1] I do suspect that in the case of failing enter_repo() or missing
> git-daemon-export-ok, saying =E2=80=9Ccannot read the specified repo=E2=
=80=9D would be
> fine.  Most of the time, there is not much value in disclosing a more
> detailed reason, anyway.
>=20

That would make it possible for random attackers to determine whether
a specific user exists on the system, which is very bad indeed.

> [2] Example fix for a problem in this class:
> http://thread.gmane.org/gmane.comp.version-control.git/139029

That's a different problem. We only end up in {send,receive}-pack if
the remote user asked for an existing repository, which means he or
she is either a very determined guesser or, more likely, already
knows that the user exists and where he or she keeps git repos. A
possible issue, to be sure, but definitely a far narrower window
than just guessing a username.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
