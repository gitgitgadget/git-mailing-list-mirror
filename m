From: Thomas Schlichter <thomas.schlichter@web.de>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Mon, 17 Aug 2009 07:25:09 +0200
Message-ID: <200908170725.09592.thomas.schlichter@web.de>
References: <200908161557.26962.thomas.schlichter@web.de> <7veirb5z9a.fsf@alter.siamese.dyndns.org> <be6fef0d0908162158y429c4b5fgb9138151446e39ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	willievu <willievu@dev.java.net>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 07:25:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcuig-0000k4-60
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 07:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbZHQFZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 01:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbZHQFZL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 01:25:11 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57163 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZHQFZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 01:25:10 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id DA331114C0445;
	Mon, 17 Aug 2009 07:25:10 +0200 (CEST)
Received: from [92.207.103.184] (helo=netbook.localnet)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1McuiU-00057X-00; Mon, 17 Aug 2009 07:25:10 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.28-14-generic; KDE/4.3.0; i686; ; )
In-Reply-To: <be6fef0d0908162158y429c4b5fgb9138151446e39ef@mail.gmail.com>
X-Sender: thomas.schlichter@web.de
X-Provags-ID: V01U2FsdGVkX18H9walef/jgjl07DiYrdJHHpjaeLI8mRuiUBZQ
	rYz8GZI0EcZ+fvRfRT9Nyz++N7MBdWT/qi0JixjThHAHJMkWyF
	oq+VFBIKVk8qfcuiLgwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126119>

Hi,

Am Montag 17 August 2009 06:58:25 schrieb Tay Ray Chuan:
> Hi,
>
> On Mon, Aug 17, 2009 at 3:34 AM, Junio C Hamano<gitster@pobox.com> wrote:
> > The report said:
> >
> >    MKCOL 98fd7fb8f32843c1bb40bd195a2f1cd6cab0751d failed, aborting
> > (22/409)
> >
> > As far as I can see you are trying (in http-push.c::start_mkcol()) to
> > create the two-hexdigit fan-out directory (i.e. "98" for this example);
> > it is strange to see a request to create the full 40-hexdigit collection
> > in the first place.
>
> Yes, you're right, but git prints out the full SHA-1 hash even though
> it is actually referring to the 2-hexdigit directory that it failed to
> create/verify, for whatever reason.
>
> > In another thread you responded to earlier:
> >
> >  
> >  http://thread.gmane.org/gmane.comp.version-control.git/125933/focus=1259
> >72
> >
> > the original report did not give the exact error message, but in that
> > one, instead of failing to create 40-hexdigit collection like this, I am
> > guessing that it fails with something like "MKCOL 'refs' failed".
>
> I guess by "original report" you refer to Thomas' initial email: yes,
> he (unwittingly) did provide theerror code in the subject line, the
> part which says (22/409). It actually means (<curl return code>/<http
> return code>). Referring again to
> http://www.webdav.org/specs/rfc4918.html#rfc.section.9.3.1:
>
>   409 (Conflict) - A collection cannot be made at the Request-URI until
>   one or more intermediate collections have been created. The server
>   must not create those intermediate collections automatically.
>
> meaning one or more parent directories weren't created.
>
> Based on this and his procedure, I'm guessing that there's something
> wrong with his setup.
>
> > *1* Not necessarily in the sense the client is broken but in the sense
> > that the server-client combination does not work for the reporter.
>
> Indeed.

Hmm. I hope you won't take this as an argument for not fixing it, because it 
is a clear regression! I tried git version 1.6.3.4, and it works flawlessly 
with exactly this server! Even during bisecting, some versions worked, some 
didn't (these after the mentioned commit...)

So I think this commit didn't only refactor things, but unintentionally 
changed the behavior. And this must be the problem. As I'm not into this code, 
and the refactoring was not completely trivial, I was not able to quickly find 
the place where the behavior was changed...

Kind regards,
Thomas Schlichter
