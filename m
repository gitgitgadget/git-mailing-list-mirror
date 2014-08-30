From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Auto Packing message twice?
Date: Sat, 30 Aug 2014 21:12:57 +0700
Message-ID: <CACsJy8Ch5WW2rF4vGrM2xyFqn2-1FgPw-kO_wLtBY8-+WqM-1g@mail.gmail.com>
References: <5401B56F.6000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 16:13:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNjPJ-00005c-8j
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 16:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbaH3ON3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 10:13:29 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:57168 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbaH3ON3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 10:13:29 -0400
Received: by mail-ig0-f181.google.com with SMTP id h15so3908752igd.2
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MtG/vMJpFRfJFNORgiGqgx9k7qSnreVpItH/EVKbbOA=;
        b=fuvQgPpL9U5q2gX2emteynu+l6l6KEilCsdAw5rCqjzj1U7Bphiax7s6oNXiH8IYsw
         HZ38+cPKK6GNqjJtPkcd4ZzYujuwxnny5bbkFig6QkDUykhng/i4kSUP55JZTInKbSgx
         do+5OWFdMZzrG5TNX/ui0SeKNmqtpuUJH+Mk7iOs7cUbNC1Lqz2py+n9v9hwZAcYcfUr
         6qff/CyUSx0ILJAGGXwnkLDrWYZy6fr4uKDRoJVpM0X6Nvg07WOwRBnQIwNalEPXMNz+
         Fw0eYErb5KSDoo73WNn56d1WmyvuDMB/dSUSPNRrIbjkpgUTM+W34C6V+rqveP+OT0eD
         vFVQ==
X-Received: by 10.50.43.233 with SMTP id z9mr10663895igl.41.1409408007813;
 Sat, 30 Aug 2014 07:13:27 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Sat, 30 Aug 2014 07:12:57 -0700 (PDT)
In-Reply-To: <5401B56F.6000907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256252>

On Sat, Aug 30, 2014 at 6:28 PM, Stefan Beller <stefanbeller@gmail.com> wrote:
> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.
> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.
>
> Obviously it should only report once?
> The reporting is done from within function cmd_gc(...),
> which makes me wonder, if it also packs twice?

The problem is we print this message before checking if gc is running
in background. Problem is we keep the lockafter forking/detaching
because locking before forking means two processes holding the lock
and I don't think there's a way to say "release the lock in parent
process". And we can't print this message after detaching either
because stdout is already closed then. But this definitely needs some
improvement to avoid confusion.
-- 
Duy
