From: Matt McClure <matthewlmcclure@gmail.com>
Subject: `git prune` doc or implementation defect, or user misunderstanding
Date: Wed, 8 May 2013 10:19:45 -0400
Message-ID: <CAJELnLFpOT=V4f-pthDHkGqVWR7zSS=QYgMz35LWTUB9KvKNUQ@mail.gmail.com>
References: <CAJELnLF_oFcoqhRmzWwFne=8D5kwt8izk5fCDqmxPrROnOxh8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 16:19:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua5Dk-000828-0J
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 16:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab3EHOTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 10:19:47 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:43226 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab3EHOTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 10:19:46 -0400
Received: by mail-da0-f44.google.com with SMTP id z8so1014875daj.3
        for <git@vger.kernel.org>; Wed, 08 May 2013 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=MdqQYnxByuG1ekMQUQ2GS4MGoomKOdIgGpRDLLZbQGM=;
        b=gYL4xcSW3zDguQlHPPh6c0hzPQj3ti/JA2n55OP+UC0OGLcgb96ejFj4uk+l/mvw+3
         HJSQeuZ8b69m6VeKXX8P7mCqEffw5PLp/QnNHd56IFbNJGWsxGZ3e9odvuCVnWwty87F
         Uaam4wcPKSwE8YnnIec0dQHdMUS9eEoLSCLwvdjJB5LKVYqJJc1v7003H1gap3d4Bann
         xVn0Kp8DICpQnMKF2LCu0CCivy5P6hCWiFwyHhrC9EQQ1U9u7A+qutSSgrHSFQug+ZK4
         0hGvMDFSlkHPiF4pyk/SinspWzSLOI2lyfZ+zRwN+fjYLCw/R7RhvpmoLUpsq4Wog5LW
         z2Hg==
X-Received: by 10.66.87.5 with SMTP id t5mr8475388paz.169.1368022785664; Wed,
 08 May 2013 07:19:45 -0700 (PDT)
Received: by 10.68.43.37 with HTTP; Wed, 8 May 2013 07:19:45 -0700 (PDT)
In-Reply-To: <CAJELnLF_oFcoqhRmzWwFne=8D5kwt8izk5fCDqmxPrROnOxh8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223668>

The `git prune` documentation says:

       This runs git fsck --unreachable using all the refs
       available in refs/, optionally with additional set of
       objects specified on the command line, and prunes all
       unpacked objects unreachable from any of these head
       objects from the object database. In addition, it prunes
       the unpacked objects that are also found in packs by
       running git prune-packed.

       Note that unreachable, packed objects will remain. If this
       is not desired, see git-repack(1).

My interpretation of that is that `git prune` will not prune packed objects
by default. The following behavior seems inconsistent with that
interpretation.

[git@438587-beefcake01 panama.git]$ git prune -n | wc -l
9210
[git@438587-beefcake01 panama.git]$ git fsck --unreachable | wc -l
9468
[git@438587-beefcake01 panama.git]$ git gc --no-prune
Counting objects: 531223, done.
Delta compression using up to 24 threads.
Compressing objects: 100% (109848/109848), done.
Writing objects: 100% (531223/531223), done.
Total 531223 (delta 405288), reused 530894 (delta 404961)
[git@438587-beefcake01 panama.git]$ git prune -n | wc -l
9468
[git@438587-beefcake01 panama.git]$ git fsck --unreachable | wc -l
9468

It looks like `git prune -n` is telling me that it would prune the objects
that I just packed. What am I misunderstanding?

--
Matt McClure
http://matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
