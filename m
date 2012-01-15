From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git grep doesn't follow symbolic link
Date: Sun, 15 Jan 2012 16:47:31 +0700
Message-ID: <CACsJy8CaBAEJo_LuvjYhb2kfofH83cbR5DFDffmmCU3uJFqk+g@mail.gmail.com>
References: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
 <CALkWK0=-LZH4MYhX50v-RWpGA2r+6q50YxsKaOxc0mJ__yuK7g@mail.gmail.com>
 <877h0zlvwd.fsf@thomas.inf.ethz.ch> <7vwr8za04q.fsf@alter.siamese.dyndns.org>
 <CACsJy8BfvhWxqBOj=+7AiF8dZBVEASAuxiOsjOvpmfE3uPrO3A@mail.gmail.com> <7v1ur1yazf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pang Yan Han <pangyanhan@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 15 10:48:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmMh8-0006o9-FW
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 10:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab2AOJsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 04:48:06 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64335 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab2AOJsD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 04:48:03 -0500
Received: by bkuw12 with SMTP id w12so918978bku.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 01:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UMZ02xJRDEqsuIia+ImjmgELCxsuLFuJT4cerhQFj9I=;
        b=LDywk0PS0xihVOxbdqwCEK75fmmz1IMKhWHpMx+u2HI82CnSBHmH3hWY4c495nMy2w
         rnG8u5IwwKxsU6+V1fWoei0tOPE1IiYfif6aUnCFu414GOkwpJHPmE1Wqfm5XKjIe1Ol
         vK22TIv41YofFWW6zdRm973z5yjd/9BfHcfTk=
Received: by 10.204.154.200 with SMTP id p8mr3079323bkw.4.1326620882196; Sun,
 15 Jan 2012 01:48:02 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Sun, 15 Jan 2012 01:47:31 -0800 (PST)
In-Reply-To: <7v1ur1yazf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188594>

On Sun, Jan 15, 2012 at 9:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stop and think what "git diff --follow-symlinks v1.3.0 v1.7.0" should do
> when these versions record a symbolic link, "from user perspective", if
> the link points outside the tracked contents. Naturally, the users would
> expect that the comparison is made between the contents of the file back
> when v1.3.0 was tagged and the contents of the file (which may or may not
> be the same path depending on the target of that symbolic link) back when
> v1.7.0 was tagged.
>
> But that is something that the user is *NOT* tracking with the system, and
> hence something we cannot give the right answer. Your "--follow-symlinks"
> option only encourages the *wrong* perception on the users' side, without
> supporting what it appears to promise to the users. Why could it be an
> improvement?

It's not wrong per se. It's an implication that users have to take
when they choose to use it. We may help make it clear that the
symlinks point to untracked files by putting some indication in the
diff.

When I do "git log -Sfoo -- '*.cxx'" I don't really care if bar.cxx is
a symlink. Neither does my compiler. It may be a symlink's target
change that makes "foo" appear. Git could help me detect that quickly
instead of sticking with tracked contents only.

Even if we decide --follow-symlinks=untracked is a bad idea,
--follow-symlinks=tracked (i.e. follow symlinks to tracked files only)
is still a good thing to support. And I suspect that's a more common
case as linking outside repository could is undeterministic.

The "=tracked" could be dropped if we have no other option value. I'm
thinking of --follow-symlinks=submodule, which is currently covered by
a separate option name.
-- 
Duy
