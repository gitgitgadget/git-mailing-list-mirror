From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv2 1/2] git-rebase -i: add command "drop" to remove a commit
Date: Wed, 03 Jun 2015 10:52:14 -0700
Message-ID: <xmqqd21cy90x.fsf@gitster.dls.corp.google.com>
References: <1433152643-4292-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433152643-4292-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<xmqqvbf7757q.fsf@gitster.dls.corp.google.com>
	<563732680.250935.1433180720935.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqoakz1dke.fsf@anie.imag.fr>
	<150689518.4344.1433229813195.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqa8wiwo33.fsf@anie.imag.fr>
	<xmqqk2vm3udy.fsf@gitster.dls.corp.google.com>
	<787870724.57987.1433322837954.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:52:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Cpz-0003ih-LH
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbbFCRwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 13:52:19 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37067 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbbFCRwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 13:52:17 -0400
Received: by igbsb11 with SMTP id sb11so20773172igb.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NBN6q+0+6LcW/RFjWKrEj/Ogpqnu9efp/oNNiBHzF9w=;
        b=b+XO/ywjKnp0GPDA6Qc/vSc6XOJ7K9T3yUrH7lldCVVjMl1Xyw2EBqrcRPFvfyQHpN
         7udH3m5VAU5V0YqIR9W84866/abnQ8uIHPvg4HgKr8LxQ+Sfo26LMGfJj693c9uz2mEe
         Y9cZyECn+PMjpQV7xJgsXIPLHOvxVKYUxgsOeBqm2cNeRC5bRxg2f504KT2QeotYCdTa
         IOQjsyhyhBpwfSnx+CHW6cV8v5Fsu0CwwMBb4eUORjsTrTCpljb14p5F543sG+mjqN6+
         UfnvZ+cEn0jXKFNxPIcHLZvVX9+5H9uu2mKRsh+aoP4Y3of1P2zcQtsL8Le4tjDk+ZxT
         zQ5w==
X-Received: by 10.107.136.197 with SMTP id s66mr42880343ioi.65.1433353936830;
        Wed, 03 Jun 2015 10:52:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id u38sm15173871ioi.0.2015.06.03.10.52.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 10:52:16 -0700 (PDT)
In-Reply-To: <787870724.57987.1433322837954.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Wed, 3 Jun 2015 11:13:57 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270712>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> Junio C Hamano <gitster@pobox.com> writes: 
>> As long as what is given to 'drop' 
>> is checked when it matters (e.g. when the code in patch 2/2 tries 
>> see if some commits in the original list are no longer there in 
>> order to warn sees "drop foo bar" where "foo" is obviously not an 
>> object name in the original list, that should be checked), it is 
>> fine. And I agree 1/2 is not the place to do so, even though it may 
>> be easier from the implementation point of view (which is why I 
>> mentioned the possibility in the review of that patch). 
>
> I disagree, I think that that either the checking for the 'drop' 
> command should either be in the 1/2 where it is introduced or in the 
> function check_commits introduced by 2/2 but in a separate 
> commit/patch. 
> The 2/2 checks if there are removed commits to have the possibility to 
> avoid silent loss of information. It is not its role to check if the 
> SHA-1 following 'drop' are correct.

Suppose you started from this insn sheet:

    pick 2c9c1c5 gostak: distim doshes
    pick e3b601d pull: use git-rev-parse...
    pick eb2a8d9 pull: handle git-fetch'...

and then after letting the user edit, you got this back:

    pick 2c9c1c5 gostak: distim doshes
    drop e3b601d pull: use git-rev-parse...
    edit eb2a8d9 pull: handle git-fetch'...

In the new world order to punish those who simply remove lines to
signal that they want the commits omitted from replaying, you would
want to see all commit object names that was in the original insn
sheet appear in the post-edit insn sheet.  I'd presume that the way
to do so is to collect all the object names from each insn sheet and
compute the set difference.  The first one has three commit object
names, the same three commit object names appear in the second one,
and all is well.

But what if you got this back after the user edits?

    drop
    pick 2c9c1c5 gostak: distim doshes
    drop e3b601d pull: use git-rev-parse...
    edit eb2a8d9 pull: handle git-fetch'...

As a part of "collecting object names from the list before and after
editing into two separate sets, and computing the set difference in
order to notice potential mistakes", you would need to make sure
that you got these two sets collected _correctly_, but you do not
know from the above sample input what the user wanted to do with the
first line.  Did the user tried to drop something else but the
object name has gone missing by mistake?  Did the user wanted to
drop the first one but made mistake while editing 'pick' away into
'drop'?

Noticing and flagging malformed 'drop' lines (or line with any
command, for that matter) as such is part of that process to make
sure you collected the object names from the "after" image
correctly, which is the job of 2/2 in your series (if I am reading
the description of your series right).

So logically I would think 2/2 is where the verification should
happen, but doing it as a part of 1/2 may be easier to do.  The end
result would not make a difference, and that is why I said it would
be OK either way.

I am puzzled as to what you are disagreeing with, and why.
