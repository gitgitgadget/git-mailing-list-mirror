From: Jed Brown <jed@59A2.org>
Subject: git send-email --notmuch expr
Date: Wed, 25 Nov 2009 03:49:59 +0100
Message-ID: <87d4375ne0.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 25 03:49:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND7wn-00022E-Vk
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 03:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934181AbZKYCtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 21:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934162AbZKYCtY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 21:49:24 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55186 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934158AbZKYCtX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 21:49:23 -0500
Received: by bwz27 with SMTP id 27so6585667bwz.21
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 18:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :message-id:mime-version:content-type;
        bh=YHz4kavfwud+Rnnw3Kz/PpDPjQdQfG+Z8Hcdb7WhNYE=;
        b=ptrStmJVWyU3tORLKz7XxtsLMfrM0018/UfMDmQIY3BGSNwbWeLtxNWVZi4DpsgX1p
         01jP2w9sp2tXIFdu1MBJ5BJcMvyGawKUBUDwXo11sgzd/jd+mt5iARHxxeYrSFnwSMzb
         p4j218Vk36ku0EEfqV4gaFHImLk5Ncin4zeWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:message-id:mime-version:content-type;
        b=j0B/ZEc0o3MMFJhfOsjYiTJs3D5zmPrOcTugYmisG181v9SfKRxszTio6fo/8StsK7
         khT28En0by3E/lxS4zC3IkOvtUbjN3j8QJnfjNt4em2HckhFEcY43TvHoDvGq8fuqNhw
         Zpm0m8t+l7DubIKsNtsZe5hCOr77K1wL0DB6M=
Received: by 10.204.162.137 with SMTP id v9mr1154887bkx.60.1259117368756;
        Tue, 24 Nov 2009 18:49:28 -0800 (PST)
Received: from kunyang (vawpc43.ethz.ch [129.132.59.11])
        by mx.google.com with ESMTPS id e17sm7962062fke.53.2009.11.24.18.49.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 18:49:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133608>

Notmuch is a new mail system with fast indexing and tagging, see
notmuchmail.org.  It has a command-line tool to build replies to emails,
and I wrote a patch to format-patch that enables

  git format-patch --notmuch EXPR

where EXPR is any notmuch query, but usually id:<Message-ID> to match a
specific message.  This will set up several headers, notably
In-Reply-To, References, To, Cc, Bcc.  This works great, and the the
patch follows this message.


But I really want

  git send-email --notmuch EXPR

This sort-of works, but the interactive part prompts for the various
headers (even though format-patch supplies them), and then duplicates
the To header (both the possibly empty field the user provided, plus the
one coming from format-patch).  I had a brief look at
git-send-email.perl, and I'm a little confused.

	} elsif (/^(?:To|Cc|Bcc):/i) {
		print "To/Cc/Bcc fields are not interpreted yet, they have been ignored\n";
		next;
	}

This regex doesn't match these headers (is the leading ?: a typo?) so
there is no warning.  But it's important that these headers *not* be
ignored, getting them set automatically is a key feature of the
--notmuch option.  I'm having trouble discerning whether I would cause
problems by just using these headers coming out of format-patch.
Presumably there was a reason why they were (intended to be) explicitly
ignored, and my poor perl skills are not helping.  Could someone
enlighten me?


Jed
