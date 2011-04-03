From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 19/51] i18n: git-pull "rebase against" / "merge with"
 messages
Date: Sun, 3 Apr 2011 13:33:25 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1104031314520.25129@debian>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com> <1301849175-1697-20-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 19:33:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6RBA-0004sD-Fd
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 19:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab1DCRdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 13:33:32 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56835 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab1DCRdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 13:33:31 -0400
Received: by qyg14 with SMTP id 14so3387538qyg.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=gpQlv4tt5Cu8+PG8LqRm6t3xlA1pnbq2aLsQCAtkakM=;
        b=Bv5Oe9FrvlMGNaFiejTNJICURd+JID5edU5HktvyNru16Ez0Ff+Deo1P2mvZ8mfVAU
         FbXhHqSXwCJ3KpSEKZPoBwL9NYPY8wWD6bsDof4WkM3IX7ySJl9zwXo9Od8P3wZ5gBgh
         gWRYEbeHBFEVe5D5A8o1J0mA+FITPsFPHrbKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=icnCfCQkRgKTBQ+byOxB1acj796o0ZggqAYI1SoaGPJIqPvAWJmS7izggqwWOBMSj3
         CFfoOgXDlukal0AXAaQs+SDF7zfwTJi93MLK/DtdKDPTbiPa37RcSvHYtKMZXtD+U/6e
         bIqJbRvTME84VYVKim7gXEe0h+QLAFuARi3PM=
Received: by 10.229.65.33 with SMTP id g33mr4943821qci.294.1301852010696;
        Sun, 03 Apr 2011 10:33:30 -0700 (PDT)
Received: from [192.168.1.102] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id c27sm2921626qck.10.2011.04.03.10.33.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 10:33:29 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <1301849175-1697-20-git-send-email-avarab@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170761>

On Sun, 3 Apr 2011, ?var Arnfj?r? Bjarmason wrote:

> Gettextize the two messages that used "rebase against" and "merge
> with". Split them into two depending on whether we are rebasing or not.

I think this conflicts a lot with my 15a147e (rebase: use @{upstream}
if no upstream specified, 2011-02-09), which factored out most or all
of the code touched in your patch a reused it in git-rebase.sh. I
remember thinking about i18n at some point while extracting that code,
but then I forgot about it. I have inlcluded the relevant part of that
patch below for your reference. As you can see, I added another
variable $cmd that is either "pull" or "rebase". It is used in plain
text because the command matches the verb in English, but I guess that
may not be ideal in all translations. Maybe we extract some parts of
the message, so we don't have to make four nearly identical copies of
the message... I don't have any concrete suggestion right now, though.

+error_on_missing_default_upstream () {
+	cmd="$1"
+	op_type="$2"
+	op_prep="$3"
+	example="$4"
+	branch_name=$(git symbolic-ref -q HEAD)
+	if test -z "$branch_name"
+	then
+		echo "You are not currently on a branch, so I cannot use any
+'branch.<branchname>.merge' in your configuration file.
+Please specify which branch you want to $op_type $op_prep on the command
+line and try again (e.g. '$example').
+See git-${cmd}(1) for details."
+	else
+		echo "You asked me to $cmd without telling me which branch you
+want to $op_type $op_prep, and 'branch.${branch_name#refs/heads/}.merge' in
+your configuration file does not tell me, either. Please
+specify which branch you want to use on the command line and
+try again (e.g. '$example').
+See git-${cmd}(1) for details.
+
+If you often $op_type $op_prep the same branch, you may want to
+use something like the following in your configuration file:
+    [branch \"${branch_name#refs/heads/}\"]
+    remote = <nickname>
+    merge = <remote-ref>"
+		test rebase = "$op_type" &&
+		echo "    rebase = true"
+		echo "
+    [remote \"<nickname>\"]
+    url = <url>
+    fetch = <refspec>
+
+See git-config(1) for details."
+	fi
+	exit 1
+}
