From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 22:04:47 +0200
Message-ID: <CAHGBnuM=QqLxPNNZmoL1jG+oAm2y6o=AuBtkH+FRwZ_8ahGC+w@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
	<xmqqppscij8a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 22:04:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKZbp-0001YZ-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 22:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab3IMUEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 16:04:49 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:45516 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab3IMUEs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 16:04:48 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so1397120lab.20
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 13:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QO8zCpt+inCoHaAb7xVvon6La/FiMzw9kAYYArmmo2U=;
        b=Aj3LqtKCEqkNAzt3h8xZT13udumjkSd5t3Nw5Up18iM05xTqP3X+xbJ7hOfDVMPzGV
         iVPsYjvg8mbgGXGCUDhoFTDXq538W5WpmE5itx/hwkyE2nFbV8I87mzsr+XlLRE0CKUM
         PxszCpalX6c4RM28Ms//cORDNtJfkVEydcTdUpAYWRogWQ36Tq7PBJWRqiZLXuKqjr9Q
         gsMt/9KD5PKUlK/qIRzWdtEiSEWbaHxf6Y6yaOGYkoXKxOhPVeou4zboosH2qzYkk10h
         pZ5PCli9Yc+vbpIip6afkG3Zq+yJWNYMnz07jhz26zSJEMBAVWP5fPHpYaIwX5wUwKeG
         RnPw==
X-Received: by 10.152.120.73 with SMTP id la9mr12207449lab.3.1379102687347;
 Fri, 13 Sep 2013 13:04:47 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Fri, 13 Sep 2013 13:04:47 -0700 (PDT)
In-Reply-To: <xmqqppscij8a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234769>

On Fri, Sep 13, 2013 at 10:01 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> I don't like the idea of introducing a compat/mingw/string.h because
>> of two reasons: You would have to add a conditional to include that
>> string.h instead of the system one anyway,
>
> With -Icompat/mingw passed to the compiler, which is a bog-standard
> technique we already use to supply headers the system forgot to
> supply or override buggy headers the system is shipped with, you do
> not have to change any "#include <string.h>".
>
> Am I mistaken?

Ah, that would work I guess, but you'd still need the include_next.

-- 
Sebastian Schuberth
