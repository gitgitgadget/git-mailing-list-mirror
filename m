From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using "git log" to find the files patched at the same time as a 
 named file
Date: Wed, 03 Feb 2010 13:36:09 -0800
Message-ID: <7vfx5idmt2.fsf@alter.siamese.dyndns.org>
References: <218b69371002031238y6a377b06x76b8f8e87ea0ee46@mail.gmail.com>
 <7vk4uughzf.fsf@alter.siamese.dyndns.org>
 <218b69371002031314rb52da81k92c45f79dc6feca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zack Brown <zacharyb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 22:36:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncmtc-0003YW-Oc
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 22:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744Ab0BCVgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 16:36:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755952Ab0BCVgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 16:36:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 771AE963F0;
	Wed,  3 Feb 2010 16:36:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ymLgGiMB6i/K3SWHVyrMS2cWbKM=; b=Rs5kqh
	zHK1lztKQT4WYtiTyetC2oRCDW7DVDiUEwkdVMTLNI2oQeytRD5Rjcq4ZnHAA1sg
	LEUDn9khdgCkx7+Yw1vJH5ON+VbNpOfsWtJLNsZ+2rdHWsDsyGcg6+jtVKOv6pMP
	CBXBuW2jWccXhm9+pso9EQoLcDJhDTMHx5kdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=glqGpgo5tbufkr107+M1DNEJ1m6sMynk
	VRevYA+3h6Bmpm0wlWU/1iiVZvylqFw+uG1DPr7f3/33XBpe7p2VCiNezUHevzeg
	g1dJxYv5mpiEhm6PMy0sBDEgUEhUQhFMMZsqPsNwOs0YUzY9/oer6w788WcjwPu3
	/rHT8IXcva8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52EAE963EC;
	Wed,  3 Feb 2010 16:36:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78727963E3; Wed,  3 Feb
 2010 16:36:11 -0500 (EST)
In-Reply-To: <218b69371002031314rb52da81k92c45f79dc6feca@mail.gmail.com>
 (Zack Brown's message of "Wed\, 3 Feb 2010 16\:14\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 276C59CE-110C-11DF-BC8B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138903>

Zack Brown <zacharyb@gmail.com> writes:

> ... What about something like this:
>
> "Without this flag, "git log -p <path>..." shows commits that touch
> the specified paths, but it only includes the diffs from those commits

I would say "s/but/and/", because it is more natural that you get the
"limited" view after you explicitly stated that you are "only interested
in these things" by giving pathspecs.

> that affected those specified paths, regardless of whether other paths
> were changed in those same commits. With "git log --full-diff -p
> <path>...", git still only reports commits that touch the specified
> path, but now it also includes the diffs that affected any other paths
> changed in those same commits."

And "but" on the second line from the bottom makes sense---by giving the
option, you are telling it to work differently.

> Would that be an improvement?

Surely.  I would suspect that people would go even further.  "-p" is not
very special (notice I used --name-status in my example).

Also I think the description should start with what it _does_, not with
what happens without it.

So how about this?

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0e39bb6..5dd1c0c 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -49,11 +49,14 @@ include::diff-options.txt[]
 	commit was reached.
 
 --full-diff::
-	Without this flag, "git log -p <path>..." shows commits that
-	touch the specified paths, and diffs about the same specified
-	paths.  With this, the full diff is shown for commits that touch
-	the specified paths; this means that "<path>..." limits only
-	commits, and doesn't limit diff for those commits.
+	Show all changes, even outside the given pathspecs.
++
+Pathspecs <path>... given to "git log [<options>] <path>..."  limit the
+output to the commits that touch the specified paths.  When options to
+show changes introduced by these commits (e.g. "-p", "--name-only") are
+given, the output of the changes are also limited to the specified paths.
+This option lifts the latter limit and tells "git log" to include all
+changes, even the ones outside of the given pathspecs.
 
 --follow::
 	Continue listing the history of a file beyond renames.
