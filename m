From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC 5/5] Support 'master@2 hours ago' syntax
Date: Wed, 17 May 2006 04:07:13 -0700
Message-ID: <7vbqtwhpum.fsf@assigned-by-dhcp.cox.net>
References: <20060517095609.GF28529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 13:07:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgJs9-0008Ca-15
	for gcvg-git@gmane.org; Wed, 17 May 2006 13:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWEQLHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 07:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWEQLHQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 07:07:16 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47237 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751157AbWEQLHP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 07:07:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517110714.GGUF18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 07:07:14 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060517095609.GF28529@spearce.org> (Shawn Pearce's message of
	"Wed, 17 May 2006 05:56:09 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20190>

Shawn Pearce <spearce@spearce.org> writes:

> Extended sha1 expressions may now include date specifications
> which indicate a point in time within the local repository's
> history.  If the ref indicated to the left of '@' has a log in
> $GIT_DIR/logs/<ref> then the value of the ref at the time indicated
> by the specification is obtained from the ref's log.

This does not allow '2006-05-17 00:00:00' as the timespec, and
the documentation carefully avoids giving that example, but I
think it is better to spell that limitation out.

> +* A suffix '@' followed by a date specification such as 'yesterday'
> +  (24 hours ago) or '1 month 2 weeks 3 days 1 hour 1 second ago'
> +  to specify the value of the ref at a prior point in time.
> +  This suffix may only be used immediately following a ref name
> +  and the ref must have an existing log ($GIT_DIR/logs/<ref>).


+	fprintf(stderr, "warning: Log %s only goes back to %s.\n",
+		logfile, show_rfc2822_date(date, tz));
+	return 0;

I am not sure about this part.  If the oldest log entry was 3
hours ago, the second oldest 2 hours ago, we can tell during
that one hour period the ref was at that point.  If the user
asked "ref as of four hours ago", and if the oldest log entry
had old SHA1 that is not 0{40} (because the log was not enabled
before that record), it might make more sense to give that back.

Also I wonder how much complexity would we suffer and how much
efficiency would we gain if we binary search the logdata (the
committer info is variable length, so you would need to resync
in each step).
