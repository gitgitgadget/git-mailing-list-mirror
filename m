From: Kevin Stenerson <kevin@reflexionhealth.com>
Subject: bash completion for git branch/checkout/etc doesn't escape metacharacters
Date: Tue, 20 Jan 2015 11:15:50 -0800
Message-ID: <CAPcx8dzgnChWpTn6po1NF65Mr_hPadUbbNCKHJqght7OG6ksFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 20:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDeHw-0003ap-QG
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 20:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbbATTQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 14:16:28 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:64917 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbbATTPv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 14:15:51 -0500
Received: by mail-wi0-f176.google.com with SMTP id em10so9440674wid.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 11:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=g7dHWT6kZqnbFfFzfG4XPleYPjapm7j4yApCm1hh2Mo=;
        b=GKbhyVFvDiayMh66ExfuuSwZ1PYWZn8xzAoJSDQ2Wjn/52Flk3yT1u5nPnBZFGxijq
         GdnK62+GJi0W6ji25CTdtlRyMZ05QTEwQJn+kZKMBXpixCw0UiorsnUdJPZMydMm6M0U
         tMzxIxtZEYiVe1oRhAq0Nx+c9F8ixsXCdj+k/fx+OnjYY/xHTJFOqU3k57a7ZMpszhfk
         tChfKctcYZYyanBNM5DF/dYo9nXsvxMqR6k4MYJW2LKswgGBQ15otfqS3MX+rd7cqIiN
         BJCtiA70Gw2GjIqapYSOG3KNTLjzNsd44hiakJRHVF43Ds+3iA6q7TFhd9A5cqB50vNA
         iYGQ==
X-Gm-Message-State: ALoCoQkw99bMxjBU12IUOLnFbJb3fV8c1cTB/g3GLThtVQoo/dwO3f6fE90pn7/DKGWdELyCTt7w
X-Received: by 10.180.73.47 with SMTP id i15mr30517215wiv.0.1421781350581;
 Tue, 20 Jan 2015 11:15:50 -0800 (PST)
Received: by 10.180.88.33 with HTTP; Tue, 20 Jan 2015 11:15:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262681>

The bash completion provided with git doesn't escape or quote parens
in tag or branch names.
Alternatively, it doesn't reject branch or tag names with parenthesis
as an invalid name (as it does for names with spaces or tabs)
Bash treats parentheses in unquoted words as a word separator.

When encountering this problem I was using git version 2.2.2 and bash
version 4.3.11

Steps to reproduce with bash:

    mkdir foo
    cd foo
    git init foo
    touch bar
    git add bar
    git commit -m "Went to a bar"

Then for tags

    git tag 'v1.0.0(215)'

Or branches

    git branch 'mybranch(myuser)'

And the actual bash completion

    git checkout   # Use completion here -- it won't escape the parenthesis
    git checkout master
    git branch -d   # Use completion here -- it won't escape the parenthesis

Similarily, when typing a name with an escape character such as
"mytag\(", it won't complete the name from that point.

This appears to be true for other bash meta characters as well such as
'<', '>', '|', ';', '&'

-----------
Kevin Stenerson
kevin@reflexionhealth.com
