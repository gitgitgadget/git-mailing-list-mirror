From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: core.autocrlf & Cygwin - files incorrectly flagged as modified
Date: Thu, 17 Dec 2009 09:05:12 +0800
Message-ID: <be6fef0d0912161705q1ef23634rccdc170d69cf9484@mail.gmail.com>
References: <loom.20091215T225528-115@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: David Antliff <david.antliff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 02:05:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL4o6-0005v8-83
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 02:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763496AbZLQBFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 20:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763482AbZLQBFR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 20:05:17 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:43498 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZLQBFN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 20:05:13 -0500
Received: by iwn1 with SMTP id 1so1117564iwn.33
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 17:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=kr6JcDN0uEzErixBHi0ukI3Mt/BDqncw1aiFXMsswD0=;
        b=loV03am798H49qEFK7/60H7XLhB0FIot+nKvZRgcUimjtUI3mhV2RmhiaoySMTZ0vq
         DDPGgNwI6FnjDQdSnvnd4WYyN3eioleUg395soVtgk+UsMMgZz3rKL2JTspQl8p5Z5VV
         MGlP8g8eUiQwRCJIWEKBO7ajVU5H6MEoJgLwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=i6ExqFAIVp/FgYtdBxXqhBSK03ifJYIG9oAmuDLbBFCcz9GI2UtmrgGCrIDwI+oI+D
         ydz8ExnmuMBav58fu8As1RssMi4GCHPBdv+btXPtdxrgDd3CRMseq8fFMUhWHZt+SY+V
         ExfHpblsHKXoSq6JsWlK7cDVItnm3auv2EfE0=
Received: by 10.231.20.230 with SMTP id g38mr1575343ibb.49.1261011912826; Wed, 
	16 Dec 2009 17:05:12 -0800 (PST)
In-Reply-To: <loom.20091215T225528-115@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135353>

Hi,

On Wed, Dec 16, 2009 at 6:24 AM, David Antliff <david.antliff@gmail.com> wrote:
> I suspect what is happening is that the line conversion routine in git might be
> stripping trailing whitespace, as well as converting the line endings. This
> operation is not properly accounted for in the reverse direction, and the file
> is flagged as modified.

I am not a Git expert, but could it be your editor on Windows?

Not just stripping whitespace; it might be setting the eol to LF
(instead of CRLF) when saving the file.

> Also, as cloned files are converted to DOS-line-endings, by default Cygwin's
> bash cannot run any scripts as they have the wrong line endings. I have to set
> the 'permanent' bash variable SHELLOPTS to include 'igncr' before bash scripts
> can run. Perhaps this is wrong and git on Cygwin (with binary mounts) should be
> converting to UNIX line endings instead?

Again, IANAGE, but according to the manual, this should be expected,
because Git, when writing to the filesystem, converts LF to CRLF:

  If true, makes git convert CRLF at the end of lines in text files to
  LF when reading from the filesystem, and convert in reverse when
  writing to the filesystem.

> At one point I tried switching off core.autocrlf for myself but this caused a
> lot of conflicts due to mismatched line-endings. It seems to me that if we want
> to switch to this, *everyone* has to do it at once.

Just make this conversion a commit, and depending on your project's
workflow, push/pull it.

Although the whole file will be marked as changed, you can always
double-check that only whitespace changes have been made by running
git-diff with --ignore-space-at-eol or -b.

-- 
Cheers,
Ray Chuan
