From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] git-revert with conflicts to behave as git-merge with conflicts
Date: Thu, 12 Oct 2006 16:15:03 -0700 (PDT)
Message-ID: <20061012231503.78452.qmail@web31803.mail.mud.yahoo.com>
References: <7vejtdkw4t.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 01:15:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY9lh-0003o3-LV
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 01:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWJLXPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 19:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWJLXPJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 19:15:09 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:40611 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751307AbWJLXPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 19:15:07 -0400
Received: (qmail 78456 invoked by uid 60001); 12 Oct 2006 23:15:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hO5FzM+6iDyIgb71uO9lVIXbgDMahgkYy556R7h7yXcGr+KRvcaIw9QBELAtStq4KqnyRB8jeUBVN/dhtsm7sZPlps4mGO0xUdggKqMVbcvHXwpcXn3x2gZlFEx7MHP1tzHOAd+6C/4ojOhHqyGy0aGphUAdjXrzRFnPRGmQLzE=  ;
Received: from [64.215.88.90] by web31803.mail.mud.yahoo.com via HTTP; Thu, 12 Oct 2006 16:15:03 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejtdkw4t.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28819>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > --- a/git-commit.sh
> > +++ b/git-commit.sh
> > @@ -441,7 +441,7 @@ then
> >  elif test "$use_commit" != ""
> >  then
> >  	git-cat-file commit "$use_commit" | sed -e '1,/^$/d'
> > -elif test -f "$GIT_DIR/MERGE_HEAD" && test -f "$GIT_DIR/MERGE_MSG"
> > +elif test -f "$GIT_DIR/MERGE_MSG"
> >  then
> >  	cat "$GIT_DIR/MERGE_MSG"
> >  elif test -f "$GIT_DIR/SQUASH_MSG"
> 
> If you rely on MERGE_MSG then you would need to clean it after
> commit is done.  Currently it does not and checks MERGE_HEAD,
> and cleans up MERGE_HEAD when it is done.  MERGE_MSG is not
> cleaned.

It is cleaned in the lines of the patch you deleted, the section
just after the "elif" above:

@@ -607,7 +607,7 @@ then
        commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
        rlogm=$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
        git-update-ref -m "$rloga: $rlogm" HEAD $commit "$current" &&
-       rm -f -- "$GIT_DIR/MERGE_HEAD" &&
+       rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" &&
        if test -f "$NEXT_INDEX"
        then
                mv "$NEXT_INDEX" "$THIS_INDEX"

   Luben
