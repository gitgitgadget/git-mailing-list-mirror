From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Git Bug report
Date: Thu, 6 Oct 2011 12:54:14 -0400
Message-ID: <CABURp0pGatN=i2V8sycD=w7EedYxMFHbw6JZNVaQV0vYRG8Hww@mail.gmail.com>
References: <1317763443.17036.15.camel@skyplex> <20111005072235.GA12600@kolya>
 <7vlisz8jur.fsf@alter.siamese.dyndns.org> <20111006003318.GA9015@goldbirke>
 <7vobxv3q49.fsf@alter.siamese.dyndns.org> <20111006010940.GR2208@goldbirke>
 <CABURp0qCsKG2oOxLw4BfU8UM=9V+pigd69ZK=TZVwetBPqjuiA@mail.gmail.com> <7vy5wy145q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Federico Lucifredi <federico@canonical.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:54:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrDV-0001Bs-Dh
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758412Ab1JFQyh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 12:54:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39390 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab1JFQyg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 12:54:36 -0400
Received: by wwf22 with SMTP id 22so4570448wwf.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QNMXZ9V8V9zs4fgIyNVD7qYmhoNaNiuOEnKXWCMRLI8=;
        b=TJlCTUzqv1X5ly9dpcCW23BD2VD9apghKw++63QjoUE9D2/iLFaodhpsArgajINwCk
         uww7AJ4ZP+l99miw7O9o1KKHt7lKnrLEHTCUq8KXywhIt+dyejCMFCLxiPLuaQxR7PQs
         f3QFxmv9H+fxfQLMswBADVVHNsEGnF1HFysVY=
Received: by 10.216.190.131 with SMTP id e3mr1284910wen.48.1317920075266; Thu,
 06 Oct 2011 09:54:35 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Thu, 6 Oct 2011 09:54:14 -0700 (PDT)
In-Reply-To: <7vy5wy145q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182978>

On Thu, Oct 6, 2011 at 12:22 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> On Oct 5, 2011 9:14 PM, "SZEDER G=E1bor" <szeder@ira.uka.de> wrote:
>>>
>>> On Wed, Oct 05, 2011 at 05:44:54PM -0700, Junio C Hamano wrote:
>>> > SZEDER G=E1bor <szeder@ira.uka.de> writes:
>>> >
>>> > > And what about unreadable .git files?
>>> >
>>> > Having then inside a working tree is so sick that I do not think =
it
>>> > deserves consideration.
>>>
>>> I'm not sure why is this any different than having a .git directory
>>> that is not a repository inside a working tree.
>>
>> What should happen here? Ignore it and keep searching? Or fail?
>>
>> I just added some common gitfile detection code and I noticed that t=
he
>> oddball case now is the one that dies on error rather than continuin=
g to
>> search for alternate explanations. =A0I left the oddball behavior as=
suming it
>> is desireable, but now you have me rethinking it.
>
> Yeah, after thinking about it a bit more, whenever we see ".git" duri=
ng
> the upward discovery process, we should always warn if we know it is =
_not_
> a GIT_DIR before looking for another ".git" at higher levels, as anyt=
hing
> in that directory cannot be added. If we cannot tell if it is or is n=
ot
> a GIT_DIR, we should error out---the reason we cannot tell most likel=
y is
> because we cannot read it, and such a file, if it is not a GIT_DIR, c=
annot
> be tracked in the real GIT_DIR at a higher level, and if it is a GIT_=
DIR,
> we cannot use it to record updates or inspect existing history.
>
> How's that sound as a guideline?

Ok.  Three cases, then:

if .git is valid, we use it.
If .git is bogus, we warn about it and keep searching.
If .git is unverifiable (permissions, IO-fail, etc.), we die.

Phil
