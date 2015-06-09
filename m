From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v2] git-rebase--interactive.sh: add config option for
 custom instruction format
Date: Tue, 9 Jun 2015 06:26:36 -0400
Message-ID: <CANoM8SWngx-hCmNMJLZ6NhDzE=OSSH_UAd-8x7xCQZ58GzeJyw@mail.gmail.com>
References: <1433797202-97425-1-git-send-email-rappazzo@gmail.com>
 <1433797202-97425-2-git-send-email-rappazzo@gmail.com> <9a61f06b14f58a0bd2b687e2aef2b805@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Jun 09 12:27:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Gke-0004bj-BX
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 12:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbbFIK1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 06:27:13 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35404 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbbFIK06 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 06:26:58 -0400
Received: by obbgp2 with SMTP id gp2so9364605obb.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc
         :content-type:content-transfer-encoding;
        bh=6mBGhPc1p3Jugsq62Cs7iUp4uagY4X95K5BGBEUR/jw=;
        b=TLdUFHxwzKdSNn2XgH+tvtEZm/DpcTCvBku65hfCOI6L4HLW7FNls3s0e3RamSoOHm
         S7fRvmWXl9+D4ETplgerdB7BWU648Fd2Eg5SvyEvNxZrAuekdcDIjGtQlGRMjDpKif7a
         V0yJf8ifmgBK1mH+SnoJU4d+/M8UQ5ebCLBOf5hEHvfklw1bKpdE2zQ6JPIWoJUlOEVy
         Zeii5J2tfZiVCw2f/uiAH6Q1PGAbakwY5Zt6Tg721HHm3H9/KkZGnc9R3OvBzdXiaMtg
         O287Ke1I7agh54u/43TLPlgeVeeSx6n7TtRGly/+IUFvm+sX1VTsMPzKnf7R2gsRbWN9
         fSkw==
X-Received: by 10.60.145.228 with SMTP id sx4mr18390795oeb.79.1433845616659;
 Tue, 09 Jun 2015 03:26:56 -0700 (PDT)
Received: by 10.202.204.20 with HTTP; Tue, 9 Jun 2015 03:26:36 -0700 (PDT)
In-Reply-To: <9a61f06b14f58a0bd2b687e2aef2b805@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271163>

I see your point, and I'll explore that avenue.

Personally, I like the idea that one could also use the short hash if
the custom instruction started with "%h ", but I see the value in
leaving the variable blank.

After running the tests with a custom format enabled, I did find that
autosquash doesn't work, so I am working to correct that.

On Tue, Jun 9, 2015 at 5:36 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi,
>
> On 2015-06-08 23:00, Michael Rappazzo wrote:
>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index dc3133f..b92375e 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -977,7 +977,9 @@ else
>>       revisions=$onto...$orig_head
>>       shortrevisions=$shorthead
>>  fi
>> -git rev-list $merges_option --pretty=oneline --reverse --left-right
>> --topo-order \
>> +format=$(git config --get rebase.instructionFormat)
>> +# the 'rev-list .. | sed' requires %m to parse; the instruction
>> requires %H to parse
>> +git rev-list $merges_option --format="%m%H ${format-%s}" --reverse
>> --left-right --topo-order \
>
> These two lines are too long (longer than 80 columns)...
>
> Besides, are you sure you don't want to substitute an empty 'rebase.instructionFormat' by '%s'? I would have expected to read `${format:-%s}` (note the colon), but then, this was Junio's suggestion... Junio, what do you think, should we not rather substitute empty values by `%s` as if the config setting was unset?
>
>>       $revisions ${restrict_revision+^$restrict_revision} | \
>>       sed -n "s/^>//p" |
>>  while read -r sha1 rest
>
> Ciao,
> Johannes
