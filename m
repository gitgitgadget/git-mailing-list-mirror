From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] http-backend: Don't infinite loop during die()
Date: Wed, 24 Mar 2010 13:25:36 -0700
Message-ID: <ec874dac1003241325y43fdec78gfbb3d115e1aaa1b0@mail.gmail.com>
References: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org> 
	<20100322142204.GB8916@spearce.org> <7vvdclk1y9.fsf@alter.siamese.dyndns.org> 
	<20100324200658.GA22505@spearce.org> <alpine.LFD.2.00.1003241623370.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Brady Catherman <brady@catherman.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Mar 24 21:26:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuX9O-00029v-Lx
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab0CXUZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 16:25:58 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:50151 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab0CXUZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 16:25:57 -0400
Received: by pxi36 with SMTP id 36so2617301pxi.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 13:25:57 -0700 (PDT)
Received: by 10.142.202.7 with SMTP id z7mr2354992wff.267.1269462356140; Wed, 
	24 Mar 2010 13:25:56 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003241623370.694@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143118>

On Wed, Mar 24, 2010 at 1:24 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Wed, 24 Mar 2010, Shawn O. Pearce wrote:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>> > "Shawn O. Pearce" <spearce@spearce.org> writes:
>> >
>> > > If stdout has already been closed by the CGI and die() gets call=
ed,
>> > > the CGI will fail to write the "Status: 500 Internal Server Erro=
r" to
>> > > the pipe, which results in die() being called again (via safe_wr=
ite).
>> > > This goes on in an infinite loop until the stack overflows and t=
he
>> > > process is killed by SIGSEGV.
>> > >
>> > > Instead set a flag on the first die() invocation and perform no
>> > > action during recursive die() calls. =A0This way failures to wri=
te the
>> > > error messages to the stdout pipe do not result in an infinite l=
oop.
>> >
>> > Hmm. =A0I would need something like this on top, but there must be=
 a better
>> > way. =A0Ideas?
>>
>> Ick.
>>
>> Just exit(0) if dead is true.
>
> Do you really want the exit code to be 0 if you're dying?

IIRC, yes.  If we exit non-zero Apache really freaked out.  That was a
big part of my motivation to write the die_webcgi handler.

--=20
Shawn.
