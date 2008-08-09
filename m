From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [TopGit PATCH] tg-create.sh: Support for multiple {to,cc,bcc}
 options
Date: Fri, 08 Aug 2008 18:37:13 -0700
Message-ID: <7vbq039dfa.fsf@gitster.siamese.dyndns.org>
References: <1218141086-16063-1-git-send-email-bert.wesarg@googlemail.com>
 <20080809003357.GQ10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Aug 09 03:38:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRdPW-0008Ko-NB
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 03:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170AbYHIBhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 21:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753909AbYHIBhX
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 21:37:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbYHIBhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 21:37:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D4E234FA99;
	Fri,  8 Aug 2008 21:37:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C46FE4FA97; Fri,  8 Aug 2008 21:37:16 -0400 (EDT)
In-Reply-To: <20080809003357.GQ10151@machine.or.cz> (Petr Baudis's message of
 "Sat, 9 Aug 2008 02:33:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B608F922-65B3-11DD-8A06-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91740>

Petr Baudis <pasky@suse.cz> writes:

>> +	prefix="$(echo "$2" | sed -e 's/\//\\\\\//g')"
>
> Maybe use s### ? ;-)

Personally I like '|' instead.  It's much less visually distracting than #.

>> +
>> +	git config --get-all topgit.$1 2>/dev/null |
>> +		sed -e "s/^/$prefix /g"
>> +}
>
> Won't this return an error code and terminate the script in case no
> option is defined?

Exit code from upstream of a pipe does not affect the exit code from the
pipeline, and sed does not exit non-zero just because there was no
substitution.

>> -	! header="$(git config topgit.to)" || echo "To: $header"
>> -	! header="$(git config topgit.cc)" || echo "Cc: $header"
>> -	! header="$(git config topgit.bcc)" || echo "Bcc: $header"
>> +	get_multi_config to  "To:"
>> +	get_multi_config cc  "Cc:"
>> +	get_multi_config bcc "Bcc:"
>>  	! subject_prefix="$(git config topgit.subjectprefix)" || subject_prefix="$subject_prefix "
>>  	echo "Subject: [${subject_prefix}PATCH] $name"
>>  	echo
>
> One trouble here is that I've seen mailers mess up when there is
> multiple occurences of these headers, so it would be probably safer to
> concatenate them all to single line, comma-separated.

It is not just "I've seen mailers"; RFC2822 wants you to have at most one
(see the table on Page 20).
