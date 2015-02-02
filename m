From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: "git status" should warn/error when it cannot lists a directory
Date: Mon, 2 Feb 2015 11:58:33 -0500
Message-ID: <CADgNjamcR+b-_DKzScU=35idAgG542B7CaJC2AqAE9Srvsq17g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 02 17:58:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIKKd-0005E9-IM
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 17:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbbBBQ6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 11:58:35 -0500
Received: from mail-we0-f180.google.com ([74.125.82.180]:56485 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424AbbBBQ6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 11:58:35 -0500
Received: by mail-we0-f180.google.com with SMTP id m14so40240828wev.11
        for <git@vger.kernel.org>; Mon, 02 Feb 2015 08:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Et2zov1xpVKjvHKavhf1M9wAtHts1zcCqbCSpgFfmVQ=;
        b=B/jxKf7micguc5PtQT836w2I7ZjkbYP+NWQkDlC1/U6lkoJJSLhRWmTa1TMxQ8qBHY
         OEmrEGNXgEKEjBmC1g/KeezVrQ98Usn/3Fyqp3vHh8ivv56WtQ+5+SxZfIYZ7E9xSTTB
         lPimgseAGGSKhJKtWfxxnAfdXrOYbSbr4gCd0pKaNI3pZsw/Aeu/182hQGzvqgkaZvJN
         dcFeMwBTts50wpaPJjXUUCcGicmuBMgJ+5OIMqwaxg86tWdhMr2TxjPL3gzRuIaG/AFo
         yo/qwmtheO3I9liN4DkhrvT2MDJpsDszd3qHIy1fnhQs71TgDxvqtvPivBLzmciK6Edk
         9E/g==
X-Received: by 10.195.13.104 with SMTP id ex8mr46694220wjd.12.1422896313951;
 Mon, 02 Feb 2015 08:58:33 -0800 (PST)
Received: by 10.194.172.65 with HTTP; Mon, 2 Feb 2015 08:58:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263262>

When "git status" recurses a directory that isn't readable (but
executable), it should print out a warning/error. Currently, if there
are untracked files in these directories, git wouldn't be able to
discover them. Ideally, "git status" should return a non-zero exit
code as well.

The problem seems to be In read_directory_recursive() from dir.c. When
opendir() returns null, we continue on ignoring any error. Is there a
scenario where returning null is expected? We can simply call perror()
here, but it would be nice if we can propagate the error to the exit
code too. How would we do that?
