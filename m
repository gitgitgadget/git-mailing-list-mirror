From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH/rfc] git-svn.perl: workaround assertions in svn library 1.5.0
Date: Mon, 21 Jul 2008 00:14:07 +0400
Message-ID: <20080720201407.GM2925@dpotapov.dyndns.org>
References: <20080706192850.32547.qmail@4480698c45f1ed.315fe32.mid.smarden.org> <20080717140856.10213.qmail@c0f13986110104.315fe32.mid.smarden.org> <37fcd2780807171137m1c5a8197vc94b2a42ac53a297@mail.gmail.com> <7vbq0tibuf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 22:15:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKfJN-0003cq-1p
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 22:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYGTUOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 16:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbYGTUOO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 16:14:14 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:32709 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbYGTUON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 16:14:13 -0400
Received: by fk-out-0910.google.com with SMTP id 18so713690fkq.5
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TxnjmraG0H5EgnCd5UoYP5cVMplOYlUjSkDGAIO3/fk=;
        b=QNwBjwid5BR7ooxDjGlgnQaNFKETstA7eleN81Xf2eO6MZpIKiv+jF5fy4UPKtrIDd
         UKPaoyDUac+PBR3IdaoLtsJFrGI1HGYFXuaYGjvrd58NEBHQZ1UV4Ch/h/kMS/BTX6Ft
         UNjNgAC/AKjYDwNLRPWrrTkmKiERZQ8CllWdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sz3UAVbeBuCeuUZC5Xw6GH7RQH70IpwlIErlajXtBKGN5J0+mx1k7kR9cVWxGQf4Xs
         uG/Nc5tTIoOAm2/iQe53Gacvjm9v8SWI0343vey7Dm3WOfNBshQap/VO23yS/2ODj8Gu
         Tz0+QKQAhN2WVbMlQFl0Pk8v1pdxbgVxg0KjY=
Received: by 10.181.31.17 with SMTP id i17mr1579944bkj.72.1216584851898;
        Sun, 20 Jul 2008 13:14:11 -0700 (PDT)
Received: from localhost ( [85.141.238.36])
        by mx.google.com with ESMTPS id d13sm11696909fka.3.2008.07.20.13.14.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jul 2008 13:14:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbq0tibuf.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89223>

On Sat, Jul 19, 2008 at 06:27:36PM -0700, Junio C Hamano wrote:
> 
> So what's the conclusion of this issue?
> 
> I'll just revert 2fe403e (git-svn.perl: workaround assertions in svn
> library 1.5.0, 2008-07-06) for 1.6.0-rc0 unless I hear better
> suggestions.

I have tested the change that I proposed, and it seems to solve the
problem and, as far as I can tell, no other correction is necessary.
Yet, I don't really understand git-svn well, so I could be wrong.

Reverting 2fe403e will only help users of svn library 1.4, while all
new linux distributives, which will include Git 1.6.0, are going to
install svn library 1.5.0, and if you use svn library 1.5.0, reverting
2fe403e does not fix anything but only add one more bug. Thus, unless
we are going to require to install git-svn only with svn library 1.4,
reverting this change does not seem to be very helpful for most users.

So, I hope my patch is better solution...

Dmitry

-- 8< --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Thu, 17 Jul 2008 22:32:02 +0400
Subject: [PATCH] git-svn: fix git svn info to work without arguments

commit 2fe403e7452bd6e1e8232445cf5434ce8f1af973 broke "git-svn info ."
due to replacing '.' with '' in canonicalize_path for the top directory,
while find_file_type_and_diff_status was not corrected.

Bug reports:

http://thread.gmane.org/gmane.comp.version-control.git/87822/
http://bugs.debian.org/490400

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a366c89..b00a91a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1226,7 +1226,7 @@ sub linearize_history {
 
 sub find_file_type_and_diff_status {
 	my ($path) = @_;
-	return ('dir', '') if $path eq '.';
+	return ('dir', '') if $path eq '';
 
 	my $diff_output =
 	    command_oneline(qw(diff --cached --name-status --), $path) || "";
-- 
1.5.6.3
