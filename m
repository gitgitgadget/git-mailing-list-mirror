From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: gitignore vs. exclude vs assume-unchanged?
Date: Tue, 22 Apr 2014 10:40:43 +1000
Message-ID: <CAH5451k+GGGdHXkwne2O-h2m2AyWg7K+5reNRG64+eF891pVUA@mail.gmail.com>
References: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>
 <xmqqy4z5go1y.fsf@gitster.dls.corp.google.com> <dee7ee673c8c4d81fb5aaecea25e9709@bellandwhistle.net>
 <20140416234555.GA4309@google.com> <4dd8389939fbf3dc77b58adcca7b17c1@bellandwhistle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: alex@bellandwhistle.net
X-From: git-owner@vger.kernel.org Tue Apr 22 02:41:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcOm9-0001sC-S0
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 02:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbaDVAl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 20:41:26 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:39963 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbaDVAlY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 20:41:24 -0400
Received: by mail-vc0-f178.google.com with SMTP id im17so1760084vcb.37
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 17:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ycXOtEtD3sRDpYMAGAsLMYHOa+mvhd0RjbjmuGw6bsk=;
        b=Jrr5FgQctAMV/lRbLbCBZtaqY3N5YQoo9EJWywAAT19/fMC7IntItg7WdL7LooXwzc
         WPqi3dJzv7cTMnWCm1Ul1mWjDMQ6ENsR7eahnFzUgiB2bVez0fiU6VN9bjT11K6rymJA
         wKUf0u2mkQoOAApnwN4gL0+Sm4XSQJmobErgkumA80bHXX5aALWdNS4jVy47um1mc0+W
         sJnx4Yd/t41HoAJPzoGL5wVPLd8Aw3QgFOudmcqnjaGApay3Gz1E/Q5/FrGcEL6/Zlu8
         RyXlKHVaREAO7rh+xnn0wwsTmXjxtezJWEHHMXYWRwzDU3uYtQG5+r/7S+7p4KEjbha7
         vW7w==
X-Received: by 10.52.0.193 with SMTP id 1mr13048639vdg.0.1398127284134; Mon,
 21 Apr 2014 17:41:24 -0700 (PDT)
Received: by 10.221.8.133 with HTTP; Mon, 21 Apr 2014 17:40:43 -0700 (PDT)
In-Reply-To: <4dd8389939fbf3dc77b58adcca7b17c1@bellandwhistle.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246682>

On 18 April 2014 10:36,  <alex@bellandwhistle.net> wrote:
> "Like the $GIT_DIR/info/exclude file, gitignore files specify intentionally
> untracked files that Git should ignore. The difference is that files matched
> by a pattern in a gitignore file will be untracked for all users of the
> repository."

As a data point, I have seen people add ".gitignore" to their
.gitignore file, as they don't want to share the file.

This seems like a misuse of the functionality, as
$GIT_DIR/info/exclude is a better choice for the same use case, but
I'm not sure why the misuse is there.

My guess is that users aren't aware of excludes, whilst gitignore is
placed front of mind living at the root of many repositories.
Education will help here, but is there any way to make the 'correct'
way more intuitive?

It would be possible to check for this antipattern during normal use
and provide a hint to the user, but that is probably too heavy handed
and might annoy people with a legitimate use case. For that matter, if
the gitignore file is easier to use for the 'private ignore' use case
we have a bigger problem and shouldn't dictate to users what to use.

As to the documentation, it is already quite comprehensive. All
exclusion methods are listed, and the reasons for why to use them are
well laid out. The introduction does specifically mention 'gitignore'
files, but that seems to be due to all the ignore files
($HOME/.config/git/ignore, $GIT_DIR/info/exclude, .gitignore) being
classified as 'gitignore' files.

So some possible improvements. We could replace 'gitignore' with 'git
ignore' in instances where we are referencing all forms of the ignore
file, not just the .gitignore file.

"Git ignore files specify intentionally untracked files that Git should ignore."

We could reference the multiple ignore locations earlier, for people
who don't read past the first paragraph of to documentation.

"Git ignore files specify intentionally untracked files that Git
should ignore. A git ignore file can be specified for all local
repositories, a specific local repository, or shared with other users
of a repository. Files already tracked by Git are not affected; see
the NOTES below for details."

Finally, it's a little confusing that one of the files is called 'exclude'.

It would be great to rename it to 'ignore'; $GIT_DIR/info/exclude ->
$GIT_DIR/info/ignore. Is there any reason this shouldn't be done?
I haven't checked how extensive a change this would need be, but it
would make the usage much more consistent. The only reference I have
found to this file is at http://markmail.org/message/l7shxticxo3kzdpn
from Junio in a discussion around an RFD for ignore rules.

I think these three changes together would make the intended usage
more obvious to both new and old users, though each change could stand
on its own as well.

Regards,

Andrew Ardill
