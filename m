From: Gunnar Strand <gurra.strand@gmail.com>
Subject: Using "git reset" in a pre-commit hook can create an empty commit
Date: Wed, 19 Feb 2014 14:05:09 +0100
Message-ID: <CAEsF1Lt8P8rSmhovbrWSyLE2HQLTjRA3sS-TK_pW6yzp_M+D3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 19 14:05:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WG6px-0000ox-MW
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 14:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbaBSNFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 08:05:11 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50941 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbaBSNFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 08:05:10 -0500
Received: by mail-oa0-f46.google.com with SMTP id n16so354141oag.33
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 05:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=sRhEW+ZUpYl19wxTCqHVtwxBxXm5/LDfIiXBDZRL+TA=;
        b=cGm+pYDNKWXBH21kadulvRHr4ZImpbKjkXRgAwrLFokQLuhenScgilqoCcRYZ5jgao
         dIEtdYYbqpAXOTx/Hkdq2E/sHlha9EC2X23vVKs8HKM9ABT/0o2bxyuP7tZ26q2pCk9y
         vRLmhAnL9dFeLRvxZypSQpOJVyl3F8g1cWH5Fg8QuRW8jQWvcIYBv/3qBlTUJpUNW/5M
         9gp6xMVsMk07kDU867Q0tNp4zxPPLK8kqdkbv3FZ62YqVnn3w2gcM1tNn0jGH2Hh6gOK
         PR39x8mKNfPPNbV8YesHIXQVuxRxIDIsWDaZDIkAjlJjpTYlnRSrs66y6u65VKsHgbTg
         9iqg==
X-Received: by 10.182.24.69 with SMTP id s5mr31368742obf.35.1392815109688;
 Wed, 19 Feb 2014 05:05:09 -0800 (PST)
Received: by 10.76.98.163 with HTTP; Wed, 19 Feb 2014 05:05:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242391>

Hi,

git version 1.8.4.2
Linux 3.0.74-0.6.8-xen

"git commit" does not properly reevaluate the state after the
pre-commit hook has been executed, and lists files which have been
reset as part of the commit, and will create an empty commit, despite
that no "--allow-empty" was given.

Steps to reproduce:

1. Create a tracked file called "ignoreme"

2. Add the following line to ".git/hooks/pre-commit":

git reset HEAD ignoreme

3. Make a change to the ignoreme file

4. Run "git commit -a"

Result:

The commit template will still list the file:

# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
# modified:   ignoreme
#


Adding a commit message will create an empty commit:

ign2$ git --no-pager diff HEAD^ HEAD
ign2$

Expected behavior:

- Git should refuse to continue if the pre-commit hook resets all changes
- The commit message should not list files removed from the index


Best Regards
Gunnar Strand
