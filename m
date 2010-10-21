From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Thu, 21 Oct 2010 23:16:57 +0200
Message-ID: <AANLkTik3Di=dcC=CxW+Lou515E2wXq8_OaR99mghC+vF@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com> <7vhbgphf25.fsf@alter.siamese.dyndns.org>
 <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
 <7vbp6vduly.fsf@alter.siamese.dyndns.org> <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
 <20101018163134.GA6343@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 23:17:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P92Vq-0000jH-6P
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 23:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab0JUVRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 17:17:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53070 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab0JUVRU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 17:17:20 -0400
Received: by fxm16 with SMTP id 16so67911fxm.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=6bAMn3rSNzYAjd/MOkq4TmaT/5jcfs+qS5SeDMO4JLM=;
        b=SehlVb5lpWwJY34ar65C6aBr9KcDuo6ugCh1JqoOlHE1DRiOVnfsnEgG55JShZnntJ
         muaKG4EVNT4eKu8YA1nyD35MIyiXS61fCxsnQ5Qa2eALRv5Xg2i/uGBTuq3om9zg4lMG
         ngaNr8qzgerJqInawUjzQjeorrEpgY0pBCrTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=pkJilrn0O3/wx8Dvc7OfjXdst0CHoNk+Uc6m4n1s+d0ikDFAoTf/h4NWbaBV+Wc9Ye
         6lF4t3Y122n51SE6zOjLGycZQHV61GlM4gALxdizEXEBif904qjYF9S2irti26M5LiyN
         jrH1DXsw53ONtOrNamlMsvBIAIMumdG/BmOyA=
Received: by 10.223.71.208 with SMTP id i16mr34269faj.82.1287695838729; Thu,
 21 Oct 2010 14:17:18 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Thu, 21 Oct 2010 14:16:57 -0700 (PDT)
In-Reply-To: <20101018163134.GA6343@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159573>

On Mon, Oct 18, 2010 at 6:31 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> A response to the general questions.

Thanks!

> Erik Faye-Lund wrote:
>> On Fri, Oct 15, 2010 at 11:16 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>
>>> Why does the signature even have to be different between the two to=
 begin
>>> with? I _think_ you have gid_t over there
>>
>> We don't, so this is the primary reason.
>
> Just to throw an idea out: you can also do something like
>
> #ifndef NO_POSIX_GOODIES
> struct credentials {
> };
> #else
> struct credentials {
> =A0 =A0 =A0 =A0struct passwd *pass;
> =A0 =A0 =A0 =A0gid_t gid;
> }
> #endif
>
> and pass a pointer to credentials around.
>

Yes, but that structure still needs to be filled somehow. I'm not sure
how this solves anything, really. Isn't it essentially another way of
wrapping an ifdef around the parameters inside main() (at least when
I've inlined serve() into main())?

>>> This is especially
>>> true if you are making the "drop-privileges" part a helper function=
, no?
>>
>> I don't follow this part. What exactly becomes more true by having a
>> drop-privileges function?
>
> (See linux-2.6.git:Documentation/SubmittingPatches, section "#ifdefs
> are ugly".)
>
> The ideal: never an #ifdef within a function. =A0(Well, the ideal is
> no #ifdef-s in .c files, but that's harder to take seriously.)
>
> #ifndef HAVE_POSIX_GOODIES
> static int drop_privileges(...)
> {
> =A0 =A0 =A0 =A0return error("--user and --group not supported on this=
 platform");
> }
> #endif
> static int drop_privileges(...)
> {
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0do
> =A0 =A0 =A0 =A0something
> =A0 =A0 =A0 =A0...
> }
> #endif
>
> would make serve() look like
>
> static int serve(...)
> {
> =A0 =A0 =A0 =A0int socknum, *socklist;
>
> =A0 =A0 =A0 =A0... setup socket ...
>
> =A0 =A0 =A0 =A0if (want to drop privileges) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (drop_privileges(...))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return service_loop(socknum, socklist);
> }
>
> which should be quite readable even to a person only interested in th=
e
> !HAVE_POSIX_GOODIES case imho. =A0With some code rearrangement it cou=
ld
> be made nicer. =A0Now compare:
>
> static int serve(...)
> {
> =A0 =A0 =A0 =A0int socknum, *socklist;
>
> =A0 =A0 =A0 =A0... setup socket ...
>
> #ifdef HAVE_POSIX_GOODIES
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0do
> =A0 =A0 =A0 =A0things
> =A0 =A0 =A0 =A0...
> #endif
>
> =A0 =A0 =A0 =A0return service_loop(socknum, socklist);
> }
>
> Just my two cents. =A0Sorry I do not have something more substantive =
to
> say.
>

You're leaving out the troublesome part, namely the glue between "if
(user_name)" in main(), and the "want to drop privileges"-stuff in
serve().

I could do a "struct credentials *cred =3D NULL;"  in main(), and assig=
n
that inside "if (user_name)". But that'd leave a warning about
unreachable code in drop_privileges(), no?

I'm also getting the feeling that I'm being hinted at to implement
proper credential-dropping (ie filling out the windows-versions of the
code with something that makes sense for windows), but this isn't how
these things work on Windows. Daemons run as services on Windows, and
what user to run a service under is a system-administrator setting. In
fact, you can't even impersonate another user without having it's
password.

Turning git-daemon into a service is something that can be done later.
I've looked into it, and what seems to make the most sense is to have
a separate mode on git-daemon (or even another program), that starts
git-daemon as a subprocess. This is because of the way Windows
communicates with the service, requiring a message-loop that can be
terminated.
