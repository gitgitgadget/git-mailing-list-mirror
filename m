From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Sun, 13 Jul 2008 15:44:29 -0700
Message-ID: <7vlk05o14i.fsf@gitster.siamese.dyndns.org>
References: <20080710170735.4c5b237a@linux360.ro>
 <7vskudr11m.fsf@gitster.siamese.dyndns.org>
 <32541b130807131432j78e5100dyea20893268321466@mail.gmail.com>
 <7vbq11qxfb.fsf@gitster.siamese.dyndns.org>
 <32541b130807131444s5e9ea0d6v9610dd5871467fc9@mail.gmail.com>
 <7vvdz9o2wu.fsf@gitster.siamese.dyndns.org>
 <32541b130807131521w79cbf23m5934678e68312798@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eduard - Gabriel Munteanu" <eduard.munteanu@linux360.ro>,
	ryan@michonline.com, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 00:45:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIAK9-0004RM-2j
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 00:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbYGMWoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 18:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755939AbYGMWoj
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 18:44:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914AbYGMWoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 18:44:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3669220BF;
	Sun, 13 Jul 2008 18:44:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EFE1D220BE; Sun, 13 Jul 2008 18:44:31 -0400 (EDT)
In-Reply-To: <32541b130807131521w79cbf23m5934678e68312798@mail.gmail.com>
 (Avery Pennarun's message of "Sun, 13 Jul 2008 18:21:05 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45272E9E-512D-11DD-9EC2-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88354>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> And it's the MDA's job to munge it, not the MTA, so the
> lines should never be munged while in transit *to* ...

Yeah, you're right.  Sending side should not have any issues like that.

My receiving end (I think fetchmail slurps from my ISP and drops mails in
my local mbox, but it's a long time ago I configured my system...) does
quote only the "From " at the beginning, which is consistent with the
traditional mbox behaviour, so I see one, one, two, three in my local
mbox, and zero, one, two, three on gmane news article.

If this additional option claims to produce a mbox, I think:

 (1) quoting only /^From / (not /^>*From/) to be consistent with the
     standard practice is the right thing to do; and

 (2) reading side might need to also pay attention to /^>From /, in case
     somebody feeds an output from this option back to send-email.

However, strictly speaking,(2) may break the standard workflow of
generating patches with format-patch and feeding the result to send-email,
as format-patch does not do /^From / munging (and it shouldn't).  The
issue is mostly theoretical --- it only matters if your commit log has a
line that begins with ">From ", and people who have worked with e-mail for
any nontrivial period have already learned to reword their sentences to
avoid lines that begin with "From " (or ">From ", for that matter) anyway.
