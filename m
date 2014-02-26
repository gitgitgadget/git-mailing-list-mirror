From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [RFC 3/3] reset: Change the default behavior to use "--merge"
 during a merge
Date: Wed, 26 Feb 2014 18:37:52 -0500
Message-ID: <CADgNjam-SBVD_Y+mgtDqaG44QVKAd--OrCFtCBRhYt4DFsa4sg@mail.gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-4-git-send-email-andrew.kw.w@gmail.com>
	<vpq8usxenul.fsf@anie.imag.fr>
	<CADgNjanavxZfuXgvEAOMzPAJr9YqAvF4+ZDq9KW9aeR_PcVo-Q@mail.gmail.com>
	<20140226204843.GN7855@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 00:38:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIo3I-0002mC-Bp
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 00:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbaBZXiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 18:38:05 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:55194 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbaBZXhy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 18:37:54 -0500
Received: by mail-wi0-f177.google.com with SMTP id r20so5094wiv.16
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wrm9gALdDxYbDNvQpH9ryGR+Scm5OuGJn9yEk4z+3d0=;
        b=tEvf0koYMBxY0mP/9E6SNdbPm4B9vsgfrK5r/drEdHPwzJJAlHI1blzYYBOnJTtv9D
         biYGkfqqyfgOpRYBtF8tRfqjXo1lJZX3IsxEvKWFim51mD2F5DMlJHjaa+mv2nUNfg9x
         3J1OEOE9HH5YXwwWWeb1M5GKqPAgtUmZz3ERfLZ+XuzdfrboxT2JMOJMVOtVgy+I8gVy
         e7w8o/yy24iy7M4Aezs+7dUua9nAeUcjrrN6A1OdI9Dlze9aPloRI4F9FOSDyTKviev1
         2aQklWfLJkeRxjPPC5QjUuI1YRLEBjGWheZ+/oj+EqeF99VK2eCeOhH04vENVY0cWnLT
         dnYg==
X-Received: by 10.180.163.206 with SMTP id yk14mr6884107wib.5.1393457873002;
 Wed, 26 Feb 2014 15:37:53 -0800 (PST)
Received: by 10.194.81.65 with HTTP; Wed, 26 Feb 2014 15:37:52 -0800 (PST)
In-Reply-To: <20140226204843.GN7855@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242773>

On Wed, Feb 26, 2014 at 3:48 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> I really don't like the idea of making "git reset" modal, though.  I'd
> rather that reset --mixed print some advice about how to recover from
> the mistake, which would also have the advantage of allowing scripts
> that for whatever reason used "git reset" in this situation to
> continue to work.

In the case where user had unstaged changes before running "git
merge", there's no way to recover from the mistake. Their worktree is
left with a mix of both the merge changes and their original unstaged
changes. As Junio pointed out, new files will also be left in the
worktree, so the next attempt to "git merge" will fail until the files
are removed. There's no way to recover from it except to have the user
manually clean out the merge changes and new files manually. That's
why "git reset --mixed" doesn't seem sensible during a merge.

That said, I do feel it might not be a good idea to have the default
behavior of "git reset" change depending on the context. What Junio
suggested might be a better approach. To have "git reset" error out
instead may be a better alternative, since that doesn't silently do
something else and break compatibility.

Andrew
