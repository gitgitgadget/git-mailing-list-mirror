From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] git-am: emit usage when called w/o arguments and 
 w/o patch on stdin
Date: Wed, 28 Jan 2009 10:15:48 -0800
Message-ID: <7v3af3thyj.fsf@gitster.siamese.dyndns.org>
References: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com>
 <780A42F8-E27C-404A-945C-38C16378EF57@ai.rug.nl>
 <76718490901280840g7d36aa96u3d0f98a709ac9fde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	sverre@rabbelier.nl
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 19:17:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSEyc-0004Yd-6a
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 19:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZA1SP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 13:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbZA1SP5
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 13:15:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbZA1SP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 13:15:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 48E7194EC4;
	Wed, 28 Jan 2009 13:15:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8FA2394EC1; Wed,
 28 Jan 2009 13:15:50 -0500 (EST)
In-Reply-To: <76718490901280840g7d36aa96u3d0f98a709ac9fde@mail.gmail.com>
 (Jay Soffian's message of "Wed, 28 Jan 2009 11:40:37 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4DE0B5A-ED67-11DD-A494-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107557>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Jan 28, 2009 at 11:18 AM, Pieter de Bie <pdebie@ai.rug.nl> wrote:
>> FWIW, I sometimes like to run 'git am', paste in a patch and hit ctrl-d.
>>
>> I can probably retrain my finger to use 'git am -', but I'm not sure if that
>> works (after this patch)? At least it's not mentioned in the manpage.
>
> "git am -" doesn't work (before or after this patch), but "cat | git am" will.

Another approach we've taken in other places to avoid the "Huh?" that
triggered this thread is to do something like:

        if there is no argument
        then
		if reading from tty
	        then
	        	echo >&2 "Reading from terminal, waiting for input..."
		fi
                process stdin	
	else
        	for arg
                do
                	process $arg
		done
	fi

Unfortunately, this will invalidate your "check -t 0 and error out" patch,
but some people may find it easier to work with and more friendly.
