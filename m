From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be
 depth-first, --parent option to execute command in supermodule as well
Date: Tue, 5 Mar 2013 16:17:05 -0500
Message-ID: <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com>
 <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
 <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org>
 <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com>
 <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Cousineau <eacousineau@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 05 22:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCzFA-00037P-94
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 22:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab3CEVR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 16:17:27 -0500
Received: from mail-vb0-f51.google.com ([209.85.212.51]:57582 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756370Ab3CEVR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 16:17:26 -0500
Received: by mail-vb0-f51.google.com with SMTP id fq11so1424836vbb.38
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 13:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aNYd/p1A3Xe+xnAuWpBfNGmlAWObH6CjcTBVtf3PIZE=;
        b=P3hCiUpWnGZz+Ny7+zUL4kC0Fi9lWvGU/QGqadY82PQCWLCs0DGjBQMkVxUHSaCjbN
         p1rR5JoA9zdm//zu7VvAzGnt+V+/6cygxokIfcsAC7epKQPXFWt4ojiFz7b6bJuSUkvc
         XAHShuQS9yjbIQBQLiMhCTSOPydC2X+2uJRnIXTQ1HdWIr9dV8/BNqAg4/6HCPqOgAXt
         2M+463q204jMw96fOQ1fSCG9FBFr+sPDUsgld8u4EOrXOc60RhKjEu/LtueNr1JZzYFS
         AMYW3lQg4W2y26Q7+5MgJWiLBTK/uZKSG20zRNX41lfwZKYs6IJ61JRUFTGf8hCX64gR
         sPbw==
X-Received: by 10.52.26.209 with SMTP id n17mr8936905vdg.26.1362518245501;
 Tue, 05 Mar 2013 13:17:25 -0800 (PST)
Received: by 10.58.201.103 with HTTP; Tue, 5 Mar 2013 13:17:05 -0800 (PST)
In-Reply-To: <51365AB6.2010602@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217481>

On Tue, Mar 5, 2013 at 3:51 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 05.03.2013 19:34, schrieb Junio C Hamano:
>> Eric Cousineau <eacousineau@gmail.com> writes:
>>> ...
>> I am not entirely convinced we would want --include-super in the
>> first place, though.  It does not belong to "submodule foreach";
>> it is doing something _outside_ the submoudules.
>
> I totally agree with that. First, adding --include-super does not
> belong into the --post-order patch at all, as that is a different
> topic (even though it belongs to the same use case Eric has). Also
> the reason why we are thinking about adding the --post-order option
> IMO cuts the other way for --include-super: It is so easy to do
> that yourself I'm not convinced we should add an extra option to
> foreach for that, especially as it has nothing to do with submodules.
> So I think we should just drop --include-super.

I agree it should not be part of this commit, but I've often found
myself in need of an --include-super switch.   To me,
git-submodule-foreach means "visit all my .git repos in this project
and execute $cmd".  It's a pity that the super-project is considered a
second-class citizen in this regard.

I have to do this sometimes:

   ${cmd} && git submodule foreach --recursive '${cmd}'

I often forget the first part in scripts, though, and I've seen others
do it too.  I usually create a function for it in git-heavy scripts.

In a shell, it usually goes like this:

   git submodule foreach --recursive '${cmd}'
   <up><home><del>{30-ish}<end><backspace><enter>

It'd be easier if I could just include a switch for this, and maybe
even create an alias for it.  But maybe this is different command
altogether.
