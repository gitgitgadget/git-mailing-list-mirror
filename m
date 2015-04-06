From: Borek Bernard <borekb@gmail.com>
Subject: EOL conversion on checkout for text files only
Date: Mon, 6 Apr 2015 20:05:55 +0200
Message-ID: <CAHNoia06Q-jsskQn6TBkT8zPY7m14qmEL70HBm18CA-SaMrWtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 20:06:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfBPk-0003nH-OJ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 20:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbbDFSGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 14:06:20 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33591 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbbDFSGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 14:06:17 -0400
Received: by lbbzk7 with SMTP id zk7so25225502lbb.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=16dHN4X3XfNemisau50jKyQfEXtL5GZYEcJErshvaNA=;
        b=gqsvlMtZZM2IBE7rsx3glAQxi3E60V/+x70gQ8qAKnI/RMaInPwFNo0LCG4Bs0CpKA
         jZZaLY/3WjPVhCPyYVstJ2CBmcaIr29g8QQM4QF0laxEuaCgWnWnfoLegl3Y5Ap6PtwF
         /qnuhhAjD12KCYIuV+eHifRqJqt6tqGXF6npnEScqq/u1yNS6M5hv+AUGDjjtOY02jrL
         sicyhmEM5Aj8LKIuJtLuAMBX0dL9piCe3N8ZDMrWlwYoZsHUfe0Sf7zhHWM6RVGcynX0
         LTBJo4q9nFam+D40huJgUJ57Hl497+0NR1FvxF4eYZu3+v/HioRB8fjvlifTz9jqLi4t
         39yw==
X-Received: by 10.112.199.133 with SMTP id jk5mr7384111lbc.32.1428343576113;
 Mon, 06 Apr 2015 11:06:16 -0700 (PDT)
Received: by 10.114.18.43 with HTTP; Mon, 6 Apr 2015 11:05:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266877>

Hi,

I'd like to propose a new behavior around EOL normalization / forcing
using gitattributes.

My use case is this: I want to ensure that LF line endings are used in
the repo *and* in all working directories, on all platforms (in our
case, the text files MUST be LF even on Windows).

The first part is easy to achieve using this in a .gitattributes file:

    * text=auto

This will correctly normalize *text files* in the repo. However, the
second part (LF forcing on checkout) cannot be achieved easily today
because adding `eol=lf` will unfortunately process binary files too.
The only solution today is to mark certain types for conversion (e.g.,
`*.txt eol=lf`) or, inversely, mark certain types as binary (e.g.,
`*.png binary`).

Both of these suffer from the same issue: the specific file types must
be listed explicitly in the .gitattributes file, which means that
either the types must be known ahead of time or all developers must
remember to update the .gitattributes file every time a new file type
appears in the project. Which they won't.

The simplest solution in my eyes would be just to change the behavior of

    * text=auto eol=lf

to do both the checkin and checkout EOL conversions on *text files
only*, using the same text/binary detection algorithm that is already
in place for the checkin direction. This feels the most intuitive to
me and I think it would not be a breaking change.

Related IRC discussion:
http://colabti.org/irclogger/irclogger_log/git?date=2015-04-04#l1143

Thoughts?

Thanks,
Borek
