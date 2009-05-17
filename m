From: Ammon Riley <ammon.riley@gmail.com>
Subject: Re: [PATCH] Fix minor memory leak in init-db
Date: Sat, 16 May 2009 21:07:40 -0700
Message-ID: <cd3664ac0905162107t7ebca943p1722685a8484f08e@mail.gmail.com>
References: <cd3664ac0905141522s3ad78411o9f015d2e7720c8b5@mail.gmail.com>
	 <7vzldclt33.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 06:11:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Xim-0007AK-8U
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 06:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbZEQEHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 00:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbZEQEHk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 00:07:40 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:5548 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZEQEHj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 00:07:39 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1571456yxj.1
        for <git@vger.kernel.org>; Sat, 16 May 2009 21:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fqW4IgYI9OadYx9DmXyM8sDMkAW9e+1aZOYIIdezUn4=;
        b=q5Q1/u7GrLgqLDWVOQ9FDDfrMJPYxTT2g3bZNufNWvtI6rE6LKp9mqe21vHXa9Z6IF
         xuudhPq81CSi2QbaBw1nSZxUE6XV5vZ1a3x81rGgRj+6ECDbsbHtTocsjqrS4tyhef+I
         Qg/bCwJwIfc4txQRnnZxgNGB1HLA7QxxVb38Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RjxQTtBaz+CoOU1Wn7xCNt5TpTqyNDY2mh0AtoSAK/39OGtZ9/VZOQP5/weBkDuqnq
         /Aw1ywPsvmslT8bpocQE7BsV7pt1aTHgm5wQ0clxpF/cEGTHHZV3S/DYUeanNv4APWRu
         Qm62QqUYkHf7r/ejnFsRho9NfbUskBJMEaWzw=
Received: by 10.100.121.12 with SMTP id t12mr6453361anc.58.1242533260552; Sat, 
	16 May 2009 21:07:40 -0700 (PDT)
In-Reply-To: <7vzldclt33.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119385>

On Sat, May 16, 2009 at 12:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ammon Riley <ammon.riley@gmail.com> writes:
>
>> There was an xmalloc() for path, but I didn't see a corresponding free().
>> Does it happen somewhere else that I'm not expecting?
>
> It implicitly happens in exit() in git.c:handle_internal_command()
> after cmd_init_db() returns the control to it.

Ah. Naturally. :)

So if I were to write a long-lived application (such as a custom UI) that
links to libgit, and bypasses those functions to call init_db() (and other
functions) directly, all those implicit free-on-exit() turn into memory
leaks.

Cheers,
Ammon
