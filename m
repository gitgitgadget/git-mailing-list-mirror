From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 09:52:52 +0100
Message-ID: <CAFXTnz5pG8ifPvMp8xin3xSikGT9iLoUfsrqpepxDDTCMZ2wRQ@mail.gmail.com>
References: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
	<7vtxq8ie63.fsf@alter.siamese.dyndns.org>
	<CAFXTnz51czE5iS_pgZyU7SdUwrmZcmLxjFGpCGVhLGJFvW=HRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:53:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txw55-0001cF-DP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 09:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab3AWIwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 03:52:54 -0500
Received: from mail-bk0-f50.google.com ([209.85.214.50]:41177 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab3AWIwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 03:52:54 -0500
Received: by mail-bk0-f50.google.com with SMTP id jf3so4270400bkc.37
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 00:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=7HO/zf4+BF+/PUmLQK1cJ2x+h3gID0IPTzxet5WxNyA=;
        b=HkkO4HJqX8lsXwpvRsTWvi98rKgATsdCx5zanoewxw9ghE/wiSadwTfHXGS+25uXK9
         obhy7KdmE2jSrjOK6i2Ejr5Yy7y/YClVFeHfhB0i6HIzQPZDKn+1I360PzPFFJCEHvXt
         I88dt6pkx2Vp+75oCM0UkWjs2KlimZst8ruoeseETqc2wL962DsvqyDROmFPN+usAkrB
         BMvejLEf+vwQLJzU+4DK+fhIxN8EYdWdnSdCcV+epdMUaJfoMT8FxUuoXOOIeRkk4v4i
         qeJ9N34EYUKs/5l1mZekKtabx4dwrk5JvvWFEKYsueehBkLJeYcTiu3quJwy8O+0HouL
         LVHQ==
X-Received: by 10.204.147.139 with SMTP id l11mr154067bkv.46.1358931172611;
 Wed, 23 Jan 2013 00:52:52 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Wed, 23 Jan 2013 00:52:52 -0800 (PST)
In-Reply-To: <CAFXTnz51czE5iS_pgZyU7SdUwrmZcmLxjFGpCGVhLGJFvW=HRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214300>

[*git@vger.kernel.org accidentally dropped from cc *]

On Wed, Jan 23, 2013 at 7:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>> +static int walk(struct strbuf *path, int argc, const char **argv)
>> +{
>> +     DIR *dir;
>> +     struct dirent *ent;
>> +     size_t len;
>> +
>> +     dir = opendir(path->buf);
>> +     if (!dir)
>> +             return errno;
>> +     strbuf_addstr(path, "/");
>> +     len = path->len;
>> +     while ((ent = readdir(dir))) {
>> +             if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
>> +                     continue;
>> +             if (!strcmp(ent->d_name, ".git")) {
>
> This only looks for the top of working tree.  Have you considered if
> this "iterate over directories and list git repositories in them"
> may be useful for collection of bare repositories, and if it is, how
> to go about implementing the discovery process?

Yes, occasionally I've needed this, but implementing it in my original
shell script was cumbersome. Doing it in C should be as simple as
invoking is_git_directory() on each subdir.

>
>> +             if (ent->d_type != DT_DIR)
>> +                     continue;
>
> I think this is wrong.
>
> On platforms that need a NO_D_TYPE_IN_DIRENT build, your compilation
> may fail here (you would need to lstat() it yourself).  See how
> dir.c does this without ugly #ifdef's in the code, especially around
> the use of get_dtype() and DTYPE() macro.
>

Thanks for the pointer, will fix.

--
larsh
