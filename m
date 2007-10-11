From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Thu, 11 Oct 2007 08:47:13 +0200
Message-ID: <854pgytafi.fsf@lola.goethe.zz>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv>
	<470DC05A.8020209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 08:46:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifroa-0004Xe-Jm
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 08:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbXJKGq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 02:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbXJKGq1
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 02:46:27 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:48122 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbXJKGq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 02:46:26 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IfrnP-0004Ej-TX; Thu, 11 Oct 2007 02:45:24 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4515F1C1F3DC; Thu, 11 Oct 2007 08:47:13 +0200 (CEST)
In-Reply-To: <470DC05A.8020209@viscovery.net> (Johannes Sixt's message of "Thu\, 11 Oct 2007 08\:19\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60582>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jonathan del Strother schrieb:
>> +	cmt=`cat "$dotest/current"`
>
> This is ok, but...
>
>> +			prev_head="`cat \"$dotest/prev_head\"`"
>
> ... there are shells out there in the wild that will get badly
> confused by this sort of quoting and escaping. Butter use
>
> 	prev_head=$(cat "$dotest/prev_head")
>
>
>> -VISUAL="$(pwd)/fake-editor.sh"
>> +VISUAL="'$(pwd)/fake-editor.sh'"
>
> Huh? This looks very wrong.

It is correct, modulo breaking when there are single quotes in the
current path name.

> What are the extra quotes needed for?

Spaces in the current path name.

> If they are really needed, isn't this a bug in
> git-rebase--interactive.sh?

No.

> I question the usefulness of this patch. Why only fix breakage due
> to spaces in the path? What about single-quotes, double-quotes?

Double quotes would work.  Single quotes wouldn't.  You can do
something like

visualpath="$(pwd)"
export visualpath
VISUAL='"$visualpath/fake-editor.sh"'

and this should work in all circumstances where VISUAL is interpreted
as intended (which at the current point of time does not include git's
C callers).

> IMHO, it's not too much of a burden for developers to require "sane"
> build directory paths.

For a normal user, the only writable directories might be of the
"C:\Programs and Data\User settings\Karl"
variety.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
