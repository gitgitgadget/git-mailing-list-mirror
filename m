From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v1 3/3] travis-ci: run Git bisect on failed tests
Date: Sun, 22 May 2016 17:35:52 +0200
Message-ID: <CAP8UFD3TJ7mJEu2xCXhrspHY1v02uTonUGdszZbcQGf9ne9_Cg@mail.gmail.com>
References: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
	<1463914856-64745-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 17:36:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4VQD-00067j-0L
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 17:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbcEVPfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 11:35:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33014 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbcEVPfy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 11:35:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id 67so8740068wmg.0
        for <git@vger.kernel.org>; Sun, 22 May 2016 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Oc5wOqhspD3I6En5pNfNTHs+B+avPkTXOi9wq6NaFBg=;
        b=iNp4pa1ACKf3XA+rf+TTExvGd4UgwnWz+SfmLbamDg5r8bTXq5MjLvCz/X8cvVSY8T
         WejnMuHUJVJrrfssEN0Y5PVaugDwt2MRq2swXXF7j3YrgYtz25KmVougNXg+Mr9E8PSJ
         txM3CYj964MnZbp2YeJjb4ozwFJpRYgRBwJISFHcEioAisCH6CnOleyoVlG4akAF8OV3
         7s7yQkUjYgHfgYoHbNfpCC0z6FJGEv7G70JxEl57jgY+Mb6tKLvHWBzlFeTrGnnHKNrC
         ZV8kcAGl7TEP5D3GympCTAvWw9m6tPgGiMoR+/vDZUXFXwziNrankhI0bXjFCRXFPHnv
         1Jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Oc5wOqhspD3I6En5pNfNTHs+B+avPkTXOi9wq6NaFBg=;
        b=KavUQCQ+QZ4df5JxwQg6aMRlntzboF65zK9BgXKJ7QLpUWBWg4Lip115QMqvveXdWX
         QZmHb4ikeN+DmcRV8XPFbg8Blzh7L7NvJutjGV/rEEUKya9gagPqGzIgJnRG1FLdPC8G
         FqtEa1WPLXNKbQpe+vawybSbSAa4fYmtnSr+bEE40vHwDQ4xovdiKMFgNUsP/m/6aVN0
         2NpuWHbq1MXowdeKzMEqS5UgtbPYReuhwEQUZ0je6SDM5IAeCysPfZByHAUrrfgsFE/q
         zo9rRx5Pptx1J513mkWz8Whp8yZ3j9PL15o7pKI9B6qCYqr/nIQCWNJ2Yb28JpcMtOf3
         4ihQ==
X-Gm-Message-State: ALyK8tJcsk8IaIaARh1w1vzI47S7RduwxQ2W1eNMFRwqUUrchi6WN4Z5LVKeXA5usRTrGTMb4aB7+KhuBOjkoA==
X-Received: by 10.28.94.194 with SMTP id s185mr501644wmb.62.1463931352566;
 Sun, 22 May 2016 08:35:52 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Sun, 22 May 2016 08:35:52 -0700 (PDT)
In-Reply-To: <1463914856-64745-4-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295285>

On Sun, May 22, 2016 at 1:00 PM,  <larsxschneider@gmail.com> wrote:

[...]

> +#
> +# Run Git bisect
> +#
> +run_bisect () {
> +       TEST_SCRIPT=$1
> +       BAD_REV=$2
> +       GOOD_RV=$3
> +       TMPDIR=$(mktemp -d -t "ci-report-bisect-XXXXXX" 2>/dev/null)
> +       cat > "$TMPDIR/bisect-run.sh" <<EOF
> +
> +EOF
> +       chmod +x "$TMPDIR/bisect-run.sh"
> +       git bisect start $BAD_REV $GOOD_RV
> +       git bisect run "$TMPDIR/bisect-run.sh"
> +       if test -e ./t/$TEST_SCRIPT.sh && make --jobs=2 >/dev/null 2>&1
> +       then
> +               cd t && ./$TEST_SCRIPT.sh >/dev/null 2>&1
> +       else
> +               # If the test file does not exist or the build fails then tell
> +               # Git bisect to skip the commit.
> +               exit 125
> +       fi

Shouldn't all the above "if ... fi" be in the here document creating
"$TMPDIR/bisect-run.sh"?

> +       git bisect reset >/dev/null 2>&1
> +}
