From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 09 Sep 2008 15:38:15 +0200
Message-ID: <48C67C47.6000107@gnu.org>
References: <20080909132212.GA25476@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Tue Sep 09 15:39:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd3RL-0001yQ-97
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 15:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbYIINiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 09:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbYIINiW
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 09:38:22 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:55813 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbYIINiU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 09:38:20 -0400
Received: by gxk9 with SMTP id 9so10398582gxk.13
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=2OpsURgTUSJZ7sGdc7mQ5ZjcSzEAn8hbOc7AV1bzTcw=;
        b=C1cY3dOYS2O/WqDICjbCAvweljzNJRz2oZpnUcYxg1I2m6RbpkieZ/V98Bpbi+x+mX
         vqsendLSsJ0x7TMquCJSjI8bQ9USPCqyqpNWgWKgKZj4jkHn1lXCkg6Ul+CtwhNtB5dC
         IFawLWnQ6r3kmK+H3oXTkNWTs9lxQq7dD9Ybk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=kz10gyU9tN0PG+uPrtivhseiKwEYpniyrL0FfyH1rPPopTrdBy2yh1pyat+bJl9sZ0
         IPJuG1yynIrc2OG2p7vMwaKawgnls3yDEmiCDWeXgijijyVpwIh8v6KfU2CnSrsNTGOI
         iAboe0LTwtuz9efxBU9f7DgVx4wPJNxy9350k=
Received: by 10.103.173.5 with SMTP id a5mr11223074mup.117.1220967498214;
        Tue, 09 Sep 2008 06:38:18 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id u9sm24860423muf.9.2008.09.09.06.38.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 06:38:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080909132212.GA25476@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95383>

> - At the time of creation, the origin field contains a hash B which refers
>   to a reachable commit pair (B, B~1).  If B has multiple parents and the pair
>   being referred to needs to be e.g. (B, B~2), then the hash is followed by
>   a space and followed by an integer (base10, two in this case),
>   which designates the proper parentnr of B (see: mainline in git
>   cherry-pick/revert).

What about just storing *two* hashes?  This way cherry-pick can store
B~1..B and revert can store B..B~1.  The two cases can be distinguished
by checking which commit is an ancestor of which.

> - git cherry-pick/revert allow for the creation of origin links only if
>   the object they are referring to is presently reachable.

Will cherry-pick -x create origin links?  Also, does the origin link
propagate through multiple cherry picks?  If not, how can the origin
object not be reachable?

> [snip good stuff]

git cherry will use origin links to mark a commit as present, and will
only use patch-ids for commits that have no origin links.  Bonus points
for an extra command-line/configuration option to only use origin links:

  --source=default	  << default: get setting from core.cherrysource
  --source=patch-id
  --source=origin
  --source=origin,patch-id

  core.cherrysource = patch-id
  core.cherrysource = origin
  core.cherrysource = origin,patch-id

Thanks!

Paolo
