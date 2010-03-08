From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: git-rebase -i prunes commits with empty commit-message
Date: Mon, 8 Mar 2010 21:07:41 +0100
Message-ID: <40aa078e1003081207u20046916yda5a62d44ce7a401@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 08 21:07:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NojEy-0002Bi-3J
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 21:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578Ab0CHUHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 15:07:44 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58628 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab0CHUHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 15:07:42 -0500
Received: by wwa36 with SMTP id 36so3534496wwa.19
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 12:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type;
        bh=Ju1LpzG/qKPJ+qYFtztd4say5VQwrSz4V9kwPHwhcSI=;
        b=yFco5/dm4JFIQauBEX9EIaaS6aDaIZKmzcM7bveZpJdB/FMQEZlpzOVOSlkFE4gcr4
         S4QGq8Sxp5Q6LuGVM50TA6JW6MAwMgSjYQkoBxCVaFbC2G3Ui+KtB8SDu2wrjkrAGW8V
         LxQdmxh7uPMq8T5Nwt38bpDb6uTPG0JQ2IBd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=De2gcAT/5qEt1e0rSHS/b4zKGb04vYE2wNQLyeCUp998q5txD+sK49EwdqOgqeaNqo
         T6ZzJ/xmzoWHoX2Q0IZKKuWivYePrTTbeEcThYFNhb8k4BPpiDoAtVCtHjmyye1dUUoi
         oDfA0u//yLRrePdMizPPb9L5dtOBCzGCw38dI=
Received: by 10.216.162.204 with SMTP id y54mr169057wek.224.1268078861188; 
	Mon, 08 Mar 2010 12:07:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141782>

I'm in the process of converting an SVN repo to Git, and in the
process I found one quite disturbing feature of
git-rebase--interactive.sh: It discards commits with empty commit
messages!

Here's a recepie for reproducing the issue:
--->8---
git init
git commit -m "dummy" --allow-empty
git commit -m "dummy" --allow-empty
git commit -m "dummy" --allow-empty
git filter-branch -f --msg-filter 'sed -e "s/dummy//"'
git rebase -i HEAD~2
--->8---

The editor window will show "noop", and exiting the editor goes ahead
and deletes all but the initial commit.

This gets even weirder if it's a mixture of empty and non-empty
commits; the commit-identifiers gets appended, together with an
angle-bracket ('>'), to the previous line.

I'm guessing that this is unintended behavior. This was observed on git 1.7.0.1.

-- 
Erik "kusma" Faye-Lund
