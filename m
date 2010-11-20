From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [RFC] rebase: use @{upstream} if no upstream specified
Date: Fri, 19 Nov 2010 19:26:57 -0500
Message-ID: <AANLkTikWYVyCf9mueoAHjGcQuNOdPFyQrmtW79As4RG-@mail.gmail.com>
References: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<20101113095140.GH8911@home.lan>
	<AANLkTin+3FuuX_pavZQMrbi4qxjTRvM7nHk1PXcFbeiZ@mail.gmail.com>
	<20101119211533.GA18942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@free.fr>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 20 01:27:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbIK-00078q-Uk
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab0KTA1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 19:27:00 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41363 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0KTA1A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 19:27:00 -0500
Received: by qyk32 with SMTP id 32so287542qyk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Vgy+WmyJy7fnRy79OLSjLK2kaBwgvnYz1Q6CaLn5fpo=;
        b=Wd/njenDWvCjJT+W/bgMsZDtxB0FieMtPEJYZdYNq87aMWpiujSUavKOI1PZsso+ZP
         AnqhbAiMpPHWX5omhlApqw+NwypJiMZiTLB9+42+TBphLWsUnppCsPEF9bjO83sovENQ
         cCJzpfZCwTzMIr9ned4ib/1cUk70xvJVyzDBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QJAji6eB00TeGOwZDLLRdXxz1E8CiHOjD0kZyZrkzwPQrPn+KRPAMx0Riykp04OtYp
         YWoKmzuM3wHNmHIouwMiUQaz9h58engop0EYDqrlS4tY8Er/231tJRcPrmKyKuHDGRYc
         jLyabEMstcD8LlAiC7XXmfh715wQWaMS7Ydgg=
Received: by 10.224.191.196 with SMTP id dn4mr130751qab.225.1290212817505;
 Fri, 19 Nov 2010 16:26:57 -0800 (PST)
Received: by 10.224.80.202 with HTTP; Fri, 19 Nov 2010 16:26:57 -0800 (PST)
In-Reply-To: <20101119211533.GA18942@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161797>

On Fri, Nov 19, 2010 at 4:15 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 16, 2010 at 09:29:46PM -0500, Martin von Zweigbergk wrote=
:
>
>> > What about simply checking if "rev-parse @{u}" succeeds, in which =
case
>> > we can use upstream_name=3D@{u} ? =C2=A0If it fails, then we can d=
o the work
>> > of finding where the config flaw is (and delegate this to a func).
>> > That would help keep the nominal code path short.
>>
>> Will make sure to find out the error only when needed as you suggest=
=2E
>>
>> I thought I would need the ref name to be able to walk the reflog if=
 my
>> other propasal would be accepted (see
>> http://thread.gmane.org/gmane.comp.version-control.git/161381), but =
it
>> seems to work with @{u} as well. I just adapted the call from 'git p=
ull'
>> (git-parse-remote.sh), but I guess I could use 'git rev-parse @{upst=
ream}'
>> instead. It does seem more natural to me.
>>
>> Maybe one of the guys on the CC list can advise?
>
> I'm not quite sure I understand the question, coming into the middle =
of
> the conversation. If you want to know "can I traverse the reflog of t=
he
> upstream with @{u}", the answer is yes. We dereference the ref first
> (similarly, foo@{u}@{3.days.ago} looks at the upstream branch's reflo=
g).
> If you want the refname, you can also use "git rev-parse
> --symbolic-full-name @{u}".
>
> Does that help?

Yes, I did try that and I noticed that it worked, but it helps to know
that it is not just by accident. I realize I was not very clear, but
what I really was wondering if there is any advantage to using
"git for-each-ref --format=3D'%(upstream)' ${branch_name}" (as used by
git pull) as compared to "git rev-parse @{upstream}" as suggested by
Yann. ($branch_name in this case would be the current branch.)
