From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Tue, 03 Aug 2010 08:37:02 +0200
Message-ID: <vpq4ofcb3sh.fsf@bauges.imag.fr>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
	<4C52E6E1.20101@xiplink.com> <vpqd3u53sd2.fsf@bauges.imag.fr>
	<AANLkTikMW=ueQXfjpXk8G2FLRN55j1aJsnNz2w19BmkH@mail.gmail.com>
	<vpqwrs9nxi5.fsf@bauges.imag.fr>
	<7vwrs8k978.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 08:37:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgB87-0002T6-C1
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 08:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab0HCGhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 02:37:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42949 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173Ab0HCGhd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 02:37:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o736Yxtd012248
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Aug 2010 08:34:59 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OgB7X-00063B-3A; Tue, 03 Aug 2010 08:37:03 +0200
In-Reply-To: <7vwrs8k978.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 02 Aug 2010 14\:15\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 03 Aug 2010 08:35:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o736Yxtd012248
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281422100.80007@k9wKrMxKk0s3c9ZtbH5qIQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152488>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> That's a good question. My original patch was running the command from
>> the toplevel, which is the natural way to implement it. I've changed
>> my mind to execute the command from the place where "git rebase -i"
>> was started (which means this has to be memorized in a temporary file
>> to be persistant accross "git rebase --continue"). I think this makes
>> more sense for the user, and I've actually already been biten by the
>> old behavior, running "rebase -i" from a doc/ subdirectory, and
>> wondering why my "exec make" was rebuilding the code itself.
>>
>> This comes with at least one drawback: if directory from which the
>> rebase was started didn't exist in the past, then we can't do a simple
>> "cd" to it. My implementation re-creates the directory temporarily, so
>> that the command can run, and cleans it up afterwards. The only really
>> problematic case is when the directory can not be created (like
>> directory/file conflict). It this case, the command is not ran, and
>> the script exits.
>
> Sorry to join the discussion after you have already coded it, but I don't
> think running the external command at a random subdirectory that the
> operation happened to have started makes much sense, as rebase is a
> tree-wide operation.  The user if s/he so chooses can chdir down (if the
> directory still exists in the revision in question) in the script, but I
> think the built-in behaviour should be to just run it from the toplevel.

I'm waiting for other people's opinion, since I'm still not 100%
convinced, but this seems to reflect the majority's opinion.

And the simplicity of the code also is an argument: even if the "I'm
too lazy to code it" is not applicable anymore, the simplest version
will also be the simplest to maintain.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
