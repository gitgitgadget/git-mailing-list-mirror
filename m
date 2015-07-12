From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 08/10] tag.c: use 'ref-filter' APIs
Date: Sun, 12 Jul 2015 16:45:58 +0700
Message-ID: <CACsJy8AEEDEUE=nBvWVv426MWYzEmRSFFR1xF-cKKD2Lid9n4w@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <559E53DC.2040804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 11:46:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEDqJ-0002wF-1y
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 11:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbbGLJq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 05:46:29 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33498 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbbGLJq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 05:46:28 -0400
Received: by iggp10 with SMTP id p10so59410896igg.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 02:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FkvSltY9ErjQISfHbPLMDTQCi/3YKBS2lGjElhUl7dQ=;
        b=XUuJtQoq4BbqJHNm/jzMkokVavd3X3Hr1Cslt4L7HeGZBcZ2fDC0EcpaUG6bW3JdQ7
         /xGIzsPQH7j5TJC6aVjzXcaZIB+VxLM4PEqJVdzGt0P5YI8MFP+pPjuH5Y7TJvpeYlij
         T1E2EoEM9fKgBW9N4Xm1w8g4qLtDiH8rrBSMFeEJMLO2l6ntCiYUMQXlWeJenQNBTFcY
         gY0ZjsBpyi5JKoyMAQTta4UD4Hmy71eD5absxjDCe01jP/SALGgbKbJaPyLgmoQO1Dzf
         UNw0is3EowfqbN19evJu3cAEI4Mi+dsb1jETspTzFZ9j9YOb26sL/PgABuCF/vUaybWx
         q84w==
X-Received: by 10.50.97.33 with SMTP id dx1mr6492751igb.1.1436694387996; Sun,
 12 Jul 2015 02:46:27 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Sun, 12 Jul 2015 02:45:58 -0700 (PDT)
In-Reply-To: <559E53DC.2040804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273890>

On Thu, Jul 9, 2015 at 5:58 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> -static int show_reference(const char *refname, const struct object_id *oid,
> -                         int flag, void *cb_data)
> -{
...
> -
> -       if (match_pattern(filter->name_patterns, refname)) {
....
> -               printf("%-15s ", refname);
> -               show_tag_lines(oid, filter->lines);
> -               putchar('\n');
> -       }
> -
> -       return 0;
> -}
...
> +       if (filter->lines)
> +               format = "%(refname:shortalign=16)";
> +       else
> +               format = "%(refname:short)";

I can see this is a faithful conversion, but this looks line an
opportunity to avoid this special limit 15/16. Even on git.git "git
tag -l -n1" already breaks alignment with *.msysgit.* tags (ok maybe
msysgit, not purely git.git) When you get to "branch -l", it
calculates the max-width automatically so you probably need
"%(refname:shortalign)" any way. "shortalign" (i.e. create the "align"
version for every modifier) does not look good because it could double
the number of modifiers and let's not thinking about truncation
options or right alignment..
-- 
Duy
