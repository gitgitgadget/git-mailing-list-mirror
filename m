From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4 move/delete errors
Date: Fri, 9 Jul 2010 22:21:05 +0200
Message-ID: <AANLkTin7eMFXT1FwZ2ojcAYgqIMSYnkz-uCoRlHvV6Tm@mail.gmail.com>
References: <AANLkTinN0Av1CO7mZU-QKeApq43UmEykUV093eyTtKQN@mail.gmail.com>
	<AANLkTikPHJuf5JUe096BWTWO_oF9u3gNlVNuw7Ik32WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lance Linder <llinder@gmail.com>, git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 22:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXK4S-0007sv-QX
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 22:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab0GIUVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 16:21:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50423 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab0GIUVJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 16:21:09 -0400
Received: by bwz1 with SMTP id 1so1355437bwz.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NDnw3Ciq7EFVm5kkWL3NeD5kvWkWPy82V47cBhNIqlU=;
        b=p66BZ85JcG05DsoKoQnXAixOkxstyXsrTBcKxO6LHiWq1Be6Rh9pHUMyR0DANaHff6
         SJQSQPnEjVPk/tj+4bpsVp1o04RR+x6as2++o0nvPeMOYQuZuZOOW9JuvAiGSWTHs8D8
         hgTLxe9MVTEGqlJdAbZEjAE+LRXBWPG+/rGr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KZaIw7z9zCXdsBEjIm3PKVOx80n2HMfOmPVAZPJm15r3s/NdjbtX36S/MEGRKd9VeQ
         kBncITzfuA4tL0uHx046kwTVPuvwumfu75a6RpwpI8L9+AnCNyF/sIDtxfWrct9DHI5Y
         NmYTYuXppq/bTmKzMQ2xo1oa+QFClSi+JGvEE=
Received: by 10.204.45.207 with SMTP id g15mr7637687bkf.14.1278706865090; Fri, 
	09 Jul 2010 13:21:05 -0700 (PDT)
Received: by 10.204.98.146 with HTTP; Fri, 9 Jul 2010 13:21:05 -0700 (PDT)
In-Reply-To: <AANLkTikPHJuf5JUe096BWTWO_oF9u3gNlVNuw7Ik32WQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150685>

On Fri, Jul 9, 2010 at 5:05 PM, Thomas Berg <merlin66b@gmail.com> wrote=
:
> Hi,
>
> On Fri, May 28, 2010 at 2:30 AM, Lance Linder <llinder@gmail.com> wro=
te:
>> Until recently I have been successfully using git-p4 with much joy a=
nd
>> happiness. Then suddenly git-p4 submit started throwing "Command
>> failed: p4 diff -du ..." when ever I delete or move a file.
>>
>> We recently upgraded our perforce server ( Rev.
>> P4D/NTX86/2009.2/238357 (2010/03/15) ). It was about this time that
>> the problem came up. First thing I did of course was upgrade to the
>> latest version of git ( now on 1.7.1 ) but the problem still persist=
s.
>> Next I updated my p4 client ( Rev. P4/MACOSX104U/2009.2/238357
>> (2010/03/15) ) but still same problem. All other submits work fine a=
s
>> long as there are not any deletions or moves.
> [...]
>>
>> Anyone else seeing these issues?

Hi. Are any of you using Perforce's "keyword expansion" stuff? I mean
the thing where you put a:

$Id$

keyword in a file, and it expands to something like:

$Id: //depot/test/main.c#10 $

If I do that (and, unfortunately, people at my $dayjob do do that),
I'm almost sure that this is the error I got... The reason seems to be
that when git imports the file from P4, the keyword expansions get
stripped off (as in: reset to just $Id$). And then the p4 diff fails
if the $Id$ type lines are included in the diff. When deleting a file,
all lines are included in the diff...

It hasn't itched me hard enough that I have tried hard to solve it
(unfortunately). I simply do deletes from P4 instead of git-p4 :-/

-Tor Arvid-

> Indeed, we just upgraded our Perforce server too, and now I'm getting
> this exact error. Did you find a solution to the problem?
>
> If not I'm very interested in solving it. Seems like the p4 diff
> command has changed behaviour and broken the git-p4 script.
>
> Cheers,
> Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
