From: Andrius Bentkus <andrius.bentkus@gmail.com>
Subject: Re: Idea, Transparent commits, easier "code style" commits
Date: Sun, 6 Jul 2014 13:44:35 +0200
Message-ID: <CAAwotL3vtkjVO5Zqz+w_gNSS0OAovUfukK8=-Df9K4ZybzNh0A@mail.gmail.com>
References: <CAAwotL2a=2syXMCjPsNB9Tzaw1Rrr4UqDyLX9+JYDE-izpJnLg@mail.gmail.com>
	<53B6C7AC.7000701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 13:44:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3ks7-00071D-BN
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 13:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbaGFLoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 07:44:38 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:60199 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbaGFLoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 07:44:37 -0400
Received: by mail-ve0-f174.google.com with SMTP id jx11so3000863veb.19
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nd+uupduRJDuqj8JsekuvPIN7c7jwK230r0j42opaoY=;
        b=Ji8sZ49mWKznO06ctYSncc/A9pHJn7TSGjll3CeeYU3/G5tCpTHEDUqC1r0XqVU/R0
         AGCojqBRkbb2ZoG33Xlvp90DvsexmmpxVawY+/L+f4Aerkjxd43/22sc0HPB4EXdMNcB
         VW4JoNSeTmMT9V2HhxB+6yuuTtsG6d/7kl7GuBDEZDF4BiL/Yk/YA7DVrSdaWYDvC6H/
         kDWOVl1L6vMn41BYlrFgWjA5WcbydfZ/TSJ1Xawchjc4LTuqaFKW8/7V/luvejNwv7dI
         lIKYO7VsfwPLzKme1B50tb2oIRwsbHXfRzB8C0ZKlrNLZSzWmXfqrSw9791Uxs2rwGxz
         dc+A==
X-Received: by 10.52.119.179 with SMTP id kv19mr17688121vdb.3.1404647075977;
 Sun, 06 Jul 2014 04:44:35 -0700 (PDT)
Received: by 10.52.10.98 with HTTP; Sun, 6 Jul 2014 04:44:35 -0700 (PDT)
In-Reply-To: <53B6C7AC.7000701@gmail.com>
X-Google-Sender-Auth: 88eADz6bRdw7ChdaOXcLBC5T9tw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252934>

-w looks good for my very specific whitespace case, but imagine you
are adding or removing parenthesis like, it is still codestyle but -w
doesn't cut it anymore.

So yes, I want a flag!

Well, if I think about it, the tools can implement themselves.

They just have to look into the commit message and look for
"#codestylefix" or whatever other string.

On Fri, Jul 4, 2014 at 5:26 PM, Stefan Beller <stefanbeller@gmail.com> wrote:
> On 04.07.2014 15:12, Andrius Bentkus wrote:
>> I have worked on projects which only after a while (a year or so)
>> established a consistent code style.
>> After the consensus was established there was still some code left
>> which did not fit the newly established standard.
>> Now the problem is, if I create a new patch to actually fix it, it
>> will pollute the blame history.
>> And most of the projects just reject these kind of patches because of this.
>>
>> Imagine that you would have a type conversion "(int)value" and wanted
>> it to change to "(int) value".
>> The patch will have hundreds of occurrences of this one line changes
>> and will make the git blame look like swiss cheese.
>> It doesn't add much information to the line (you'd rather have
>> technical explanations in the commit) and actually hides all the
>> original comments of the line.
>>
>> So you kinda want to have that style fix patch because inconsistent
>> code style just triggers your OCD, but you can't do anything about it
>> because it doesn't add any value to the program when it executes and
>> actually makes it harder to browse the source code using git blame.
>>
>> My proposal is to add "transparent" commits.
>> If you write git blame these commits will not be shown, instead git
>> blame will show a merged version of the code style commit and the
>> actual commit while only showing the commit id of the original commit.
>>
>> A little visualized example:
>>
>> Imagine your first commit is:
>>
>> 58461d5a float yolo(void *i) {
>> 58461d5a   return (float)*i;
>> 58461d5a }
>>
>> And you want it to change to (float) *i, so you patch it and the blame
>> history looks now like this:
>>
>> 58461d5a float yolo(void *i) {
>> 263da519   return (float) *i;
>> 58461d5a }
>>
>> But what you really want to have when you do a git blame is this:
>>
>> 58461d5a float yolo(void *i) {
>> 58461d5a   return (float)*i;
>> 58461d5a }
>>
>> I hope I expressed myself clearly enough.
>> Maybe this was already proposed, but I couldn't find anything in the archives.
>
> Check the -w option of blame
> http://git-scm.com/docs/git-blame
> to fix it while blaming.
>
> Or you need to rewrite the history (a bad idea if the history is
> published to collegues or on the internet) and squash your fixes into
> the original commits.
> (see git rebase for that)
>
> But re-reading your mail, you would like to propose a 3rd way?
> So when commiting the fixup, you want to add a flag, which tells git
> it's just a fixup commit, which should not be shown, when blaming, but
> rather their parent for the lines in question.
> That's an interesting idea.
>
> Stefan
>
>
>
