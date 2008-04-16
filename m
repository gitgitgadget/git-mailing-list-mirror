From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH 2/3] git-svn: Add --add-author-from option.
Date: Wed, 16 Apr 2008 12:46:08 -0400
Message-ID: <32541b130804160946s343d53d2l271b9391d89a7953@mail.gmail.com>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com>
	 <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
	 <7vej96v2pk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Avery Pennarun" <apenwarr@versabanq.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 19:16:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmAms-0003Iv-CI
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 18:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbYDPQqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 12:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758592AbYDPQqO
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 12:46:14 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:54570 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbYDPQqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 12:46:12 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2862602fkr.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=e5WZ03k8FfvwVNZrC9CBUJ/Fkd/p4bPFMb+QcYKRlkI=;
        b=WZSCRfVTPZotarqPQIpmUsvPrKoNbZ43n9bz+CyMNliL8fEqYq5MDGd+bnNEZWEfunbznKajNuGGyFB0lDqAK8fhEYvVy+aKbYylQoV23/mWBfvEJQYFfCvJRLqoNEeBnMF/kf04Eqhtv4oVcYTpDhJDJX2acPz1Sj0jDQEKZvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r2wVeS4xFzVZN1rshqKm5eXIHffpS+HQFqVqm4BQkVBVrqGAoel12fFaiNJsUZOORaXrOIKDo+eAQfVRp6YYYTSH2/dQ0iVmzgsOm89RJyf2ufXvoqt9yQ6W9xowFPqsN5QzbtcHOfuPizy0QDnMRQGsd1bd3Gpmb4WrsFaOwOQ=
Received: by 10.82.145.7 with SMTP id s7mr272431bud.74.1208364368381;
        Wed, 16 Apr 2008 09:46:08 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 16 Apr 2008 09:46:08 -0700 (PDT)
In-Reply-To: <7vej96v2pk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79718>

On 4/16/08, Junio C Hamano <gitster@pobox.com> wrote:
> apenwarr@gmail.com writes:
>  > This adds a From: line (based on the commit's author information) when
>  > sending to svn.  It doesn't add if a From: or Signed-off-by: header already
>  > exists for that commit.
>
> I admit that I do not use git-svn, but I am confused.  Where are you
>  adding that "From:"?  You grab a commit log message out of git (which does
>  not have such "From:", add such a line at the beginning of the commit
>  message using the authorship information and send the resulting commit log
>  message to svn?  Why?

When git-svn copies a commit from git to svn, svn eats the authorship
information; it always sets the svn author field to the username of
the person logged into the svn server.

With the (existing) --use-log-author option, git-svn will pull From:
and Signed-off-by: lines from svn's log entries when pulling back into
git, which helps with this problem.  However, it only works with
commits that have a Signed-off-by: or From: already included.

The new option --add-author-from makes sure that every commit going
into svn *does* have a From: or a Signed-off-by: by adding one based
on the git Author field if it doesn't already exist.  Combined with
--use-log-author, this reduces the information loss in a round trip
through the svn server.  (And there's always a round trip, as "git-svn
dcommit" throws away your pre-svn commits and replaces them with the
commit it has put into, then pulled out of, svn.)

Does that make sense?

Thanks,

Avery
