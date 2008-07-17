From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [PATCH/rfc] git-svn.perl: workaround assertions in svn library 1.5.0
Date: Thu, 17 Jul 2008 22:37:48 +0400
Message-ID: <37fcd2780807171137m1c5a8197vc94b2a42ac53a297@mail.gmail.com>
References: <20080706192850.32547.qmail@4480698c45f1ed.315fe32.mid.smarden.org>
	 <20080717140856.10213.qmail@c0f13986110104.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
To: "Gerrit Pape" <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJYNO-0004Zv-3O
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 20:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757966AbYGQShv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 14:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758161AbYGQShu
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 14:37:50 -0400
Received: from el-out-1112.google.com ([209.85.162.183]:44515 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757745AbYGQShu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 14:37:50 -0400
Received: by el-out-1112.google.com with SMTP id z25so23232ele.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qtq207rZRvmBkQXQNrnkIYtTrefBVYGQOInOVOOCY/0=;
        b=NJ1WfUIlpIGfITmDq//bRHxUeuMqHcYn0iJbGGH06h8rsW1g6J32GHQf9APtB8uKfs
         6/WChg3igMPuxiqELSB62MX9Xz5hazXKryX9XwzjhMHBMPL6RJpBxij7mETbgOEA6aD9
         TzXU4M2YVLTQQfdlgxQ78UuFwVTwECkF81GAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cpBBjZu+hDXVal0iJFJqn92HyuJkg/zR770ilp9f7tpj5mTKwO5YfPPjCK6NtnSW9/
         zAK5Bk6bnZUYaNI/FCN4FnMk/JqTmj46+Cymyv4U9Qps8k7rUXemOfhyFV3pSfLcGv8C
         IBWf6cgQkL2PIU6ukoD34oaSagJvqWzElq25A=
Received: by 10.142.132.2 with SMTP id f2mr766324wfd.22.1216319868799;
        Thu, 17 Jul 2008 11:37:48 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Thu, 17 Jul 2008 11:37:48 -0700 (PDT)
In-Reply-To: <20080717140856.10213.qmail@c0f13986110104.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88900>

On Thu, Jul 17, 2008 at 6:08 PM, Gerrit Pape <pape@smarden.org> wrote:
>
> Hi, while this commit fixed the selftests, it unfortunately is a
> regression
>
>  http://thread.gmane.org/gmane.comp.version-control.git/87822/
>  http://bugs.debian.org/490400

This particular breakage is easy to fix:

diff --git a/git-svn.perl b/git-svn.perl
index 3750e47..a5a5b1b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1226,7 +1226,7 @@ sub linearize_history {

 sub find_file_type_and_diff_status {
        my ($path) = @_;
-       return ('dir', '') if $path eq '.';
+       return ('dir', '') if $path eq '';

        my $diff_output =
            command_oneline(qw(diff --cached --name-status --), $path) || "";

but it could be some other places in git-svn that may need correction too.

>
> I'm still not sure whether this is a git-svn problem, or actually a
> problem in subversion 1.5.0

Accordingly to SVN developers you do not use SVN API correctly,
therefore you got assert. So, the problem in git-svn.
http://svn.haxx.se/dev/archive-2008-01/0425.shtml

Dmitry
