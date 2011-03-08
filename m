From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cherry-pick -x: add newline before pick note
Date: Tue, 8 Mar 2011 16:08:43 -0600
Message-ID: <20110308220843.GA27156@elie>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
 <loom.20110308T134920-72@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Martin Svensson <martin.k.svensson@netinsight.se>,
	Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>
To: Oswald Buddenhagen <ossi@kde.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 23:09:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px55V-0003Dj-Oc
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 23:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab1CHWI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 17:08:59 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39575 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab1CHWI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 17:08:58 -0500
Received: by vxi39 with SMTP id 39so5151666vxi.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 14:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=s8FfQpv+NI516A0LAXHkxG/fsxjCvnlUW18LJ5ML+Io=;
        b=GYMHSjZfA7IyksRzkGY9vuy8voYsQU8sU/v7iFUfsrDkZUWGHWbayRAPtL5ctUCghU
         rQCeKVGa4sw9kn2xQ+naiRWg4qSiqIARtIFWD01FEhAnma4mqECx50MCvWSvDg3ag7cI
         oIpmuXVMxZ37VmZcx2sq7wWgCrmQtDbDL4RtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qdsl7SYvIzOVXEDOBl6J80cR3LgcSx/2ml/jj3QE5ldRp7PiA4nwI4vfWfDf6nsv9l
         XQsN9+pf82tgoVSsMHYEzsejBqQh5O6bUYd4G46FldQTB+NN1ptFUTl+4sPc9WxxsboC
         u39QrPwqOPjKCD4YkYCuo9dElR/AVR0/L8GFI=
Received: by 10.52.93.19 with SMTP id cq19mr45830vdb.294.1299622137706;
        Tue, 08 Mar 2011 14:08:57 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.ameritech.net [69.209.61.99])
        by mx.google.com with ESMTPS id b26sm849107vby.3.2011.03.08.14.08.50
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 14:08:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20110308T134920-72@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168706>

(please do not cull the CC list)
Hi Oswald,

Oswald Buddenhagen wrote:

> so while everybody is apparently thinking about totally over-engineering
> things as much as possible, could we please have this patch applied so we
> have a solution for the time being?

I am not convinced that this patch makes a positive change in general.
Starting from a message

	Foo the bar

	Make some excellent improvement to the frobnicator.

	Signed-off-by: A U Thor <author@example.com>

a person passing on the patch might write

	Foo the bar
[...]
	Signed-off-by: A U Thor <author@example.com>
	[committer@example.com: avoid multiple return points]
	Signed-off-by: C O Mitter <committer@example.com>

Similarly, when cherry-picking from permanent history, it can make
sense to write

	Foo the bar
[...]
	Signed-off-by: A U Thor <author@example.com>
	(cherry picked from commit 78a8b989a76c8798a9898c98a98c98a98ca)
	Signed-off-by: C O Mitter <committer@example.com>

In both cases, it's just another hop in the life of a patch and not
something that seems to deserve emphasis with extra whitespace.

> i really hate to tell my coworkers that
> they have to amend the cherry-picks just to make them comply with git's
> own guidelines for well-formed commit messages (and thus have them pass
> our pre-receive hook).

I assume you are referring to one-line commit messages becoming two-line?
Here's something rough to start.

diff --git a/builtin/revert.c b/builtin/revert.c
index dc1b702..343e7e7 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -198,6 +198,28 @@ static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
 	strbuf_addstr(msgbuf, p);
 }
 
+static void add_blank_line_if_oneline(struct strbuf *msgbuf)
+{
+	const char *newline = memchr(msgbuf->buf, '\n', msgbuf->len);
+
+	if (!newline) {	/* No newline at end of message. */
+		strbuf_addch(msgbuf, '\n');
+		newline = msgbuf->buf + msgbuf->len - 1;
+	}
+
+	/*
+	 * If the change description consists of a single line,
+	 * add a blank line separating the title from the new
+	 * message body (the "(cherry picked from" line).
+	 *
+	 * NEEDSWORK: it would be better to reuse the append_signoff
+	 * logic.
+	 */
+	newline = memchr(newline, '\n', msgbuf-> buf + msgbuf->len - newline);
+	if (!newline)
+		strbuf_addch(msgbuf, '\n');
+}
+
 static void set_author_ident_env(const char *message)
 {
 	const char *p = message;
@@ -499,6 +521,7 @@ static int do_pick_commit(void)
 		next_label = msg.label;
 		set_author_ident_env(msg.message);
 		add_message_to_msg(&msgbuf, msg.message);
+		add_blank_line_if_oneline(&msgbuf);
 		if (no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
-- 
