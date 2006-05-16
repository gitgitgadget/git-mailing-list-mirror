From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Fix silly typo in new builtin grep
Date: Mon, 15 May 2006 22:10:38 -0400
Message-ID: <118833cc0605151910s7619ddf0x8f014adba2a1eba5@mail.gmail.com>
References: <Pine.LNX.4.64.0605151743360.3866@g5.osdl.org>
	 <Pine.LNX.4.64.0605151801100.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 16 04:10:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffp1G-0000U2-UA
	for gcvg-git@gmane.org; Tue, 16 May 2006 04:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWEPCKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 22:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWEPCKk
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 22:10:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:54175 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751043AbWEPCKj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 22:10:39 -0400
Received: by nf-out-0910.google.com with SMTP id o25so187652nfa
        for <git@vger.kernel.org>; Mon, 15 May 2006 19:10:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jRDS5BUU569pcCCNjcA/Sx7cMYOrv1yBAEhQOEHGjuya351T717BOMoYqzCtJ2d7QY2BiNez7xRIz167DiEAo+7Gz+rcKA333Z/2csFUtj9cqZ1DuKpJo5r61tWBhbg3fE6IGX07+sDUVKW5UK2vrBcQeTmpmhQHVOWye4fxHM4=
Received: by 10.48.47.7 with SMTP id u7mr4001485nfu;
        Mon, 15 May 2006 19:10:38 -0700 (PDT)
Received: by 10.49.12.11 with HTTP; Mon, 15 May 2006 19:10:38 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605151801100.3866@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20093>

If I read the code right, it calls regexec for every single character
on every single line.  No wonder that takes a while!  Just call it
once and it'll search for its match quite nicely.

If that's not enough, the two obvious optimizations are...

1. If the pattern contains no regexp characters  (and that is very
    common), do a strstr.

2. If the pattern must start with a specific character, search for that
    by itself.

M.
