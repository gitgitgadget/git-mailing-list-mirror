From: Brent Goodrick <bgoodr@gmail.com>
Subject: Cloning into an existing directory
Date: Sun, 15 Feb 2009 23:10:45 -0800
Message-ID: <e38bce640902152310x195a14e5p445817bdfc6e319f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 08:12:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYxeZ-0006I0-Uu
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 08:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbZBPHKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 02:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbZBPHKr
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 02:10:47 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:37490 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbZBPHKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 02:10:46 -0500
Received: by gxk22 with SMTP id 22so2784614gxk.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=8gvrKekkxkBTiKkB8ZOZawDQydJYWM11r7SqU6qAJmg=;
        b=E8LjOzR+Arlf3T3IFcQvv7HTpU4rg/OqBjNJ6fCcUHeR0PSrLwiFpPAq0i0jmbhawV
         9+Mky5hQEXLLosH/Fx2w0neIcmhf8kh/OABxBD2y3Zm2VYr65vTrK3r0yavjDZh/9UTY
         Npj4GRIHEoyBrGNkKhKv5mN1TWfPRBLdmUrXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=d5D0LJMizhAxLU8MJto3VMB0fZKXDQUo91O0wLdxJ6fIwzzhBPeaBPJRhzbzcxUmku
         ascy8Z+s2h9AAUZTJ8ulTBm6esvvBP1SMRjOv0A/UwM5MLzytRYOeXGyC5CSCoBbuCwP
         cgIN8ZjVDxns08X4y0Yjtrp0JywYNT9uFSfNM=
Received: by 10.90.98.12 with SMTP id v12mr212454agb.105.1234768245077; Sun, 
	15 Feb 2009 23:10:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110142>

Hi,

I would like to manage my startup scripts such as .bashrc and other
setup files relative to my HOME directory using Git. However,
git-clone disallows cloning into the existing "." directory, but only
allows cloning into a subdirectory that does not yet exist.  If my
home directory is /home/brentg and my remote repository is on
remote_machine:~brentg/my_setup.git then git clone in my home
directory on the local machine creates /home/brentg/my_setup with
files such as .bashrc inside it, which is not what I want. I want them
checked out and managed _in_ the current working directory, and not to
mess with other files or directories that already exist that are never
to be managed by git.

I don't want to create softlinks from files in the HOME directory down
into the subdirectory (e.g., /home/brentg/.bashrc -->
my_setup/.bashrc) if I can at all avoid it, since then to do so for
all of my setup would require extra scripting work, and it may be the
case that some setup files are required to be regular files and not
symbolic links by certain programs.  Moving the files manually is also
out of the question, since then I can't do a git diff operation on the
file directly.

I did see the --bare option to clone, but the entry in the git-clone
man page implies that using that option turns off a lot of tracking of
things that I believe I will need:

       --bare
           Make a bare GIT repository. That is, instead of creating
<directory> and placing the administrative files in
           <directory>/.git, make the <directory> itself the $GIT_DIR.
This obviously implies the -n because there is nowhere to check
           out the working tree. Also the branch heads at the remote
are copied directly to corresponding local branch heads, without
           mapping them to refs/remotes/origin/. When this option is
used, neither remote-tracking branches nor the related
           configuration variables are created.

Specifically, the statement: "branch heads at the remote are copied
directly to corresponding local branch heads, without mapping them to
refs/remotes/origin" and "neither remote-tracking branches nor the
related configuration variables are created" are what is scaring me
off.

Is there a way do to this, or is the --bare option really what I need
here? If so, what are the caveats of the use of that option given the
above "scary" statements.

What is interesting to note, is that git clone on a local repository
to "." seems to work just fine. It is only when cloning from remote
repositories that it complains about the target being an existing
directory.

Thanks,
bg
