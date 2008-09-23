From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Locking binary files
Date: Wed, 24 Sep 2008 01:54:22 +0400
Message-ID: <20080923215422.GV21650@dpotapov.dyndns.org>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com> <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com> <48D8983C.7070506@op5.se> <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com> <48D8A97E.8070003@op5.se> <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com> <alpine.LNX.1.00.0809231216350.19665@iabervon.org> <7v7i92tzgb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0809231551320.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mario Pareja <mpareja.dev@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFrB-00071M-5v
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbYIWVy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbYIWVy3
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:54:29 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:21455 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbYIWVy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:54:28 -0400
Received: by ey-out-2122.google.com with SMTP id 6so683893eyi.37
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 14:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CMtHSTi5q9iRV/slrpz4IYpIhyJDxWaPo45wVlsk6R4=;
        b=OV3aW8BQflet0bSQfGH2nFCJ/hwYP8dWu/e5Y8VkGZ7YSh3QwPUgUgBxGySN9r0u4d
         pwJwYS+DruqyLrSVF8Ojjz8kyLqShBu6RMKmyguyWqmRCtiBPKqHX3E5M5aTiZ4zeLbp
         FPg2nPA2PsaESc8g3Rz7qwIWCKdi4O94wcInw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u2WlFzj5G/mbuSMOqXR5M2StzxzJ4QZBAVfjkhzhVtEj/mP8TfGJEWLtXJUd+B+PvV
         +x0/t6Z13STy9+3uSux/nBl/VXfHo/vYKQ6z7twKBT5GvKVzSH9ickj/KI5xPNA9jWQF
         lYFyYQn2mcb7iTwbdkRqG2v9yRr7EuPMaYrHk=
Received: by 10.210.125.13 with SMTP id x13mr7245099ebc.187.1222206866047;
        Tue, 23 Sep 2008 14:54:26 -0700 (PDT)
Received: from localhost (ppp85-140-170-49.pppoe.mtu-net.ru [85.140.170.49])
        by mx.google.com with ESMTPS id 5sm3620899eyh.2.2008.09.23.14.54.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 14:54:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0809231551320.19665@iabervon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96606>

On Tue, Sep 23, 2008 at 05:13:29PM -0400, Daniel Barkalow wrote:
> 
> The lock needs to last until you push to the repository the lock is for; 
> otherwise you have the exclusive ability to make changes, but someone who 
> grabs the lock right after you release it will still be working on the 
> version without your change, which is what the lock is supposed to 
> prevent.

It still will happen if developers work on topic branches, and it is not
a rate situation with Git. Thus locking some particular path is stupid.
What you may want instead is too mark SHA-1 of this file as being edited
and later maybe as being replaced with another one. In this case, anyone
who has the access to the central information storage will get warning
about attempt to edit a file that is edited or already replaced with a
new version.

Dmitry
