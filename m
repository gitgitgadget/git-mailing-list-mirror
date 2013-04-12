From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v1 23/45] check-ignore: convert to use parse_pathspec
Date: Sat, 13 Apr 2013 09:09:33 +1000
Message-ID: <CACsJy8Au4KL7msPr62bvSgGdseWFF=cUJSuB2JzGUXehDD6hng@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-24-git-send-email-pclouds@gmail.com> <20130412150304.GH26949@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sat Apr 13 01:10:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQn6i-0000U4-DY
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 01:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab3DLXKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 19:10:05 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:55722 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab3DLXKE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 19:10:04 -0400
Received: by mail-ob0-f182.google.com with SMTP id ef5so2817001obb.13
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 16:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1Gdv164R9kGzmiVY83his3LVQrtBzX6kQqPi3HhngaU=;
        b=pjzER2sKgCpLbkty0nsyOOE3cX6itYdBFtrFLZO/IAsqtJySTFOdK8o7lqZLVjajel
         5hmHnmn3/cnQmtFGVidp3k37VdRmQq6+4/YdPooPc66UQi+WjTB2b+7vfl6jIwB/JLtc
         6xP0sFQnQ+y7xg7JeKpZOH2yQhv3zF01uQFpfMWaP0wGb4VN0nNX5X8N+7Z4sE0xaiQw
         9GxamNthCMhOcdBIsoEHChxCSe5IUAHVi6jAiMAKR/xLnt2cEAN580W+cMxuIwO/7CH/
         nntz/jR9u3jGuPdEKnQsdVOv0zk/p4JYNTQJa5Z17nMJ9YJ8d0wHqQ+HElgAdszMeXd/
         akRQ==
X-Received: by 10.182.116.70 with SMTP id ju6mr556850obb.48.1365808203215;
 Fri, 12 Apr 2013 16:10:03 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Fri, 12 Apr 2013 16:09:33 -0700 (PDT)
In-Reply-To: <20130412150304.GH26949@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221037>

On Sat, Apr 13, 2013 at 1:03 AM, Adam Spiers <git@adamspiers.org> wrote:
>> -static int check_ignore(const char *prefix, const char **pathspec)
>> +static int check_ignore(int argc, const char **argv, const char *prefix)
>>  {
>>       struct dir_struct dir;
>> -     const char *path, *full_path;
>>       char *seen;
>>       int num_ignored = 0, dtype = DT_UNKNOWN, i;
>>       struct path_exclude_check check;
>>       struct exclude *exclude;
>> +     struct pathspec pathspec;
>>
>>       /* read_cache() is only necessary so we can watch out for submodules. */
>>       if (read_cache() < 0)
>> @@ -70,31 +70,39 @@ static int check_ignore(const char *prefix, const char **pathspec)
>>       dir.flags |= DIR_COLLECT_IGNORED;
>>       setup_standard_excludes(&dir);
>>
>> -     if (!pathspec || !*pathspec) {
>> +     if (!argc) {
>
> Is there a compelling reason for introducing argc as a new parameter
> to check_ignore(), other than simplifying the above line?  And why
> rename the pathspec parameter to argv?  Both these changes are
> misleading AFAICS, since paths provided to check_ignore() can come
> from sources other than CLI arguments (i.e. via --stdin).

Because I introduced "struct pathspec pathspec;" I need to rename the
argument "pathspec" to something else. Maybe we could rename the
argument to "paths"?

> The introduction of argc also makes it possible to invoke
> check_ignore() with arguments which are not self-consistent.

This is the same problem with main() and other places that follow this
convention. But I don't mind dropping argc either.
-- 
Duy
