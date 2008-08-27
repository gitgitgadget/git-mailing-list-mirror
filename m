From: Rainux <rainux@gmail.com>
Subject: Which is the better repository structure for my project?
Date: Wed, 27 Aug 2008 17:54:27 +0800
Message-ID: <a7f79a680808270254u6900bbf9o453fa741cca069ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 11:55:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYHkT-0001Pl-Jg
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 11:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYH0Jy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 05:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbYH0Jy3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 05:54:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:28870 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbYH0Jy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 05:54:28 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2568719rvb.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=R/JSQgkUDjfWN1Ef/l8O09fDxFIA9CjPAAmCXzCXW8E=;
        b=m3Qfu2VVpelBuqv4JmyqWWlijhf/3zif/BIO9JR9kC52UKnqkLhzxT0Qtf4jHj0Raf
         9NTEc/0Dc6TaZZ331EaIknbVSDIZAnc4jfZcbozd40y/Jw9TXlZM8UMaBoCApwJCK0lI
         QE4iIFkxLaS+6mg2CAt/XHME7zPDVhn7rgWzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=oNdm1qeDOpODspVI/pstB819INmwWZVroGk4N7LKqqumyLnyX2764z//6YbuSllAjl
         yAVgodpSmgtE+iL+OfXSw3BX80PUpxOzubgWKl1vPsAPgJYiFVWR8bVVn9xpwk4RJm67
         ozdmb3BddRBERkYFhbUzVVtBGrLnHGoSzVClU=
Received: by 10.141.198.9 with SMTP id a9mr3464830rvq.108.1219830867717;
        Wed, 27 Aug 2008 02:54:27 -0700 (PDT)
Received: by 10.141.137.19 with HTTP; Wed, 27 Aug 2008 02:54:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93885>

I have a web application ProjectFoo managed by subversion, and now I
want to use git to manage it.

ProjectFoo have
* 4 editions, the differences between each edition are trivial things
just like images & CSS files.
* 2 development lines, stable & unstable, so we can always do bug
fixing in latest stable branches, and add new features to unstable
branches, test them and finally deploy them as new stable branches
like 1.2.

The repository structure of project_foo looks like this:

|
+- trunk
|
+- branches -+- stable -+- 1.0 -+- trunk
             |          |       |
             |          |       +- edition_1
             |          |       |
             |          |       +- edition_2
             |          |
             |          +- 1.1 -+- trunk
             |                  |
             |                  +- edition_1
             |                  |
             |                  +- edition_2
             |
             +- unstable -+- edition_1
                          |
                          +- edition_2

I've found git-svnconvert.rb can convert subversion repository which
have strange branches structure like above to git repository, and I've
done some modifications & fixing to make it works with the latest
version of git. It even can split a subversion repository to several
git repositories by branch.

I've imagined 2 different structures of the new repository:
1. Follow the old structure of subversion repository. The known down
side is, with single git repository, I can not test 4 editions at the
same time.
2. Split to several repositories by edition, each repository contain 2
branches (stable & unstable) of an edition, and a repository of
"trunk" edition used to do the main development, other edition of
repository just track "trunk" repository and pull changes from it.

Which one is better?

I've tested method 2, when do git pull on edition_1 repository, it
seems do not known which changes already made on edition_1, and looks
like try to merge all changes on trunk/master (from "trunk"
repository) to edition_1/master, actually these changes already merged
to edition_1 in subversion repository.

The question is, when repo_1 start to remote tracking repo_2, is there
any method to tell git that repo_1 is "already up-to-date" with
repo_2, so that git pull will just merge new changes on repo_2 to
repo_1?


-- 
Best Regards

Rainux
