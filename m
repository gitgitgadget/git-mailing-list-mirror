From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Relative paths don't work in .gitignore as would be expected.
Date: Mon, 2 Feb 2015 18:18:27 -0800
Message-ID: <CALbm-Ea7X3dDrMUw0sDhWf0sg+zs7oRUkRD+aPzD9fHqB=ZuWQ@mail.gmail.com>
References: <CAKU1PAWMh_3x9OoFmXG4+5b=7PRckC47k-MAq++SXahxAP5V7g@mail.gmail.com>
	<54CF11CA.6000308@gmail.com>
	<xmqqsieot999.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "/#!/JoePea" <trusktr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 03:18:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIT4W-0005ou-J4
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 03:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbbBCCSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 21:18:31 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42391 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbbBCCSa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 21:18:30 -0500
Received: by mail-wi0-f178.google.com with SMTP id bs8so18853943wib.5
        for <git@vger.kernel.org>; Mon, 02 Feb 2015 18:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZT2rbp+AjSOUbLUHLOzABbXwtVQ+0AptIZA6/D0zceA=;
        b=wpltf1JOgARaVZrwSjzappEGo+EZiLWyFZIwWifpydAK1Myes41o0xUjB34QlUY3gH
         abuM4KtmTflwvnjy7/cCJ8WOtl2OaKcvMo+xEnkm3K9pM0k/RmnzV/IqKbe/z62tlqT6
         QQ2wrvRj2exvv6qDlrHjNnhV8Pm7dIbA2rsEgUtaeB3yU+gpJD0xGdoBX4feZRMQg7vR
         NllaeYh9XteO8K1bOukcWboOn+zUbKwXFdORw7JWfnwONPjhkXc7A/Pw6sA+PPnZia+j
         spGP14+Xy6l6B4M0VB4p/P9gB9I517EFqoyq/5Aha31a3dkXTh3gE6ERyYa7mgPW5bql
         v4vg==
X-Received: by 10.180.7.199 with SMTP id l7mr30421157wia.66.1422929908043;
 Mon, 02 Feb 2015 18:18:28 -0800 (PST)
Received: by 10.180.94.132 with HTTP; Mon, 2 Feb 2015 18:18:27 -0800 (PST)
In-Reply-To: <xmqqsieot999.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263303>

2015-02-02 11:15 GMT-08:00 Junio C Hamano <gitster@pobox.com>:
> Stefan Beller <stefanbeller@gmail.com> writes:
>
>> On 01.02.2015 14:51, /#!/JoePea wrote:
>>> I have this in my .gitignore:
>>>
>>>   ./*.js
>>>
>>> I would expect that to cause git to ignore .js files in the same
>>> folder as .gitignore, but it doesn't do anything. However, this works:
>>>
>>>   /*.js
>>>
>>> I'm not sure what this actually means because a leading slash is the
>>> root of some filesystem,
>
> Isn't gitignore(5) documentation reasonably clear?
>
>  - If the pattern ends with a slash, it is removed for the purpose
>    of the following description, but it would only find a match with
>    a directory. In other words, foo/ will match a directory foo and
>    paths underneath it, but will not match a regular file or a
>    symbolic link foo (this is consistent with the way how pathspec
>    works in general in Git).
>
>  - If the pattern does not contain a slash /, Git treats it as a
>    shell glob pattern and checks for a match against the pathname
>    relative to the location of the .gitignore file (relative to the
>    toplevel of the work tree if not from a .gitignore file).
>
>  - A leading slash matches the beginning of the pathname. For
>    example, "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".
>
>> That's true, though you'd never (barely?) git version control an entire
>> file system?
>
> When you have the entire file system under /.git, "/var/" still
> would be the right way to spell a pattern to match only a directory
> (because of the trailing '/') whose name matches 'var' and lives in
> the root level of the filesystem (because of the leading '/' anchors
> the pattern to the same level as the file the pattern appears in,
> i.e. /.gitignore) and no other place.

Ok, that's true. So when I started diving into the wonderful world of
unix like operating system, one of the first things I was taught is
"/" starts an absolute path, while "./foo" or just "foo" starts a relative
path. And this stuck with me. Now I realize git treats the repository
root literally as the root and hence absolute paths starting with "/"
make totally sense inside git as the world stops for git outside its
work directory.

>
>> (from man gitignore, though reading that and not finding a './' it may
>> need improvement
>
> We do not allow relative pathname traversal with "." or "..", do we?

Because we don't have to. It's always relative to the .gitignore file
(foo/.gitignore can talk about bar/ and still mean foo/bar), so we don't
need to express the relativity in any special way.

>
> I would be very hesitant to special case "./*.js" to mean "*.js
> files in the same directory as .gitignore appears", as I think it
> risks intelligent readers to infer "../foo/*.js" or "../*.js" would
> take effect, when placed in "bar/.gitignore".  A design that spreads
> an incorrect assumption/expectation is not a good one, I would have
> to say.
>

I did not say I'd change the behavior of the ignore rules. I rather meant
to say the documentation could be filled with examples for common
patterns.

That way you'd not be required to read all the rules and *think* about
them, but rather can just copy/paste and hope it works. ;)

Sorry if this sounded otherwise.
