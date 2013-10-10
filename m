From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools/diffmerge: support DiffMerge as a git mergetool
Date: Thu, 10 Oct 2013 04:21:10 -0700
Message-ID: <31ead18e-0098-4ec8-b8f4-1275580fbc1f@email.android.com>
References: <1380961741-85909-1-git-send-email-ssaasen@atlassian.com> <CAJDDKr6vyt-UgO-p2HxxAdpQnGy+=zwpc9TUpK5LL54LrjNEGg@mail.gmail.com> <CADoxLGMxi7CvKHD2-UFEh4=kkF_8Oker4o7YivsB2tSosXJ+Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Thu Oct 10 13:21:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUEJ3-0002gt-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 13:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab3JJLVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 07:21:15 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36172 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab3JJLVO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 07:21:14 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2471231pdj.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=WL2IKUhNu5ZBTaOlffx2Ml8kDMQmNr6L2mftpgJMO6k=;
        b=NfhbTcvc8FhOU40j+4yp4T9X6GWe8gfy3XqvIkU/dmM+xuZfzdAhQ9gNo253Mlkoyw
         wMddqyfKCOYQFqiZ4dXMOC9ZFueZAzmNrGfiOL+/FTOeQrQcG1AQQB3rnb+1VbzSeD88
         Sq4YgR5KGXqKglcjlnNhX8+jlGxZIkzE2el/wZngh1NOagd6fVxxQokUqjvE39ZF7UO4
         TNvGa/IUfDkwCAT/fJpmyC9jRf2PMljxLtn/tKqXpJYPC5BYyLkUNUWT4iKswF1ebMWk
         j3hduW+aHVns1J1VHb/8Dcp3CpVQMoyiMgAuzM/Xfil1r4OhgGEj70t+4I32TpazXRN8
         dVjA==
X-Received: by 10.68.170.68 with SMTP id ak4mr645949pbc.202.1381404073459;
        Thu, 10 Oct 2013 04:21:13 -0700 (PDT)
Received: from [192.168.1.30] (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id yo2sm61830553pab.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 04:21:12 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CADoxLGMxi7CvKHD2-UFEh4=kkF_8Oker4o7YivsB2tSosXJ+Jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235859>

Stefan Saasen <ssaasen@atlassian.com> wrote:
>Thanks for the review David, much appreciated.
>
>> I think this line was already too long in its current form.  Would
>you mind
>> splitting up this long line?
>
>I've updated the patch and had a look at how to avoid repeating the
>list of
>available merge/difftools.
>
>> ... follow it up with a change that generalizes the "list
>> of tools" thing so that it can be reused here, possibly.  The
>> show_tool_help() function, as used by "git difftool --tool-help" and
>> "git mergetool --tool-help", might be a good place to look for
>> inspiration.
>
>> We were able to eliminate duplication in the docs (see the handling
>> for $(mergetools_txt) in Documentation/Makefile) so it'd be nice if
>we
>> could do the same for git-completion.bash, somehow.
>
>I can think of a number of approaches and I would like to get some
>feedback.
>
>Firstly I think a similar solution to how the duplication is avoided in
>the
>documentation can't be easily applied to the completion script. Looking
>at the
>script itself (and/or usage docs like
>http://git-scm.com/book/en/Git-Basics-Tips-and-Tricks) the recommended
>way of
>using it is by copying the script as-is. That means there won't be a
>build step
>we could rely on unless I've overlooked something?
>
>That leaves a different approach (run- vs. build time) where I can
>think of two
>possible solutions.
>The first would be similar to what is being done at the moment by
>looking at
>the MERGE_TOOLS_DIR and in addition considering any custom merge tools
>configured. I'm working with the premise that it is a reasonable
>assumption
>that users of the git completion script have a git installation
>available even
>though they may have gotten the script by other means.
>For users to still be able to install the script by simply copying it
>to any location
>on the filesystem the list generation function(s) would either have to
>be sourced
>from the git installation or duplicated. I suppose the former would
>need to
>take into account that the completion script doesn't necessarily
>matches the
>installed version of git with some potential brittleness around
>relying on external
>files and directories. The latter doesn't buy us anything as it
>duplicates even
>more code than the current list of available mergetools.
>
>The second approach would be to do something similar to resolving the
>merge
>strategies (in __git_list_merge_strategies) by parsing the output of
>the `git
>merge tool --tools-help` option with a very similar disadvantage that
>it relies
>on the textual output of the help command and doesn't work outside of a
>git
>repository.
>
>
>I'm currently leaning towards the last approach as it seems less
>reliant on
>implementation details but it doesn't look ideal either and I may be
>missing
>another approach that would be better suited.

I agree that this seems like the way to go. Perhaps we can add git mergetool/difftool --list-tools which can print the available tools so that the completion can use it. 


>
>> It might be worth leaving the git-completion.bash bits alone in this
>> first patch and follow it up with a change that generalizes the "list
>> of tools" thing so that it can be reused here, possibly.
>
>To decouple this and adding the diffmerge merge tool option, I'd rather
>keep the
>git-completion change part of the patch. That way the patch is self
>contained
>and covers the change including the completion using the current
>approach and
>doesn't rely on the duplication change. Any concerns around that,
>otherwise I'll
>resend the patch with only the long line fixed?

That sounds good, we can keep these as separate patches. 

Thanks,

-- 
David
