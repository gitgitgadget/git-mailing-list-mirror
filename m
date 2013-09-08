From: Isaac Levy <ilevy@google.com>
Subject: Bash completion doing full tree traversal?
Date: Sun, 8 Sep 2013 05:12:48 -0700
Message-ID: <CADHXV5kfaMm3nAEK_uR0McoAahj6pVtm=11Ei0_Y_teDJixWTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 08 14:13:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIdro-0006Al-Hb
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 14:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab3IHMNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 08:13:21 -0400
Received: from mail-qe0-f48.google.com ([209.85.128.48]:37367 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3IHMNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 08:13:20 -0400
Received: by mail-qe0-f48.google.com with SMTP id nd7so1668793qeb.21
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=+7kirb2KLNBIu7stX8hgudR4ztZUQvG1c0LOn5MZP/E=;
        b=bWU4Kpy75oGEuwNLbqi3RjK2Lkap1GVmZcpZMYUsu0k+9B2cieHFGsvdEcfSiv6g0X
         qM2ZN2JDSZh4lKexiu9SXB7eSt1McHXcEchfcQF2lS8lVYMpwU8+6CGxtRJ9W4qqDDPB
         GwEHwaEFqVndwWrzaoMATPrSotrrJMJ/bYMzatRq/ltlzvNzw0nTJJlpUdjdqP4yIS8r
         R2ZjlPTFfyfb0V5aaeNeDNI+ae7HUZlvIYLqVa3gCqn+Cj01+UIT8NxBzIDhsJ7RfyCi
         tY0FBXJmrk2C6UqwDe7BJ6ENHPpdvojEM6IB0oInvlIHOLxTaURQurJ5H0qoeqRLeb+t
         ELdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=+7kirb2KLNBIu7stX8hgudR4ztZUQvG1c0LOn5MZP/E=;
        b=CMYYsYiYNGFnS/Db+nwqpOBftwyXElCOqGMCH0caebK/hSkfXhc0sJfEpMYJQS54kT
         yHRLw2Ec9i4hB0zn19fHiUgW0fsPIHri4yu6slpDpwakA6K7gquM/znzlWZwyDIcJEr7
         kZyynEiufWtrhJCvjkUZTNy+nWYdKKPYuGbqfNCDIJkDI7Zv6mLX7+Qd0q1+4NgF1fB4
         y8IOd62Z8J45Pat1UZk3VPZwhh9451OCfbtFrIqvPCj1kOcohILcUTscjGsaucJgC6lI
         CKqKjtF3p4iOT+Hkc997c6kCeKcRgotpRIytdlN4XtH7ZTR62tPNkjyAxKG+DwVT67R4
         PFfA==
X-Gm-Message-State: ALoCoQk/Q1QI+TpyWotWYksfWtmkTDl9xQ+VOV5v6dy1yQGAQSo7i/KnGWj7ExCbIIdieyJYCJwfnfBu7d0oxcRcc3dny2ZNKBdBi1KaJnpL32zOkoNvDBK6PMQ5dH9JNcmp5EiT2PEBNC2FN2eUbFbSQbhBIGtevmHz+aoMEJR1zIRraiTcxTMJCa7/DB19zSssYamy+yZx
X-Received: by 10.49.59.44 with SMTP id w12mr14755703qeq.57.1378642399038;
 Sun, 08 Sep 2013 05:13:19 -0700 (PDT)
Received: by 10.229.65.70 with HTTP; Sun, 8 Sep 2013 05:12:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234237>

I experienced a weird stall from git bash completion:
$ git add p<TAB>

I did some investigation and found this call trace:

+ __git_index_files '--others --modified' ''
   ---> git ls-files --exclude-standard --others --modified

This bash function captures output of the git call and strips all but
the base directory or base filename.  The results are limited to
entries in the current directory.

Appears to be from fea16b47b603e and first released in v1.8.2 (I have 1.8.4).

Isaac
