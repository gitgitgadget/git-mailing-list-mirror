From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/13] bash prompt: run 'git rev-parse --git-dir'
 directly instead of __gitdir()
Date: Tue, 18 Jun 2013 00:16:32 -0400
Message-ID: <CAPig+cTXxxkburz1PySnYptN70QUM3JwkKq9g5ULRYpUai4MrQ@mail.gmail.com>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
	<1371521826-3225-7-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 18 06:16:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UonLS-0000u1-22
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 06:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab3FREQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 00:16:34 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:62778 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab3FREQd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 00:16:33 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so3169215lab.31
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 21:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OnaMyWjyjfFG5z2v++h4sBR2QYi3eiIhWlJNxpaxg+A=;
        b=D08nQAgdQBoAwn7Egyif5yMYXwCwZTA3F00t1ZsVYVUa3Og9x425kK0svrEin5z73E
         GJj4++qWlJIkJ5lhxPVk6s2XqKf/t0vjmSyarT6sL98KP9VHBwzocf76PUcWY5O+AxsQ
         7XOuyxhd6uZQ/++alDssp/PFphEN1kLyyu9/2tlXN1lBYpFDsuCkYgFTSu9tff3maEWR
         p0YgOdMABfHReGkUSrRuENecdmN6u/5rEiyK1FEj2KKbQdPp59M3KQ+R7MpRijCRRGUP
         69oBNSSOD7MEle2YYZJ9K200UE+b12OgdVjs6mWd0wwx/UUERio9oJXsyS7WDc8w62f4
         EKjw==
X-Received: by 10.152.44.225 with SMTP id h1mr8041447lam.90.1371528992082;
 Mon, 17 Jun 2013 21:16:32 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Mon, 17 Jun 2013 21:16:32 -0700 (PDT)
In-Reply-To: <1371521826-3225-7-git-send-email-szeder@ira.uka.de>
X-Google-Sender-Auth: xbwUcKVotx3n8T6RKmv_JIPEW5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228150>

On Mon, Jun 17, 2013 at 10:16 PM, SZEDER G=E1bor <szeder@ira.uka.de> wr=
ote:
> From: SZEDER G=E1bor <szeder@ira.uka.de>
>
> __git_ps1() finds out the path to the repository by using the
> __gitdir() helper function.  __gitdir() is basically just a wrapper
> around 'git rev-parse --git-dir', extended with support for
> recognizing a remote repository given as argument, to use the path
> given on the command line, and with a few shortcuts to recognize a gi=
t
> repository in cwd or at $GIT_DIR quickly without actually running 'gi=
t
> rev-parse'.  However, the former two is only necessary for the
> completion script but makes no sense for the bash prompt, while the
> latter shortcuts are performance optimizations __git_ps1() can do
> without (they just avoid the overhead of fork()+exec()ing a git
> process).
>
> Run 'git rev-parse --git-dir' directly in __git_ps1(), because it wil=
l
> allow this patch series to combine several $(git rev-parse ...)
> command substitutions in the main code path, and the overall
> performance benefit will far outweight the loss of those few shortcut=
s

s/outweight/outweigh/

> in __gitdir().  Furthermore, since __gitdir() is not needed anymore
> for the prompt, remove it from the prompt script finally eliminating
> its duplication between the prompt and completion scripts.  Also
> remove the comment from the completion script warning about this code
> duplication.
>
> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
