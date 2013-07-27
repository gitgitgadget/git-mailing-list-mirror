From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sat, 27 Jul 2013 18:01:53 +0530
Message-ID: <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Xin Jiang <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 14:32:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V33fs-0002xW-6N
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 14:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488Ab3G0Mcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 08:32:36 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:42463 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab3G0Mcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 08:32:35 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so472912oag.41
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bxG1rGAD94/T9IEVSPv9jyUI5fiRYFWAhV4BqXgSL/w=;
        b=vKGmBIiXlXFz35vEJN07vQziJ2Q/C+MF1QJdOLeBq1zp9wV9br7o7dXQZLpPzfQd2V
         Q8KE0y46RNPcOlrmafwZZ58AUwFhhhQp1Pfry3ZpF0f4aiup7aoHAj07jhsvqk4igWy1
         u88wnBy1Jkqt5z4vSC4fLy+smmJVsYWArRhMb/M44UfId39c2f8MyZysfRBos310IeLi
         jqvFG8SEmj+a/WKtltT0+g/EIqkZgh0R1LDOLNa0twg5SAPZz3tCfOyaViI09naMmHr0
         l28gzdnvT4KJqBcaL1pKzXMZrTAN1YfGwa3hb9iJULQ8IrRCdIzkpUbtiA75hd6qwxZE
         lo1g==
X-Received: by 10.50.225.66 with SMTP id ri2mr261415igc.55.1374928354051; Sat,
 27 Jul 2013 05:32:34 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 27 Jul 2013 05:31:53 -0700 (PDT)
In-Reply-To: <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231242>

Ramkumar Ramachandra wrote:
> e02ca72 (path.c: refactor relative_path(), not only strip prefix,
> 2013-06-25) is the offender.

The problem is the callsite in setup.c:setup_work_tree(). When
relative_path() is called with
"/home/artagnon/dotfiles/.git/modules/.elisp/flx" and
"/home/artagnon/dotfiles/.elisp/flx" as the first and second
arguments, it sets sb to "../../.git/modules/.elisp/flx".

Makes me wonder why setup_git_dir() doesn't just use git_dir; why does
it need a relative path at all?
