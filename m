From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-send-email.perl: Really add angle brackets to In-Reply-To if necessary
Date: Sun, 09 Dec 2007 19:21:43 +0100
Message-ID: <851w9vsp8o.fsf@lola.goethe.zz>
References: <1197219900-19334-1-git-send-email-mh@glandium.org>
	<1197220648-20433-1-git-send-email-mh@glandium.org>
	<7v63z7rb87.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:22:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Qmu-0003hY-Hf
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbXLISVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbXLISVf
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:21:35 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:51767 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbXLISVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:21:34 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1J1QmT-0001go-0V; Sun, 09 Dec 2007 13:21:33 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 2C1DA1C4CE33; Sun,  9 Dec 2007 19:21:43 +0100 (CET)
In-Reply-To: <7v63z7rb87.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 09 Dec 2007 10:09:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67644>

Junio C Hamano <gitster@pobox.com> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> 3803bcea tried to fix this, but it only adds the branckes when the given
>> In-Reply-To begins and ends with whitespaces. It also didn't do anything
>> to the --in-reply-to argument.
>>
>> Signed-off-by: Mike Hommey <mh@glandium.org>
>> ---
>>
>> I just got bitten by this...
>
> Interesting.

Ouch.

>>  git-send-email.perl |    5 +++--
>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 76baa8e..1434eb2 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -367,10 +367,11 @@ if ($thread && !defined $initial_reply_to && $prompting) {
>>  	} while (!defined $_);
>>  
>>  	$initial_reply_to = $_;
>> -	$initial_reply_to =~ s/^\s+<?/</;
>> -	$initial_reply_to =~ s/>?\s+$/>/;
>>  }
>
> I wonder what the original rationale for these \s+ was.
> Will apply, anyway.  Thanks.

The original line read

	$initial_reply_to =~ s/(^\s+|\s+$)//g;

and was used just for stripping spaces (no stripping necessary when
there is no space, so \s+ was ok).  The change was supposed to work
on the brackets, too.

That Mike got bitten here is proof that the original idea had merit.
Too bad the implementation did not actually work.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
