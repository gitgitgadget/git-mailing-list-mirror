From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sat, 27 Jul 2013 20:03:14 +0530
Message-ID: <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
 <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com> <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 16:34:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V35ZI-000257-PJ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 16:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab3G0Od4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 10:33:56 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:62717 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab3G0Odz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 10:33:55 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so9953450oah.35
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6R57Gm/n1nQYw35fwN0ddhXCtWriltJnvsRPUbOE/+I=;
        b=e9a0wy2XJlb/ZFFgrQ3KDo6XGqfqtHWrPRTTGJqJhCf2Ds/FBcTJirdk2B5XWH1x/J
         hk18aiwCa0SgnEWFGrCQZ3+pgRwfyaqvUqctMrm1QC0Bopj2P9rl1uLMUrm9sWOud9eQ
         zyUiL6HQqOpQmHCzQsDw97hjBzSsPn7T0V/eNpqvkqTKKb1bB6jJaSP6EahPtIKkUWhB
         rbT8+jPuPrkPE/CzVyg+jrLMnvWEmvF+Vp/uJKW+hgTpNAemcBrqzBmCfk4I3nb91xkQ
         zK3dou35/gEofnD2MtUlrt5+oPN5tLeZ2n9V7S9d1nQZ45Gad17NcX6X3FmuWplnTHEW
         /nMw==
X-Received: by 10.50.6.16 with SMTP id w16mr311878igw.29.1374935634628; Sat,
 27 Jul 2013 07:33:54 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 27 Jul 2013 07:33:14 -0700 (PDT)
In-Reply-To: <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231246>

Duy Nguyen wrote:
> 044bbbc (Make git_dir a path relative to work_tree in
> setup_work_tree() - 2008-06-19)

Okay, so it does seem to be a significant optimization.  Frankly,
e02ca72 only improves the relative_path() algorithm, and it's not
really doing anything Wrong: it's has just uncovered a previously
undiscovered bug.

So far, we know that the line:

  s->fp = fopen(git_path(commit_editmsg), "w");

in commit.c:prepare_to_commit() isn't failing; so, the work_tree and
git_dir do seem to be set correctly. The problem seems to be in
launch_editor().  What's worse? Everything works just fine when I have
a symbolic link to a directory in a normal repository; I still can't
figure out what submodules have to do with any of this.

What the hell is going on?!
