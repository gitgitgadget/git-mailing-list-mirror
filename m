From: Alexander Nestorov <alexandernst@gmail.com>
Subject: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 15:25:22 +0200
Message-ID: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 15:26:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UovvF-0004nv-6A
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 15:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab3FRN0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 09:26:05 -0400
Received: from mail-qe0-f43.google.com ([209.85.128.43]:64561 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227Ab3FRN0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 09:26:03 -0400
Received: by mail-qe0-f43.google.com with SMTP id q19so2464411qeb.30
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=NYtnHlQimJhL5mrgWmMS0s07qIkYBAJeVO44hp+yusk=;
        b=sLqMCMYAIg7ZvQxXsJhPJ4impxspUlnozWWt5KpLDMWPMfuyZDWAvpospqOqTC3Z69
         kbc/ahWZL6xO5PwCdOM0byVSIe66jJnMURy1uwsvHW5zszPVzW1aLFoYfziwcfOCCBBF
         TQTKVh6Bmyhz0YUa7Ees/C0ZqqMohT84O4TYsEv96oMg4BXTzwU+zJ2jzi/zehj5TKVG
         kgnU77odNdySI7088N+/8fFBy78koMWD++21RN79ZzWOPgJSPXCQglxjT+UqqXlU4hHT
         SEXbS4V0QVTQU2HGhNKy56wizH7YuZgLZysOZXFEAw2FXpdvO+yRvuwYpYjEeJ8fe+CN
         +v3w==
X-Received: by 10.49.12.145 with SMTP id y17mr15403389qeb.7.1371561962111;
 Tue, 18 Jun 2013 06:26:02 -0700 (PDT)
Received: by 10.229.168.70 with HTTP; Tue, 18 Jun 2013 06:25:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228227>

Recently I had to write some automation scripts and I found
that git reset --hard actually restores each file's permissions.

That is causing both the created and the last-modified dates
of the file to get changed to the time of the git reset.

This behavior is easy to demonstrate:

echo "test" > myfile
chmod 777 myfile
git add myfile && git commit -m "Test" && git push
chmod 775 myfile
git reset --hard origin/master

After the git reset --hard command, the entire file was
checkout-ed. Instead, git should be able to check if the
content of the file changed and only if it did, check it out.

I do realize that checking the content of each file in a big
repo could result in a slow operation, but there should be a
switch/argument/option to make git reset actually check the
content of each file instead of blindly replacing it.

After reading man a few times I didn't saw any option
that'd let me do this; the only solution I'm able to think about
is actually restoring the permissions of each file to the ones
git thinks they should have before doing the git reset.

Maybe I'm wrong and there is a way for doing what I want, if
so, please correct me.
But if there isn't, should this be implemented? Are there any
reasons for not doing it?


Thank you for your attention
Regards

--
alexandernst
