From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Enumerating all objects in the Git object store
Date: Fri, 26 Mar 2010 09:13:18 -0700 (PDT)
Message-ID: <m3zl1vhxjg.fsf@localhost.localdomain>
References: <a1138db31003260831q34967f69u9fc8de861f7931b1@mail.gmail.com>
	<4BACD86E.4020803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Richards <paul.richards@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 17:13:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvCAL-0005gT-S6
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 17:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab0CZQNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 12:13:22 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:60637 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0CZQNV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 12:13:21 -0400
Received: by fxm23 with SMTP id 23so2271984fxm.21
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ST/8yqMGUZozP0Fo0cHn9e7XXs2wChCbFoNUzwjc1iQ=;
        b=D2MBmzHrKPFNuDvwjtMnZQ04GJo4pkXgR9VRHo8cOPGmUZfs/NetNHNiXdcRGq57cb
         fxNMXECcPWUppC/e9eNVgzTBQKXStGsEKo1yn2aAKUrgLrnvm9H0l8etAMKCoXEEA45Y
         WnXY4JigV6vmJc/0yltF85vnCppIncGyIEABU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=FrDXx2YsH1/TpC7kaD4+pXWpSUgbdZRzI/Pqqy9YF2mODhvf3QGGy02u8575rqoyqa
         q9TDabmIVn0IlKdsnZlJRxGI+EXAMD2qx0lx8G7VzKIVZ4Je8bKubtYtFA/H0AX6BjSs
         3G1udw++DnP6bbowLLei4z7elqDzERqMxYITQ=
Received: by 10.102.240.16 with SMTP id n16mr586604muh.100.1269619999664;
        Fri, 26 Mar 2010 09:13:19 -0700 (PDT)
Received: from localhost.localdomain (abvh236.neoplus.adsl.tpnet.pl [83.8.205.236])
        by mx.google.com with ESMTPS id s10sm4501556muh.5.2010.03.26.09.13.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 09:13:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2QGClRo012923;
	Fri, 26 Mar 2010 17:12:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2QGCaZ7012919;
	Fri, 26 Mar 2010 17:12:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4BACD86E.4020803@viscovery.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143255>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 3/26/2010 16:31, schrieb Paul Richards:
> > Is there a way to enumerate all the objects in the Git
> > object store, and for each one figure out its type (commit, tree, or
> > blob) and obtain a list of the objects it references?  If not, is
> > there a way to do this for a single object at a time?  (I can then
> > simply recurse through the whole structure.)
> 
> Use 'git rev-list --objects --all' to find all objects connected to all
> refs (use something else than --all if you want to). Do *not* look at the
> path that the tree and blob objects have attached - it is not authorative
> information.
> 
> Use 'git cat-file -t' to find the type.

For performance it would be better to feed `git rev-list --objects --all`
output to `git cat-file --batch-check` instead.
 
> Use 'git cat-file -p' to pretty-print the content of an object. Parse it
> depending on the type that you find.

For performance it would be better to use `git cat-file --batch`...
but on the other hand side you would have to parse "binary" tree objects
representation.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
