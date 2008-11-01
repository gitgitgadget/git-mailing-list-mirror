From: "Elijah Newren" <newren@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Sat, 1 Nov 2008 12:36:30 -0600
Message-ID: <51419b2c0811011136uabb544g87e156631d025d33@mail.gmail.com>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Sam Vilain" <samv@vilain.net>
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Nov 01 19:41:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwLPp-0001Jv-Qo
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 19:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbYKASgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 14:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYKASgb
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 14:36:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:53242 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbYKASgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 14:36:31 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1839692rvb.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3kwx8GpKWHfkjhTW/FVWgoP0HYgdamOIN7eM1mEnRAI=;
        b=li3PHSaM/fXN7ssyi4LfDflFFDEpnqflRfTA+ENhKkaM9fpqS9sXws9a2BKN4bTSLQ
         EepjOkDBTGUBuD0Zu+yIWCo7bMxYgB/bMzXGpADe1N3DjoI0ncerOqDszbFL2z54MAfl
         pHJbco00+8OSKNKWgfXckE6KwxTZV8zkqfkl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AoLfQoV6EcKD1EmTvHf8hiH5i7/7fpd0tySzcu9q4B6Uf8ntg9MJym6Y0AUoXJSwob
         mW+7OKWX1/tn83RsZEe8pjhhTOftC4NZ/MhHoShcrqXwsIZ+/rqHhoasGloJ3aIYjxZh
         04eg5PeCeulFdfbWln+3+2FEGsatf3ZyIhZjI=
Received: by 10.141.88.3 with SMTP id q3mr7641548rvl.3.1225564590367;
        Sat, 01 Nov 2008 11:36:30 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Sat, 1 Nov 2008 11:36:30 -0700 (PDT)
In-Reply-To: <1225338485-11046-1-git-send-email-sam@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99757>

Hi,

Good list..  I agree with others that the 'undo' name doesn't sound
right (and will discuss other issues with it in response to another
email) but otherwise nice work.

On Wed, Oct 29, 2008 at 9:48 PM, Sam Vilain <sam@vilain.net> wrote:
> +  * 'git push' to checked out branch of non-bare repository not
> +    allowed without special configuration.  Configuration available
> +    that allows working directory to be updated, known caveats
> +    notwithstanding.  Ideally, it would refuse only in situations
> +    where a broken working copy would be left (because you couldn't
> +    fix it), and work when it can be known to be safe.

Configuration of remote repository, special command-line override, or both?


Some food for thought: One thing I did in EasyGit was to disallow
pushes to non-bare repositories* unless both source and destinations
references were explicitly specified.  For example:

$ eg push origin master    # or 'eg push', in this case
Aborting: You are trying to push to a repository with an associated working
copy, which will leave its working copy out of sync with its repository.
Rather than pushing changes to that repository, you should go to where that
repository is located and pull changes into it (using eg pull).  If you
know what you are doing and know how to deal with the consequences, you can
override this check by explicitly specifying source and destination
references, e.g.
  eg push REMOTE BRANCH:REMOTE_BRANCH
Please refer to
  eg help topic refspecs
to learn what this syntax means and what the consequences of overriding this
check are.

$ eg push origin master:master
Counting objects: 5, done.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 260 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /home/newren/testing/dumb/.git
   852ffee..f5596e4  master -> master


This seems to prevent errors for new users, while still allowing
people to work around firewall issues.

* The big problem was that I was only able to detect if a remote
repository was bare or not if it was accessed via the local filesystem
or via ssh; for git:// (or rsync://) repositories I didn't know how to
perform such a check and so I simply omitted it.


Elijah
