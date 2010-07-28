From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: finding if a commit is needed
Date: Wed, 28 Jul 2010 18:23:38 +0930
Message-ID: <AANLkTin4o=uNBFELYMb8TDA=taGJyqpLvgxZcPFr+Pq+@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 10:53:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe2OW-00059Y-Rm
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 10:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab0G1Ixk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 04:53:40 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61964 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab0G1Ixj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 04:53:39 -0400
Received: by pwi5 with SMTP id 5so782993pwi.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 01:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to:date
         :message-id:subject:from:to:content-type;
        bh=zFvic5ObjaBtEVVWiPNo5OOkEu6W+fCZeKGF3kBm9DU=;
        b=JzpCSwDvEUlTMvkzgbpQ/9CZpUkTYJ94xI/U2JMycHxRaA5fB1qpF+fDJKk4Jc6/f/
         7CLagQfSfYPEzp9zabFbaUHMwjMtnzghxVkT9ktT8nIvKIf6LcdBLv4RfFAUIcZMkIzb
         k3+/KgPsbgqxKFIkIVN8ElgDCSUFpC6EUhlEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=Jb6TeEyY9YxC4A+4q9JDrKOAsnCzGsL/2ILl5KgEE7SuYH38FzeOiaMwAQD4ddjyYA
         S8AzHi+YBvVpztHCOl5aVYOr+yOAD/hXx5wOBuslgoRmU+VycCochMw+NktUuW3DlZbk
         RMepyaj0ZvJxrXrkIIY+O+mG40Ud3XtauBvPA=
Received: by 10.142.132.12 with SMTP id f12mr8143354wfd.281.1280307218725; 
	Wed, 28 Jul 2010 01:53:38 -0700 (PDT)
Received: by 10.143.9.14 with HTTP; Wed, 28 Jul 2010 01:53:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152058>

We have an interface which "rolls back" commits to a previous time in
a set of data files using read-tree.

Works great ... but sometimes there are files which have
been changed in the working tree which cause read-tree to fail.
The files should have been committed but weren't.
"git read-tree -i" isn't appropriate because
we want to commit these files before the read-tree rolls
them back ... because they are changes which might be
resurrected and we don't want to lose them altogether.

So ...

       git commit -a -m "something" && git read-tree ...

Doesn't work when there are no files which need committing ...

       git commit -a -m "something" || git read-tree ...

Doesn't work when there are.

Is there something which can test whether a commit is needed?

I define "needed" as meaning when git commit -a would make a non-identical
commit.

Many thanks,
Geoff.
