From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git rebase -i error message interprets \t in commit message
Date: Tue, 6 Aug 2013 21:31:04 +0530
Message-ID: <CALkWK0mg4FTONDieaaW+OV0cbUpzb46gj39NcNmBMXSyey_JKQ@mail.gmail.com>
References: <87k3jy6cyc.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 06 18:01:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6jhl-0008H0-9R
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 18:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab3HFQBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 12:01:45 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:39779 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755728Ab3HFQBo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 12:01:44 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so1266118obb.16
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+7p4I+Sd7EvsKUymF5bMMLfHBtyMlJTFZShxSqlAvGc=;
        b=Zauy7I48efwyuTIN+MgePIdUwKQGhluH5AXRrKI7yGRihstURWHDOsVQ4RT4MG/VHS
         /SfJY6C+HqINKzH/H2ilhIC0xcbJuPw9196EveRPPsAqhUI5P1JFcY+kqFmK3TcPQBKj
         2L9DvybQ9IE9Cj72pYwFo+WVWB1DwB26l9PvnI1I1/PwZCwOWOMNlnFWoQXrKFWPmt3o
         2CjUfWLLx1XpcBd6mRM19s+1lL9+QvgyVNJybELykwSmzuVBv1aW/ZS12wVTUmNntJVJ
         CNFeePuRLiUofqOmrwbKkfJAa2wfKHGFmVTKM3w0ZBV8sGDhlh9k428v459EP42Rw9Nd
         Lf0Q==
X-Received: by 10.50.23.16 with SMTP id i16mr189992igf.50.1375804904247; Tue,
 06 Aug 2013 09:01:44 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 6 Aug 2013 09:01:04 -0700 (PDT)
In-Reply-To: <87k3jy6cyc.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231757>

David Kastrup wrote:
> As you can see, the first message starting with "error: could not apply"
> outputs a reasonable rendition of the commit summary line.  However, the
> final "Could not apply" message (starting with a capital C) converts
> instances of \t to a tab.

To get you started:

  $ git grep "could not apply"
  sequencer.c=475=static int do_pick_commit(struct commit *commit,
  sequencer.c:628:                      : _("could not apply %s... %s"),

  $ git grep "Could not apply"
  git-rebase--interactive.sh=431=die_failed_squash() {
  git-rebase--interactive.sh:436: warn "Could not apply $1... $2"
  git-rebase--interactive.sh=460=do_pick () {
  git-rebase--interactive.sh:476: die_with_patch $1 "Could not apply $1... $2"
  git-rebase--interactive.sh:479: die_with_patch $1 "Could not apply $1... $2"

So, it's the shell script.  Now, read about shell escaping [1] and
submit a patch.

Thanks.

[1]: http://tldp.org/LDP/abs/html/escapingsection.html
