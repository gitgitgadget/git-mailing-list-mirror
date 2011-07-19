From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: t5403.1 and adding a file that belongs to a submodule
Date: Tue, 19 Jul 2011 20:57:07 +0700
Message-ID: <CACsJy8AKMQa2u6Y5qQHGujbjqq0qnM5D1+aEvcfk7POxQBqsVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 15:57:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjAnw-0006Vx-0a
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 15:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1GSN5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 09:57:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35967 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab1GSN5i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 09:57:38 -0400
Received: by ewy4 with SMTP id 4so2013216ewy.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=BsSleg2ugF9DU7FiNCKsaisKV6yMX6ZMMbFC1sw4Sf4=;
        b=xo0yu92o6oVqIQYofZtoyG3cd4kk3PYlf76wgRZS9Xm3Bqu8I9ksBe5GXkrrMSSQoB
         j2M013IlX9wJ1rKQ1lMUaaj29Dh/V776TI8qccl8C5koha8qKVnDw9cyy6FIGqYfxUlw
         b0VgMTTiQSRWtpr/Hn/gpxda0SBtC1ugcZ+8w=
Received: by 10.204.49.6 with SMTP id t6mr830345bkf.135.1311083857094; Tue, 19
 Jul 2011 06:57:37 -0700 (PDT)
Received: by 10.204.123.199 with HTTP; Tue, 19 Jul 2011 06:57:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177454>

A part of t5403.1 is like this

touch a b; git commit -am1
git clone ./. clone2
GIT_DIR=clone2/.git git add clone2/b

The last command troubles me because clone2/.git is valid, I don't
think it should add "clone2/b" to clone2/.git/index. This is likely
due to common prefix optimization in read_directory, where it skips
checking .git at the first level (clone2). If we turn that command to
"git add a clone2/b" (common prefix would be ""), the second argument
is silently dropped (seems like a bug to me). Should t5403.1 be
rewritten to avoid that construct?
-- 
Duy
