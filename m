From: Alexander Gladysh <agladysh@gmail.com>
Subject: git blame vs. directory symlinks
Date: Fri, 27 Aug 2010 15:25:12 +0400
Message-ID: <AANLkTik-9H+KUjn-v7d4EeHaBn8=u5GjOi39T03EmCHG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 27 13:25:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oox43-0002ZQ-7l
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 13:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab0H0LZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 07:25:38 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49955 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab0H0LZh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 07:25:37 -0400
Received: by qwh6 with SMTP id 6so2613886qwh.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=SbSazfIjR+VNZMz61NCFaSBLWtmHbMdMtPFVMg4cGEI=;
        b=MMnFnAJ7p4/ejTaLu4Tbe8TQ6QwXB+KRPAP1oQZIy/u5wMt5LoVX1MUT6NwwqWlp2B
         Vj+Xy3lj7QE3m+7hPNANmNp5G1+n9zE24jNkz9qKJf0EJr7W9I9/t7CObT11Z22k2IgN
         4w7pEo43eYlWwj+WEGTkQBcJul+PpYbYqctbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=fjHf1GtYsgXUkbYSGc+8wMPw9mIJtzfMfxNKLELBv/XaM6WbBaXlZ9G32GiBE9zwj5
         8rZVv/MomNgwPrkjSM8WtVnFw9gulJwgnErszHXPjB2u+/kRqzpX1Us/i2zZErHQUVp6
         1+ELSMXnX6AoZ2+8TBAZ3VAySUDo10Tfuw8X0=
Received: by 10.224.19.147 with SMTP id a19mr199300qab.235.1282908336197; Fri,
 27 Aug 2010 04:25:36 -0700 (PDT)
Received: by 10.229.188.203 with HTTP; Fri, 27 Aug 2010 04:25:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154593>

Hi, list!

OS X 10.6.4
git version 1.7.2.2

Another bug with symlinked directories.

The git blame works correctly for the symliked files, displaying the
history for the symlink source.

However, if the symlink is not the file itself, but a directory in
path, git blame reports the file as "not committed yet".

See minimal example below.

HTH,
Alexander.

mkdir repo && cd repo
git init
mkdir alpha
echo "one" > alpha/file.txt
git add .
git commit -m "initial commit"
echo "two" >> alpha/file.txt
git commit -a -m "updated alpha"
ln -s alpha beta
git add .
git commit -m "beta symlink"

git blame alpha/file.txt
^33848ab (Alexander Gladysh 2010-08-27 15:16:16 +0400 1) one
5afed689 (Alexander Gladysh 2010-08-27 15:16:35 +0400 2) two

git blame beta/file.txt
00000000 (Not Committed Yet 2010-08-27 15:17:04 +0400 1) one
00000000 (Not Committed Yet 2010-08-27 15:17:04 +0400 2) two
