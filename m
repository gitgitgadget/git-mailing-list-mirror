From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Wed, 19 Feb 2014 07:33:15 +0700
Message-ID: <CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com> <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
 <xmqq4n3warni.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 01:33:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFv6k-0001QR-N6
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 01:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbaBSAdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 19:33:46 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:62479 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbaBSAdq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 19:33:46 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so27195022qcy.11
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 16:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/+dpqFxelH98qe8Z6ayznU0Y3byfUnrTw+bI6nWgEvs=;
        b=yMR7eVlsStnUCFp8HOUgXx+zUVw8yTQNxWyoRTB++fRDz0UGylNw1qe2gYGYsboF/o
         rDo7AUr/wBmh+MPc/ZwP4pog7iutXgr9wkhdik6SWEO/uGAMPLLaUNJR79rXeHMPhJk0
         ttP/9/xDKo0FZ/E4B2Ot+qN77SAMtYJiyTXyDI9LI9TDJYdCsnve5AJEKW9KzkXZePh8
         9Y9VD2DQxfPcARQHcjBU7t74QzUY3bbY62bszb1NXDiq7/U9H8EP6CTQSK1X7JuK01IS
         uggZqCVh+N19DbbwTnBB92iEI5fhDZ9gxVuAfBLGP9iXvLicWlDR777KxHbUxg4SCUS2
         VSJg==
X-Received: by 10.140.98.203 with SMTP id o69mr6220104qge.102.1392770025496;
 Tue, 18 Feb 2014 16:33:45 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Tue, 18 Feb 2014 16:33:15 -0800 (PST)
In-Reply-To: <xmqq4n3warni.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242381>

On Wed, Feb 19, 2014 at 7:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Lower depth than default (50) does not sound "aggressive" to me, at
>> least from disk space utilization. I agree it should be configurable
>> though.
>
> Do you mean you want to keep "--aggressive" to mean "too aggressive
> in resulting size, to the point that it is not useful to anybody"?

git-gc.txt is pretty vague about this --aggressive. I assume we would
want both, better disk utilization and performance. But if it produces
a tiny pack that takes forever to access, then it's definitely bad
aggression.

> Shallow and wide will give us, with a large window, the most
> aggressively efficient packfiles that are useful, and we would
> rather want to fix it to be usable, I would think.

fwiw this is the thread that added --depth=250

http://thread.gmane.org/gmane.comp.gcc.devel/94565/focus=94626

yes, if reducing depth leads to better performance and does not use
much disk in general case, then of course we should do it. "General
case" may be hard to define though. It'd be best if we have some sort
of heuristics to try out different combinations on a specific repo and
return the "best" combination of parameters. It could even take longer
time, but once we have good parameters, they should remain good for a
long time, I think.
-- 
Duy
