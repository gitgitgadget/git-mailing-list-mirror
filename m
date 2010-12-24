From: Mihai Rusu <dizzy@google.com>
Subject: Allow empty commits to be rebased
Date: Thu, 23 Dec 2010 16:48:08 -0800
Message-ID: <AANLkTim4pHZ=d3XwEP_ZM8P7ZO6FbMJbMDGzssuL5kVj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 01:48:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVvpS-0002LY-VV
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 01:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab0LXAsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 19:48:13 -0500
Received: from smtp-out.google.com ([74.125.121.67]:58557 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab0LXAsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 19:48:12 -0500
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id oBO0mBlG019693
	for <git@vger.kernel.org>; Thu, 23 Dec 2010 16:48:11 -0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1293151691; bh=RhZ4Tgc9YnCBigQ3HZ5t5MEfVRU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type;
	b=nwzgl8V5h3JWwCz+ZTtZsDI47vaVpTRktHblIfjZocoMPlEfZ3l0aw0po5nIINHwp
	 B5KHwd8NOo2y8Ayuj+Jpg==
Received: from eyg24 (eyg24.prod.google.com [10.208.7.24])
	by wpaz29.hot.corp.google.com with ESMTP id oBO0m8lR015049
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 23 Dec 2010 16:48:09 -0800
Received: by eyg24 with SMTP id 24so3108955eyg.10
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 16:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=2pb0QT+5rv/x683uRfSoGsy74qnPj1jOpirIrEshGiI=;
        b=kEXWS4aQWoEtboIFSBlRFwQwYRqJGm9zhVpC5OxMV59b5wyE6dSf1OdKsj+5rpD/9v
         lJsvexW58j/F9gV89xCw==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WllLQkPbIsYpRraEeXY9HKeePARHW8Zc0aBGnZczF4KmElD8rjP2NPa2nj+DWKDP6M
         z0z/EQHpwtSri/vWCdxA==
Received: by 10.213.29.201 with SMTP id r9mr7286435ebc.6.1293151688486; Thu,
 23 Dec 2010 16:48:08 -0800 (PST)
Received: by 10.213.29.136 with HTTP; Thu, 23 Dec 2010 16:48:08 -0800 (PST)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164142>

Hi

When trying to rebase empty Git commits (git commit --allow-empty),
"git rebase" (and "git rebase -i") just skip the empty commits. This
may make some sense in the context of "git rebase" trying to determine
if the code to be rebased already exists in "upstream" but in our case
we need to rebase purely because of parent changes. Playing with "git
rebase", the only way to force it to rebase empty commits was to do
something like:
$ git rebase -i --onto upstream HEAD~N # where N is the number of
commits we want rebased

And then for every empty commit it stops as if it got a conflict, I
have to issue git commit --allow-empty and then git rebase --continue
(if I just run git rebase --continue as I should it skips the empty
commit). If I drop "-i" or if I don't use the onto/HEAD~N trick I'm
not able to rebase empty commits.

If you don't think that "git rebase" should support rebasing of empty
commits by default then please consider adding an --allow-empty
argument to enable such functionality.

Thanks!

-- 
Mihai Rusu
