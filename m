From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default
 values for user.*
Date: Fri, 07 Mar 2008 18:08:22 -0800
Message-ID: <7v7igeynl5.fsf@gitster.siamese.dyndns.org>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
 <20080305204414.GB4877@steel.home>
 <8aa486160803061345k690af0dcv14fe5d62b310ad6f@mail.gmail.com>
 <20080307164111.GB4899@steel.home>
 <8aa486160803071613pdacc88fkabc10f52da56ad5d@mail.gmail.com>
 <alpine.LSU.1.00.0803080223030.3975@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 08 03:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXoVB-00016x-R3
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 03:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896AbYCHCIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 21:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755835AbYCHCId
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 21:08:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbYCHCId convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 21:08:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF1A52C90;
	Fri,  7 Mar 2008 21:08:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A90812C8F; Fri,  7 Mar 2008 21:08:26 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803080223030.3975@racer.site> (Johannes
 Schindelin's message of "Sat, 8 Mar 2008 02:24:29 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76541>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 8 Mar 2008, Santi B=C3=A9jar wrote:
>
>> On Fri, Mar 7, 2008 at 5:41 PM, Alex Riesen <raa.lkml@gmail.com> wro=
te:
>> > Santi B=C3=A9jar, Thu, Mar 06, 2008 22:45:43 +0100:
>> >
>> > > On Wed, Mar 5, 2008 at 9:44 PM, Alex Riesen <raa.lkml@gmail.com>=
 wrote:
>> >  > > Santi B=C3=A9jar, Wed, Mar 05, 2008 20:18:04 +0100:
>> >  > >
>> >  > >  > @@ -171,7 +171,7 @@ static const char au_env[] =3D "GIT_AU=
THOR_NAME";
>> >  > >  >  static const char co_env[] =3D "GIT_COMMITTER_NAME";
>> >  > >  >  static const char *env_hint =3D
>> >  > >  >  "\n"
>> >  > >  > -"*** Your name cannot be determined from your system serv=
ices (gecos).\n"
>> >  > >  > +"*** Your name cannot be determined.\n"
>> >  > >
>> >  > >  Why not?
>> >  >
>> >  > Is this important? Or in another way, is this useful? The impor=
tant
>> >  > thing is how you can fix it. But others think otherwise I'll ch=
ange it
>> >  > to explain the reason.
>> >
>> >  It is precise explanation of what happened. It could be a hint to=
 fix
>> >  gecos field to someone. It is considered useful not to hide
>> >  information, even if you have no idea of how useful it is.

I'd agree with that reasoning on one condition, that is, msysgit folks
would adjust this to whatever gecos equivalent is called in the Windows
world ;-).

I do not personally think this part of the patch is so bad to waste you=
r
brain cells and time arguing about.  I would even suggest removing the
whole "cannot be determined" and just say "Please tell me who you are."

Yes, if you tell people that a lacking GECOS is the underlying reason t=
hat
you are getting this message, it would hint them an alternative solutio=
n
of talking to their sysadmin to get it fixed, and that one-shot fix wil=
l
last for all repositories on that machine (and machines that consult th=
e
same NIS/LDAP for name information).  However, the "config --global"
suggested in that message is also a valid one-shot fix, and hopefully
one-shot across machines that NFS mounts the home directories.  The lat=
ter
knowledge can hopefully be reused when you are forced to use git on
Windows, but the fix based on GECOS would probably not.

So I'd even argue that Santi's change to the message is an improvement
that removes geekspeak that is not particularly useful to the end user
in this context.

However, I would also say that this message improvement does not belong=
 to
user.default or whatever the configuration variable is called in this
round of proposal.  It should be a separate patch, and it would be a mu=
ch
easier sell than the rest of the patch series.

