From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC 2/2] format-patch: show notes as message after the
 ---
Date: Wed, 27 Apr 2011 08:37:51 +0200
Message-ID: <4DB7B9BF.6000009@drmicha.warpmail.net>
References: <cb2af8d1ef663a68ea96dbb916dcfa0aee71abcb.1303808057.git.git@drmicha.warpmail.net> <826def15eb7204ee30fc4c358f72103ec75b4e42.1303808057.git.git@drmicha.warpmail.net> <7vsjt4ewsy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 08:38:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEyNw-0000sR-5K
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 08:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab1D0Gh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 02:37:56 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53592 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752322Ab1D0Ghy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 02:37:54 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3B8602086D;
	Wed, 27 Apr 2011 02:37:53 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 27 Apr 2011 02:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=k+uCo9eZqUP9wPAufFY8zeVZ+ec=; b=WTIM7V4hFPGAaWrrA1ydFmrxexiwCU7Veivl25CrZbpNofT8iiABtEq+k1MgQ3/HxA0VdLq/DnserSD2sMb7LliwdscflDm/RC7zUuiMdRK5KNIW8pT+K6TCF8TgUmV14KGcmMoshcD/gIV2eRN+2z0hLXh9xS6MeP/CfCUVHgM=
X-Sasl-enc: 66xi8meMeyhdQlpXqzbRuSfbfKE1lp/a9S3F4qVMBwQ3 1303886272
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A3AFE440CAF;
	Wed, 27 Apr 2011 02:37:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vsjt4ewsy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172178>

Junio C Hamano venit, vidit, dixit 26.04.2011 19:39:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> When requesting notes with "--notes", "format-patch" produces notes
>> within the commit message which "am" misunderstands as being part of the
>> message.
>>
>> Change this so that notes are displayed after an additional "---". Any
>> "am" (old or new) will ignore that, so that it is a safe place for
>> additional comments:
>>
>> Log message
>> "---"
>> notes
>> "---"
>> diffstat
>> patch
>>
>> (The first "---" appears only when there is a note, of course.)
>>
>> Later on (say with "--format-notes") the output format can be changed
>> easily to accomodate a future "am" which knows how to create notes from
>> such patches.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> Reducing the output format to one "---" only is not only complicated (the notes
>> separator is generated in a quite different place from the patch separator)
>> but also unnecessary (am reads the patch anyways) and not even preferable (to
>> give a clear separation of the parts).
>> ---
> 
> If you show more than one note, separating them with "---" in between
> would be a good idea so that reader can tell where each note ends, but I'd

It does that already. More precisely, each note is preceded by a "---\n".

> rather not to see the "---" after the last note.  Put just a blank line
> here instead.

Well, in the note which you snipped, I tried to explain that that is
complicated (the note code would need to set a flag "dash_output" which
the log-tree code would need to look at) and may not even be preferable,
because the "---" gives a clear separation between the note and the
diffstat. I'll check whether there's an easy way (and provide a test).

Michael
