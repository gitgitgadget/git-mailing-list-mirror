From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH for next] insert missing newline in a diagnostic
Date: Wed, 01 Sep 2010 08:04:14 +0200
Message-ID: <vpqeide0zkx.fsf@bauges.imag.fr>
References: <87iq2s4ewn.fsf@meyering.net> <20100901001729.GG6747@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 08:08:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqgUK-000454-G3
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 08:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab0IAGHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 02:07:55 -0400
Received: from imag.imag.fr ([129.88.30.1]:45158 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296Ab0IAGHy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 02:07:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8164EeQ023958
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 Sep 2010 08:04:14 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OqgQg-0007fK-IG; Wed, 01 Sep 2010 08:04:14 +0200
In-Reply-To: <20100901001729.GG6747@burratino> (Jonathan Nieder's message of "Tue\, 31 Aug 2010 19\:17\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 01 Sep 2010 08:04:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155017>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jim Meyering wrote:
>
>> When merging, I would get a message like this:
>> 
>>   error: The following untracked working tree files would be overwritten by merge:
>>   FILE_NAMEPlease move or remove them before you can merge.
>> 
>> This change inserts the newline after FILE_NAME.
>
> I fear it is more complicated.  With your patch, in some situations
> (e.g., when running t7609-merge-co-error-msgs.sh) I get a leading tab
> and extra newline:
>
>  error: The following untrack...
> 	FILE_NAME
>
>  Please move or remove them before you can merge.
>
> In unpack-trees, display_error_msgs() prints the version with a tab
> but you are getting the message from add_rejected_path which suggests
> to me that o->show_all_errors is unset.

That sounds like an explanation. The patch series did two things:
override plumbing error messages, and introducing show_all_errors. The
two are meant to work together, and clearly, if you set one without
the other, you get surprising results. A fix would be to make sure
that we set both in the same places.

Patch follows, untested. Jim, can you tell us whether it fixes the
problem? If not, can your give us a reproduction script (preferably as
a patch to t7609-merge-co-error-msgs.sh)?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
