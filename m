From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Mon, 20 Apr 2015 12:52:02 +0700
Message-ID: <CACsJy8B1QWzehAEtjnQeRJ8uehcFFDbdHSViwk_JtrtYehV8ZQ@mail.gmail.com>
References: <55300D2C.9030903@web.de> <1429319946-19890-1-git-send-email-pclouds@gmail.com>
 <5533A567.7070301@web.de> <CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>
 <xmqqy4lnmkbv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 07:52:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk4dP-0003Im-L7
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 07:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbbDTFwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 01:52:33 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:32880 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbDTFwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 01:52:33 -0400
Received: by iecrt8 with SMTP id rt8so96264204iec.0
        for <git@vger.kernel.org>; Sun, 19 Apr 2015 22:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EBedzUHezP2iFQpXzWGY9gitWiloAwgrfKe9tNhczDg=;
        b=CpDKfNbLUOlu40ipDGu/8YE3MNM+CJunsN75alHB1jGOsRRJC6FHwduqijxt7/2SQq
         0TI0r1JIaFZS2tiFyDZq1Y4OIRq7NkXRSv6wFdaIEWJ206E7FnBLM0N0ZOguLSjMfJi8
         zcocmXbxPH9BNYeZv0Hub8/AjJZT7Qa00iznXG1x7+gXV/Hff760vjvrrH3OpR0NpBCE
         fCGEjxIyE0IdIRZq+4kfmGsi0l5BuIDFxhO84Ecsg+jfqiIT7rZDBNceb40eRnxm29Vx
         4Pd3ynbjTPqjt+ifHVQ2BpNL0oLlXdrZ1fMQF9m+jsGT3tAruABGCiY43aY9vuEPdrGU
         DSWg==
X-Received: by 10.50.77.13 with SMTP id o13mr18865892igw.39.1429509152343;
 Sun, 19 Apr 2015 22:52:32 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Sun, 19 Apr 2015 22:52:02 -0700 (PDT)
In-Reply-To: <xmqqy4lnmkbv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267453>

On Mon, Apr 20, 2015 at 12:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> But if you look at it another way, "cd subrepo; git add ." should be
>> the same as "git add subrepo" ...
>
> Once you cd into "subrepo", you are in a different world, a world
> different from the toplevel project.  "git add ." over there should
> mean "add everything in subproject's working tree to subproject's
> index", shouldn't it?  On the other hand, "git add subrepo" without
> leavingin the working tree of the superproject is about binding the
> submodule to the superproject's index.
>
> I do not think these two should be the same.  Where am I mistaken?

I think I wrote this sentence and deleted it: I didn't say which way
was right. I simply looked at this from the implementation perspective
and it looked the same, at least with current impl. But we can
differentiate them if we want (prefixlen is the key). A corner case if
we go with erroring out in "cd subrepo; git add ." case, do we error
out with "cd subrepo; git add ../subrepo"? If we want this case to
error out too, I don't think I can use prefixlen to set it apart from
"git add subrepo" any more..
-- 
Duy
